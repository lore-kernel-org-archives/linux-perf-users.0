Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=125.209.209.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793505850;
	b=FiGWo8esolrSXJLx3the8CJYT6HvEvx4PCuX1C5wQrozv9AIG4D1qUuhLx8jPOE248VL
	 w7nXZvpqEZ2fi3CQs311Cf/UATNiX02gtSvSmN1VXoEdYMNQApTjFxyGOOrpiL21Z7sRr
	 znC5r71o0CLPbdvR1fBmbozpZipN9b3mznpqTdivMyn9MKCiYklRjSBKcTun+AE5Majfx
	 IcfX/uSCTFobaqQQvpWw9vyuew+H3RwzfVO4eN7y2frcFAZ7iF3FYTvrVAKLUZlU19UYA
	 5hlVbXOoJLxXK5x3EwYrs16sJ6GzHG85dgmKvOkndCZ+bpm4Ou9gNRZ8FpFhaWOZ98Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793505850;
	h=DMARC-Filter:DKIM-Signature:X-Originating-IP:Received:DKIM-Signature:
	 X-Session-ID:X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Isw7AFKbpr1vS9bnVMSvJU1ZABdHzaOBNO8ANA0dyJ0=;
	b=AADfRraVEITdBqY8/2+fuGYWBUSD8dLpNNKtcjb/L3CsgvPRCQ7B4Yp9M942Q9LjxWLM
	 mxfmFIvZ98pN8FupgzroNjgYQ7V5rE7R01/eVs2RkfNVUQZYGB33dMBxgWO/BOhTE5jBW
	 leahpYVuoyqa+E6/1wDGnL4X38Sui2Mf2/CEw620T1Z31pJRgo/lDa1rRSrNqN4eNDNN+
	 gIFIEMjlT9ml3ri7y2siO5SXCz8/XCyxl6x+edkbr6ezzlheSC9ulcVyrD/xEJ2i8MUnc
	 p0eJB8q4OAPHie7iuX3CRBLRe4XXcq1m9FHZfbxGviDITWulZLmaRQsGIq9LnOD0vKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=korea.ac.kr;
	spf=pass smtp.mailfrom=korea.ac.kr;
	dkim=pass header.d=worksmobile.com header.i=@worksmobile.com header.a=rsa-sha256 header.s=s20171120 header.b=IlkLD8Zw;
	dkim=pass header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=naverworks header.b=WYgATIm0;
	arc=none smtp.remote-ip=125.209.209.50
Received: from cvsmtppost101.wmail.worksmobile.com (cvsmtppost101.wmail.worksmobile.com [125.209.209.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3921606A325
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Nov 2026 04:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3921606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=worksmobile.com header.i=@worksmobile.com header.a=rsa-sha256 header.s=s20171120 header.b=IlkLD8Zw;
	dkim=pass (1024-bit key, unprotected) header.d=korea.ac.kr header.i=@korea.ac.kr header.a=rsa-sha256 header.s=naverworks header.b=WYgATIm0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=worksmobile.com;
	s=s20171120; t=1793505838;
	bh=k+1cQ1vA7dP1jD2LtfF/Ct1StYGYJbgURgmAl9S1CZ8=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=IlkLD8Zw6IYMzTLIiNaLXu3fwOVoB+mvy+wkVDNVRKeQWS6Hvan8FM3tuuUh53Cuj
	 tn1XExdFDKpXFj+PESqr08j6DPhLSjVvhz7oZfMZ/qybhUDC2VAUysr57RrOPYnjy1
	 sd/iJed3Sm44allZK8ADxkE91cvwLGF82TJo1MfOQdkNkmP0rgTZWi9U3yRGZlR5kK
	 7PKit3s+zpxIDfzm6u2GcmhiIP9iDvp5iozfD+8lAAhxnhTI5uFEJh8UPzHJ+CKz+r
	 8V3jaZNPrzusDYw5cO0QK2ELkxzaXgslPOqTcvf/VwVr8XZT7f4NOeOvrw7POxygZ4
	 Biqg9eBfW/mjg==
Received: from kr1-hmac-real-5 ([10.174.201.129])
  by cvsmtppost101.wmail.worksmobile.com with ESMTP id TZ04GnF6SqqFEjhseF1Dfw
  for <linux-perf-users@vger.kernel.org>;
  Sun, 01 Nov 2026 04:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=korea.ac.kr;
	s=naverworks; t=1793505838;
	bh=k+1cQ1vA7dP1jD2LtfF/Ct1StYGYJbgURgmAl9S1CZ8=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=WYgATIm09rRquhyTm9hF6Q4gTBLAMIcZk/Wh6OVNB7xJcPjXIkA//2lp9v4W89uZc
	 pt5pajOn5xNsJ4nBa5Rh7ftXGxsgxphh9sRZaOUIW0Bhtxe4u/glBjWnteMhxQEsCN
	 RclNLskvgQ09YGcNfhy6UDpkrNjbBzY7cBy21m8Q=
X-Session-ID: -k+1eZqjSUOmthJOS0h6wg
X-Works-Send-Opt: 5/Y/KqgmKAKmKAFYFqMXKAK/FqMXjAumKAgmKxEmFxudKoMqKNmwjAuXjAuXFxMXaAErKqpYjHmm
X-Works-Smtp-Source: fqbXFAKlFqJZ+HmXKqtq+6E=
Received: from s2lab05.. ([163.152.163.130])
  by cvnsmtp101.wmail.worksmobile.com with ESMTP id -k+1eZqjSUOmthJOS0h6wg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sun, 01 Nov 2026 04:03:57 -0000
From: Ingyu Jang <ingyujang25@korea.ac.kr>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingyu Jang <ingyujang25@korea.ac.kr>
Subject: [PATCH] perf/x86/amd/core: Make amd_core_pmu_init() return void
Date: Sun,  1 Nov 2026 13:03:56 +0900
Message-Id: <20261101040356.3204097-1-ingyujang25@korea.ac.kr>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_core_pmu_init() has always returned 0 since commit 471af006a747
("perf/x86/amd: Constrain Large Increment per Cycle events") removed
its -ENODEV path for unknown CPU families, so the error check in
amd_pmu_init() never triggers.

Change the function's return type to void and remove the dead check.

Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
---
 arch/x86/events/amd/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce5664..c72e745b2591d 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1412,7 +1412,7 @@ static const struct attribute_group *amd_attr_update[] = {
 	NULL,
 };
 
-static int __init amd_core_pmu_init(void)
+static void __init amd_core_pmu_init(void)
 {
 	union cpuid_0x80000022_ebx ebx;
 	u64 even_ctr_mask = 0ULL;
@@ -1422,7 +1422,7 @@ static int __init amd_core_pmu_init(void)
 	perf_nmi_window = msecs_to_jiffies(100);
 
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
-		return 0;
+		return;
 
 	/*
 	 * If core performance counter extensions exists, we must use
@@ -1523,22 +1523,17 @@ static int __init amd_core_pmu_init(void)
 	x86_pmu.attr_update = amd_attr_update;
 
 	pr_cont("core perfctr, ");
-	return 0;
 }
 
 __init int amd_pmu_init(void)
 {
-	int ret;
-
 	/* Performance-monitoring supported from K7 and later: */
 	if (boot_cpu_data.x86 < 6)
 		return -ENODEV;
 
 	x86_pmu = amd_pmu;
 
-	ret = amd_core_pmu_init();
-	if (ret)
-		return ret;
+	amd_core_pmu_init();
 
 	if (num_possible_cpus() == 1) {
 		/*
-- 
2.34.1

