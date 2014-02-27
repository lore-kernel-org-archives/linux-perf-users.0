From: Junjie Qian <junjie.qian@yahoo.com>
Subject: Re: Profile the waiting time for lock or lock stats for one application
Date: Wed, 26 Feb 2014 19:17:19 -0800 (PST)
Message-ID: <1393471039.86366.YahooMailNeo@web124905.mail.ne1.yahoo.com>
References: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
Reply-To: Junjie Qian <junjie.qian@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm17-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.110]:41836 "EHLO
	nm17-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752868AbaB0DRU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Feb 2014 22:17:20 -0500
In-Reply-To: <1393351991.27573.YahooMailNeo@web124901.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi all,

This is a follow up question about "perf lock".
I recompile the kernel, with both=A0CONFIG_LOCKDEP and CONFIG_LOCK_STAT=
 are "y". But when I run the command "perf lock record -- sleep 10", th=
e error information still shows as:
tracepoint lock:lock_acquire is not enabled. Are CONFIG_LOCKDEP and CON=
=46IG_LOCK_STAT enabled?

Could you give me some suggestions on this?

Thank you
Junjie Qian
