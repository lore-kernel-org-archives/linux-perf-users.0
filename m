From: Christian Convey <christian.convey@gmail.com>
Subject: newbie question: tracing userspace call/return sequences
Date: Thu, 5 Jan 2017 22:49:13 -0500
Message-ID: <CAPfS4ZwrYePYFoNtf7GOvMpJKABY8ZdCf+MB+xc+Ksa7ubRATQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32791 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdAFDtO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Jan 2017 22:49:14 -0500
Received: by mail-qk0-f181.google.com with SMTP id s140so41021222qke.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2017 19:49:14 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi guys,

Any suggestions for the best way to achieve something with perf tools?

Systemtap has an example script, "para-callgraph.stp", that reports
the *sequence* of userspace function calls and returns made by an
application.

I'd like to perform that kind of analysis using perf tools rather than
Systemtap, because I recently learned that Canonical considers
Systemtap to be unsupported.  (E.g., it's pretty broken on Ubuntu
14.04.)

I think I've gotten fairly close with these steps:

  perf probe --exec=./fib -f --add='*'
  perf probe --exec=./fib -f --add='*:%return'
  perf record -e 'probe_fib:*' -aR ./fib
  perf script -g py
  perf script -s ./perf_script.py

The generated Python script contains two Python functions for each
userspace function that's called during the execution of "fib".  This
seems to work, at least on a small, toy program.

But AFAICT, this has two major downsides relative to the
Systemtap-based approach, in cases where the target program has
thousands of functions:

(1) The generated Python script will be huge, and

(2) It will require some non-trivial Python coding for me to tweak
what that script does for every call/return event.

Any suggestions for a good/better way to pull this off?

Thanks,
Christian
