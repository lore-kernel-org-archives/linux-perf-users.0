Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A5455616;
	Wed, 30 Sep 2026 20:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799407; cv=none; b=dQQMdx+dy9En+gyDzPb7kSmQvOvt+CXxwt9hDx8Ocf0zuMye3/t5ISO3BP+bBps5PrAWV+74ge1O/rlFPnh5YulO1J/+eYTxYVCWr78VsYX2/5uLTbM5mnMQ3uNLnTDIWXrAJyt/vpLuHsM/8u1aVwGMAM25lUD2Bf9HQ/y5x30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799407; c=relaxed/simple;
	bh=YHhbmkGcjt0XJGtNB+k9UXRyMSzALCrYIS1gHah/Tc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wmyg4z3FsfFyu0OMudIpgB+O1hc+HuzCIbNKSqQwV615HM2uqfeoBMLqIBdXI8y1zCD6E5l0KlmHR1cOSnsnnXHgDUAhc4TIrUjI6lkPyG/OXPK/VJm4gD+aYYUbC07Z+wKKyczni2ZdrNuDHRjwRdm5psW936KDGtTHgdwjhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUhZ/SW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUhZ/SW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3361F000FF;
	Wed, 30 Sep 2026 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799406;
	bh=r2+T9QlYhb8V1vGFMQT48Ttio8lY1V7v5DeS74DqK7c=;
	h=From:To:Cc:Subject:Date;
	b=MUhZ/SW+wdxXKaINdpCiT7FPhkzLOP1L3JZ0x1CpB0QxRwpmRK82hw1oV9kQisCAI
	 MwMnd2EbxKNZl5JomSbulKaXlOgoVOBTgeaVY0l/+u0uRd/hi4OpW3QBnJrIJgHi1L
	 RrC/5p1MNMBTxUU251tG0cVgKTVfrJq5zNYTTq3J4d+xkHDbXfdMcVK9TSYDI4+Yvo
	 s5fAipodWoxX8WcWhy+0Q95bUJkH9dbwx/GrNVWkira1yERqk7VyQAB/viXhvceoSh
	 dGljzTBraD5AaCLhPmQcu+Zr3I7JWHzzQ4HqoxPBoX2PXHan7o3r4VprrUmP7jXYxH
	 jGaEIhEtLfj7g==
From: Thorsten Blum <blum@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
Date: Wed, 30 Sep 2026 22:16:18 +0200
Message-ID: <20260930201617.111270-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=blum@kernel.org; h=from:subject; bh=YHhbmkGcjt0XJGtNB+k9UXRyMSzALCrYIS1gHah/Tc4=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl78wR3Kl1Mnyijc8rs3OMb8/wDXr/ZfHQxI8tt221Wu Z7P9M3MOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiYuyMDMcCov1qar6Jsofd Vvxxt0xXRKr66HzfKs/KEN0kKc9HzAz/tE8L3fr3OuU5w9uHdxyakizuMHaF9pWFimrbGmq55wZ xAAA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred for formatting sysfs output because it provides safer
bounds checking.

Add a terminating newline as suggested by checkpatch.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thorsten Blum <blum@kernel.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
Changes in v2:
- Add a terminating newline as suggested by checkpatch
- v1: https://lore.kernel.org/r/20260206194254.36105-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b2109b37ea7f..b35a779e9b17 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -153,7 +154,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s\n", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
