From: Junjie Qian <junjie.qian@yahoo.com>
Subject: Profile the waiting time for lock or lock stats for one application
Date: Tue, 25 Feb 2014 10:13:11 -0800 (PST)
Message-ID: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
Reply-To: Junjie Qian <junjie.qian@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm7-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.167]:36747 "EHLO
	nm7-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753193AbaBYSNM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 25 Feb 2014 13:13:12 -0500
References: 
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Dear all,

I am working on one project, which tries to profile the lock stats for one application, such as total waiting time for locks or how many locks happens during the execution.

I did some research, which shows "perf lock" may help to report such information, but I am getting the error showing as "tracepoint lock:lock_acquire is not enabled. Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?". Does this mean, I need to recompile the kernel to have this option?
Could anyone give me some link for this?

I also got this link "http://article.gmane.org/gmane.linux.kernel.perf.user/770/match=perf+lock", talking about profile the sleep times, but I cannot find how to use this.

Any help would be great appreciated.

Thanks!
Best
Junjie
