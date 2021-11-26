Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0594C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352474AbhKZGH5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:07:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5892 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbhKZGF4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906564; x=1669442564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YQ/XAKWYAeapcTzZkPgcULpc8rtRC5bV6gTHpBAfk4o=;
  b=e8ywRhY0Wdu8FWmENGQwQFFC8hrX/zFyXbv72JgnCXz8ydLFY6eJGrXL
   y4kFYbB8ov2cy6bmB+bSg3qH1n945cRLP+88O5sOj5EJinCLkinaOBWka
   w0noB07HbtSOJMcgbG+wGMSO5qdzcYyUUULmZouRoio0WYiQsi/eZQ+RR
   9CiTCxsEpLft/tn4Sj5SsKY5DOhQkA1lfXrYaeEGfMEVe3OOxeUmUKxUf
   JritGWDgxPGgUTMg0DMDJG99jpkaFXwEi1zK0m1nuvS+MN02LcRiwBxAN
   JOkYrdHXtyPVHC51iS1dsvx3/+8XXBvVFbagzhQFxonurt7aAFd9izv2E
   w==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="290649428"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:00:51 +0800
IronPort-SDR: lTkR4bMeyfN8FttQIYLusvkbyWnHRbld62OsZQ+pXoZOQni7TcZpiG+km9B0QZAJgokxCPy35w
 vSEYuwWfrduKoOS1U0wj2niKlWoZmqZvN+PloybLRTsOv7Qyf5tM1Y+RAL1tmsij9ntjS2fE49
 WXhLRS7sMhTHryuflJbU6vC2adeiNTGIt5W/rkqz3pgBBhNyGwJyxTRAo7egB5XtcjRGje6N2a
 VJKJg6ChAZr0t+bBd/PKGBVYoPXkMeNgZzdEJjFQ2uo5RFyHo2AgsVc0p+5tkBBUlRsfr5EL2a
 RPUWz20+XVT7bLwqwM5lpjlg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:35:42 -0800
IronPort-SDR: v7BW3vvOxWLnMeFTZh+xyDGSvQiERrc8x4G8yFmla0Ry9DP9EHmBPzV0bN+ZWQ94l3ODDcpxEV
 HlItMcnDnvEz9JXIzWsHSEoDlEjUNi0NA/+yEXGPbU4uDQdW0Edh4BG8l369L/ax2n5MdTXEnV
 1C+RpmDVaiwNVGTAIIoBJkS3C05xzEcMj1M2j2cUSPXg2iTu24hH7ZEAcq3Ap4WJP0NuboPOpJ
 3pQ17clJt9H6BS65TM5k0Iw7J0kMhByUGOPvrzWYk7Rq837tlAtkyQ5BcqzOmjiJfy8RyTZmO6
 E1s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:00:51 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kcz309sz1RtVy
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:00:51 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906449; x=1640498450; bh=YQ/XAKWYAeapcTzZkP
        gcULpc8rtRC5bV6gTHpBAfk4o=; b=qSepZE0TJCGKMTPVeiNaJ76N0HumfJTJOP
        gtWt6EaLt0NmvkP/mqwKWp1HyV/VGWoupWYTKiYht7Lx6tJCRFsa4Kf1TMjit6z2
        /V7kusXnH9Xe8DplGXeCiVZblRdmS8Zvi+41vlk6t5/dGc6i6j/su5skvpUfHlwr
        0brYstOJ6Cbh6b36/01+LNtzKhpTGUZb891ZKbrCd35AWTL/RW8LJTplAH1u4OBK
        9yFQtwUA1BrNEstvqiy3nINtJvqZiB7oB53veUSo/IS6cBHcxlxhWHT8gI1+WaTp
        d6kYdN0puIuhXhXc6z03/tK26mE8ixdEspqvivGYS74L1puSfTww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fwPJFOOFiPT6 for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:00:49 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kcn4qNYz1RtVv;
        Thu, 25 Nov 2021 22:00:40 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/6] selftests: futex: Call the futex syscall from a function
Date:   Fri, 26 Nov 2021 16:00:20 +1000
Message-Id: <20211126060024.3290177-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
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

