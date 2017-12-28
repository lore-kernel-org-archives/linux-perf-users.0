From: David Hinkle <david.hinkle@securly.com>
Subject: How do I troubleshoot Dwarf Unwinding Issuess?
Date: Thu, 28 Dec 2017 14:53:37 -0800
Message-ID: <CAOrDofT4WWsDZC6tY+Kh3tPDczRAJO+iu-DzNx5ct45AG-aomQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:40107 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbdL1Wxi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Dec 2017 17:53:38 -0500
Received: by mail-io0-f170.google.com with SMTP id v30so7902206iov.7
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Dec 2017 14:53:38 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

A problem I'm running into with Kernel 4.9.70 on Amazon Linux:

I have a bunch of samples with empty call stacks.  I edited the
"stackcollapse.pl" so I can see what the symbol is and what dso that
symbol is in (There was a bug that prevented the display of the symbol
in the case where a call stack existed but was empty, as opposed to
not existing).

For example "vprintf" in "/lib64/libc-2.17.so" has an empty callstack,
but the debug symbols for "/lib64/libc-2.17.so" are installed and
other samples of symbols inside "/lib64/libc-2.17.so" have stack
traces.

Any suggestions on how I can get some traction on this issue?  Perhaps
there is there any way I can obtain the stack and run it through
libunwind manually?  Just anything for a lead at this point.

- David
