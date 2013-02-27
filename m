From: Dongsoo Nathaniel Kim <dongsoo.kim@gmail.com>
Subject: perf terminates immediately with segfault in dmesg
Date: Wed, 27 Feb 2013 23:21:00 +0900
Message-ID: <CAP+Vy9d8Yd7HoxvixS6oT+wow+rV2PzriKBqOw17VVFwTc0iNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:48060 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760074Ab3B0OVl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 27 Feb 2013 09:21:41 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so1223009oag.18
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Feb 2013 06:21:40 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to profile kvm guest and host as well.
I checked out v3.8 vanilla kernel and built bundled perf tool.
(commit 19f949f52599ba7c3f67a5897ac6be14bfcb1200)

Here is my command line:
sudo perf kvm --host --guest --guestmount=/tmp/guestmount record -o
my.perf.data
(I mounted guest instance on /tmp/guestmount using sshfs)

and perf gets terminated immediately and no clue but segfault message in
dmesg:
[11618.130483] perf[39937]: segfault at 30 ip 00007fed26de1121 sp
00007fff0394c258 error 4 in libc-2.15.so[7fed26d58000+1b5000]

Any idea? Can too many processor core cause this problem?

BTW, I'm working on AMD 64core system..and found that perf tool doesn't
work perfectly with AMD opteron processor.

Cheers,

--
=
Dongsoo Nathaniel Kim
Linux kernel, media device S/W engineer / Ph.D Student
Dept. of Computer Science, KAIST
Real-time & Embedded Systems Lab.
