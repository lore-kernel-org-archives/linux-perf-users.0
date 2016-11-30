From: HOUSSEN Franck <fghoussen@gmail.com>
Subject: perf-probe : error "Rebuild with -g, or install an appropriate
 debuginfo package"
Date: Wed, 30 Nov 2016 14:49:09 +0100
Message-ID: <CABvthiqmUuGqcDU6LQRJhsPiic4-qePRx8wJtMoj+D+ihjAVdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36568 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbcK3NtL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2016 08:49:11 -0500
Received: by mail-wj0-f195.google.com with SMTP id jb2so22280158wjb.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2016 05:49:10 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I compiled myApp.cpp (that contains a function named myFunction) with:
~>mpic++ -O2 -ggdb -fno-omit-frame-pointer -o myApp myApp.cpp

When I try to probe a function from the myApp binary, I get:
~> sudo perf probe --exe ./myApp --add "myFunction:2"
The /home/path/to/myApp file has no debug information.
Rebuild with -g, or install an appropriate debuginfo package.
  Error: Failed to add events.

... -g has been set a t compile time and libelf (and libelf-dev) seems
to be installed:
~> dpkg -l *elf*
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                                  Version
Architecture            Description
+++-=====================================-=======================-===================
un  elf-binutils                          <none>
<none>                  (no description available)
un  libelf                                <none>
<none>                  (no description available)
ii  libelf-dev:amd64                      0.166-2.2
amd64                   libelf1 development libraries and header files
un  libelf0                               <none>
<none>                  (no description available)
ii  libelf1:amd64                         0.166-2.2
amd64                   library to read and write ELF files
ii  libelf1:i386                          0.166-2.2               i386
                   library to read and write ELF files
rc  libelfg0:amd64                        0.8.13-5
amd64                   an ELF object file access library
un  libelfg0-dev                          <none>
<none>                  (no description available)

I googled that without any relevant answer... Could somebody help me
on this ? What's wrong ?

Franck

PS : When I do that
~>sudo perf probe --exe ./myApp --add "myFunction"
Added new event:
  probe_myApp:myFunction (on myFunction in /home/path/to/myApp)

It works !?... I need to place the tracepoint at the second line below
the entry of myFunction => replacing "myFunction" with "myFunction:2"
does not work ! Why ?...
