Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AF39A80E
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701102; cv=none; b=Wu1Tdx+5VU/9UF22wdAcMwNba4Td4Jx/CCVayP12+muTXt9sy5JCZ5PCL3qCTrIZ82bIP7zAVKSV1R5ELqlgalMuwG5RtwOvRhO6LZgKe4cQ7WsqyJQSvA6T+FV81UnOAdKIjHRjNlzWLNWGYzOHesxqnQKN8b42nGLahjZuuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701102; c=relaxed/simple;
	bh=V02sakPukpSZGzMyKfhyDXi17gYfpEoQjUbGir9AWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KGDtz1YiAOWHZ1Rdg/fiBSHbqvUFUsHu2YSdksY5cFbrUf2PNHgWdlYhuUMDmRcS29DRJuLBDKr5SuL3H6RI9AtCWJsWluX5bHsVIYXIhtSH+QQkoopFmRabCi78UNkQobI/jZ3RcTLmoWvTj6eQEi0LqIaTIaIfjhDzEUCnVII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahvSs0Co; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahvSs0Co"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779701098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oZRzOesaTWAp0x7FPwLyvcL6uegKl8tfVJmsD5Lkv38=;
	b=ahvSs0CoubSeIX9hoXlJHmCN6Qg3Hyg1dQ3V85dqTUlC07r25mJFKkrhAQgbCDQHlDFi2B
	cJ1SJWNn6pb9DkE+y1hgJLutuhEFPYi+8kEttuwHeMeSDYnzx0y2NSbTbfCE06zT7RBZbC
	gDdFCdSSUlKsOeXPn1iqKKbw3bpXXZQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
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
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
Date: Mon, 25 May 2026 11:24:41 +0200
Message-ID: <20260525092440.818322-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1315; i=thorsten.blum@linux.dev; h=from:subject; bh=V02sakPukpSZGzMyKfhyDXi17gYfpEoQjUbGir9AWFI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkiohH+W8p+MWvNULsbo3ZA9937ZSGrn2+UN8rvyvPW/ 5NhHr63o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYiO42R4c85K8uejovJcxVK FJm+Xb3Y+k/h0/VZH2NC791K+u56ZAEjwzGV1au6JIOvpe7NX+Lje1/4iJLQhaLlV14dNH78sPj lfTYA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred for formatting sysfs output because it provides safer
bounds checking.

Add a terminating newline as suggested by checkpatch.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Add a terminating newline as suggested by checkpatch
- Link to v1: https://lore.kernel.org/lkml/20260206194254.36105-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e9cc1ba921c5..befc03152b90 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -134,7 +135,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s\n", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
