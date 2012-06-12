From: Maynard Johnson <maynardj@us.ibm.com>
Subject: --mmap-pages option seemingly has no effect to help with LOST samples
Date: Tue, 12 Jun 2012 15:55:21 -0500
Message-ID: <4FD7ACB9.70205@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49766 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803Ab2FLU4U (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Jun 2012 16:56:20 -0400
Received: from /spool/local
	by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-perf-users@vger.kernel.org> from <maynardj@us.ibm.com>;
	Tue, 12 Jun 2012 16:56:17 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 56EA938C8056
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Jun 2012 16:55:47 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5CKtkuB211852
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Jun 2012 16:55:46 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5CKuGt3013962
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Jun 2012 14:56:16 -0600
Received: from oc3431575272.ibm.com (sig-9-77-151-108.mts.ibm.com [9.77.151.108])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q5CKuFxp013776
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Jun 2012 14:56:16 -0600
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
On my Intel Core 2 Duo with RHEL 6.2 with the watchdog timer disabled, I'm using perf to collect a CPI profile as follows:

    perf record -e cycles 100000 -e instructions -c 50000 ./memcpyt 500000000
where 'memcpyt' is a test program that simply does a LOT of memcpy's -- takes about 20 seconds of real time to complete.

	This fails roughly half the time with:

	[ perf record: Woken up 11 times to write data ]
	[ perf record: Captured and wrote 4.540 MB perf.data (~198348 samples) ]
	Processed 0 events and LOST 872662!

	Check IO/CPU overload!

I've seen some postings on this list in the past about the LOST events and the suggestion to try the --mmap-pages option.  I see from the perf source that the default number of pages to use for mmap'ing the kernel's perf_events data is '8'.  I tried going up to 64 pages with little noticeable effect.  Additionally, sometimes when I get the LOST samples message, I'll also see the following junk pop up in all of my terminal sessions:

	Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
	 kernel:Uhhuh. NMI received for unknown reason 00 on CPU 1.
	
	Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
	 kernel:Do you have a strange power saving mode enabled?

	Message from syslogd@oc3431575272 at Jun 12 15:21:52 ...
	 kernel:Dazed and confused, but trying to continue

(Not sure, but these syslogd messages may have occurred only when I was running as root.)

I tried decreasing my sampling rate for both events by half (200000 for cycles and 100000 for instructions), but still got LOST samples, with or without the "--mmap-pages=64" option.  Decreasing sampling rate by half again finally did get rid of the LOST samples.

Questions: 
1) Why doesn't the number of mmap pages seem to have the expected beneficial effect?
2) Why doesn't the kernel's throttle capabilities prevent the LOST events in the first place?
3) What's up with the weird syslogd messages?  heh.

I realize none of these may be perf userspace issues, but may be perf_events kernel issues instead.  But I thought I'd start out here on this list instead of wading neck-deep into LKML land.

Thanks.
-Maynard
