/**
 * Created with JetBrains RubyMine.
 * User: nikunj
 * Date: 22/3/14
 * Time: 9:41 AM
 * To change this template use File | Settings | File Templates.
 */
$(document).on("page:change", function () {
    if (window._gaq) {
        _gaq.push["_trackPageview"];
    } else if (window.pageTracker) {
        pageTracker._trackPageview();
    }
});