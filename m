Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBAC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Nov 2021 06:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358875AbhKZGIW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:08:22 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5940 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhKZGGV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Nov 2021 01:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637906589; x=1669442589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zqk+jHl+OGQOsKByrp4sFB5aR55ftrVPzVlhJ9AS07c=;
  b=oRaxVs9wcs99hBYHE1WYcgI2+hEckLeoQgBIp9WasbGuoAfHEFpL3Bk8
   gX4k4a8jk5SuiiuxBtU5cewHgzStNyfQM4iUCOC02MTD3lQgHSDA2t5Z7
   ecVv8iK0FLkLpbO+c/D+dwB3BwGYDA+xgdTXWzzxXifkclKnjICbz2sfn
   bE/RI+DoRPtE+ZyQE1/vd1246qDmORimAC5GkaUk59lNhBoAhw+ej6k08
   Qpih8rx4j8ulap2aMuadH26jhTwp97+7cZggqwO1XdDZy0tqfqtNW+FvK
   2bL17LABhRPNRFWzJzHikYWVK7EgBcfyPTziQ3npd5EuGQYVUc++9mUU9
   A==;
X-IronPort-AV: E=Sophos;i="5.87,263,1631548800"; 
   d="scan'208";a="290649457"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 14:01:09 +0800
IronPort-SDR: iWERrJIK7G9Q6C+B1xsqQOB0YQX8w+lUgQP/aiccvmzVEdgntjkB0IjGntxR35T4kb31Zcnvwi
 B+5GFVVaJ981/0u/OzoIkmpcrLizVtnsV/RHb10EQmp1/ik7BGKkKENLm35mMh7wqqnWYHRg+A
 tzmQLA1xlMWRvlLvUgeYU1ARIn9KBjVo9xKK9cVXqKM4CDq+Nm2wj6y2Gv0DphLGE0pOS54Gg5
 prozUYVIjTjTyqEizMTgULf0YWxrbALsNnbYcURbTUkT+78V4sKw389hBDp4dwGX0MeaIPwUP0
 DvXeCMRMAcjSPlilLHt6jHJo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 21:34:27 -0800
IronPort-SDR: LMXh3oK19lhXHSoNdNG3sBHyYn7A8v3HN2wTMairuwddXroq6asz1rO+DyFnRAFAj8xnZMeyPY
 C2yZXOLoUmmdnbrRc5K2aowlXBLOJ5i0r5tjma65uUGy7jdvd9r3m3OCuDYiP/H0exGnZeJtie
 WLGvUzplVe+bT3kGsUALUQCV9GAl71+PStWzI1UwQgV4aCCPwVpydHhoeYUNPEgLEUK79m8vIw
 P92OKVre3rwgAiOSHkp8VOa7mzVtI427tQXRctJmtw1QB/zxLr1dpcNP6AhT5BOn47eqzTu/sJ
 i5g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 22:01:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J0kdJ2kMbz1RtVw
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Nov 2021 22:01:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1637906467; x=1640498468; bh=zqk+jHl+OGQOsKByrp
        4sFB5aR55ftrVPzVlhJ9AS07c=; b=EL73Ac6N55b0h61bCYruLeyW3KTlUIY6pc
        FxhNSErfXXALeHReJ2ux5HJkdy4UPPxapugnfDRBANXj2jysUMCJRnneMw6cxjg1
        WGUKEKFyoW5G2FaMcWIxAaAbJcD5ZjNWx/Qi++E+vZkwBr3X9e4W8i18N3SUsS82
        7ECNu8nnbuNkqgUmp0utissFKgavJBHMNcCf4fhED5COe+ICGP408nKOHh93XteQ
        ns/kFv9TTxX4wDr8S9Dfw+Pb4GoEWNuCXvXzfc4YhaZnL8K6wHW6YbVTIoc6umD9
        N44mRK3OZy0sCdcDZ24L7AGk8fvsvQGoBTH4cUdhb40da0ggUUXg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fk4s9ytrfqXN for <linux-perf-users@vger.kernel.org>;
        Thu, 25 Nov 2021 22:01:07 -0800 (PST)
Received: from toolbox.wdc.com (unknown [10.225.165.62])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J0kd74xYPz1RtVm;
        Thu, 25 Nov 2021 22:00:59 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, arnd@arndb.de, namhyung@kernel.org,
        peterz@infradead.org, alistair23@gmail.com, jolsa@redhat.com,
        dave@stgolabs.net, mingo@redhat.com, dvhart@infradead.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 4/6] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 26 Nov 2021 16:00:22 +1000
Message-Id: <20211126060024.3290177-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Using the new __kernel_futex_syscall*() functions let's add support for
32-bit systems with a 64-bit time_t. We can just direclty call the
publically exposed __kernel_futex_syscall_timeout() and
__kernel_futex_syscall_nr_requeue() functions to do this.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 tools/testing/selftests/futex/include/futextest.h           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7..d3673996fed4 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index c786fffecb8a..1686f94667b1 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/futex_syscall.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +70,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+	return __kernel_futex_syscall_timeout(uaddr, op | opflags, val, timeout=
, uaddr2, val3);
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+	return __kernel_futex_syscall_nr_requeue(uaddr, op | opflags, val, nr_r=
equeue, uaddr2, val3);
 }
=20
 /**
--=20
2.31.1

