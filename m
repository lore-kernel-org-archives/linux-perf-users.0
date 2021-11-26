Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D94C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358619AbhKZGGl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:06:41 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11683 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358620AbhKZGEj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:04:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906486; x=1669442486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UHFYtRUpqo1Z8U1NRYz0VvF/MbTIc2c4ImiQa8RqQHA=;
  b=JdUYymJC8zDkSDU3ayOFLkINOFUKGouMoxwZzty6TnR240z2nnmE5+Tx
   YIU37uBGeUHWY9+hzFxYf7U+395mhkc5MfTq9HY9Kx0CbjcVeFHVtolll
   NvoZSnFSEvlvYmifdSlijo3r7LKncPLeRCoZBujv23O4/+4lFIaolWA1B
   qkxnJCrJCNz90oEaue4fT5MT/8YphJHNtPW8w32//N+VHt6lAL23BcZTg
   Zqg0/tH6gXH1/LJSv60gMAVZmU6E50XA/TTK1wKHpk1/sPu5EbaXQsocn
   eL/aeqe93LvJ+2B5nDCeevkTeSNAY1dWQGU7XYeuAtoEoz6Fo8NaoS+sF
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="191493918"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:01:16 +0800
IronPort-SDR: PGFog1hACF488osHk/Of1Ar9MVsAzFlfFdCJClwgrwbNpG6kAufx2lpHKucO+QhU6Tah/E/DuA
 Q5nkiGLYyMQX/DUu49xA4oBRKn+IRkmoao4pK4BZaV/ck0fOSYWNvd+mOVkt7FwyB0aTRxfghO
 ElWfbN3Tec36yAw+6da4ewdPfcsTTxpg6DanR6qaNhyz+Bm5kDanHtqId0pQhIBKsKkY5BTgLX
 oseKHkdw0JFbR/HVmYgIuiWEnLGBoeyY+g4UaR6VbsyXyP+PiLl09CMHKRPK2oip7J2aBZUN+A
 D2jV5Ji3QtbyR3GTF1pr7ga5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:36:08 -0800
IronPort-SDR: hbpQzF0FIvJVzeo4OIJmdeTJanCXKcIUYxg5mcv1rBhFM9kgiI0n89fKSkcDH5x9/II2BJXOMf
 ONSloAFktZDTHQzNWVLBGtIGBC6cbGFRmdYuxpdMtXNqQuUEwW8cYc3YaKL5tYCH66PPAMqPdo
 Pu06OhQWPYyl7dW9BbjHurdHUpjyvyBqhRtpjkye4ftx3js+sTd1+ClUCtoYvZsAmkjz3KIgbr
 w7wrFOW5sd0+EjAMxwlkQ1ctLRAobjzeTxp0ku3mbIhCrcIKBiEx2T65b8HOPCv8UZm+0HSA3o
 JoM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kdT2Jk8z1RtW4
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:01:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906476; x=1640498477; bh=UHFYtRUpqo1Z8U1NRY
        z0VvF/MbTIc2c4ImiQa8RqQHA=; b=UM3s2tFc8rIj4gOSHiCA2kixJ06bmwMSZm
        nXp/xzAWpAlxvSmK/DRN5fHKOiHUtKZTJZTnbLSxMu8efaNrAv1g9NoDY8heiXV8
        zGhJfUk7qvuVCbb3J6cwARZRee3JhUbCmIa0waojGvwKjmIWpvl9X1Zb728ki1ZC
        dKeSYMSD50v4zg9KFdpcg4YuMY1EYhs2s2V/PlXJnaaDEBWEJzyeLj/Ri0ETBNJ6
        r+WpxXgQL8MQ8yEQAaRZ7VdvqJ9qW3OgX+7qX600On4BXtwLhlXw7hp9uNmSnYJH
        2ARVktXiqK9/sbDrx7G+Eb1sp2TRZB5HFge9YvgyG9Ha/8EsrMsQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jSJVc89ii6t8 for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:01:16 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kdJ2F6xz1RtVp;
        Thu, 25 Nov 2021 22:01:07 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 26 Nov 2021 16:00:23 +1000
Message-Id: <20211126060024.3290177-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds a futex waitv syscall wrapper that is exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. As the futex_waitv syscall
always expects a 64-bit time_t this can be tricky for 32-bit systems to
get correct.

In order to avoid userspace incorrectly passing the wrong timeouts let's
expose a public helper function that ensures the kernel is passed the
correct timeout struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 32 +++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index e0305c581142..98c550990833 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -9,12 +9,15 @@
 #ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
 #define _UAPI_LINUX_FUTEX_SYSCALL_H
=20
-#include <asm/unistd.h>
+#include <unistd.h>
 #include <errno.h>
+#include <linux/futex.h>
 #include <linux/types.h>
 #include <linux/time_types.h>
 #include <stdint.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
=20
 /**
  * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrappe=
r
@@ -86,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * futex_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int
+__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsig=
ned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	/* futex_waitv expects a 64-bit time_t */
+	if (sizeof(*timo) =3D=3D sizeof(struct __kernel_timespec))
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clo=
ckid);
+
+	/* If the caller supplied a 32-bit time_t, convert it to 64-bit */
+	if (timo) {
+		struct __kernel_timespec ts_new;
+
+		ts_new.tv_sec =3D timo->tv_sec;
+		ts_new.tv_nsec =3D timo->tv_nsec;
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts_new, =
clockid);
+	} else
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, NULL, clo=
ckid);
+}
+
 #endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

