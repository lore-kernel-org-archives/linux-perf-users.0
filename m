Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D33C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Dec 2021 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhLJADa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 19:03:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:65003 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbhLJAD3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 19:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639094395; x=1670630395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn9DS7hISPQiTe0ItoOGPSItTCkQ9fCzmpu8eWvFTQQ=;
  b=GkespTro1U1KCJ+EPuMcaasYlJhCLGwvuUknvlaEhSqYBuSO0dx3bsnx
   r34aEsul/U8JRErAgQPPOyRBjJyqHzKWHMFhqVlm4ZfolPhd7VEiDMBmf
   WS/pAiW1+GWHuM2fGqL3jb1xIwqrJyZWtvoki4CndJ5ARlq0lp/OESKv2
   iWMRlHlCKKn+i/N92VREl+t1qBxbBgnBir36GalZTl5fkHhgXWaFVqcxu
   erAoCEbx7Hry4bqDKWnoNktSAKH3F/fBgSI5jZ+eEb9nyIjP/aFD3XtAr
   6KMoR0ZpmH7zfN23irBGPhbYHTU+gCqbYCeQwjqYZ69Q7o0Kh2w8HFJEr
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="291872816"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 07:59:55 +0800
IronPort-SDR: lEt/xJJBcaT/71QNopsTLntgZEBy11hLpqUN4MgwK42TfQqaFkXR+STfaIbNfNsKBNTwLZIMIi
 2nkK9xyiQ7ck+hOOxkYIbBD/UttG01ZeoKRtMKV3NB+7O9XGxjpUoYzXG/zhz2eJMrFo0cd2cp
 pV7K3O2vd3BoA+5QeQsrC0jWE0uHNO6EPcjHt1KpQ2h3FxW5SMw6gw9/T+ob4hid9zqJSgURmX
 6DYXDGeXaNxNp4vdP7f4raZqfRGOuv7ILxXQTqARnlOVjePS89HgpSkDL0f89hT9tXaRgPSpll
 Hwxb+lGYvK9pS7+YDHfbjwGF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:32:57 -0800
IronPort-SDR: gCpUZvE7hGfYd9z1tOgKwHke3o9vt0EfQ0fBCrP7C/Yfo/6PCctKyZ/DHJFbNJclfGE52FAUiX
 XbIMaEh+J1fDt10KkCZezBQy/QSmuU51lQjbYzUZHfZHk+t07aBAq1FJVpgqm/zqZdytpvYzM+
 G4XfRrwFLFXDrhgciVqha7gjH1utrBuymIMxAdgVa43g1CVUYPBHuD1TBJRSXpvpi5wqFAT/6L
 K7TgT1+RUE/gRnYWT8QrG1uV562bjxaoVfxnkEqDMkrzgEM+Xk61T2DZ+AZGUHh5YhUfRCCh2R
 oLo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:59:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J99y303g6z1RtVG
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Dec 2021 15:59:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1639094394; x=1641686395; bh=Qn9DS7hISPQiTe0Ito
        OGPSItTCkQ9fCzmpu8eWvFTQQ=; b=PXRXqb7P2jYj+HqiqQR4cegIyWFU2OmLVI
        D++hfADINigHHPgn4h07wi4P9W7aG+D/uLRoTeQFV3tlhSllqqNHhFxKI76IZpzB
        eK5MUxAbUOUASmgoAgHLkM435FeflMCP6YAGsiGAc20A6SxfQyedk9yLHG3Q5Xo7
        ff/kkVAAhlWj7wC6MGArgf4QSa/uC2RgRJkt37v6RpKSQeVWHT3ufw4wXfa/dV5q
        zfresTq0NtsXSlpJspSe/InMy2P94AWEsDcyVZBPR7tNuUSk08YPJrhHUwkz5iMt
        TghYt6j0kNMrq6g6uhMrWcehAqvbzlv6Pzr1X/3PHhpnpjHaDu/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CEPkjdpeXnuC for <linux-perf-users@vger.kernel.org>;
        Thu,  9 Dec 2021 15:59:54 -0800 (PST)
Received: from localhost.localdomain (unknown [10.225.165.65])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J99xt332dz1Rwvj;
        Thu,  9 Dec 2021 15:59:45 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, dvhart@infradead.org, arnd@arndb.de,
        alistair23@gmail.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 10 Dec 2021 09:58:56 +1000
Message-Id: <20211209235857.423773-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/futex_syscall.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index bac621eb319c..f637f05a3be0 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -89,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * __kernel_futex_syscall_waitv - Wait at multiple futexes, wake on any
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

