From: AKel <ankelly006@hotmail.com>
Subject: Re: Using perf to generate a call stack from a kernel function to the user space caller
Date: Wed, 21 Jan 2015 09:42:29 +0000 (UTC)
Message-ID: <loom.20150121T090925-23@post.gmane.org>
References: <loom.20150120T180008-930@post.gmane.org> <54BEA111.9060504@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39112 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbAUJmh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Jan 2015 04:42:37 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YDro3-0004nL-3L
	for linux-perf-users@vger.kernel.org; Wed, 21 Jan 2015 10:42:35 +0100
Received: from 12-96.252-81.static-ip.oleane.fr ([81.252.96.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2015 10:42:35 +0100
Received: from ankelly006 by 12-96.252-81.static-ip.oleane.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2015 10:42:35 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


Thanks Rick for your reply. Unfortunately I'm in the big bad corporate 
world where a simple minion such as myself is not granted sudo access. 
I've tried passing the callgraph (-g) flag to perf, however I can only 
recover the call stack within the kernel, it begins at what I suspect is 
the kernel entry point. Ideally I could generate a complete call stack.
