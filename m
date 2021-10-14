Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE24C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 05:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76022610CB
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 05:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhJNF6M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 01:58:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43063 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhJNF6M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Oct 2021 01:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634190967; x=1665726967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Sf+179vW/iQYlKmtz8f0y7xIP3dUveU16tfuDHqj1X0=;
  b=QTT7P1ekMqg82WISG+Ae6uL+sp3gcGWYDTX0S/eLP8f/vFmjpwJcudjH
   VAzbPK5PkNqc+nBYgn7MJh4XqIOUFRRdLdgj4iSrb5OB6YeNV1jpYavbS
   oq3LqfUXWM+lBQS/UqEgHW88hwOfYoe44SLD8K/tBNGbhJCaXuQA2zYp7
   pVz1GiRitSIt4InlXzey11cnSN9RCYItrO1QlEsHpTT8XDmWzNLdLLt1P
   oFTkTvJNGWUj1Nt3UUrsW15Plm4etqz1awaaLnvq0bxOAVqgoA4xUoa7u
   T+spB34sKxTVRAar1pGBOUZ3kXwpIcIRJDp+gK/dhB6q8TYf7rZKAONf/
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,371,1624291200"; 
   d="scan'208";a="294531046"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2021 13:56:07 +0800
IronPort-SDR: G5ERmuz5u68Ykn5uLCGM7Dg6UHMd58RxD+4wJ3WRsL5lgdg8L53F54OVIKvuz2VJthafND7JkM
 TQm7z15YaNpKh+GSKrc+jhfE5WWUod4Shgh/AjG+klA+BC+F/WUcZ5AtInASJGNgKMUDUfa+ky
 qKCGK8NwafxFj+M5ECUMfy4nL8RO7EaAmt50CtFOOVemG51m6lZDXOCtfmhUNzGBhi8b+HJlXT
 RROpVNgcuRjuRCpmBY6dwEefsK9O9/oxV33Zeb0FwTYXuKebMy35eLEBrssjDXsYL5T0tKqMET
 NsT23wogLKmmJkBhDQd9lYYt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 22:30:20 -0700
IronPort-SDR: KImnLPtd5wLAWQjsuH3aqS104GXp49WjM7mKWKBFW5JljV5ZLpFbO6aBiIxLD1G7OShM+6us72
 qRfmqlM0tx3vtz3DFL+yJ53txsokCy6GfVDYhxXUP4bSyPeW06kPpEokgMd+acYftQjJChKrKZ
 Gs8UNUj27ofcH470/JAgSYtuNm7eLWKvKa5NHx6ED71QTFJTEd1j/6ARhLWQ9g+420A0eYYMtZ
 sd+RublqpJavLvFrVkUxHwuar4Ozxk8QfhELGovM29tEa7seNh8yK6TEYd131LABc3ZJvnCncc
 Skk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 22:56:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HVJYM21D5z1RvmJ
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Oct 2021 22:56:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634190965; x=1636782966; bh=Sf+179vW/iQYlKmtz8
        f0y7xIP3dUveU16tfuDHqj1X0=; b=hC46IN7cy5gRrX4LT14zPDnZWoNyg48Yal
        2OfYpq+jCdC0M1FUwYdvCamDDUARVTRbvzae9xDK0xF1mp7LR3eBeGdbhK7m7L7P
        EQ7vprUmO0CUhi5sOAR8k2bEfMCoWbOxg0vJqYkkWWPInFPrt4cjfZe/NK6k3H6H
        sEqOdz8yLwvULfkxGhGdIEoa0cLgEBV4KMav/t4gjdFZZBhy2NzrqdcsYOAip/Gy
        JNmavE6kkozByqzIoVNJU0M4XAlYq2dmTyht0FoPtH3D0xMoHZACwmOnQxQsnWdT
        8Ywzr39lIz/qG/H6uCEygHC7ez+mnvUCafFqhMOiKTh+6E7i/fTg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TYHVm9LFFaDG for <linux-perf-users@vger.kernel.org>;
        Wed, 13 Oct 2021 22:56:05 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.36])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HVJY54SCtz1Rvlw;
        Wed, 13 Oct 2021 22:55:52 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] selftests: futex: Use a 64-bit time_t
Date:   Thu, 14 Oct 2021 15:55:27 +1000
Message-Id: <20211014055527.1238645-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com>
References: <20211014055527.1238645-1-alistair.francis@opensource.wdc.com>
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
 .../futex/functional/futex_requeue_pi.c       |  6 +--
 .../selftests/futex/functional/futex_wait.c   |  2 +-
 .../futex_wait_private_mapped_file.c          |  2 +-
 .../futex/functional/futex_wait_timeout.c     |  8 ++--
 .../futex/functional/futex_wait_wouldblock.c  |  2 +-
 .../selftests/futex/include/futextest.h       | 39 +++++++++++++++----
 7 files changed, 43 insertions(+), 18 deletions(-)

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
index 1ee5518ee6b7f..497c0dc80916f 100644
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
@@ -290,7 +290,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		time_t secs;
=20
 		info("timeout_ns =3D %ld\n", timeout_ns);
-		ret =3D clock_gettime(CLOCK_MONOTONIC, &ts);
+		ret =3D gettime64(CLOCK_MONOTONIC, &ts);
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
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
index ddbcfc9b7bac4..72361b41cdbae 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,12 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
=20
+struct timespec64 {
+	long long tv_sec;       /* seconds */
+	long long tv_nsec;      /* nanoseconds */
+};
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
@@ -67,15 +72,35 @@ typedef volatile u_int32_t futex_t;
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
+#if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
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
@@ -95,7 +120,7 @@ futex_wake(futex_t *uaddr, int nr_wake, int opflags)
  * @bitset:	bitset to be used with futex_wake_bitset
  */
 static inline int
-futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
+futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec64 *timeou=
t,
 		  u_int32_t bitset, int opflags)
 {
 	return futex(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bitset,
@@ -118,7 +143,7 @@ futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int3=
2_t bitset, int opflags)
  * @detect:	whether (1) or not (0) to perform deadlock detection
  */
 static inline int
-futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
+futex_lock_pi(futex_t *uaddr, struct timespec64 *timeout, int detect,
 	      int opflags)
 {
 	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
@@ -183,7 +208,7 @@ futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_=
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

