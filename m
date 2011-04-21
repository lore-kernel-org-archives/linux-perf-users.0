From: Francis Moreau <francis.moro@gmail.com>
Subject: how to get a kernel callgraph starting from a syscall
Date: Thu, 21 Apr 2011 09:46:49 +0200
Message-ID: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:33930 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1DUHqt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Apr 2011 03:46:49 -0400
Received: by pxi2 with SMTP id 2so1135138pxi.10
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Apr 2011 00:46:49 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

Sorry if the question is dumb but I'm a bit lost about this.

I know that ftrace exists but I think that perf can do this too: I
have a userspace application which is calling a libc C function (read)
which ends up doing a sys_read.

For the sys_read, I'd like to see what's happening in the kernel by
displaying the call graph.

Can perf do that ?

If so, would it be possible to point me out the perf command to use ?

Thanks
-- 
Francis
