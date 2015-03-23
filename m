From: Vinson Lee <vlee@twopensource.com>
Subject: [PATCH v3] perf tools: Work around lack of sched_getcpu in glibc < 2.6.
Date: Mon, 23 Mar 2015 12:09:16 -0700
Message-ID: <1427137761-16119-1-git-send-email-vlee@twopensource.com>
References: <20150320203828.GN16485@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320203828.GN16485@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Namhyung Kim <namhyung@kernel.org>, Yann Droneaud <ydroneaud@opteya.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

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
 tools/perf/util/cloexec.c | 6 ++++++
 tools/perf/util/cloexec.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index 6da965b..85b5238 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -7,6 +7,12 @@
=20
 static unsigned long flag =3D PERF_FLAG_FD_CLOEXEC;
=20
+int __weak sched_getcpu(void)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
 static int perf_flag_probe(void)
 {
 	/* use 'safest' configuration as used in perf_evsel__fallback() */
diff --git a/tools/perf/util/cloexec.h b/tools/perf/util/cloexec.h
index 94a5a7d..68888c2 100644
--- a/tools/perf/util/cloexec.h
+++ b/tools/perf/util/cloexec.h
@@ -3,4 +3,10 @@
=20
 unsigned long perf_event_open_cloexec_flag(void);
=20
+#ifdef __GLIBC_PREREQ
+#if !__GLIBC_PREREQ(2, 6)
+extern int sched_getcpu(void) __THROW;
+#endif
+#endif
+
 #endif /* __PERF_CLOEXEC_H */
--=20
1.8.2.1
