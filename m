From: Vinson Lee <vlee@twopensource.com>
Subject: [PATCH] perf tools: Work around lack of sched_getcpu in glibc < 2.6.
Date: Fri, 13 Feb 2015 18:06:47 -0800
Message-ID: <1423879609-4373-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:39467 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbbBNCG7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 Feb 2015 21:06:59 -0500
Received: by pdjy10 with SMTP id y10so22953337pdj.6
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2015 18:06:59 -0800 (PST)
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
index 47b78b3..3738924 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,6 +7,12 @@
=20
 static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
=20
+#ifdef __GLIBC_PREREQ
+#if __GLIBC_PREREQ(2, 6)
+#define HAVE_SCHED_GETCPU
+#endif
+#endif
+
 static int perf_flag_probe(void)
 {
 	/* use 'safest' configuration as used in perf_evsel__fallback() */
@@ -21,9 +27,13 @@ static int perf_flag_probe(void)
 	pid_t pid =3D -1;
 	char sbuf[STRERR_BUFSIZE];
=20
+#ifdef HAVE_SCHED_GETCPU
 	cpu =3D sched_getcpu();
 	if (cpu < 0)
 		cpu =3D 0;
+#else
+	cpu =3D 0;
+#endif
=20
 	while (1) {
 		/* check cloexec flag */
--=20
1.8.2.1
