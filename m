From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: L1-dcache-stores twice as big as expected
Date: Thu, 30 Apr 2015 16:14:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1504301613070.30426@vincent-weaver-1.umelst.maine.edu>
References: <loom.20150430T211657-416@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34026 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbD3UJ3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Apr 2015 16:09:29 -0400
Received: by qkgx75 with SMTP id x75so40069012qkg.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 13:09:28 -0700 (PDT)
In-Reply-To: <loom.20150430T211657-416@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Patrick <plafratt@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 30 Apr 2015, Patrick wrote:

> ->         2,207,859 L1-dcache-stores
> ->       0.006255441 seconds time elapsed
> 
> I can't figure out why it is recording over 2 million stores to the L1 
> data cache. I 
> would expect it to be around 1 million. Has anyone seen this before?

also it looks like you're using C++.

Quite possibly the "new" initializer is setting each element in the array 
to zero and then you later set each to one, so it wouldn't be surprising
you'd get a result 2x as much as you'd expect.

Vince
