Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DD9C38A02
	for <linux-perf-users@archiver.kernel.org>; Fri, 28 Oct 2022 09:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJ1J61 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 28 Oct 2022 05:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiJ1J5z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 28 Oct 2022 05:57:55 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC7F4A109
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666951057; x=1698487057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JydiMbJm91qt7Dzdbzqgf9FuIhgVG9u78TP21lC8mbE=;
  b=eJRQveILHp7xS3dKf83C2WHOgN/VdBt37rqb87KKFrUXBdbXDDqGzO70
   HmdJNeV/gBShr7MumKUCHJ1ltXfcfmUrpjcgQW1EtejK22Df7IcDyQltV
   O2LEGudfZaVWQJAAA5EOXlOqDTvX9YTS3TGhr3LqYEOG7R+RWhQaeWNVw
   AIjbKHXMXkx00bBNenZEcHIbDLnq6IsDYuyEVcNfm+f4CWnUzIj2QpcJJ
   TVZMODMMdkvL9ZXo3G647Gx0hk4KTWPaVaGerczz0eqekAbITrDVDTUpt
   RJjQRUXikBdzXNHASoFyGjCBjmk2pvi7kSIPdB4MqcRbx6toqh6968uoT
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,220,1661788800"; 
   d="scan'208";a="327068527"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2022 17:57:37 +0800
IronPort-SDR: 9fEb0NXQM7Jtcqr7HYZ9JxfhTPUuzluFlzEL6nauhwk6zQce/Gp+UBjzOrvnGzVJVr9WY7Hxeb
 V5sCFXZJP5qM6LlrmwMQZms22P3Tah+gUJmmLsuslXj+UM8Vs65OdTrUOm+jC0zi6LuJCoIq5J
 TQLNJtMWD8DBsdFW99gc+d8rBLFLJhcILcy7HKIO1ct6BDmSFnnzK9/V9FXX0R3j6AdgnhmIOv
 MOxjJtQxgJt/dCkuF2QhZpgUy7R6ID/Fejvg47bvV1JKQljjY5hO54BK4RCzXLry3SxTKtSR3E
 p7EJfzl81n8qfPrhoNKYpTip
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:11:14 -0700
IronPort-SDR: byUOpeUcEZ9L3Y5cFIDTC2CP5LlWHjJaY4ff6mgwRlykNpuWi40O1ZpCLRygShArjvHnt8s9GG
 QcLLNv6yy9ADYOI+7MfzAFSDucigHfmtzZGddRLxbxU6rtnew/eAkkPyBgqud8HnzWltmOfGYg
 GYCduQKwXft9A3jksr2wdk9QlbYkrKJsgJgDxakn0/d0yeeUI3IvPjBBKcZECAxVlF1VfQky9e
 FEPMGHK1rAJG1N8Q3OyxvAt+6e/cd3In6+R2PVZWKVmF51jC3hCcY+qjB4TjHuoUgx2KNEpU/m
 gzU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Oct 2022 02:57:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MzHz45bmpz1RWy3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Oct 2022 02:57:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666951055; x=1669543056; bh=JydiMbJm91qt7Dzdbz
        qgf9FuIhgVG9u78TP21lC8mbE=; b=j4RPkeDxD2OMqX5Kxa/3L32kWsZVpnmHr6
        BX+yIlhNHMvGj8A/k3T1hWRpUdDmrQWD7bum2uaSPmy7PgQtfwWQh9jsrpx9aLai
        twJ3Qb4KRS3qMqAY5VyHySyh/tP8wknTEYHCs061Qq7tKyih2RzCagzYSo+nsAQH
        dvvF8wU4J247DKqVq+cPiysOHuqw5sByri8/ct5ZjmjXPD6smYx/xm7TL4i5AZvh
        i539ZC1YkSepuErIJctkmpHBUR4i5HAeJgJKBBDQ/doWP8SbVzFX+EErBI3DA9hF
        vGgkNwGT29RTkowIHP/Zy/Wu4zNaPL+MlyFdv2ud1IqiEU2U1i/g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8P_VW2ui3p4v for <linux-perf-users@vger.kernel.org>;
        Fri, 28 Oct 2022 02:57:35 -0700 (PDT)
Received: from toolbox.alistair23.me (unknown [10.225.167.50])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MzHyy43gyz1RvLy;
        Fri, 28 Oct 2022 02:57:30 -0700 (PDT)
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
Subject: [PATCH 6/6] selftests: futex: Use futex_waitv helper function
Date:   Fri, 28 Oct 2022 19:56:32 +1000
Message-Id: <20221028095632.1081262-7-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
References: <20221028095632.1081262-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Use the publically exposed __kernel_futex_syscall_waitv() helper
function for the futex_waitv tests.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20211209235857.423773-6-alistair.francis@opensource.wdc.com>
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
2.37.3

