Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80983C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 11:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbhLBLVb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:21:31 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38692 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357274AbhLBLVa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443888; x=1669979888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nl5CWwCo+HyJCS82sRYKOmxVIBP7Goz/nQOWZ6792B8=;
  b=PugC9wAb4MZRY1dGXvhFqf+eUdvlD20KFaFgSw5pWlE4yV0eg0DGyBu/
   xDTKjf8U5DpwFjQQmy9lKVXKrL9BPdZU+43gYadczDMiMisDrNZKpEFg2
   1NGKJ7t7WGX542hz/wRgO8+EVfjDa5kAgNFofiSVHGOldUV13D1hdu+S8
   U9TFSfsaWXHKYE1LPrzR8XlKCfZF4ysr3jkE9RSfmrp2nwEPeOJTgv2Sf
   YBTDqmFuIoswdx+yKwynNluktOrjheTugW0+saaKHurTc0P9zf1/kdYKb
   QIjY3ZHuMVCSYqY7JlBRe5PVPicvvb5JnTkOF3FLe4IKNTUode3fSVtpg
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="186259547"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:18:07 +0800
IronPort-SDR: VFBbobicz3cEwC57YzSR3YXnMqXFq5VesX7BzLLpcGR7Qy1fTU3tfIpujGeoxWo8s47kG4UShO
 Y46+tz4JB8TRsnjAGZndy43NzHmI3xRIX0NcgQA8qucRiF493vlynzDq7Gi5s2BYz6OvNoQBml
 7a3w62HS3CQTdUVvOyrKSIU3TRwIlP6PhczafxRh6BdF6PMtMwhU2/B216RdRrP33bHZ5+lvoN
 +MVhUaVx57zTaYjwWlQ28aVzjwNSWCt4z6aXnBcy5eQc3uCPKV3WcdZG4DyOH0o6wGUaqo4ezU
 AZd5voAk0iULTdLKRxnvwDGi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:52:50 -0800
IronPort-SDR: 2M4040oE2aHSO6W80PrhkB63kqat0TPbmfNV4bpFYS/3CnNjS5/+vHU9ciTqRJgjhyZYU/9+L/
 /UPbB1yNewjpg+Z/k53qidrSXSIaH3p/0WzJdN0N/g26YPqRTM7GXHFThwl9xqakoZ+9A6n4bT
 R0N+QFcUGHjW0WCy0W2DUZUJkCV9Lwks/UAAU8MQgdRyLS2CaqLq+m2kb9aTlboDQaJGaYObJq
 fWUxMRYslvZqRTYfl03Rc6CiljhgrR/GzDAhwkLO429rutLruAJoOUgAFbf04eeWbKPhGBFJgx
 5RA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:18:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YNH22zjz1TFlw
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Dec 2021 03:18:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443886; x=1641035887; bh=nl5CWwCo+HyJCS82sR
        YKOmxVIBP7Goz/nQOWZ6792B8=; b=ZBaBgjYBGtfY2X8siccP2z8zE8wIXrCR5W
        meKK49dRKRY/dOVcZixP6TxnjRvI+ZBY9brrPuACeRI1AUCFKjLgIXRWahkoPX+T
        +tUSQSUC/t2AbEoK75jo6LjsiyUEUi7LYvAtvL6RzMY/0oT2tLigwWwjRDbRj0jM
        MogY7ddNcXl3v9y3JSnJ68qoh7ypTX3Y2K0SSpdDcruK2aEaHc1j60qOkxcylBkv
        E3e1L6uzD/e5v0ZCsIFNHCwb1kpDegWADl/5nsISoRsld3A72GyEgZiZVU883pRy
        ozB7KhYuhhUJ8qHCagtJuWd4aOQSaYfB7q6WqYuQhd6ASxyq5Tcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P_SiqtjQSIFc for <linux-perf-users@vger.kernel.org>;
        Thu,  2 Dec 2021 03:18:06 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YN50X3fz1TFlx;
        Thu,  2 Dec 2021 03:17:56 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 6/6] selftests: futex: Use futex_waitv helper function
Date:   Thu,  2 Dec 2021 21:16:59 +1000
Message-Id: <20211202111659.2077911-6-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
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

