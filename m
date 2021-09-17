Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5305C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C993561019
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 06:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244731AbhIQGMa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 02:12:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25066 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240695AbhIQGMa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 02:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631859068; x=1663395068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9y8Ut/ugz/WF4xLl6QXyYdgaBuD43Adc9tbqyoQdLNk=;
  b=SVz42hyYSOr3velNWAqou73p+H+So2kr2A7wnFCKnPcf07eHpmBCgbi4
   FnWexcBEa1hSHSe2S4ru+t+hTAhq95iuQ8TNfCpkiiLsTuJw+9cqrb5A2
   T8B2qrwofU5bcY8oC+ltfjYztjvryGuQQ6oBXW0ixQWbp8IlB1M3JW15N
   xWzlnpLRlFYTwVCIgvXT80yY3BnW++AnX+Tt355pG03CKIEFUxwLh0Srt
   qfUhFuWqmW/N4MEaNMche/SuLZfn34Jr6nz50NOMO84bNhhDEl5GJ5UPG
   PVeODjZv6vOwKye2lRCgUUO1DsUqxukI3nx9uYUQb4+LE2cVQBkDz+vgc
   g==;
X-IronPort-AV: E=Sophos;i="5.85,300,1624291200"; 
   d="scan'208";a="179315998"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2021 14:11:08 +0800
IronPort-SDR: x2Vjdfyf4U0aUvLxldzEN5uZuiyOCKMTVxpR1zOZXjcBjY8WQERQB3hJnQG1253Ouj566cze8t
 7sqtPAugKM8nX7v2aXz62wtmVeqB2/+0bPBdkqU2T5UJ8BZKjNuuYCCOM6T19PbQreOYaYK6jr
 QNjMf68nImwVw07YN3dOBng4DPI4deaol5U+4E31Tqr0KFXkmkCAgwGEOG44DD2aEsjAVtG0PK
 ItcrnetHTrmXPvVRMMsbcLeV/Bq+9/6511hj/6mQQVEoi+74o2t8GCTkFEuWe2+ObDzMfEen9I
 NY8b3oi8W1DUUIwgiXw7f8OF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 22:47:28 -0700
IronPort-SDR: sI1k0EduDykCYNanv2NGudIAk0Clv2A3poGQfe701kMwp2cNWlF1kfr3dNfqQ1GUM/vj2UkYCP
 9POhAWZS4aKppZMpCzDp42lkc2Kz4/QYl5bpZEq2ln5cPfsTDzYrMgDS07jrGfIIWrVlMgZp8u
 BI4m33JIlIiFW6BU21qNker37vvrL+RVIzeoc0vJFkYLuDxSE2T1tWogBKCmqyy+Tj+fpgCe32
 ILJ3C7xAV0AiyJZR7VdiXvqKtps+jHiRBQkdw9J9pCreUstiKbGHsEAjpT4iQUwN31emkMKkxD
 QL0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 23:11:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4H9k976sSxz1Rws9
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Sep 2021 23:11:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1631859060;
         x=1634451061; bh=9y8Ut/ugz/WF4xLl6QXyYdgaBuD43Adc9tbqyoQdLNk=; b=
        FTpn5lTFFIb7CVyFVdwEZTRODEyp/xPxiNLIytniHNV25YEqe3GBBHORFmhZkn1Z
        qR3HCQG52ChvU2fotwI5V0RCe4ar1n+OQGZSW2dB9qOkb9e9NgHwyPhQ/yB2JYf2
        B1/OB8XVBFJobwj6Fmqwvts/Lpuo8h+0V+mjBx4BprEZMAMbYTmW1LdByZmAy33a
        5rXG6f9Sy+PqjWf6GtHu5fc6g360pbneMvQXFltXRb4kiY58pynvf+Y3hn607BnF
        3f+c1OHT4veuJ6QBGBva+lywRBq4clTcezshHAUYmOgZm2bBCfYEXUUdXJbDX7Js
        3Q01W/o2EseiAQ05zscasg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id quugzp51Uc_s for <linux-perf-users@vger.kernel.org>;
        Thu, 16 Sep 2021 23:11:00 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.165.23])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4H9k8p5NrKz1Rvlb;
        Thu, 16 Sep 2021 23:10:50 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 1/2] perf benchmark: Call the futex syscall from a function
Date:   Fri, 17 Sep 2021 16:10:39 +1000
Message-Id: <20210917061040.2270822-1-alistair.francis@opensource.wdc.com>
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
---
 tools/perf/bench/futex.h | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index b3853aac3021c..f80a4759ee79b 100644
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
+futex_syscall(u_int32_t *uaddr, int op, u_int32_t val, struct timespec *=
timeout,
+	u_int32_t *uaddr2, int val3, int opflags)
+{
+	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
+}
+
+static inline int
+futex_syscall_nr_requeue(u_int32_t *uaddr, int op, u_int32_t val, int nr=
_requeue,
+	u_int32_t *uaddr2, int val3, int opflags)
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
@@ -97,7 +106,7 @@ static inline int
 futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, in=
t nr_wake,
 		 int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_r=
equeue, uaddr2,
 		 val, opflags);
 }
=20
@@ -113,7 +122,7 @@ static inline int
 futex_wait_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2=
,
 		      struct timespec *timeout, int opflags)
 {
-	return futex(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2, 0,
+	return futex_syscall(uaddr, FUTEX_WAIT_REQUEUE_PI, val, timeout, uaddr2=
, 0,
 		     opflags);
 }
=20
@@ -130,7 +139,7 @@ static inline int
 futex_cmp_requeue_pi(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2,
 		     int nr_requeue, int opflags)
 {
-	return futex(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requeue, uaddr2,
+	return futex_syscall_nr_requeue(uaddr, FUTEX_CMP_REQUEUE_PI, 1, nr_requ=
eue, uaddr2,
 		     val, opflags);
 }
=20
--=20
2.31.1

