From: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: Perf on custom module
Date: Sat, 11 Feb 2012 15:38:19 -0200
Message-ID: <CA+MoWDq6KFd3_=tpkjnS+p2G8NCU+12RsQ6V-ekXfwDcu_-jdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42470 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab2BKRiU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 11 Feb 2012 12:38:20 -0500
Received: by yenm8 with SMTP id m8so1913872yen.19
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Feb 2012 09:38:19 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm using Fedora 15 and my goal is to compare the performance of
different Kernel module codes.

For example, on a custom module, I'm comparing:

getnstimeofday (ts_start); /*stopwatch start*/

for (i = 0; i < q->num_buffers; ++i)
	q->bufs[i]->state = VB2_BUF_STATE_DEQUEUED;

getnstimeofday (ts_end); /*stopwatch stop*/

to:

getnstimeofday (ts_start); /*stopwatch start*/

buf_ptr_end = q->bufs[q->num_buffers];

for (buf_ptr = q->bufs[0]; buf_ptr < buf_ptr_end; ++buf_ptr)
	buf_ptr->state = VB2_BUF_STATE_DEQUEUED;

getnstimeofday (ts_end); /*stopwatch stop*/

I was able to do the profiling with perf on user space, by making one
executable for each code, but I was not able to restrict the profiling
to the portion of the code I'm interested in.

My questions:

1 - How can I restrict the profiling to a specific portion of the code?

2 - How can I use perf to profile custom module?

Kind Regards,

Peter

-- 
Peter Senna Tschudin
peter.senna@gmail.com
gpg id: 48274C36
