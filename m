From: david lerner <dlernerdroid@gmail.com>
Subject: perf probe dwarf on shared libraries
Date: Thu, 4 Sep 2014 15:11:31 -0500
Message-ID: <CANq2XvGNtBO2zVoGTZJkfUofRbZ94-NJ5hZrSz5BT3En4dEHJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43704 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755210AbaIDULb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Sep 2014 16:11:31 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo20so7838735obc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2014 13:11:31 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Has perf probe for userspace shared libraries been modified to use dwarf info?
The first commit to provide this useful functionality...
   fb7345bbf7fad9  perf probe: Support basic dwarf-based operations on
uprobe events,
shows examples only with the executable perf, but not with a shared library.

With version 3.14 I'm able to set probes in application executable,
for example for the test application 'libunwind-test.out' I see the
usual args to main():
   root@qemu0:~# perf probe -x ./libunwind-test.out --vars main
   Available variables at main
        @<main+0>
                char**  a
                int     c
But I can't access the variables in a library that has embedded (not
split out) dwarf debug info...
   root@qemu0:~# perf probe -x /usr/lib64/libunwind.so --vars unw_backtrace
   Failed to find symbol at 0x33c38039cd
   Failed to find variables at unw_backtrace (-2)
   Error: Failed to show vars. (-2)
I've used gdb to confirm that perf found the correct function address
for unw_backtrace(), and that gdb knows the symbolic names of the
arguments.

Is using dwarf debuginfo with shared libraries for perf uprobes on the
to-do list?
Or is this capability incomplete in version 3.14 and I need to pick up
other patches?

Thanks,
Dave
