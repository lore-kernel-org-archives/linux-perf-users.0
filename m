Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C0C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36B16112F
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJVBg0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:36:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29088 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhJVBgX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 21:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866445; x=1666402445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m97MnHAZ25lH2gTLkW56Y00NrpnkCF1Bb4DbwT8g/50=;
  b=PYKPV5NlT1Xas8ISzVuW/8p2tl5ZjW1XXBGEZcpOVKzZK0LFuRPZHP2J
   AIC+afyswDVHCNAGfN5mub277JmWyHRdTNxrwW0YpsfajaCMr1vFiJnc3
   NtVsXkdmA1fIdCCHczwEidthR2GBbZG1lLFydyPvFyjih5+ihcCmxj5F1
   Z6nsLL0jP0lU+CfbKgU5EXEl1dLcX+dZqBPnqZGNmpHkf2WrDa5PPYcJW
   z/muisVJE5s6f4jCWRv9oiQeFlgZ9GQGhMOFXR3GwEIDRauVD5W/VQ0em
   efLtsF2rRo/2Dm/oGcfHn0IlRK9uV5+AfgUhEssqV4IXLOOD+2jQYt78h
   w==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="188347980"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:34:04 +0800
IronPort-SDR: pNd+pch/S9bodI4Kty8jMsGQPAJPeaCmVyXsxorCZh6fWka1m/BRPWZY+t10pe8KZMUB9WjzEF
 iC+XKR0R4SxUMfhBzgmdQSMWul4xkf0TmuKDXJ5sLxzxjyE/QORBvgMcfujrWBU3ZTC1Izt4Fa
 QGZkAEUFT2zJrHNdJ3LU4UEwl7QwsvXTs8dho8CAKJjCt8pXy2Jzg7+LvgyrzQ2tYaIfIqxF4V
 4I9DDR2cZ8d4KkjxqHkv7bqcMu13NLzzVI3HemZR1TbbzcmKiA7BGD93HUAD5Ys90WEg8Es2PR
 yt8Bz+QBzhIlJPhtefJ+Mj5i
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:09:41 -0700
IronPort-SDR: iXEqEU71Y/gR3MTsb/KGCM80EUQeAMfT8/g9D/UXHvrRw4phFSiEtsYhm8MaS8lo+GzBlopT4x
 U0Q6WbGJs6R+ySWm0X9AXcjvA6M8D0RgaULmUdhRhlCnNRBCIgpm6KiVpf1nfZQkyArNSl71ix
 SjNWPf4abYfTn0VNk/TEdGO3mzvf516SqSQExhGNBnakOaIufelK6sK3MN1DWiX3duA3VAGE6e
 eW+CBBGVpv3uXVJe6Qvu+p9NPAbrv6+FHIqcC2564BDxZCOB4tGzVoUoOC/0paLDs8h/WxxAKo
 tD0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:34:06 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6MK3Y9Gz1RwtM
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Oct 2021 18:34:05 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1634866444;
         x=1637458445; bh=m97MnHAZ25lH2gTLkW56Y00NrpnkCF1Bb4DbwT8g/50=; b=
        Hl+HmMG70w0gT7rLNv7TyC7bez2Wy3hlf3tLx0jqMV+BhM5ywmIhpjJzIz/1RHhG
        HD+R8Pq4sJGaN+sKzCq84eFJHJMna/ygU59CUtve6mZltjoJRbILFCbm6rCWiAqB
        YP8uLnN7oLYSjdjjP5zmwmm021qtLbNVMdyIGcbQjBbRkqjjvE700Pv9N7I55obO
        K1t0582OlwEt/UWXOZrXDVyM0rwf5VER4bCM2CUGufiAzYNk/GNN54urjh6O1ljl
        qQiSMeHiCvJzZ3FfJdoH9T2u+QbC/rgDTRkXrnEodohI7KIOgeZ6Ek/ZSiCJ3WeP
        9oN760y8b+WAFN07IiU6KQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fHO0lfddocAV for <linux-perf-users@vger.kernel.org>;
        Thu, 21 Oct 2021 18:34:04 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6M32PPzz1RvTm;
        Thu, 21 Oct 2021 18:33:50 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, acme@kernel.org, peterz@infradead.org,
        dave@stgolabs.net, Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v5 1/4] perf bench futex: Call the futex syscall from a function
Date:   Fri, 22 Oct 2021 11:33:40 +1000
Message-Id: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

In preparation for a more complex futex() function let's convert the
current macro into two functions. We need two functions to avoid
compiler failures as the macro is overloaded.

This will allow us to include pre-processor conditionals in the futex
syscall functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex.h | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..ebdc2b032afc1 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -28,7 +28,7 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex() - SYS_futex syscall wrapper
+ * futex_syscall() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -38,17 +38,26 @@ struct bench_futex_parameters {
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
@@ -57,7 +66,7 @@ struct bench_futex_parameters {
 static inline int
 futex_wait(u_int32_t *uaddr, u_int32_t val, struct timespec *timeout, in=
t opflags)
 {
-	return futex(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAIT, val, timeout, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -67,7 +76,7 @@ futex_wait(u_int32_t *uaddr, u_int32_t val, struct time=
spec *timeout, int opflag
 static inline int
 futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
 {
-	return futex(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_WAKE, nr_wake, NULL, NULL, 0, opflags=
);
 }
=20
 /**
@@ -76,7 +85,7 @@ futex_wake(u_int32_t *uaddr, int nr_wake, int opflags)
 static inline int
 futex_lock_pi(u_int32_t *uaddr, struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_LOCK_PI, 0, timeout, NULL, 0, opflags=
);
 }
=20
 /**
@@ -85,7 +94,7 @@ futex_lock_pi(u_int32_t *uaddr, struct timespec *timeou=
t, int opflags)
 static inline int
 futex_unlock_pi(u_int32_t *uaddr, int opflags)
 {
-	return futex(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags);
+	return futex_syscall(uaddr, FUTEX_UNLOCK_PI, 0, NULL, NULL, 0, opflags)=
;
 }
=20
 /**
@@ -97,8 +106,8 @@ static inline int
 futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, in=
t nr_wake,
 		 int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
-		 val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_r=
equeue, uaddr2,
+					val, opflags);
 }
=20
 /**
@@ -113,8 +122,8 @@ static inline int
 futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2=
,
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
@@ -130,8 +139,8 @@ static inline int
 futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
 		     int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
-		     val, opflags);
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requ=
eue, uaddr2,
+					val, opflags);
 }
=20
 #endif /* _FUTEX_H */
--=20
2.31.1

