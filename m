Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0471C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 00:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhLJADj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 19:03:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:11374 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhLJADi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 19:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639094404; x=1670630404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nl5CWwCo+HyJCS82sRYKOmxVIBP7Goz/nQOWZ6792B8=;
  b=RQAUpybnHK8q1ReG6Oeem0uWctJGYzMz57RxAH5K7KXZBlZEn7vMwpxm
   abL6Rh/GMkl/qjDU9W1pIzvpNQcdKFEd3zYstLthuFDhb+vBoS4Ctq8wc
   6mB5GvwvoDeGz10OgNroK/+vNXAP3g4emn5HEZUZenaHYuyheilFu9Z47
   gD+3fxFjlHXDuUgJKXt/LnO1BtrsM8HJaMFBxT55z54hrlF+4enKaVsu7
   MOcXGs31v8yfx6EOnZURarLCeszdhbUyPvKo9BuY9F/RVMT+JmPltfSKf
   kz1DezjfY2pMlYJlay0Z9o31Vj67J5+Yb3TeBlY9qcBYtkSL8xzS8AF6M
   w==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="192670757"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 08:00:04 +0800
IronPort-SDR: /HDFd1heGVpMiqPIEN82QQgPbKlUp09WF1ErjNBWTBO+1BnSb52uZuhfoh9m2KbyZIitSCNOok
 BcguABvak0KugQ7KL0Fki/zTctk+mdECbWBcLIWlDp0XAEFWgJVWbuIBkMt+2msYWYWmQB/fxm
 ZJvVM9+J1d3iVvcK50QdswIM+w5NfF2y/7Q6S3a/ipZIXI6dEXePtPtM3+OcQRS6dRnjqatBoi
 RUhjFL1/XhBShm23qN2+JyOaaV3E1XQud+KG9Qr9AnBqFZ9ZFdEH9lrUzvjeZtZd63YWP/W3rF
 0bnqb0WUznvsUvbOmmAaY2BE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:34:36 -0800
IronPort-SDR: 2HpOwyW2n05ayCOGoE2VUWXTMGTwPhQghLqHkm6heEftPu/Z6ibi2/tTeuriIp/1r7hM1tnquP
 YZnba9DcdDIXC4ri2Sl0KJdJr3jfnhucqWGinvTMChRFlUP9hWIHzjnvZD+ulUk47oD8qcXuYT
 Oege2R0B/ZzukudGFMu3di+XYMcr8INCkxRNoStyHih2/r+/rJeEkgoY5NpmnKev9QrJ0x5fiG
 ghX1nQTARs6onIC2LMvDfXixTZhe9Ju2Xckh73LtwQFSZIuf1TM3THVc0jP1EKPJzP5IuLBdGB
 HlM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 16:00:05 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J99yC4v3tz1Rwvh
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Dec 2021 16:00:03 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1639094402; x=1641686403; bh=nl5CWwCo+HyJCS82sR
        YKOmxVIBP7Goz/nQOWZ6792B8=; b=o2lfcKC8VYsfqVvTNNfLmya14x8mJpM1Tg
        eGt2Yea3le2cpBSSLjD9ps4whWUQxyQSth9i02HGs2qORO5q9i1oQD8LAR/gqosh
        mTUvxbHa87+us5siyYm+vW0XDP32fRNt7zHLqRm3cv66vhX7gseZu1Ki08awR+PS
        GSBLWpGem852c7SY5ulYvhjsTbQcrunxOdrcTa6xYMncJrVWdYz74vB6RLCz24EN
        EZ/8xfG48eZzamZmNmS0xqQJ+ewHlQZLItKkAFCIrXmlvuAuyD2tOnFh2Ly1sUGw
        LWPfWw5t/j0zFLKUNvb5s3AbpD9yKVLrGJ+/Kd6+JGHPCHTkwE5A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HWqoN4WaIium for <linux-perf-users@vger.kernel.org>;
        Thu,  9 Dec 2021 16:00:02 -0800 (PST)
Received: from localhost.localdomain (unknown [10.225.165.65])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J99y31XPdz1Rwvl;
        Thu,  9 Dec 2021 15:59:54 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, dvhart@infradead.org, arnd@arndb.de,
        alistair23@gmail.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 6/6] selftests: futex: Use futex_waitv helper function
Date:   Fri, 10 Dec 2021 09:58:57 +1000
Message-Id: <20211209235857.423773-6-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Use the publically exposed __kernel_futex_syscall_waitv() helper
function for the futex_waitv tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/include/futex2test.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/t=
esting/selftests/futex/include/futex2test.h
index 9d305520e849..fdc0a0a270cd 100644
--- a/tools/testing/selftests/futex/include/futex2test.h
+++ b/tools/testing/selftests/futex/include/futex2test.h
@@ -5,6 +5,7 @@
  * Copyright 2021 Collabora Ltd.
  */
 #include <stdint.h>
+#include <linux/futex_syscall.h>
=20
 #define u64_to_ptr(x) ((void *)(uintptr_t)(x))
=20
@@ -18,5 +19,5 @@
 static inline int futex_waitv(volatile struct futex_waitv *waiters, unsi=
gned long nr_waiters,
 			      unsigned long flags, struct timespec *timo, clockid_t clockid)
 {
-	return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, cloc=
kid);
+	return __kernel_futex_syscall_waitv(waiters, nr_waiters, flags, timo, c=
lockid);
 }
--=20
2.31.1

