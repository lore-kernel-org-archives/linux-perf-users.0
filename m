Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08733BBCF
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775806634; cv=none; b=ZOragy6D9hbTeITgYp71wuyyRSxUPEMSdWZ1L7Xw2UWjtNqJ1mzsY5MxgnN6z79dEKrzwfoP//aZFT/toi9cpE3ccwDuYwYXsUPBy2VFVII1j/7buBpMrPie2h5MicwQTQSd9i+G8r8hfF/ZiNEImLM4AQs+ur50+Ln+QJqNbCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775806634; c=relaxed/simple;
	bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGaZCAXzRITNQCBd2wFNmTbLGA2EIGjHR/zAU9R69PNV4ZUn42pANxplshJ/JMQ/XSzF9RGfSkuGpp48pW0UjbOUBAhGScUAWGk0u82NTtMes6K+L/RneZsbew8E+UKIKHhnL5AGArSK6ypKMu8OixbDKhwTfbXSk+4ARKqbVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SU8JzM1K; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SU8JzM1K"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABBAD2008;
	Fri, 10 Apr 2026 00:37:06 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E21743FAF5;
	Fri, 10 Apr 2026 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775806632; bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SU8JzM1KuaKW28CDLX3pbekN3ZRdRb+ZqSzUZzdAmQVmRwNBQ5NVEqQSe4I/Icdfx
	 JOYWTAECwIOJsjmbUy+ur/pNBiMKLcvwSpEORxjz3Ime6SPl598LljG0OH5TlhBi3V
	 S/6D0geiEjiDv9qZicuik4c0hjAyMfZeWXBByXaA=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 10 Apr 2026 08:37:00 +0100
Subject: [PATCH v6 3/4] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-perf_support_arm_spev1-3-v6-3-3c6f2dfe2cd3@arm.com>
References: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
In-Reply-To: <20260410-perf_support_arm_spev1-3-v6-0-3c6f2dfe2cd3@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775806625; l=1398;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
 b=EyBDyzU2HoPN2Cq+viFTjtt2uQ9zvOK4C+W0J+zduJwZ6pAEQqTOKpFrz7VzOu2AkegMAvYXe
 WuCmgNGYdR4BEZWpd9lfI3cCPgs4V+1zrULYcnlmxL31OKsa/pUoPCJ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Update SIMD architecture and predicate flags.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/perf-report.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 52f316628e43ac9851ecaa85f706e22c26294649..22f87eaa3279653836eaaa07a358c14f2e0afa75 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -136,7 +136,10 @@ OPTIONS
 	- addr: (Full) virtual address of the sampled instruction
 	- retire_lat: On X86, this reports pipeline stall of this instruction compared
 	  to the previous instruction in cycles. And currently supported only on X86
-	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
+	- simd: Flags describing a SIMD operation. The architecture type can be Arm's
+	  ASE (Advanced SIMD extension), SVE, SME. It provides an extra tag for
+	  predicate: "e" for empty predicate, "p" for partial predicate, "d" for
+	  predicate disabled, and "f" for full predicate.
 	- type: Data type of sample memory access.
 	- typeoff: Offset in the data type of sample memory access.
 	- symoff: Offset in the symbol.

-- 
2.34.1

