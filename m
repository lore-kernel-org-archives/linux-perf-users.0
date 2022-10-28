Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63938FA3741
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiJ1J6C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJ1J5o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:44 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE21CE3E4
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951018; x=1698487018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCBe/q5YolyqbHnPs4c9IauGtcofM9sooHtix6H+SW0=;
  b=A0d42222+DrBR02nD8B03NbOUu8DoRCQYVlSqdm717JxC2WJYeku7npy
   WBEEos/D4VUxIbox6ebDhmDroMvdDWO/Jkfl3FxQ4RMVavq22UhRsjp7r
   mszcK3sKNwpPAiu1NSvhawyMVApdH/wJbikGC5Eq+P8bfCNIsZsxx5lRT
   IwM1E66PpOowijULLrfLEupNXaRk5MW7cnm5LM6lTAanCVLDC4EHbxSwt
   V84MexdOudbfpGaHOPn8X6qvGhPfTJSP+a9GvSvaRWHpk9LAdsxxfSNg9
   bWwkGh+iCXa5P0Rx5hqLSaj9+1qGKewLuBRicuWwWRVw/corFDEOKRSEl
   g==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="214962172"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:56:57 +0800
IronPort-SDR: THpn/VFw05IO0g+NczxIOxllroCU3jLFNv1Eb8X9wOPjCyTwTHDs8bH5gal3lZmq6PlXEb+i6A
 X3Z6nOBXaAi3NIJSt+CVOIzi4MsyA+/5yMsAl7RE5NJE9gcpSrUeJPmI+qWX6vg/7OcVAaXbbN
 Foy1sE4kWpOHjgc7wbKmHRa+H5Bb3tLhqGjwm+tYkxirp76YDcgrc+5g/Pgq0R2I6zkneiBRL+
 XCn1W0wSzTx1H1VjA6BN41n2EJ9vXCdBwxSs5B2pnxVSowgttXmK6G0xBk2yljWClEItIbO7Oa
 ygrLxq3kBco37qiiwZZcg5SN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:17 -0700
IronPort-SDR: K7FqwptOCQ7QrTxgjs1OmHSlX18EESeO252yCukYwsWrCPfjm7gEjPG0nDw9WiY0cXs/1o+Ojp
 0l4pRXRY7brPlviBQYOr977UHTm3LQthcFJYLbe8d21GSINfbVSS9mK/On46mTC40NHCRd1Lg1
 e9ULPJ5gcvae5kx1Wn5RavNldDp0UHu9lDuYOI/v51VYNiluC0WdBYf/MrKoyoRuh1uiuHMzpn
 lieIL5NiQYPlEO9T/4yJoNxNG63Lwg+itEj13TtayqNngEwwnq7aA2zr/yzTQlKMfzmCtUhdiN
 tkU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:56:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyJ1Xqdz1RwvL
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:56:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951014; x=1669543015; bh=cCBe/q5YolyqbHnPs4
        c9IauGtcofM9sooHtix6H+SW0=; b=OAa1FYOtOr8Yv6LLPxBxxoNFUhQW1PLMnJ
        KFEd1oT/7vn16T4Ox7LgvGBdS+hqd6gPwOQD+nIAb+mY8pOgCRmEUosR2o/YvVo7
        wpOApZYhSgJk5YFexLdrCigBcPzlYSH1qa+qFwQ6OpEDnM78Seta0h3nrh40sQme
        m6PJx/hKkzXwqplYVSPZZP6jZpEbq6RStVjLuI+4SJNkY8C/uphHH0wg2GWucedb
        K7fTkvTVRg6JfbnLrdL1GltYKVNnAI5+AYitDl/Pdw2Vvy69WKH6rB4ynzmNbF3H
        kXvPWTYZsbt5AnqAlvR2HFSepDgUBQm5t2SDARtsEN5IOPa9eCSw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PwB-uvMwo4HO for <linux-perf-users@vger.kernel.org>;
        Fri, 28 Oct 2022 02:56:54 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHy76NpKz1Rwt8;
        Fri, 28 Oct 2022 02:56:47 -0700 (PDT)
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
Subject: [PATCH 1/6] perf bench futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 28 Oct 2022 19:56:27 +1000
Message-Id: <20221028095632.1081262-2-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
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
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Message-Id: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
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
2.37.3

