Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFCFC38A02
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiJ1J6N (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJ1J5w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:52 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F687F8D
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951026; x=1698487026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HDOW4KvVqZm7M+oRwyLLXnE8cnS2CkUYQNAOKUB1qEA=;
  b=jRqdHqcx/aR/bij84Bzd1HIN5kpKrBVS7bBSC2/+cto/QOMYEPxGiDwz
   yfusXjdNONcY1dNteLvSg1RNi3XPQg1aJSPq2JUQynfwyMsJDzBFtsfzJ
   Ws1Jy1muSwkseREWSFoGlkB/5ZLn30cRbRvoGffVn7dJlghIfIXMptYdF
   HO9VwhV5hvJfzDe8OxWpS28p8ya0vKmblZ2WwUKE9V2nDy9U4mKRVyUV5
   2tLFlLnHXIHsNQ1oxmBnbPsUdeeufSQflrmonIv3YdJJ9Yd3vwA4QUsYs
   HIztAgSpODBzH4aPknySfKAB7+LXt7qSjN+FWR7BC12qxBP4JkOJvZS2q
   g==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="214962180"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:06 +0800
IronPort-SDR: 8+IBSGSVmg1lZTuRnoj+wH1K5WRGIcl2uzCXW47A7TVsxjCajvdXzXH7cuzvxvwSRpCUNd8kN9
 QAfAbO94VmHU16jbtWEIU0I2hIa1iEFRmyLd7Y/Ekm6NOQ3zhfsm7QOv78kz6S2e8ThZJO2uwt
 HlEE2EWkdCbwWmT2Eue3IMBEKymMwfXm8dv5LuSUnUCz17vxvGmQVPul2Ap9f4OWqtWUy3z8Le
 fvkahFfqdw939Y91laMfyO6G7pBwoUSBE1Ak2iecj/SEz3YwHxX/1HioiD/95EKA+dDZBdH3Mu
 DUKOGZfXADUQJG5GE/HzpD7N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:10:42 -0700
IronPort-SDR: p3CdAcnMP4Agchq7tUlzOn4Kq+hXwjwi2hcVkBJktArWt00E5dc8uFvDGPsLdaiis9G69X19t6
 NJUuVI8ayZb4QxsKTcOMHJQ9nzDrBf/Io9PU+WpJtzip0DtuYD0EFJovk6wSmZJ2cydEZPh4wp
 vUHgZrl8onnychrhTw4sHAwp9DT/TmImzojvgF1LrpFy9gz3/+qTLFdPPnLrlWKhvuiivDWvCC
 9TK+7Ywn6cStKgqglE2qgFOPUtpCPBtdhTW9BRJj+3bordTJWh/t5jvcH2q1+hNtkLuFd96kxZ
 Oe8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyT1nlWz1Rx15
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951023; x=1669543024; bh=HDOW4KvVqZm7M+oRwy
        LLXnE8cnS2CkUYQNAOKUB1qEA=; b=sAi49Kz2aJYOKZLKyiB/WlLqbdA/IvI1xK
        OBN3BMUWU/e1IBbG+n6Ac+ZZqv+G5mMc1Js/804PxVD4y7APryBjKkSh849VHIcc
        nG0PZChp3RVA8YGzYh0X1Ha/1dDleUur6uepq87pxLK13mEGdf6JAZ9jaNdTnE0i
        NFUaD83Rux/jF5LDGkHT8Lc1SafrYsu3KuGFpuFooVooLgnLcxnK6S4j7V2l6FFX
        kAPK8IsQ/ENXLpif3vkLWEudo6NV1JaLzzENYnjyxnnxeQ3cni0F3GER8FPdqS41
        NT3LgJcWBh2BCp1vKPVeDaSZgJ+IK92VwpME44nP1sYKxpqe/+MA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jWWqDZ0wdbtD for <linux-perf-users@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:03 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyH5rjnz1RvLy;
        Fri, 28 Oct 2022 02:56:55 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, dave@stgolabs.net,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, acme@redhat.com,
        dvhart@infradead.org, mark.rutland@arm.com, peterz@infradead.org,
        arnd@arndb.de, alistair23@gmail.com,
        linux-riscv@lists.infradead.org, mingo@redhat.com,
        alistair.francis@wdc.com, atish.patra@wdc.com
Subject: [PATCH 2/6] selftests: futex: Call the futex syscall from a function
Date:   Fri, 28 Oct 2022 19:56:28 +1000
Message-Id: <20221028095632.1081262-3-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
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
Message-Id: <20211209235857.423773-2-alistair.francis@opensource.wdc.com>
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
2.37.3

