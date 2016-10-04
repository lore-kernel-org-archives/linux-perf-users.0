From: Jonas Wagner <jonas.wagner@epfl.ch>
Subject: Problems with -b, and confusing error messages
Date: Tue, 4 Oct 2016 17:02:58 +0200
Message-ID: <CAMRJFfLVEHrJ3zqExY=SMzuw8TS7V5A4sy5N2vW9moL=uYvYvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:38426 "EHLO smtp5.epfl.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752745AbcJDPDp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2016 11:03:45 -0400
Received: by mail-wm0-f50.google.com with SMTP id f193so172994385wmg.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Oct 2016 08:03:40 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I would like to ask for help, because perf stopped working when I
enable taken branch stack sampling (with the -b option). Here are a
few examples:

$ perf record -b /bin/true
Error:
'precise' request may not be supported. Try removing 'p' modifier.

$ perf record -b -e cycles /bin/true
Error:
No hardware sampling interrupt available.
No APIC? If so then you can boot the kernel with the "lapic" boot
parameter to force-enable it.

$ perf record -e cycles /bin/true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.014 MB perf.data (8 samples) ]

$ perf record -e cycles:p /bin/true
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.014 MB perf.data (9 samples) ]

$ cat /proc/cmdline
BOOT_IMAGE=/boot/vmlinuz-4.4.0-38-generic
root=UUID=a5440a73-d559-4b61-808c-2430cd67ba25 ro quiet lapic

I have a couple questions about this:

1. What's wrong? Branch stack sampling used to work on this machine...
how can I make it work again?
2. Apparently, the problem is not related to the precise modifier, or
the lapic boot parameter. Could we make these error messages more
meaningful?

Note regarding (1): I recently upgraded the kernel on this machine
from 4.4.0-36-generic to 4.4.0-38-generic, on Ubuntu Xenial. Using the
previous kernel, perf worked fine. It's tricky for me to undo the
update though :(

Help would be appreciated. Happy to provide more logs if needed. Thanks!
Jonas
