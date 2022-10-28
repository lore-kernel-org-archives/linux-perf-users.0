Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CECFA3741
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 09:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJ1J6W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJ1J5z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D13548EA4
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951052; x=1698487052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sXdRpXoL8fKMHadmBmTH5z4Y4mbuNPDkZAxHvAj8lU=;
  b=oXDiouemYkNz3V1T1KwN2AgmAXQyq+B4+Fw8JPNeVVGfErvf1ZQJ/MAV
   0pEIJwNts4GepmiZnHY4aMEqrIDezziMmPhYW/yoS7vRnbAsMr1r18/6f
   TctDLw+JKx4Btu/NQ61ag+wSWAa2kymHS2voXc2K4M9bQpvhiZugiXvYp
   aToCCjyR5q7WlvjpZrKC5dbz5/DjrRpidHq76Y5BS0U0cXDSyv0BcNzKj
   b6SFdKJfVz+NGE9EZ53na5PgtMh/4i4FM/AVzzdfddfRGTtKYNauEUTKu
   IalnWGmk+8NL5/C+ehZbe2E366fQDnFWQJPms+B2YUR/FcYovimIyy224
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="214962253"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:31 +0800
IronPort-SDR: SwYGmSTn7iLFlw8DIrgOi2JijN8g4zupRRDLGJmQfe960BU5rNALX14lPHfs6W0Xgan2NZwM6X
 BxqBi/9mFLhpJHRNixZq2PoM6HTuMjBEUYHWZMNfbNN1DU4gvL6VeIigbsdLbmryH8hmDoLTNg
 8trlRRERuXLd0P/Q1EIKw74eLaQKZlDYLFzZfOzZruWlxdAuhIjKgov1swvjBm6WNcIkkzygL0
 eLYjMemjdxHhxYxbEJSStJHOsS1B4EmQh/aMgSvSIjn/ly97LgeDQ3W0xDPkKVR3Z2qaV5KjUg
 MmFeMD2NykEjFt7daglcqQhp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:16:51 -0700
IronPort-SDR: MlEHrnBCwV8DWORiCVvj2W16LVRo1MzrJctcdyLg/sKtfWup39GREIi5V05zkLhiJlUwHlGOeU
 otcsGftcQWbzO0MhG2FFB1bSgogsHl02kyKGT9QD37/9KxMQE6nFcETqcR5k99jEehD9AgopI7
 L9zsTAu74OjjErGXTYObHKHCLieBlVNN5V2GAyugsjF4DJi2+3kwmbyVPKBUZofVjxXzSNTlZs
 PcZe6irN5uPd20yLtXpl/Aq6pNoTyKKTA5Qo8c75j9dw1p+N1uk2JNvhR62jcJe3XuG6iLtcHk
 s+k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHyy6zkSz1Rwtm
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951049; x=1669543050; bh=5sXdRpXoL8fKMHadmB
        mTH5z4Y4mbuNPDkZAxHvAj8lU=; b=i4/10uIu5RyP75V/f5ENBFGxGBQsJdPxTT
        e+kzdLy8o7BJq2hv9WGbJcPNne4tQPPnn2Acj2woZm2Xyp4Jhw3LAI8A/HAIFFwl
        NNiTQBR4Zf4diFyhwtRhDQRyV4eUz8AhcYUH6bk+kk/ew6Ih3Lw2hZlN3MeFCtWq
        yg8I5LQk6DPR8peBUxhVIrW2l/B00G4BReNrsIqnEJFmkQSIk0ZyB2BKx8Y9ZjZH
        HMMi3VYWfIYEbXeJU5BkIuewRNqpBMfAqUzDKolPa5HPPj05XT48eQ9Y3LRbuUoe
        1dKOqJ/YCh/NfdcW9YftXy/87Oq4Y/lmphJilXOocMvsDc8RgHXw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 287ZDoC-DNlo for <linux-perf-users@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:29 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyn26b8z1RwtC;
        Fri, 28 Oct 2022 02:57:20 -0700 (PDT)
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
Subject: [PATCH 5/6] uapi: futex: Add a futex waitv syscall
Date:   Fri, 28 Oct 2022 19:56:31 +1000
Message-Id: <20221028095632.1081262-6-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
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
Message-Id: <20211209235857.423773-5-alistair.francis@opensource.wdc.com>
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
2.37.3

