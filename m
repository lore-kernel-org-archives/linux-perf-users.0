From: Justin Thomas <justin.thomas1@gmail.com>
Subject: Re: Majordomo results: Re: Confirmation for subscribe linux-per
Date: Mon, 24 Apr 2017 13:36:35 -0700
Message-ID: <CAOX5HaCN54f_znzLVoTgxBdM4Scz3jjjBeObE+_6MuMeNGtUzg@mail.gmail.com>
References: <S977312AbdDXUEL/20170424200411Z+35176@vger.kernel.org>
 <CAOX5HaBep+=CjGrb9H9EKcE=Biz-YqdVWbDmtBWyhChXbsF2tQ@mail.gmail.com> <CAOX5HaBVNdzQNRpSmkrxi3UsC03sMkyFLY7kz46w7BPtWVkYuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35009 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S977621AbdDXUgg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2017 16:36:36 -0400
Received: by mail-qk0-f175.google.com with SMTP id f76so48507330qke.2
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2017 13:36:36 -0700 (PDT)
In-Reply-To: <CAOX5HaBVNdzQNRpSmkrxi3UsC03sMkyFLY7kz46w7BPtWVkYuQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Segfault when running perf record with cap_add SYS_ADMIN inside a
docker container:

 root@903... $ perf record -a -g
perf: Segmentation fault
Obtained 10 stack frames.
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x1efa44) [0x563c94b74a44]
/lib/x86_64-linux-gnu/libc.so.6(+0x357f0) [0x7fcefe0e27f0]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x184bb0) [0x563c94b09bb0]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x11b71a) [0x563c94aa071a]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x11c8a1) [0x563c94aa18a1]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x177633) [0x563c94afc633]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x10a71e) [0x563c94a8f71e]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf1) [0x7fcefe0cd3f1]
/usr/lib/linux-tools/4.10.0-19-generic/perf(+0x10a84a) [0x563c94a8f84a]
[(nil)]
Segmentation fault (core dumped)

setting: $ sudo sh -c " echo 0 > /proc/sys/kernel/kptr_restrict" on
the host causes it to work.

Also tried on kernel version 4.8, but don't remember which minor rev.
