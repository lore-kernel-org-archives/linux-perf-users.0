From: David Ahern <dsahern@gmail.com>
Subject: =?UTF-8?B?UmU6IDQuMC1yYzEgcGVyZiBidWlsZCBlcnJvciAiYnVpbHRpbi1rbWU=?=
 =?UTF-8?B?bS5jOjMyMjogZXJyb3I6IGRlY2xhcmF0aW9uIG9mIOKAmHN0YXTigJkgc2hhZG8=?=
 =?UTF-8?B?d3MgYSBnbG9iYWwgZGVjbGFyYXRpb24i?=
Date: Fri, 24 Apr 2015 07:54:50 -0600
Message-ID: <553A4B2A.7090703@gmail.com>
References: <CAHTgTXUA6T0yX9CpwZZJ43UKNfZQzx2PCw_hJTsNeOSm0nZTyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36627 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbDXNyw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 24 Apr 2015 09:54:52 -0400
In-Reply-To: <CAHTgTXUA6T0yX9CpwZZJ43UKNfZQzx2PCw_hJTsNeOSm0nZTyA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vinson Lee <vlee@twopensource.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 4/23/15 6:38 PM, Vinson Lee wrote:
> Hi.
>
> 4.0-rc1 commit 0d68bc92c48167130b61b449f08be27dc862dba2 "perf kmem:
> Analyze page allocator events also" introduced a build error with
> older toolchains.
>
> For example, this build errors occurs on CentOS 6.
>
>    CC       builtin-kmem.o
> cc1: warnings being treated as errors
> builtin-kmem.c: In function =E2=80=98search_page_alloc_stat=E2=80=99:
> builtin-kmem.c:322: error: declaration of =E2=80=98stat=E2=80=99 shad=
ows a global declaration
> /usr/include/sys/stat.h:455: error: shadowed declaration is here
> builtin-kmem.c: In function =E2=80=98perf_evsel__process_page_alloc_e=
vent=E2=80=99:
> builtin-kmem.c:378: error: declaration of =E2=80=98stat=E2=80=99 shad=
ows a global declaration
> /usr/include/sys/stat.h:455: error: shadowed declaration is here
> builtin-kmem.c: In function =E2=80=98perf_evsel__process_page_free_ev=
ent=E2=80=99:
> builtin-kmem.c:431: error: declaration of =E2=80=98stat=E2=80=99 shad=
ows a global declaration
> /usr/include/sys/stat.h:455: error: shadowed declaration is here

=46ixed in Arnaldo's core branch; he will push to urgent and Ingo soon.

David
