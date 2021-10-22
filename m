Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5936112F
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 01:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhJVBgh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 21:36:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29109 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhJVBgg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 21:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634866459; x=1666402459;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0jezQdAQdWhHmDMWZLYcoD4DYC4/yRryNOc0ZTLZ39I=;
  b=TzyGw8vN92SP1saNfsMrQrfQeQCPWNx0oN0ow7MkMMsTDQh0afbHwCOE
   GkmApg2B9tMvxqKhlThyYBPhxmNUcvRPu5q5vxIge0bM5qQOdqK8wTN57
   XmSzAtPo/k0yRK7XrAoKQf7n8pX0/YGBpmYdVac463iL4RVs+weIUPDtF
   2R4JtQjlAm7YIFpCXYctZmc7cidO5gse1/JvaEbra4PccsLIAzWIeL5Gw
   az2dNNMxOYGc8u49l45iaKvq01lOBch0H0Q1523T1Smqin5hzmPF9S/Lj
   B5ep5wZSfmgWvk5Pw9aqPGRzJSdQQEA13Ryhf4K4TnFSQghQtm07MJUhu
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,171,1631548800"; 
   d="scan'208";a="188348021"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 09:34:19 +0800
IronPort-SDR: Uu/lJG+4ebREUhE63qxQhk+tqg/AGDCDDyCsHSuVcoZiaCphK96w8KLPx/L9LkpE47NjFdU7rI
 +JK5Pfp6EbOh1VPiXJXir3yt1AEmkoVViyr7GznNQLDisLzcqIzWdCFvErmuoECxTOILCv4qQf
 LqK74JQR2CiihKC+nIuK7eVd9f2KB8mgxIlBJygb1lvAK+uIqJaKPoLWeEIpuxW3plee8jwc0r
 zirS0u6FskgfFkcegRhHySZiEiEXVXOOZxgb8ySyg31xiW9tjbgOEODo7zUDkOcLjGjES65HEE
 O9+BqWc16bReXPNEK69AFygT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:08:22 -0700
IronPort-SDR: 1C0s0j6Rlp+iloT2N9Dn97rofwKVExpRVmkX+PeJ7JdMZopy2ZA//XFp96zZYG6nZweDqqWF/D
 Fee+pyJJIMG7nUDL6aXPcm6u9d8s3W8zitXLY9DqOOmpNCf5207Kb23q48iAJkMBaqPEpjsIRD
 w0cvDSr/+4wV3nQsS/Q0q8XJ5SaLrzACBFDCsO0Xo/OeO/ZfAbVjQ41zqZJSZeRDNJenYG6LaY
 w3BCEW/76SAOQPVXq22Rd5QqtflcX57hqyWE4ocHidhf6v872PhUjEdj1oXS9J6DSboghLMdUl
 ZPM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 18:34:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hb6MZ4Bzhz1Rwt5
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Oct 2021 18:34:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634866457; x=1637458458; bh=0jezQdAQdWhHmDMWZL
        YcoD4DYC4/yRryNOc0ZTLZ39I=; b=srYgOZj35H5p9OIJQafrSjr8v7mCjz+hup
        H56NYdLtorEQPLbINDMzDLT4r+FJEn7KMI8jdsV4oo+l7Uuq/NISmJMLZODbwGk9
        S2Ha3vj8MPkrHvONyQlGO/ZxWJ6xyyf1Vq+xvot3DtCGsdZ2ap4+6uxcI4nWlcSY
        GJfNTGvXueh2A41SdyjIkRt89B1pHtcbW7AZ3vRroWby9RBF39mNDJv55D3N1PPc
        711XAvSiuygtbyeQwFqca6UDVI2SC/ZO1A6V6ySbbbkOElqONZXEbS36PSofpvde
        /BgQZKvoJxz/gZP5RdVHfHNqHQRFmaz3MYdrrxrVcIvlACCsrrYA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W5A1yu1-Wvx0 for <linux-perf-users@vger.kernel.org>;
        Thu, 21 Oct 2021 18:34:17 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hb6MK10B0z1Rvlw;
        Thu, 21 Oct 2021 18:34:04 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     dvhart@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de, alistair23@gmail.com,
        mark.rutland@arm.com, acme@kernel.org, peterz@infradead.org,
        dave@stgolabs.net, Alistair Francis <alistair.francis@wdc.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v5 2/4] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 22 Oct 2021 11:33:41 +1000
Message-Id: <20211022013343.2262938-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
References: <20211022013343.2262938-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
time_t and as such don't have the SYS_futex syscall. This patch will
allow us to use the SYS_futex_time64 syscall on those platforms.

This also converts the futex calls to be y2038 safe (when built for a
5.1+ kernel).

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex.h | 43 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc1..6a7dd86871eb8 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,10 +8,12 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 struct bench_futex_parameters {
 	bool silent;
@@ -28,7 +30,7 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +51,49 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, time=
out,
+				   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op | opflags, val, timeout, uaddr2, =
val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts32;
+
+		ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op | opflags, val, ts32, uaddr2, val=
3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op | opflags, val, NULL, uaddr2, val=
3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op | opflags, val, nr_re=
queue,
+			   uaddr2, val3);
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op | opflags, val, nr_requeue, uaddr2=
, val3);
+#endif
 }
=20
 /**
--=20
2.31.1

