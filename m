From: Christian Convey <christian.convey@gmail.com>
Subject: Obtaining program/library name and function name in "trace_unhandled" ?
Date: Mon, 9 Jan 2017 10:38:56 -0500
Message-ID: <CAPfS4ZyL+rZvA1f2SNJ4ah+Ep2yXXsxjGTEHfbVU3ht1O+Waaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35813 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757079AbdAIPjR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2017 10:39:17 -0500
Received: by mail-qk0-f176.google.com with SMTP id u25so528362106qki.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2017 07:39:17 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi guys,

Is there a good way the "trace_unhandled" script function can
discover, for each function call that it's handling, that
executable/DSO in which that function resides, and that function's
name?

Thanks,
Christian

tl;dr

As I mentioned on another thread, I'm trying to implement userspace
function call/return tracing, using perf.

My tracing logic is implemented in a modified Python script,
originally created by "perf script -g py".

In the target programs I want to deal with, there are thousands of
functions.  So to keep myself sane, I let "perf probe" do the hard
work of finding all the functions to which it should add probes.  For
example:

sudo -E ${PERF_EXEC_PATH}/perf probe --exec=./foo --add='* $params'

Also, to avoid having to write custom logic for every per-function
perf event, I'd like to implement all of my logic in the
"trace_unhandled" Python function.

In my previous attempts to make this work, I just parse the actual
event names, because embedded within them is the name of the
target-program function.  For example, "probe_foo__main".

However, I first noticed this approach breaking down when I used it on
C++ code, where I have two classes, and both of them implement a
method with the same name.  In this scenario, the event names are
simply based on the method name, without any indication of the class
name.
