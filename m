From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: L1-dcache-stores twice as big as expected
Date: Thu, 30 Apr 2015 16:00:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1504301556390.30193@vincent-weaver-1.umelst.maine.edu>
References: <loom.20150430T211657-416@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36408 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbD3TzS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Apr 2015 15:55:18 -0400
Received: by qku63 with SMTP id 63so39703627qku.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Apr 2015 12:55:17 -0700 (PDT)
In-Reply-To: <loom.20150430T211657-416@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Patrick <plafratt@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 30 Apr 2015, Patrick wrote:


> When I run perf like this:
> 
> -> perf stat -e L1-dcache-stores:u ./copy 1048576
> 
> I get the following output:
> 
> -> Performance counter stats for './copy 1048576':
> ->         2,207,859 L1-dcache-stores
> ->       0.006255441 seconds time elapsed
> 

what type of processor are you running this on?

What compiler and compiler options?

I'm actually surprised the compiler isn't just optimizing
away your array since nothing is using it.

Vince
