From: Justin Santa Barbara <justin@fathomdb.com>
Subject: How do I trace new threads in a process?
Date: Mon, 29 Aug 2011 17:44:10 -0700
Message-ID: <CAFoXKmqpdGKmAuWCypDJ5uxOBUjqHdhHL9UbYE=rtzRr2dm32A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59178 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1H3AoK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 29 Aug 2011 20:44:10 -0400
Received: by ywf7 with SMTP id 7so5210986ywf.19
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2011 17:44:10 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm trying to use the perf API to trace a single process, including
any child threads that are created after I initially set up the
events. =A0(My end goal is to integrate perf-events into
google-perftools; my work is open source and available here:
https://github.com/justinsb/fathomdb-google-perftools-extensions)

The strategy I've been using is to enumerate all child threads at the
first call by reading /proc/<pid>/maps. =A0I then set up my performance
events using sys_perf_event_open, one event per thread tid. =A0I mmap
each of those fds, and then poll() them. =A0Works great.

If a new thread starts, I do get the PERF_RECORD_FORK event, so I can
then add additional monitors for the new thread. =A0However, the poll i=
s
only signaled when a page is full, by which time that thread could be
long gone (or I could have missed all sorts of interesting events on
it).

I would think that PERF_RECORD_FORK should cause an immediate signal,
but I don't see how I can do that without having _every_ event signal
my thread (which would be very high overhead I think).

I guess I could schedule a second "dummy" perf event monitor on the
same process, with immediate signalling, but with a low enough
freequency that it wouldn't fire except for process events.

I can't use the "inherit" flag (which would otherwise be ideal),
because then I can't mmap the result (the kernel deliberately won't
allow it - it's the first test in perf_mmap() in
kernel/events/core.c).

I feel like I'm doing something wrong - what is the suggested approach =
here?

Thanks,
Justin
