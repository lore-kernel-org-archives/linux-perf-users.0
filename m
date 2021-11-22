Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A34C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 22 Nov 2021 23:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhKVX0F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:26:05 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:44499 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhKVX0F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 22 Nov 2021 18:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637623376; x=1669159376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YQ/XAKWYAeapcTzZkPgcULpc8rtRC5bV6gTHpBAfk4o=;
  b=mPwQjwmoRKT3R4rlvLuFUnEK1isZkCvqay+qn+EaJ07WzAp1JNENUYl6
   6xvsGkGQ1jgeaezcbFJHDFbn9fSVdsrrCJPVtd8CrgItE/mEcjM7dY4gP
   7i8gYHgt7BXT4O2C49qP2dpsAlO98lNjvrU0XmAMDKPFGrJihWCGsgDnT
   y+E/OgURRF/HSHwSx5iJVCUI3Z5xuo6DJhO+hS9nCeSV+B5/cPOkqJrd0
   aoWcCtB/vQwBM73GvrgEe05ZVrqdQnhYG1xG20aCI6Sm1gaOpdKEJzQpi
   rxc+tjHwRbK3caR2jrY6YZLpMRR50gof8ZqqZFTAy/AfB8GjAKc9gco6g
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,255,1631548800"; 
   d="scan'208";a="191158502"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2021 07:22:56 +0800
IronPort-SDR: sOOv7S2/vsMmLHqJFg4bh+MLA119MqFlkKiTehJbdKH1sWBbms0COy6yJgABtJg6nV+2AkeFsY
 Fhmh0tr6UtDiaOZ2QwxZgDyk1etr4R8iDfC1Ay86rZfVruhXV3CORhJIKTgmRZPt50yG09S2zQ
 8qnDpXgonIznRpsUEAaby7bj/JsykaUS106a+UCWGSEEwGuSqgmC3V0uobMZEdExsTmxtbjW+g
 O1z7tLthYwu7oQveAfubazpQGqdMJjUn+0GeChT2IuxA+33fxgz8TOzGJz/k7YeUB8SD3yBcd/
 7dn6cklF6HqvhMEyKtwPnOyz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 14:56:20 -0800
IronPort-SDR: V1hQ+O2W//7AKSuUEJq5cyyFnqKym1QCO+nb3gMc6n+W4KQQh9RWqMTuXzQQ2pfrsS7W80VKcV
 CslOwFXonMfTtz6vYVZ67JD1FMtf/za9mK58pk+LdBkX9C6pBB211H2u7qhnzmyU1deHox0omI
 xpqnuTV3tMMQybniAnO8rdCenwhVwRQpvTFSkqEWmV2hDeArXHns5yXjH3+qTGPKQn22VvYXdv
 TLDGZTDeje7OVIgDTmxg1ccIu9cm04uVXAw35xonnD+1gzQeI9rc7aN2/O11be1pB6WA8oJYfg
 U8g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 15:22:59 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HyjxF2V1Fz1RtVy
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Nov 2021 15:22:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1637623376;
         x=1640215377; bh=YQ/XAKWYAeapcTzZkPgcULpc8rtRC5bV6gTHpBAfk4o=; b=
        uXuB4eILMIMxwqKN5uy0RnqMStAIUYqYfAhMgkwBD9YGxxZ41LQRHYE/MKtMi3uL
        a3m1GSKUR8wRfYAWzJ18ZiuEMysESzsZr0kvc/BPrUfQgmKs6/UI7asqjytSLPfm
        W1YLwL1qOwxKS57KooHddtSC0+d7+4KI6rsxFCwqBGLbUm/Nu0dB9uRZDI054q6f
        2zq99/11ZNtQD+uLgT8TdRfxHZeim7kyhqDPVWIkvuoB1/RtFmW1t4y2qBz2zXXc
        MXHVL3wH2P17Pgw9F3CBLLQNS7cqIOK7oJZjAiduPrmj1HEwg2LPgqwBRT+sxIiG
        5hGpZGBvxikJjTYwNUyijQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x7RgLQPPDqlR for <linux-perf-users@vger.kernel.org>;
        Mon, 22 Nov 2021 15:22:56 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hyjwz2rT7z1RtVl;
        Mon, 22 Nov 2021 15:22:42 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, namhyung@kernel.org, dave@stgolabs.net,
        arnd@arndb.de, linux-kernel@vger.kernel.org, jolsa@redhat.com,
        acme@kernel.org, alistair23@gmail.com, dvhart@infradead.org,
        mingo@redhat.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 1/2] selftests: futex: Call the futex syscall from a function
Date:   Tue, 23 Nov 2021 09:22:35 +1000
Message-Id: <20211122232236.119533-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Call the futex syscall from a function

In preparation for a more complex futex() function let's convert the
current macro into two functions. We need two functions to avoid
compiler failures as the macro is overloaded.

This will allow us to include pre-processor conditionals in the futex
syscall functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../selftests/futex/include/futextest.h       | 59 +++++++++++--------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index ddbcfc9b7bac..c786fffecb8a 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -48,7 +48,7 @@ typedef volatile u_int32_t futex_t;
 #endif
=20
 /**
- * futex() - SYS_futex syscall wrapper
+ * futex_syscall() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -58,17 +58,26 @@ typedef volatile u_int32_t futex_t;
  * @val3:	varies by op
  * @opflags:	flags to be bitwise OR'd with op, such as FUTEX_PRIVATE_FLA=
G
  *
- * futex() is used by all the following futex op wrappers. It can also b=
e
+ * futex_syscall() is used by all the following futex op wrappers. It ca=
n also be
  * used for misuse and abuse testing. Generally, the specific op wrapper=
s
- * should be used instead. It is a macro instead of an static inline fun=
ction as
- * some of the types over overloaded (timeout is used for nr_requeue for
- * example).
+ * should be used instead.
  *
  * These argument descriptions are the defaults for all
  * like-named arguments in the following wrappers except where noted bel=
ow.
  */
-#define futex(uaddr, op, val, timeout, uaddr2, val3, opflags) \
-	syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, val3)
+static inline int
+futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
+	      volatile u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+}
+
+static inline int
+futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
+			 volatile u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+}
=20
 /**
  * futex_wait() - block on uaddr with optional timeout
@@ -77,7 +86,7 @@ typedef volatile u_int32_t futex_t;
 static inline int
 futex_wait(futex_t *uaddr, futex_t val, struct timespec *timeout, int op=
flags)
 {
-	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -87,7 +96,7 @@ futex_wait(futex_t *uaddr, futex_t val, struct timespec=
 *timeout, int opflags)
 static inline int
 futex_wake(futex_t *uaddr, int nr_wake, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags=
);
 }
=20
 /**
@@ -98,8 +107,8 @@ static inline int
 futex_wait_bitset(futex_t *uaddr, futex_t val, struct timespec *timeout,
 		  u_int32_t bitset, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bitset,
-		     opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT_BITSET, val, timeout, NULL, bits=
et,
+			     opflags);
 }
=20
 /**
@@ -109,8 +118,8 @@ futex_wait_bitset(futex_t *uaddr, futex_t val, struct=
 timespec *timeout,
 static inline int
 futex_wake_bitset(futex_t *uaddr, int nr_wake, u_int32_t bitset, int opf=
lags)
 {
-	return futex(uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL, NULL, bitset,
-		     opflags);
+	return futex_syscall(uaddr, FUTEX_WAKE_BITSET, nr_wake, NULL, NULL, bit=
set,
+			     opflags);
 }
=20
 /**
@@ -121,7 +130,7 @@ static inline int
 futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
 	      int opflags)
 {
-	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, op=
flags);
 }
=20
 /**
@@ -130,7 +139,7 @@ futex_lock_pi(futex_t *uaddr, struct timespec *timeou=
t, int detect,
 static inline int
 futex_unlock_pi(futex_t *uaddr, int opflags)
 {
-	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -140,8 +149,8 @@ static inline int
 futex_wake_op(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_wake2=
,
 	      int wake_op, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE_OP, nr_wake, nr_wake2, uaddr2, wake_op,
-		     opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_WAKE_OP, nr_wake, nr_wake2=
, uaddr2, wake_op,
+					opflags);
 }
=20
 /**
@@ -156,8 +165,8 @@ static inline int
 futex_requeue(futex_t *uaddr, futex_t *uaddr2, int nr_wake, int nr_reque=
ue,
 	      int opflags)
 {
-	return futex(uaddr, FUTEX_REQUEUE, nr_wake, nr_requeue, uaddr2, 0,
-		     opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_REQUEUE, nr_wake, nr_reque=
ue, uaddr2, 0,
+					opflags);
 }
=20
 /**
@@ -169,8 +178,8 @@ static inline int
 futex_cmp_requeue(futex_t *uaddr, futex_t val, futex_t *uaddr2, int nr_w=
ake,
 		  int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_r=
equeue, uaddr2,
+					val, opflags);
 }
=20
 /**
@@ -185,8 +194,8 @@ static inline int
 futex_wait_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2,
 		      struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
-		     opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2=
, 0,
+			     opflags);
 }
=20
 /**
@@ -200,8 +209,8 @@ static inline int
 futex_cmp_requeue_pi(futex_t *uaddr, futex_t val, futex_t *uaddr2, int n=
r_wake,
 		     int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, nr_wake, n=
r_requeue, uaddr2,
+					val, opflags);
 }
=20
 /**
--=20
2.31.1

