Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB69C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 11:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357254AbhLBLUy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:20:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65004 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357241AbhLBLUx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 06:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443851; x=1669979851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQ/XAKWYAeapcTzZkPgcULpc8rtRC5bV6gTHpBAfk4o=;
  b=qonbzq+aYalkdOQOevGsLwm5/FFxB4qUOByjhwMCQ0IHz3uN3dQ/7Gzr
   m2pEPp3eZQw9znTChX8jfz5naaB4ByHS2kZjtZo1FXfY6gwB3zqBnntZi
   IOVIux+oDm9p08DfO9UypAmQMHJUn+ERShiHThypkT6ibc+GXaKsyWYrb
   j1SSmsFehJrHjQAECRYSvZJbPFPbzFtJzfcuM5klq3npoDisLIlp35okm
   d52gs1T/I1UKOnOO56+kmBPESMMjqnBOdXfJvBPNR/QqcINAxZS/BT01f
   7xf5xFVg69PJZqCXq2EW46XG13duSKtUjeHM9H0bhIVzOK13xpHcSJZ4M
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299115573"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:29 +0800
IronPort-SDR: W18B/7YXrtZKcuHfNt99MSAAVRmDlhRtHOG6h4ssdLlZDXyFrjzkPLP4FBHXAeqz+E2OWbe/BB
 aC8Kurqf4tnllztKFLCSHx+d+i0v3g4rF18EZMQyMT80fifPevs/Xlzmf/4NaTY2oVFJUhx0nF
 2dULpkSPZrint6Lg+wCLvBk/vmVH3qUOrer0Ob/7pboc62eX5aiOxSlCQVPPrVyI8BeSaCcN/z
 aLFfKUUQ4M5ILJyFGz5hV5wXvD0VqZSznmPWw3fSwYt1YVB/1U9/jAIz1Klh1A6SnK7nvkzDHM
 8o7aT5ujaX+KybMvtS7nrhfI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:50:39 -0800
IronPort-SDR: wQtypDb6Uj2O+DwbP/h4eHWGXAsm8G3p011859DgVmLZruJLnDeWwGDaDW9k+5no6MG/V0/1yB
 jeAFjk/n8ZDd/TXr+fYIrSxNfQfbYlQoJqJ542mSFB8DW/LZZt0eEJhSpHZkqIYPN5T+Gh89y7
 y0x7JVepHsCCBcG7o2zkhAS5ZlNWKmFDTK+6snjrLcD/oC9CM0+TlPcv3cR5ObPZ321szIlCsw
 +dfGTd8EFmhUPKNW68DwHlA4iFdqWIwFtc6V4FUF9laFGkhHCDQK2EQGTpevI7YBZ2qEXZ44GJ
 Idw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:29 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YMX4hpXz1SHkN
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 03:17:28 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443846; x=1641035847; bh=YQ/XAKWYAeapcTzZkP
        gcULpc8rtRC5bV6gTHpBAfk4o=; b=ErQcnrPuOEBswdronRI4bOeAxI/o/Uz6Uj
        BLPiEWhSFj4lLIijD0sU2BFpvCV7f6nu01oaulfMVVJwBjgLyNWIUStg2/xN8MbT
        Oukd5E6rwBstkYXJgOdyLjw6H/u8RC3xwsZ+XVzGMUseUTVpVz4XDkjCXc47PpO0
        4pwT2NfCDz+rb5tw+K1iA4wzxk5m7A7ndwjWeYbXxOp5YiLBW/676xvVSFd4B+ZM
        l9Hp9cZwDmbA9VEFvkzRb2B60joTQ7+xAH0YC08mQOe6B88g8Yo+zxo4Wk4zIMKf
        rdqZBYPmm8bmMa6rP5VxPerrqU1e5AfTRyMCV8t02ohHWd+Yg1hA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C5Sdw0vM-bZ2 for <linux-perf-users@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:26 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YMJ6dbJz1Rx0v;
        Thu,  2 Dec 2021 03:17:16 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 2/6] selftests: futex: Call the futex syscall from a function
Date:   Thu,  2 Dec 2021 21:16:55 +1000
Message-Id: <20211202111659.2077911-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
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

