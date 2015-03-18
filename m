From: Vinson Lee <vlee@twopensource.com>
Subject: [PATCH v2] perf tools: Work around lack of sched_getcpu in glibc < 2.6.
Date: Wed, 18 Mar 2015 16:11:52 -0700
Message-ID: <1426720316-7470-1-git-send-email-vlee@twopensource.com>
References: <20150318091527.GM23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36422 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbbCRXMB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Mar 2015 19:12:01 -0400
Received: by padcy3 with SMTP id cy3so56169470pad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2015 16:12:01 -0700 (PDT)
In-Reply-To: <20150318091527.GM23123@twins.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>

=46rom: Vinson Lee <vlee@twitter.com>

This patch fixes this build error with glibc < 2.6.

  CC       util/cloexec.o
cc1: warnings being treated as errors
util/cloexec.c: In function =E2=80=98perf_flag_probe=E2=80=99:
util/cloexec.c:24: error: implicit declaration of function
=E2=80=98sched_getcpu=E2=80=99
util/cloexec.c:24: error: nested extern declaration of =E2=80=98sched_g=
etcpu=E2=80=99
make: *** [util/cloexec.o] Error 1

Cc: stable@vger.kernel.org # 3.18+
Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 tools/perf/util/cloexec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 6da965b..285bd70 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,6 +7,16 @@
=20
 static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
=20
+#ifdef __GLIBC_PREREQ
+#if !__GLIBC_PREREQ(2, 6)
+static int sched_getcpu(void)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+#endif
+#endif
+
 static int perf_flag_probe(void)
 {
 	/* use 'safest' configuration as used in perf_evsel__fallback() */
--=20
1.8.2.1
