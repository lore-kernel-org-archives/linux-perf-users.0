From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: linux-tools-4.2
Date: Thu, 30 Jul 2015 17:04:15 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1507301701550.21840@vincent-weaver-1.umelst.maine.edu>
References: <55B9ED8A.5060507@vu.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35868 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbG3U5c (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Jul 2015 16:57:32 -0400
Received: by ioeg141 with SMTP id g141so66484775ioe.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2015 13:57:32 -0700 (PDT)
In-Reply-To: <55B9ED8A.5060507@vu.nl>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Sanjay Rawat <s.rawat@vu.nl>
Cc: linux-perf-users@vger.kernel.org

On Thu, 30 Jul 2015, Sanjay Rawat wrote:

> As kernel 4.2 experimental is out, I am searching for linux-tools-4.2*.deb.
> Can anybody points to it, please?

if you're running a 4.2-rc kernel you are probably compiling it from 
scratch, so you can just build perf yourself (it's in the kernel source, 
in the tools/perf directory).

Also it's usually not a problem using an older version of perf with a 
newer kernel (though to avoid the annoying shell-script redirection you'll 
have to run "perf_4.0" or whatever manually).

I say usually, because even though perf versions are usually forward 
compatible I know that around 4.1 they changed up the tracepoint support 
so if you are using that functionality then you will need a newer version 
of the perf tool.

Vince
