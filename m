Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D3CC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 00:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A9D61040
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Oct 2021 00:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhJOA7R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 20:59:17 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46612 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhJOA7Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Oct 2021 20:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634259430; x=1665795430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vox09O8iJZNJFD6HnQqSS+dhijYiK6HKhu64AHS7bHs=;
  b=QiG76X39WSxooxq56vDQNthWM3YHGD16S6DZquwqclxJ/Q5lgXADsPys
   0q3jANE6ivICstuc6uOCMXLN6KuK1TyFWBjINSPwU0Syf302NLukrIuu1
   APsiM03w25O7esiVaNevHZJvEHrOzpLtV9KCq2PbHvV/4H3EQ5nJMsygM
   XjaLVYD16kXyKuFC/+EhhZoPSDqmHqAgjWLW3JJgpWhbi1uQLiWn5d0xZ
   uV54GcLlli8xPgy3GcgZhCegc46VTb6CUce+1Rx1+pJmBX7Kqnro+Moh0
   jWtc0v7UyS2Jy/yvGZq+UZBXmvZSnEDXyHPPK1ISj9MqGDITKmpac8WID
   A==;
X-IronPort-AV: E=Sophos;i="5.85,374,1624291200"; 
   d="scan'208";a="182900004"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 08:57:10 +0800
IronPort-SDR: PGQnZUFmfR5FvlqkCUQJFav0ncPwo3kTjgUwd3DF6OX5UMWmhtOaDFIS8r4rtNF6pf/2cj9gOZ
 dgiSZpluaP3CZeM+n/umguGAG+yqQ8tsU6QHMk8jq9lki8z9uFXlZpXykxAe3RBafmrjzlBx24
 YuhMNN8/7zUb9720VKQ/tOyF4bFKSkcsHzGc+AGVaAK48sjqrYrEt8dLVPv/RMgL2ikWvXHO/O
 QjEVIb6szbcbIQ/tDDiQnO8629JvV/+KNeGAj76QESaMUvZHXxzeUTJmjqW2rygcWRZsmHC1Ts
 THUBnMT8JQ/EjZMRHbdB447i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:32:55 -0700
IronPort-SDR: Fo91xT2xfz1xwXA8iJj1ya4htqBkcDJCuog4i6t4P3FsrzCnQtZvPJD+DX/csHuFTYP0nFL+xy
 16BUca+EYRNcIcAxG8UnZ3sA5hUq/sXR/1ugSeadhnsNB1hmsta7R06p6SFZeXvfHiWtJEVMVT
 0aZ19NYYpDanSKUZtIgr2nKFiFXjIJK2LXadcLqH3v0LnJhkH7YPZ/0aX21bNLfM48fS5K/vNJ
 bEY6RryXEK9JdRz1o6jscsHhjPUIRPHG33oUXwMbViZsgAVB+l9hLdJZ3G5dUbBrC2/+mGQ5ur
 /C8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 17:57:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVnsy2yz1z1Rvm0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Oct 2021 17:57:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634259428; x=1636851429; bh=vox09O8iJZNJFD6HnQ
        qSS+dhijYiK6HKhu64AHS7bHs=; b=VmvreB8M797gFnF1vsWLSqll7HLmf9ylg/
        t/c5zxAas4brEoT1j3KqTfDAACztLUgQmCp05JUZFCuHFdfHmEukjpIRyctJGM4g
        cMQp9lAfzKYJryypmWQBwYVo7CL8Uxt20z5TrkBR7mjS5op+F3NYOlu6pvZq5Hb7
        EkC7ZuW8qrchojxCq6mOtwfj53i2+qf+BXVn30JuiSc7JuaOK/seXAqeZdlSJhKv
        vQIB2QyFJCoDNLqLUby4PQMDqk+0QoICiOWFIiOQoEx/5afiBEsGM/cYsuDtosid
        Xl7nLviwB3E8SqTtxXQ8gRecocdhDv71y2OqErY5fiNxfZfQ1mmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id owX6TxBafFqT for <linux-perf-users@vger.kernel.org>;
        Thu, 14 Oct 2021 17:57:08 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVnsj1CGPz1Rvlg;
        Thu, 14 Oct 2021 17:56:56 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 2/2] selftests: futex: Use a 64-bit time_t
Date:   Fri, 15 Oct 2021 10:56:34 +1000
Message-Id: <20211015005634.2658470-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
References: <20211015005634.2658470-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Convert the futex selftests to only use a 64-bit time_t. On 64-bit
architectures this isn't a functional change. On 32-bit architectures
we now only perform 64-bit time_t syscalls (__NR_futex_time64) and
use a struct timespec64.

This won't work on kernels before 5.1, but as perf is tied to the kernel
that's ok.

This allows the tests to run and pass on RISC-V 32-bit.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../futex/functional/futex_requeue.c          |  2 +-
 .../futex/functional/futex_requeue_pi.c       | 10 ++---
 .../selftests/futex/functional/futex_wait.c   |  2 +-
 .../futex_wait_private_mapped_file.c          |  2 +-
 .../futex/functional/futex_wait_timeout.c     |  8 ++--
 .../futex/functional/futex_wait_wouldblock.c  |  2 +-
 .../selftests/futex/include/futextest.h       | 37 +++++++++++++++----
 7 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/t=
ools/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f1..f51aedffcd161 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -27,7 +27,7 @@ void usage(char *prog)
=20
 void *waiterfn(void *arg)
 {
-	struct timespec to;
+	struct timespec64 to;
=20
 	to.tv_sec =3D 0;
 	to.tv_nsec =3D timeout_ns;
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7f..32d6ee554ec2e 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -48,7 +48,7 @@ static int locked;
=20
 struct thread_arg {
 	long id;
-	struct timespec *timeout;
+	struct timespec64 *timeout;
 	int lock;
 	int ret;
 };
@@ -281,7 +281,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 	struct thread_arg blocker_arg =3D THREAD_ARG_INITIALIZER;
 	struct thread_arg waker_arg =3D THREAD_ARG_INITIALIZER;
 	pthread_t waiter[THREAD_MAX], waker, blocker;
-	struct timespec ts, *tsp =3D NULL;
+	struct timespec64 ts, *tsp =3D NULL;
 	struct thread_arg args[THREAD_MAX];
 	int *waiter_ret;
 	int i, ret =3D RET_PASS;
@@ -290,12 +290,12 @@ int unit_test(int broadcast, long lock, int third_p=
arty_owner, long timeout_ns)
 		time_t secs;
=20
 		info("timeout_ns =3D %ld\n", timeout_ns);
-		ret =3D clock_gettime(CLOCK_MONOTONIC, &ts);
+		ret =3D gettime64(CLOCK_MONOTONIC, &ts);
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
-		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
+		info("ts.tv_sec  =3D %lld\n", ts.tv_sec);
+		info("ts.tv_nsec =3D %lld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
=20
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tool=
s/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d2..d1c8a4212c74c 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -30,7 +30,7 @@ void usage(char *prog)
=20
 static void *waiterfn(void *arg)
 {
-	struct timespec to;
+	struct timespec64 to;
 	unsigned int flags =3D 0;
=20
 	if (arg)
diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_=
mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_priva=
te_mapped_file.c
index fb4148f23fa37..5e84e136ad99e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_=
file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_=
file.c
@@ -38,7 +38,7 @@ futex_t val =3D 1;
 char pad2[PAGE_SZ] =3D {1};
=20
 #define WAKE_WAIT_US 3000000
-struct timespec wait_timeout =3D { .tv_sec =3D 5, .tv_nsec =3D 0};
+struct timespec64 wait_timeout =3D { .tv_sec =3D 5, .tv_nsec =3D 0};
=20
 void usage(char *prog)
 {
diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.=
c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 1f8f6daaf1e70..86b1e847a0246 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -71,11 +71,11 @@ static void test_timeout(int res, int *ret, char *tes=
t_name, int err)
 /*
  * Calculate absolute timeout and correct overflow
  */
-static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
+static int futex_get_abs_timeout(clockid_t clockid, struct timespec64 *t=
o,
 				 long timeout_ns)
 {
-	if (clock_gettime(clockid, to)) {
-		error("clock_gettime failed\n", errno);
+	if (gettime64(clockid, to)) {
+		error("gettime64 failed\n", errno);
 		return errno;
 	}
=20
@@ -93,7 +93,7 @@ int main(int argc, char *argv[])
 {
 	futex_t f1 =3D FUTEX_INITIALIZER;
 	int res, ret =3D RET_PASS;
-	struct timespec to;
+	struct timespec64 to;
 	pthread_t thread;
 	int c;
=20
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblo=
ck.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 0ae390ff81644..76faa664544d6 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -38,7 +38,7 @@ void usage(char *prog)
=20
 int main(int argc, char *argv[])
 {
-	struct timespec to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
+	struct timespec64 to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
 	futex_t f1 =3D FUTEX_INITIALIZER;
 	int res, ret =3D RET_PASS;
 	int c;
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index ddbcfc9b7bac4..67ed97a455274 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -47,12 +48,14 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
=20
+#define timespec64 __kernel_timespec
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
- * @timeout:	typically an absolute struct timespec (except where noted
+ * @timeout:	typically an absolute struct timespec64 (except where noted
  *              otherwise). Overloaded by some ops
  * @uaddr2:	address of second futex for some ops\
  * @val3:	varies by op
@@ -67,15 +70,35 @@ typedef volatile u_int32_t futex_t;
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted bel=
ow.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+/**
+ * We only support 64-bit time_t for the timeout.
+ * On 64-bit architectures we can use __NR_futex
+ * On 32-bit architectures we use __NR_futex_time64. This only works on =
kernel
+ * versions 5.1+.
+ */
+#if __BITS_PER_LONG =3D=3D 64
+# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
+	syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+#else
+# define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
+	syscall(__NR_futex_time64, uaddr, op | opflags, val, timeout, uaddr2, v=
al3)
+#endif
+
+static inline int gettime64(clock_t clockid, struct timespec64 *tv)
+{
+#if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
+	return syscall(__NR_clock_gettime, clockid, tv);
+#else
+	return syscall(__NR_clock_gettime64, clockid, tv);
+#endif
+}
=20
 /**
  * futex_wait() - block on uaddr with optional timeout
  * @timeout:	relative timeout
  */
 static inline int
-futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int op=
flags)
+futex_wait(futex_t *uaddr, futex_t val, struct timespec64 *timeout, int =
opflags)
 {
 	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
 }
@@ -95,7 +118,7 @@ futex_wake(futex_t *uaddr, int nr_wake, int opflags)
  * @bitset:	bitset to be used with futex_wake_bitset
  */
 static inline int
-futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
+futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec64 *timeou=
t,
 		  u_int32_t bitset, int opflags)
 {
 	return futex(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bitset,
@@ -118,7 +141,7 @@ futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int3=
2_t bitset, int opflags)
  * @detect:	whether (1) or not (0) to perform deadlock detection
  */
 static inline int
-futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
+futex_lock_pi(futex_t *uaddr, struct timespec64 *timeout, int detect,
 	      int opflags)
 {
 	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
@@ -183,7 +206,7 @@ futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_=
t *uaddr2, int nr_wake,
  */
 static inline int
 futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
-		      struct timespec *timeout, int opflags)
+		      struct timespec64 *timeout, int opflags)
 {
 	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
 		     opflags);
--=20
2.31.1

