Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FCC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 11:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357269AbhLBLVW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:21:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65044 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357279AbhLBLVT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443877; x=1669979877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn9DS7hISPQiTe0ItoOGPSItTCkQ9fCzmpu8eWvFTQQ=;
  b=kKmvTUz/hPuLODbgDMlCGB+7roPSHalbwsZFTOCCbGVOP+OuZzORGA+D
   nbOYQWLPePZkyIHH3NcvpoVmSYr+rogiCLcNr/6YK8TqgNE572k9IC5bl
   QhTOQe77stTktaboqHa3NLUjG0roMnEVNgJ1P73a8JqrxuYVX4yi19P/G
   p7KU2gdhcBQ0PwFS29nH/wt2Kzrrji7CXDtlH7NndDohQBqt7QwLw9s5V
   8ngMboku9UfUim10cSTOUULgmXCjK/HeMiUcxt5n8Yf7922vreT6b9Hkl
   Lvwu4tKdLjpUSaotup9i/0EXGoWlp+dIo0a9xX1yJZ87eGAndh0odYtq0
   w==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299115601"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:57 +0800
IronPort-SDR: T8tVpLOWf4pkB5GmxG9ODiIq6IbE0JL5fxM23oasw4tJeMCv7IWqnwSkOI7+BIoUfxfEb1L+GD
 wJbG8uHbShEXPxyLu64MbLEpjtOqUNaIMx7CQXoFND9/0qQDLY5aasALcarUDM05ZTT7W406iR
 lxyg0MCIO8e9p8E/thVR5HCI7XoNxIjtjXmA28ZSPT3ZR4XUEQ1OHa/yDW51XVVPMkF2tg0jA1
 PdJBt57EiOckZJLlYyMHjvHFy5THeRoztlHuk4dFT+KLYKHVIlOGXNkna9R/CNYnENCN4AFlQF
 qXreGGGOUbbHcu1T4ndEB53g
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:51:07 -0800
IronPort-SDR: cXrcx/uy4hGA6dLB0ggcwQ2d4aClL5CVubNU6jLyUQ/Rs3GSM5D2MdkJs5uvNYbKBqS9P4EOHl
 bwHUwSEEHyvX/3+V41Hd+Quqkw5Pd/8wUIBKzWJw7RaT+77/c3bgWAZrpieg4XN5LhW9fcfY+s
 sFSWEKA4osyg8jZQ/aNJcjus0paXUZQL26RyG90rjZR7VRUUZKYBHTr+8gQN/Y7qw/DmjtWAIb
 WQg96Ur7eX+daFnmh959pVZl4bmECwp6n3xgprVb2s14D8EbcTIzLzHEExA0FEsBRf7t1Yitrr
 XXY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YN475dlz1TFln
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 03:17:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443876; x=1641035877; bh=Qn9DS7hISPQiTe0Ito
        OGPSItTCkQ9fCzmpu8eWvFTQQ=; b=bzA8OoOXLo+BGprMmKNs9R0rF89h3Wxh0z
        DMRlt7TEXbomkdaxSiBBKrXlXgaV2YYfimBiiroVpZDG5Yn6Xk9RU2rEXdeYTvJs
        jgZQqhFJru1GSq6T0OonQh2FAMab/wyWtp3Op0sX/5NG9uTJcRtTQC5zwEpU9xdd
        cRGigCmRJVgOtPB5wcICs6/fEIxVzqbrpvbiNphC5Bkgf78HDq1W8yfWA++jKlmI
        oJAA55mb6gVIhwPgwFE8JxIiPzRiVLdCvaMLdDwoeQOt+y3rCH9A59bE7vuF6qF6
        hqsh7yI6ZjRzvxA6+bmbo43I3ogKNNcaRvHy1M3MiAxvWOwbikKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id roIr_UsZQi2j for <linux-perf-users@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:56 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YMv2VDsz1TF9q;
        Thu,  2 Dec 2021 03:17:46 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 5/6] uapi: futex: Add a futex waitv syscall
Date:   Thu,  2 Dec 2021 21:16:58 +1000
Message-Id: <20211202111659.2077911-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
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

