Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1C8F7D;
	Tue, 24 Dec 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052254; cv=none; b=AU5pp5PhBO8GcLvni1JVI3X387KPWeKqUqLY5duMlvgEPvOUx6nQYCtMCIPP3yusXliSae1Ze2hPZ42g3EnqQXSvIALFlyB7DKjd719+Etz+T7xbwJReqpSAhLBzNF9LMcKD6oeswspQXs85o8zPQyOi5yWf14/ZDXHvdk97bOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052254; c=relaxed/simple;
	bh=FkMQxKV9JGGtY6sYeWg7qH3BnBg/+h/taXfaX6eHL9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDWG4Hdszt+hoJNXxQZ3IuccSAjsr4KlRSGecl1Y6J9EnWV++t36rTQZIig1nwt9Qx1EyblfAhIjtNXAzSxRU/cpCwyCH640ieThD4TqWTOCRIgB9O8GjyEUgU+9ifr3xql+MHFzuSnOj2M5X9dGwAIVUgyg+QitVK+LFszi4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ixu1C7Of; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ixu1C7Of"
Received: from localhost.localdomain (unknown [103.155.100.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2F70D3F778;
	Tue, 24 Dec 2024 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1735052243;
	bh=vVmYMnHqiVo79hj/Xiz0+x8NC6KQ+SI8zlz0LEH1RWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ixu1C7OflFgyCruWQwbDFUNnGl9/8Fgt7jLHxXwv34U1+qdMolRhLvXgq663jqOjH
	 xLmCUiaeZhN3cCRvKqcvSfn8QpU+/17T+aVGps/JD0F52O+SYbAWcYb8RQovMQKhOn
	 r79Nv1PTnn5Pk2OkxbZ6l0CkfeoTmelnSRt0uJbO2s75UDfEpCSXKhrQ1z+ErbYx7d
	 suOsLTJrewP9bh/DUCZMgSdes8uYM6qJQ1a+DuZ4bmGi8CjswUs16LYzx+NYK+gZQH
	 vUa5mqX5LefY4W0neHGKMsQ5vcGGJ8kgm3fn5sUSzjstD+qOfMoAziQRjKEll0eCcH
	 ZrJX8X9ahcyBQ==
From: Aaron Ma <aaron.ma@canonical.com>
To: peterz@infradead.org,
	rui.zhang@intel.com
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kan.liang@linux.intel.com,
	alexander.shishkin@linux.intel.com,
	mark.rutland@arm.com,
	namhyung@kernel.org,
	acme@kernel.org
Subject: [PATCH] perf/x86/rapl: Add support for Intel Arrow Lake U
Date: Tue, 24 Dec 2024 22:55:16 +0800
Message-ID: <20241224145516.349028-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Arrow Lake U model for RAPL.

  $ ls -1 /sys/devices/power/events/
energy-cores
energy-cores.scale
energy-cores.unit
energy-gpu
energy-gpu.scale
energy-gpu.unit
energy-pkg
energy-pkg.scale
energy-pkg.unit
energy-psys
energy-psys.scale
energy-psys.unit

The same output as ArrowLake.
  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index a8defc813c369..7e493963d0576 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -796,6 +796,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&model_skl),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
 	{},
 };
-- 
2.43.0

