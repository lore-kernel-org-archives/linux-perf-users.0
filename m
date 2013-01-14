From: Digant <digantdesai@gmail.com>
Subject: Task Profiling
Date: Sun, 13 Jan 2013 21:59:29 -0700
Message-ID: <CAHbVqFa_8qLtEakFwXjOu-V8dPH5bGyyfeCXET8eFYrOYq5dNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:63544 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab3ANFFO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Jan 2013 00:05:14 -0500
Received: by mail-la0-f54.google.com with SMTP id fp12so3344361lab.41
        for <linux-perf-users@vger.kernel.org>; Sun, 13 Jan 2013 21:05:12 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

I wish to profile all tasks with one or more PMU events for all time
on all CPUs. What I mean is I wish to add a support inside kernel to
check average IPC of all running task individually. And also user
READ_ONLY through something like "/proc/<PID>/avg_IPC".

I checked kernel perf-events source code seems overwhelmingly
complicated and mainly for user-space perf tool support.
I could not find much documents for inside kernel use for perf_events
mainly per task PMUs except watchdog example in FAQs.
I am using Intel SNB with kernel-v3.5.5. If any one can point me in
right direction that will be helpful.

I am new to this mailing list sorry if I did something stupid by asking ..thanks
Regards,
Digant Desai.
