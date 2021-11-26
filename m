Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D60C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358736AbhKZGGG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:06:06 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5907 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbhKZGEE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906451; x=1669442451;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EbRQaPC5mcE8TRYTTGUiLeoUuaS4O51bfJDEd0m/Nic=;
  b=D6P1eHxaBemEiN38EGSZz3EvyOW4qc+Dy4WDTBs7jc+6YMCcXOrn7I7E
   Z6+grM6Ed9HAZ2YvCpr6FsW2TcdegC4Jby6pvU8bJCXTPQy8eZjY3oQd1
   4Rz4iLBDXHTj+/9oz+V/RR6zqnQNLHhQeEa6Wllbf7sdmGcjxcIooRU+5
   MBi3qO4EUiNVnXydJP8tINE8v5IWWDX0nvbf8dAHJwSQs8E+nYNkoa2VN
   VmEog3NjP7nj+SaJcrNlSzM66MvIGpy5ZoybMOnE7eaDLSE6eqkQ+bGLm
   KLAlKO0KomcOddAQfIiin6o1/+eCtes2s7/8wAu8jYZi3KiX0Otpz66Iy
   w==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="290649418"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:00:43 +0800
IronPort-SDR: ZD1L63U+3a+MwnUjPA2wKH6Jno5TzqDoSiO5SlN4NY7zPomvVeFp+dwe43pDie1tkgtJdXDLjy
 /Ho6ak4ehStjNFqS+/gC4/LTCq5FjXDukcF5OwTjtiQFbaawzXF9II4cZBHxw3Vmsp232+75gZ
 xuPi71mTE8mohKPYamC356FNeoBtvFj8z5OL1EDe7v/n2hxQyp4xO2bpZkFo+oAYPD/vE0QuHW
 fOtsRnHIHcGnL0EebD0oz6nkvShjBKmVG+le53kLPOfJTByrCPkcPKSJ33P/FHqcVSoFHtQ8o3
 Gzj6LLfZRS48M3UUVV+dCx+H
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:35:33 -0800
IronPort-SDR: 51AkQKh8OM5kYFlZXM0Wm01Ju4IRG2K1KAHvqvbriczUygrVjzpBcZoMsreEDa4tXUWNQydlHU
 ftqWIegFTXbnyFQlq/N//bh7LsjlSrbh7hqAowLFC1YHHgKWF7zK8XYpqWu+5RMs/Apnz6klku
 a1dHPc9DGRyRa3OH6Yhk4Lt/bseAcfU1thEonDVLC/zusyMo9m/8JqjhwW5qENWTMrStUch8Ni
 nn3+EWD/Nezj1dvnj0y5qYKxvH11spee+xY/jANpGlm2RKfltYxJRPjLQgrVNJkqldl28xIalN
 K1A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:00:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kcp2tFtz1RtW1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:00:42 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1637906441;
         x=1640498442; bh=EbRQaPC5mcE8TRYTTGUiLeoUuaS4O51bfJDEd0m/Nic=; b=
        fNz005kQFISzqSYZXNF868n282+1+jomk9Z5KjcCoexdWPKniu5tjRv0oXJASf9Q
        FsP929dUv5qazL3RSFp80EzlkDnj14CAQHhih7Tap+Ape5Xj47RJJCWNI3fZnaX7
        PGAXPaaaLCrBKYIzAz0jFLPu7TDlQr+n9LUcYc+5kQkisnfnP1opJ4lYpM8kjpb3
        T6vsc5YZ6apmdv2V9iLPfsGnsbLoW1Xws8LbH5ubJYjAv+ft33wBvP0MmVq7hcaU
        Y1Eb1UiBpxaX1BnoPVrKisaAUEuY0R0lck0sqTXqiQq42rdU8D1O7s7wQszmAFjp
        XWzG0Le4RbsJxdU/xyYVSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5ziWnHa28vDW for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:00:41 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kcb0sp4z1RtVl;
        Thu, 25 Nov 2021 22:00:30 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 1/6] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 26 Nov 2021 16:00:19 +1000
Message-Id: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
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

This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
"Revert "perf bench futex: Add support for 32-bit systems with 64-bit tim=
e_t"".

The original commit was reverted as including linux/time_types.h would
fail to compile on older kernels. This commit doesn't include
linux/time_types.h to avoid this issue.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-riscv@lists.infradead.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/futex.h | 52 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index ebdc2b032afc..385d2bdfaa9f 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -8,6 +8,7 @@
 #ifndef _FUTEX_H
 #define _FUTEX_H
=20
+#include <errno.h>
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
@@ -28,7 +29,17 @@ struct bench_futex_parameters {
 };
=20
 /**
- * futex_syscall() - SYS_futex syscall wrapper
+ * This is copied from linux/time_types.h.
+ * We copy this here to avoid compilation failures when running
+ * on systems that don't ship with linux/time_types.h.
+ */
+struct __kernel_old_timespec {
+	__kernel_old_time_t	tv_sec;		/* seconds */
+	long			tv_nsec;	/* nanoseconds */
+};
+
+/**
+ * futex_syscall() - __NR_futex syscall wrapper
  * @uaddr:	address of first futex
  * @op:		futex op code
  * @val:	typically expected value of uaddr, but varies by op
@@ -49,14 +60,49 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op | opflags, val, timeo=
ut,
+				  uaddr2, val3);
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

