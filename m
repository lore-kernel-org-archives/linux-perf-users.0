Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C59EC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7AF6112D
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhJVBhC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:37:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44478 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJVBg7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 21:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866482; x=1666402482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQmD8tz0siK/3ewe7eS/wMF3ydoICuJwawIePzDCHFY=;
  b=QqKLPPlrRqDkPFkGknyXIsN/CgKur96in4HposD8gXlGlQAa6hIrnskE
   yKvmdhSyPt2IoragWJsSfIdIpu6G06+6JEnhYXxozshxx8hZ5ZAzAMjU1
   0iI/wahJo5dDVmgnVvexc5on0RucyHHpGK5ryBE/BkqCua2V4Gywpr4L1
   LCjqoTSzj4mnnnuC/IgrXv7vE6jyqSSk/LTdzwfkENYrVd1tOeMvF7FBk
   4gJ5AGKvRh2WNxHHbwuhpDkMDler6oJJh7vHW2jGQvlvLZ+L+Apne0Am+
   AuXNe0uS5nv0SpJ72md+kkxDHtltYXfRRiFvQPVGpjFwIOP1jRXudrE9e
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="295304686"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:34:32 +0800
IronPort-SDR: nTzEWTSVa0o5UgIeEal2azOuWC4aYqHh3k9b3d82BFTaNwdfb5d49tzUt0KYzcXJxXhp5yH7PU
 gT8Ejh9rKNUwM01mWA10tnI9NIfpr/GvoZXdMjyCGVfUwIOYuctaqx4j5i7VFALUoFhKkHSCmZ
 Tzr8LngY4Zvdsl3/Dr2Sg57g4hLWltjIAxxoTMyKtWUJZph1yqwYYR97x+P1y0+YkYnulrSGQr
 xh4to6u+TqriFGqX5D4yf3T7yhPlVEqOfSE8LAN++tpNOOKh9YBHBdF4D4P3hgrikiXX0u1Mxh
 jsMegCz4faa8sEYiLpoOGCa6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:08:34 -0700
IronPort-SDR: uV3QoH28EQhHZKMgZA9LIsx1E/C+Qxcwg8fIIg8e5upZIm9qhlMhPDU6mF7711WpMGMCm+/GVR
 xA4AUnDZnZlj1hyN5NjhyBsZk0ERdyypKp7rdmVvhC2t2sDacBIxT/zMxF3M5KF/rwbO/8tqCn
 7WoZM3M8OVnKEFrdx8S4vSdFqK6tx8QdfT618+Q86WHglWKTqlMVtyx1Ym9ap3BeZJegkiokFo
 aXUosu4ZDaxaoj3Be3O0x2a+Yc3nTTQH1CW8KCT+4dSvMZ/wjNW8lj/8pZex2waReMZ9pm7o+Z
 0tw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:34:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6Mq55Krz1RvmK
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Oct 2021 18:34:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634866469; x=1637458470; bh=nQmD8tz0siK/3ewe7e
        S/wMF3ydoICuJwawIePzDCHFY=; b=usycVyQxOLWhFUbFjg6sW3zKN6InQ6Mubf
        +QIcS9RxcpNThMBc/WwosWe47Rtce79KcevQHPja1tPPHI5Zr9m1BExO1Hqh0sDz
        jK70vZgQIAB8eDzNFQUw9JH83ej719ywECGM9xt525c8xGBn7edhT3KP5zoo0UGH
        loGvBeAWu+CUr4vq40jj+izmgRqtD3sx2OWxZUgJw/HzMx9uux/EVINgQ4zth+Hj
        /Q4E+KULVIUO3RfKzN82s3PmSs/66aJTeigt3E/OYrne7NYzP2JBuxFkRPprjdFz
        6uK3DK9Py3NIifq/a63GFZE8hRX+0Zex+KrLp1fIcn3NejraExUA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O2Q-sHH9naMg for <linux-perf-users@vger.kernel.org>;
        Thu, 21 Oct 2021 18:34:29 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6MZ4H63z1RwtM;
        Thu, 21 Oct 2021 18:34:17 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, acme@kernel.org, peterz@infradead.org,
        dave@stgolabs.net, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 3/4] selftests: futex: Call the futex syscall from a function
Date:   Fri, 22 Oct 2021 11:33:42 +1000
Message-Id: <20211022013343.2262938-3-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
References: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
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
index ddbcfc9b7bac4..c786fffecb8a5 100644
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

