Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D55DC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358746AbhKZGGO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:06:14 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33495 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhKZGEN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906460; x=1669442460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SSseRtMSybeDf72z5xPZsA6JPa2OKfvjC4qAA+TvZZE=;
  b=GGkq174WhIGsuvffrrf2A6o1lEcPH+R574d0/yKVmQY6clmfRBFw1Cbs
   6/tU2SuxEOVzMwx84GF0B64Dc+lL7J3cuPQSMaVOFo5PQ+W9ZGZ4tXGVs
   m2/4Px1SGOGs/vDZNXsURo+l1KVYKrDI3xhsiA78qRnweMJQPLsFoAT1y
   sY1Yrg5jZrfMTyWsqpE2iGAeewYOaXVXbUmQTwUFIzasAVa+jfU3jSWX1
   0xkBqvX+WggAZkTNlC5WfIFb9U6dyrtuRGfk/hX5hLGRmIFOH8xE1iPSt
   SwUfYpXRBjPdrKj6OHXDXteK46vNxYeFtqEj18+o6aGGdFHrcNcJ6Bpdl
   w==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="186703980"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:00:59 +0800
IronPort-SDR: tpbXS3YFDMEwxdAWAXZBDQixQWz0A7lik7/lkQaua/rkalJpUPdiGUyWIbVyy6hYnSbRm3emX8
 ooW1u5W+jJwLKvXDNr8TlCo4K1CFgUKap7+Ok96+3nkjA/GQRK0FIJw3+CPZnq8nTHXM2RVDDN
 rGruzlBDf20YV3H/Wl7WAWDcz+/c+gdynH8uMhVMeEBgXjdP3ZNpu/i2PreyuKQ986rD4ZSn8U
 ImU/0z7/MuJi01eFRkD2kL/TOi4bCc6qUfjyRBrdpHCC5e/E0EC2ERECeNCEi7u1DzxanWCuzN
 CdPu4WIEyjLjk5cSsOrwK19M
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:34:19 -0800
IronPort-SDR: tfE3Vu2L3zn6KQ3roE+icTwfx82kLGkIqhv/+rRxsGAPds41E+UTM4i16UXu2/ua8NyxoeOcdC
 Q/DwPw6H6UZrN18LsmCVhqeGn9PH5w87RmOy2mjczh7PMnwua15AY5B2clUyhiOZDN1xmeqKR2
 ZIgWspd162nFIZ89QHqBLeJFK0e8x/AjarzxJ6yDRZz/zJgvr1BNtYE2Jpy741ojJuOMEwPW28
 nsYMUFXL5djBXuIaWuC2/G3DuAVELo/zReNQ03juPjM8QAZeZfSdSXE24q6xRCjfHWmv4GE71K
 4sE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kd80jbQz1RtVn
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:01:00 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906458; x=1640498459; bh=SSseRtMSybeDf72z5x
        PZsA6JPa2OKfvjC4qAA+TvZZE=; b=sg8Mjw+7a50zWsxWcSpZhin6Is3dZFVtaN
        xcfr+6GXVA7Z2LZn+Wr68JfQlJsVMjNN6SBvaHyyvBv7riqzugFUkvHa+HsHFpfm
        l66ebGi1i1wFFi+c+wGdBZBTqajsEwd/bTJyk+iBf+H5nBcspO0uw0phgLo8vTgl
        Yr9pss5WcQRTw06bMmFZfm7rkmqII9yYJAtEZt5K5iFXi/NaVkN16fQSAEnkE5MM
        2q2pANIprKrasacqmTGdsoaCryhcPvHJMlWOwCkVtzgNM+gmjPo7hKq1x3HlSYHS
        6BHd+Nxg409gm3OnKXAgPwByFn5pkIS6WFRVE193UNCvty3rch3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lJ2w4i5sKK1r for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:00:58 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kcy5MkTz1RtVl;
        Thu, 25 Nov 2021 22:00:50 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 3/6] uapi: futex: Add a futex syscall
Date:   Fri, 26 Nov 2021 16:00:21 +1000
Message-Id: <20211126060024.3290177-3-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds two futex syscall wrappers that are exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. This has mostly been because
the overloading of one of the arguments makes it impossible to provide a
single type safe function.

Until recently the single syscall has worked fine. With the introduction
of a 64-bit time_t futex call on 32-bit architectures, this has become
more complex. The logic of handling the two possible futex syscalls is
complex and often implemented incorrectly.

This patch adds two futux syscall functions that correctly handle the
time_t complexity for userspace.

This idea is based on previous discussions:
https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=3DRtm-Wb08ym2TNiuAZgX=
hYrThcWTw@mail.gmail.com/

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 89 ++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 000000000000..e0305c581142
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Futex syscall helper functions
+ *
+ * Copyright (C) 2021 Western Digital.  All Rights Reserved.
+ *
+ * Author: Alistair Francis <alistair.francis@wdc.com>
+ */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <asm/unistd.h>
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+
+/**
+ * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrappe=
r
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @timeout:  an absolute struct timespec
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_timeout(volatile uint32_t *uaddr, int op, uint32_=
t val,
+		      struct timespec *timeout, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2=
, val3);
+
+		if (ret =3D=3D 0 || errno !=3D ENOSYS)
+			return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts_old;
+
+		ts_old.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts_old.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op, val, &ts_old, uaddr2, val3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+/**
+ * futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 syscall wra=
pper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @nr_requeue:  an op specific meaning
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_nr_requeue(volatile uint32_t *uaddr, int op, uint=
32_t val,
+			 uint32_t nr_requeue, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uad=
dr2, val3);
+
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

