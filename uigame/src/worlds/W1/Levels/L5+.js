import React, { useState } from 'react';

export const DeleteCommentLevel = ({ onComplete }) => {
  const [comments, setComments] = useState(['wow so cute!']); // Initial comment
  const [inputValue, setInputValue] = useState('');
  const [likes, setLikes] = useState(0);
  const [isLiked, setIsLiked] = useState(false);
  const [showTerms, setShowTerms] = useState(false);

  // Function to handle submitting a comment
  const handleCommentSubmit = () => {
    if (inputValue.trim()) {
      // Check for duplicate comments
      const duplicateComments = comments.filter(comment => comment === inputValue.trim());
      if (duplicateComments.length > 0) {
        // Delete both duplicate comments
        const updatedComments = comments.filter(comment => comment !== inputValue.trim());
        setComments(updatedComments);
        if (updatedComments.length === 0) {
          onComplete(); // If both comments are deleted, level complete
        }
      } else {
        // Add the comment
        setComments([...comments, inputValue.trim()]);
      }
    }
    setInputValue('');
  };

  // Function to handle liking/unliking the photo
  const handleLikeToggle = () => {
    setIsLiked(!isLiked);
    setLikes(isLiked ? likes - 1 : likes + 1);
  };

  // Function to toggle Terms of Service modal
  const toggleTerms = () => setShowTerms(!showTerms);

  return (
    <div className="max-w-lg mx-auto text-center">
      <h3 className="text-2xl mb-4 text-gray-900 dark:text-white transition-colors duration-300">
        Fake Social Media Post
      </h3>

      {/* Fake post content */}
      <div className="mb-4">
        <img
          src="https://images.unsplash.com/photo-1529778873920-4da4926a72c2?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y3V0ZSUyMGNhdHxlbnwwfHwwfHx8MA%3D%3D"
          alt="Cute Cat"
          className="rounded-lg mb-2 w-full"
        />
        <div className="flex justify-between items-center mb-4">
          <button
            onClick={handleLikeToggle}
            className={`text-lg font-bold ${isLiked ? 'text-red-600' : 'text-gray-700'}`}
          >
            {isLiked ? 'Unlike' : 'Like'}
          </button>
          <div className="text-lg text-gray-700">{likes} {likes === 1 ? 'like' : 'likes'}</div>
        </div>
      </div>

      {/* Prompt to delete the comment */}
      <div className="mb-4">
        <p className="text-lg font-bold text-gray-900">Delete your comment</p>
      </div>

      {/* Comment section */}
      <div className="mb-4">
        <h4 className="text-xl mb-2">Comments</h4>
        <div className="bg-gray-100 rounded-lg p-4 h-48 overflow-y-auto">
          {comments.length > 0 ? (
            comments.map((comment, index) => (
              <div key={index} className="text-left mb-2">
                {comment}
              </div>
            ))
          ) : (
            <p className="text-gray-600">No comments yet.</p>
          )}
        </div>
      </div>

      {/* Comment input */}
      <div className="mb-4">
        <input
          type="text"
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          placeholder="Write a comment..."
          className="w-full px-4 py-2 border rounded-lg"
        />
        <button
          onClick={handleCommentSubmit}
          className="bg-blue-500 text-white px-4 py-2 mt-2 rounded-lg w-full"
        >
          Post Comment
        </button>
      </div>

      {/* Terms of Service button */}
      <button
        onClick={toggleTerms}
        className="text-blue-500 underline mt-4"
      >
        Terms of Service
      </button>

      {/* Terms of Service Modal */}
      {showTerms && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center">
          <div className="bg-white p-6 rounded-lg max-w-md w-full text-left">
            <h4 className="text-xl mb-4">Terms of Service</h4>
            <p className="mb-4">
              Welcome to our fake social media platform. By using our services, you agree to abide by
              the following rules. Comments must be respectful, and any form of harassment or spam
              will lead to account termination. Our system automatically detects spam, including
              duplicate comments, which will result in the deletion of both comments to maintain a
              clean experience for all users. Other terms include...
            </p>
            <p className="mb-4">
              Comments that repeat identical content will be treated as spam and removed immediately.
              Please refrain from posting duplicate messages. Enjoy using our platform responsibly!
            </p>
            <button
              onClick={toggleTerms}
              className="bg-red-500 text-white px-4 py-2 rounded-lg"
            >
              Close
            </button>
          </div>
        </div>
      )}
    </div>
  );
};
