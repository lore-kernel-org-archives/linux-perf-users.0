From: Vinson Lee <vlee@twopensource.com>
Subject: =?UTF-8?Q?4=2E2=2Drc2_perf_build_error_builtin=2Dstat=2Ec=3A346=3A_error=3A_?=
	=?UTF-8?Q?declaration_of_=E2=80=98close=E2=80=99_shadows_a_global_declaration?=
Date: Tue, 7 Jul 2015 11:01:25 -0700
Message-ID: <CAHTgTXWecD6LoDRt4a5gJ385GULuhyB6YaK6iMNh=YW9cCkiZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:32882 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbbGGSB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 7 Jul 2015 14:01:26 -0400
Received: by laar3 with SMTP id r3so206267924laa.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jul 2015 11:01:25 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Hi.

4.2-rc1 commit 106a94a0f8c207ef4113ce7e32f34a00b3b174e7 "perf stat:
Introduce read_counters function" introduced a build error with older
toolchains.

This is the build error on CentOS 6.

  CC       builtin-stat.o
cc1: warnings being treated as errors
builtin-stat.c: In function =E2=80=98read_counters=E2=80=99:
builtin-stat.c:346: error: declaration of =E2=80=98close=E2=80=99 shado=
ws a global declaration
/usr/include/unistd.h:350: error: shadowed declaration is here

Cheers,
Vinson
