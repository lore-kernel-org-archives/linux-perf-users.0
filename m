From: Alexander Pozdneev <pozdneyev@gmail.com>
Subject: The issue with `perf report -s comm`
Date: Thu, 21 Sep 2017 17:51:56 +0300
Message-ID: <CAE3E0fDuYbhSj_EESFh2OKzBUQS=oGKWm3+H7XJARi=m7CLxqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:54799 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751734AbdIUOwh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Sep 2017 10:52:37 -0400
Received: by mail-io0-f175.google.com with SMTP id h66so11352779ioh.11
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Sep 2017 07:52:37 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I have the following issue with perf `report -s comm` that seems to be
a bug. This is how the code looks like:

int main() {
    double a, b, c;
    a = do_things_main(WAIT_TIME * 2); // 40% of time, a.out
    b = do_things1(WAIT_TIME);         // 20% of time, libdo1.so
    c = do_things2(WAIT_TIME * 2);     // 20% of time, libdo2.so
    return (int)(a + b + c);
}

This is how I run it:

$ LD_LIBRARY_PATH="." perf record -g ./a.out
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.743 MB perf.data (11911 samples) ]

This is the regular output of `perf report`:

$ perf report | grep -v '#' | head -n 12
    39.99%    39.99%  a.out    a.out              [.] main
            |
            ---main

    39.94%    39.94%  a.out    libdo2.so          [.] do_things2
            |
            ---do_things2

    20.05%    20.05%  a.out    libdo1.so          [.] do_things1
            |
            ---do_things1

It looks exactly as expected. If I sort by `dso`, the output is also OK:

$ perf report -s dso | grep -v '#'
    39.99%    39.99%  a.out
            |
            ---main

    39.94%    39.94%  libdo2.so
            |
            ---do_things2

    20.05%    20.05%  libdo1.so
            |
            ---do_things1

However, If I try to sort by `comm`, the output looks strange:

$ perf report -s comm | grep -v '#'
   100.00%   100.00%  a.out
            |
            |--59.99%--do_things1
            |
             --39.99%--main

Specifically, `do_things2()` is missing in the report.

Here is the full source code of this example:
https://github.com/pozdneev/perf-report-s-comm-bug
Originally, Louis Stuber (IBM Client Center Montpellier) discovered
this behaviour when we have been playing with Flame Graphs
(http://www.brendangregg.com/blog/2016-04-30/linux-perf-folded.html).

This is the list of Linux/perf versions that I've tried:

* Ubuntu 14.04.5 (3.19.0-80-generic), perf version 3.19.8-ckt22
* RHEL 7.3 ppc64le (3.10.0-514.el7.ppc64le), perf version
3.10.0-514.el7.ppc64le.debug
* My colleague confirms that he observes the same behavior with kernel
version 4.13.

Could you please check if the issue remains in the current development
version of Linux perf?

Thanks!

Alexander
