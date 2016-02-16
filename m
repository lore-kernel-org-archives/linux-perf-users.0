From: Al Grant <Al.Grant@arm.com>
Subject: perf hardware multiplexing - how to diagnose it?
Date: Tue, 16 Feb 2016 11:32:03 +0000
Message-ID: <AM4PR08MB07852A0E218C6131CE75852F86AD0@AM4PR08MB0785.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:41915 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750953AbcBPLcI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Feb 2016 06:32:08 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: nd <nd@arm.com>

Is there any way to find out about how perf is multiplexing hardware
counters between different clients?  I'm having some issues where perf
hardware events are not being scheduled on to the CPU as often as I'd like.
I suspect that this is due to other people running perf on their own
processes, system-wide perf monitoring daemons, applications
collecting their own stats via PAPI etc.  At any given time the kernel
has a number of hardware events it needs to schedule on the
available counters and in general only some of them will be mine.

"lsof | grep perf_event" gives a rough guide to who's currently talking
to the kernel perf subsystem, but I was wondering if it's possible to find
out who's contending for the hardware counters specifically, and how
the kernel is scheduling them and prioritising them.

Thanks,

Al
