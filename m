Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F2DC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D5F6121E
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 22:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhJTWmr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:42:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12463 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhJTWmq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 18:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634769631; x=1666305631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iokVJV3cYX9f/SC9Fc+lMMtmzbpnIQZDRYW/FHmCWd0=;
  b=aDYQqedbrbnW7bmV/7dXV3Zt6QsS9wa9K2/K9PelXuFmEfOIluvos7AZ
   rUyWBW6Ck+ejULaDyFSu4GkbBTT2PpBAwH/ZHeHbNO7Vf7a2YDPRve1oX
   MwqFjp1qgJxl22cj+/MzVhxxDoRSOzp/CJlbOn6yKEclaDTT5UNIUhQGL
   JB+12wCxEIVH9BLT3WG7A+2IyzHNP13Oa2x0rHaIsjrz6AGPse+eZEwwl
   bI77JceH+OCcyrodcYiE4g+u8CHvUmUvXwPQpNqzcQuU8NrasRV2p7aqC
   HDqmoTbPyiq3n1vuORE8weY8dcP/ATtyru2WISyogXv0+Tk+ha6pG3RYZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,168,1631548800"; 
   d="scan'208";a="182470041"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2021 06:40:31 +0800
IronPort-SDR: wZcbgwSRRFil0ealVNEsfpF/pii20jWGEQMlxadcZdqT6tMmGQypvZy77ZKs7xC/jY1bMblosg
 rjdRiidPaM0OjNcl7GFJ5jrDsPADsjbXfy6cELUYphGeEupaJg/Q59ga+M8nfT+bN4H60XKQQr
 4Em7O0O9EEO8qLU2w+8c5bueKTntlKyIRemMUK4bV4BHvg8nUW3hbyowxbjE2+S823WCy7/8sd
 7gtQkkGE3U1BgL77CDzc43+G1j+2qIKEMW5z6SnSpSvB0vO6Ff3Q+b5/PgEViC2d7G2n+VkZm+
 MhwV5T4A7XpXcQXutRDJrzRf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:16:08 -0700
IronPort-SDR: tqheKOq2rPXCQJFdfx+XZK9QOGDR68h64J1vuB9ew+F+PL2FcFBi48x0cJsPs/5ZpBVU7Kx/Ng
 QcDVyB5KAzw1yVr3yez4nNZMbPDLol0CB/hL1Hfem1oo8rmke5eFAcQg3aqgcgyB4uf9mVUhgC
 +PIkixadGoZDCigtPGvl9Bcd85pF57IpLbADRk1KHiajIK6hxoc9uznj2CKTezulSaJwtHi4Wk
 w5/SZEe2lTuI2St58hbxLaI47J5pJ2as9JWZ4JF9pzAlKWh7LcMd6T+CeoSC+HxGGi4U+aPVi5
 74k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 15:40:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HZQYV56D8z1RvmK
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 15:40:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1634769629; x=1637361630; bh=iokVJV3cYX9f/SC9Fc
        +lMMtmzbpnIQZDRYW/FHmCWd0=; b=HbmBALspll9m4t/0EDKKGA/oB0V3treqkQ
        xIhDbAG8iqUVNKIkW2EnoBNPC3BM3gslxGNdMhJnGa2hZc8hr+8zwk5T89c9Uzo+
        jGCPEg14L1xAueenvGRHT+b7XvGOy1pE8YkTVhAAbm13dX4hbUJF1Mf4OMgplYRC
        vOxPf0dk4xYfarU+MqcVzqB8FNfRn8zM61k//SniLMk5SE8VPOoxDEvKPZGDoJad
        eI/3xWawihNjTBfbffi49TkpXnBDFaWMLnQ3kP+RE9bxFjoc4PXjB42iBY9l510Y
        xMTs0+pr2/agO5wRBUcj5rkYYQupuE/PgtS7dG2+GAWH5vqqoadg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9TEdik3-qR1Y for <linux-perf-users@vger.kernel.org>;
        Wed, 20 Oct 2021 15:40:29 -0700 (PDT)
Received: from toolbox.wdc.com (unknown [10.225.165.39])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HZQYF5gT8z1RvlZ;
        Wed, 20 Oct 2021 15:40:16 -0700 (PDT)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-riscv@lists.infradead.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        acme@kernel.org, dave@stgolabs.net, dvhart@infradead.org,
        peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        atish.patra@wdc.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 4/4] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Thu, 21 Oct 2021 08:39:20 +1000
Message-Id: <20211020223920.2810727-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
References: <20211020223920.2810727-1-alistair.francis@opensource.wdc.com>
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
---
 .../futex/functional/futex_requeue_pi.c       |  2 +-
 .../selftests/futex/include/futextest.h       | 44 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7f..d3673996fed4e 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index 1b133f81e9b7b..b303d0d492ff7 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -17,10 +17,12 @@
 #ifndef _FUTEXTEST_H
 #define _FUTEXTEST_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/time_types.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +71,52 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, ts32, uaddr2, val3)=
;
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
+
+	errno =3D ENOSYS;
+	return -1;
 }
=20
 /**
--=20
2.31.1

