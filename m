From: Roland Dreier <roland@kernel.org>
Subject: perf for analyzing userspace contention
Date: Thu, 13 Oct 2011 23:36:23 -0700
Message-ID: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53611 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1JNGgp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 02:36:45 -0400
Received: by eye27 with SMTP id 27so805812eye.19
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Oct 2011 23:36:43 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi everyone,

Hope this question from a kernel hacker about profiling userspace
isn't too dumb...

Anyway, suppose I have a multithreaded userspace app that uses a bunch of
pthread_mutexes, and I want to figure out which locks are hot and/or heavily
contended.  What's the best way to do that?  Is perf the right, or is there
something better?  (This seems like such an obvious thing to want that there
must be some good way to get this data, I hope)

Thanks!
  Roland
