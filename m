Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F30E3ACA64
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775641419; cv=none; b=XoFtBj9U61BXkRP1zH6LpZrk4EHoIhOTWE/8Se6/SPtJjMVA6m0Qif+aFFrpBtgJnfiyjxVqyROtMbppoC8UVnuKxDYZRv8ugw48CXwakAwGDIibjctObCxAbC/zsjEnKOuhfl/27EVPmeVnPLp/n/wJBf8X8oMpdmYOIAeJY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775641419; c=relaxed/simple;
	bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aewx43M2w4cyItUO5Sncvq7P2354B4L9hx6hn0kSKCg1VjXV7PkbtWz4PBpyr5bE7OIWkVh/pbO8di6Ky7LR1Jm4BUa6kxOTPdxK5i2Q414ybyer972rJmwjCnIAi/XiAAseMBnA4ToUmmpi/r45yKn9vMAOXeO5P3epqcz+oys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f/2KpYMH; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f/2KpYMH"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C76DF3549;
	Wed,  8 Apr 2026 02:43:29 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F1053F641;
	Wed,  8 Apr 2026 02:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775641415; bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f/2KpYMHPLtzR73A1s06GOf1gVP/LZnSAcN8oQPJIhZ3JTAkFcNoaMzDChCXW6GZT
	 foVfu9zCDGNjbuke1fdDEI9kZG5P78vbQuMIoR1kB02ESY5rFa3yB0ShsQ9Qqlmahy
	 gGpx6P66NnaQTjOwROmCfJgXQltx7fXWSgXY3Vsc=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 08 Apr 2026 10:42:33 +0100
Subject: [PATCH v5 3/4] perf report: Update document for SIMD flags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260408-perf_support_arm_spev1-3-v5-3-b5bcea6217bb@arm.com>
References: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
In-Reply-To: <20260408-perf_support_arm_spev1-3-v5-0-b5bcea6217bb@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775641408; l=1398;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cOjsCfTIlqHDLksAzetJn1AEXlTBDB/YvI4KzpW9jBk=;
 b=brLZgWmpUQvomqATFNOk4OGKkkmVelJqZUQqI5i8ZIKx+LQ4eqZkIHb60vniheyxXzuUxJdj6
 tTgJA+p+cyhCeEpVAGs3vxh0IRpGdbjvYxLw95PV0lKM+dOTyzUu5hQ
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

