From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/15] perf/urgent fixes
Date: Wed, 6 Jun 2012 08:50:14 +0200
Message-ID: <20120606065014.GB17808@gmail.com>
References: <1338588999-32509-1-git-send-email-acme@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56409 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab2FFGuV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Jun 2012 02:50:21 -0400
Content-Disposition: inline
In-Reply-To: <1338588999-32509-1-git-send-email-acme@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: linux-kernel@vger.kernel.org, Akihiro Nagai <akihiro.nagai.hw@hitachi.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anton Arapov <anton@redhat.com>, Avik Sil <avik.sil@linaro.org>, Borislav Petkov <borislav.petkov@amd.com>, Corey Ashford <cjashfor@linux.vnet.ibm.com>, David Ahern <dsahern@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Mike Galbraith <efault@gmx.de>, Namhyung Kim <namhyung@gmail.com>, Namhyung Kim <namhyung.kim@lge.com>, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Stephane Eranian <eranian@google.com>, Steven Rostedt <rostedt@goodmis.org>, Sunjin Yang <fan4326@gmail.com>, Thomas Gleixner <tglx@li>


* Arnaldo Carvalho de Melo <acme@infradead.org> wrote:

> Hi Ingo,
>=20
> 	Please consider pulling, this is in addition to what already were in
> perf/urgent.
>=20
> - Arnaldo
>=20
> The following changes since commit 79695e1bb65ba0e21488c360a1bed6e358=
354aaa:
>=20
>   perf stat: Initialize default events wrt exclude_{guest,host} (2012=
-05-30 14:02:38 -0300)
>=20
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-=
urgent-for-mingo
>=20
> Arnaldo Carvalho de Melo (2):
>       perf tools: Fix make tarballs
>       perf tools: Make --version show kernel version instead of pull =
req tag
>=20
> Avik Sil (1):
>       perf tools: Fix pager on minimal-install embedded systems
>=20
> David Ahern (2):
>       perf script: Fix regression in callchain dso name
>       perf tool: Build fix, remove duplicate declarations
>=20
> Jiri Olsa (3):
>       perf symbols: Handle different endians properly during symbol l=
oad
>       perf session: Handle endianity swap on sample_id_all header dat=
a
>       perf evsel: Fix 32 bit values endianity swap for sample_id_all =
header
>=20
> Namhyung Kim (5):
>       perf callchain: Make callchain cursors TLS
>       perf tools: Check if callchain is corrupted
>       perf tools: Update ioctl documentation for PERF_IOC_FLAG_GROUP
>       perf evlist: Pass third argument to ioctl explicitly
>       perf: Remove duplicate invocation on perf_event_for_each
>=20
> Srikar Dronamraju (2):
>       perf symbols: Check for valid dso before creating map
>       perf uprobes: Remove unnecessary check before strlist__delete
>=20
>  include/linux/perf_event.h       |    4 +-
>  kernel/events/core.c             |    1 -
>  tools/perf/MANIFEST              |    2 +
>  tools/perf/builtin-report.c      |    2 +-
>  tools/perf/builtin-top.c         |    2 +-
>  tools/perf/design.txt            |    7 ++-
>  tools/perf/util/PERF-VERSION-GEN |    2 +-
>  tools/perf/util/callchain.c      |    2 +
>  tools/perf/util/callchain.h      |    2 +
>  tools/perf/util/evlist.c         |    6 ++-
>  tools/perf/util/evsel.c          |   29 +++++++++---
>  tools/perf/util/hist.c           |    7 ++-
>  tools/perf/util/hist.h           |    2 -
>  tools/perf/util/pager.c          |    4 ++
>  tools/perf/util/probe-event.c    |    8 +--
>  tools/perf/util/session.c        |   97 ++++++++++++++++++++++++++++=
+--------
>  tools/perf/util/symbol.c         |   38 ++++++++++++++-
>  tools/perf/util/symbol.h         |   34 ++++++++++++-
>  tools/perf/util/util.h           |    6 +--
>  19 files changed, 195 insertions(+), 60 deletions(-)

Hm, I got this build failure:

bench/mem-memcpy.c: In function =E2=80=98bench_mem_memcpy=E2=80=99:
bench/mem-memcpy.c:193:2: error: implicit declaration of function =E2=80=
=98perf_atoll=E2=80=99 [-Werror=3Dimplicit-function-declaration]
bench/mem-memcpy.c:193:2: error: nested extern declaration of =E2=80=98=
perf_atoll=E2=80=99 [-Werror=3Dnested-externs]

Which appears to be a result of:

6b7df4a0237a perf tool: Build fix, remove duplicate declarations

Those declarations were not so unused on this fresh install of=20
=46edora 17.

Luckily, the offending commit was the last one in the series, so=20
I merged your tree at cb7225f, excluding only the buggy commit.

Thanks,

	Ingo
