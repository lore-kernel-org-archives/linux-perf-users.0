From: Vinson Lee <vlee@twopensource.com>
Subject: =?UTF-8?Q?4=2E0=2Drc1_perf_build_error_=22builtin=2Dkmem=2Ec=3A322=3A_error=3A?=
	=?UTF-8?Q?_declaration_of_=E2=80=98stat=E2=80=99_shadows_a_global_declaration=22?=
Date: Thu, 23 Apr 2015 17:38:49 -0700
Message-ID: <CAHTgTXUA6T0yX9CpwZZJ43UKNfZQzx2PCw_hJTsNeOSm0nZTyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34411 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbbDXAiu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Apr 2015 20:38:50 -0400
Received: by qgfi89 with SMTP id i89so16301518qgf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2015 17:38:49 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi.

4.0-rc1 commit 0d68bc92c48167130b61b449f08be27dc862dba2 "perf kmem:
Analyze page allocator events also" introduced a build error with
older toolchains.

=46or example, this build errors occurs on CentOS 6.

  CC       builtin-kmem.o
cc1: warnings being treated as errors
builtin-kmem.c: In function =E2=80=98search_page_alloc_stat=E2=80=99:
builtin-kmem.c:322: error: declaration of =E2=80=98stat=E2=80=99 shadow=
s a global declaration
/usr/include/sys/stat.h:455: error: shadowed declaration is here
builtin-kmem.c: In function =E2=80=98perf_evsel__process_page_alloc_eve=
nt=E2=80=99:
builtin-kmem.c:378: error: declaration of =E2=80=98stat=E2=80=99 shadow=
s a global declaration
/usr/include/sys/stat.h:455: error: shadowed declaration is here
builtin-kmem.c: In function =E2=80=98perf_evsel__process_page_free_even=
t=E2=80=99:
builtin-kmem.c:431: error: declaration of =E2=80=98stat=E2=80=99 shadow=
s a global declaration
/usr/include/sys/stat.h:455: error: shadowed declaration is here

Cheers,
Vinson
