Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966DC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358756AbhKZGIa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:08:30 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11810 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358763AbhKZGGa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906597; x=1669442597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oUs8KHpPoES62pGveh25YWvNvWsKpMxtp/olrjhpVBo=;
  b=YXe+c9t/GQ9zDUpPBhlaesx1udIX32JmIW2UVsC4oCn2z+ndv+PwV1la
   gZO3YPGS/3gItBqlZ2INwDt2CGeHefHzHYkCIUzXWVhyYPkFZ5EYRpahc
   PlnqisB5598pl57XxypfZFEHpL8621zTCp9iwGR3RouhduEeFyDB7/ibS
   I5hKW4vX/nL4nqeCszy0erQ2qxgryPhtjGPb8NZFrQSBwkygvC6E2s3XE
   KUqNOKPgF7bXGSsd5gHHDaUeALW5+77NWiAGCHzkkFs05wIISnKrYecyi
   ZTETo4PquI0J6vRvSZC6pMD35LJJ26Ayd1k7bQHQ0QfMbSMt6MoCdl653
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="191493926"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:01:27 +0800
IronPort-SDR: FUZObnQiMyKM30Np/taksJZWEwr6EEJoOANv9y0UG6uIaiLKihVV36LaP31RkR6rZplkfOIzTX
 QMhjvyfiN1Eh4WPl+MNZqVB0qKlj71zFcC8xexFAk8/vphp/vvm0rQC9qGh4m+F7+gtMiaWr1p
 4TKUeKr+8Tp4O75+qbzxBYROpADnhUqQtaSuT9eG6UolbxvUMLxqC3yS3MqshVR/PbuV/CsRR5
 NzlQS32D3hBNHgIU7oUWTdLy1mKUt77CWSE6wW32K1/W9D9MCC7ESY8GAE1Xe57icAiaQyjJ1r
 HZiYyPLTv/WFRNHUsy8a5rl+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:34:46 -0800
IronPort-SDR: ueQOVVBDKmwgN2MiEQ2ZO4Ifi7VQet0yYk4pMsJq7HJ9VNEtQSmP+j6D4y5f/zfd2KM6DfLDt9
 fOasDuJRBK/6yccCHKVzgP+MlXYYETvvoR3UbLjFxH/Wi2bJN6Dh/D17tBmXpkjUTCrAgIQl5Q
 uJneh1bAUnVg/jtoUxrOyu4Aoc5EzHT20oAoiBivVUgDqt7kSEwflUcMt1dFuwO9pasmXZ2zgR
 R/58YaxqOVjD9XIxgey6rb6zajlFNVDnMGjl4tdGeWhNhRliVLYuJtg52zvCeZyPcMc/dsRJ46
 Grs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kdf65tPz1RtVv
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:01:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906485; x=1640498486; bh=oUs8KHpPoES62pGveh
        25YWvNvWsKpMxtp/olrjhpVBo=; b=ADB3Iga72GY66n+Uk4bV4rpd9x0Ognceny
        byUnLSah0nVg7yvJK5Aq1Mj+bX2p4AqBYvGWHYAYtLWQWQjvWbeWOITmKpkA9RFv
        hh34RuaH0uEyAAnbEJqNlBOy22wvJD0wWpnjyFkE2n1AlYWA4QwbJ53vKIIcnNll
        Rt8486s/kqn/6uq4oX5E8YPeUmkeaho9v0Sxkfa1Cp1sxY/5aTjyMR0daR94Yaj9
        GJGeuLN+rmsJ65GSQnG4jNWiTsMKNrxTtHkkW2HnOVQ+rsH/kuth0qIrGIlpvBSk
        ZfwekZfEez2+Ge676qILQLIu3Qml1LRIQUwf4uuLhyCGWWia7UJA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3TBaCYNdvCv3 for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:01:25 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kdT2FD4z1RtW3;
        Thu, 25 Nov 2021 22:01:16 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 6/6] selftests: futex: Use futex_waitv helper function
Date:   Fri, 26 Nov 2021 16:00:24 +1000
Message-Id: <20211126060024.3290177-6-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Use the publically exposed __kernel_futex_syscall_waitv() helper
function for the futex_waitv tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../futex/functional/futex_wait_timeout.c     |  6 ++---
 .../futex/functional/futex_wait_wouldblock.c  |  4 ++--
 .../selftests/futex/functional/futex_waitv.c  | 16 ++++++++------
 .../selftests/futex/include/futex2test.h      | 22 -------------------
 4 files changed, 14 insertions(+), 34 deletions(-)
 delete mode 100644 tools/testing/selftests/futex/include/futex2test.h

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.=
c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 3651ce17beeb..f25e3bd8222e 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -15,9 +15,9 @@
  *
  ***********************************************************************=
******/
=20
+#include <linux/futex_syscall.h>
 #include <pthread.h>
 #include "futextest.h"
-#include "futex2test.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait-timeout"
@@ -185,13 +185,13 @@ int main(int argc, char *argv[])
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
 		return RET_FAIL;
-	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC=
);
 	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
=20
 	/* futex_waitv with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
 		return RET_FAIL;
-	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
+	res =3D __kernel_futex_syscall_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME)=
;
 	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
=20
 	ksft_print_cnts();
diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblo=
ck.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 7d7a6a06cdb7..399ac636524b 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -17,12 +17,12 @@
=20
 #include <errno.h>
 #include <getopt.h>
+#include <linux/futex_syscall.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
 #include "futextest.h"
-#include "futex2test.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait-wouldblock"
@@ -96,7 +96,7 @@ int main(int argc, char *argv[])
 	}
=20
 	info("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+=
1);
-	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC=
);
 	if (!res || errno !=3D EWOULDBLOCK) {
 		ksft_test_result_pass("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/too=
ls/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..8ba45363c094 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <error.h>
 #include <getopt.h>
+#include <linux/futex_syscall.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -16,7 +17,6 @@
 #include <stdint.h>
 #include <sys/shm.h>
 #include "futextest.h"
-#include "futex2test.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait"
@@ -25,6 +25,8 @@
 static struct futex_waitv waitv[NR_FUTEXES];
 u_int32_t futexes[NR_FUTEXES] =3D {0};
=20
+#define u64_to_ptr(x) ((void *)(uintptr_t)(x))
+
 void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -45,7 +47,7 @@ void *waiterfn(void *arg)
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_M=
ONOTONIC);
 	if (res < 0) {
 		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      errno, strerror(errno));
@@ -153,7 +155,7 @@ int main(int argc, char *argv[])
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_M=
ONOTONIC);
 	if (res =3D=3D EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
@@ -172,7 +174,7 @@ int main(int argc, char *argv[])
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_M=
ONOTONIC);
 	if (res =3D=3D EINVAL) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
@@ -190,7 +192,7 @@ int main(int argc, char *argv[])
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(waitv, NR_FUTEXES, 0, &to, CLOCK_M=
ONOTONIC);
 	if (res =3D=3D EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
@@ -206,7 +208,7 @@ int main(int argc, char *argv[])
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_MONOTONIC);
+	res =3D __kernel_futex_syscall_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_MO=
NOTONIC);
 	if (res =3D=3D EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
@@ -222,7 +224,7 @@ int main(int argc, char *argv[])
=20
 	to.tv_sec++;
=20
-	res =3D futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TAI);
+	res =3D __kernel_futex_syscall_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TA=
I);
 	if (res =3D=3D EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/t=
esting/selftests/futex/include/futex2test.h
deleted file mode 100644
index 9d305520e849..000000000000
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Futex2 library addons for futex tests
- *
- * Copyright 2021 Collabora Ltd.
- */
-#include <stdint.h>
-
-#define u64_to_ptr(x) ((void *)(uintptr_t)(x))
-
-/**
- * futex_waitv - Wait at multiple futexes, wake on any
- * @waiters:    Array of waiters
- * @nr_waiters: Length of waiters array
- * @flags: Operation flags
- * @timo:  Optional timeout for operation
- */
-static inline int futex_waitv(volatile struct futex_waitv *waiters, unsi=
gned long nr_waiters,
-			      unsigned long flags, struct timespec *timo, clockid_t clockid)
-{
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, cloc=
kid);
-}
--=20
2.31.1

