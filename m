Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA03546F5;
	Wed, 12 Nov 2025 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971938; cv=none; b=FEd9yhLsl4Tc8f1G82GbqG9HvFDYRTEP8NnyxqeYdAiTJ16U5U0JGtZuGEdJ5O/FpD8S1IRub+6/dI3QDiBAOg9Pdm02H5b3BHGrUme14BrczCgA9y15DzByUrHAuYs13rjsAi0iv60GJWdYozJdf3Hhd9thfsID2ly4Nf/uZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971938; c=relaxed/simple;
	bh=A7ojri2MUqobrd+TLOmz8lLFTBFq9buLIlAc/yoYVBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oTMLoxplY2AECRZUXUHH6zLtDmmDGbaVHk1zSc/51f4hANBZu8i3DkqCl8mAIvUyj6eVVn7n94+mquGiKarGIAMA+Slt9xZATGI8uQOqXxqiUKuSj8Tbo3tXDe22JWAJ3vQvtK0nq24Uts9ndIECMUdUOU9mOXhw8GUCtm7HVuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33651515;
	Wed, 12 Nov 2025 10:25:28 -0800 (PST)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 900473F63F;
	Wed, 12 Nov 2025 10:25:34 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 12 Nov 2025 18:24:46 +0000
Subject: [PATCH v3 20/25] perf mem: Print extended fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-perf_support_arm_spev1-3-v3-20-e63c9829f9d9@arm.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
In-Reply-To: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762971891; l=3651;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=A7ojri2MUqobrd+TLOmz8lLFTBFq9buLIlAc/yoYVBg=;
 b=+CIICRF0kKKwCbqZzzjolMZ58mP7afNb0PCC3SrH5HJHj7vYONLtzPMQwZGjLst13tWe5/Rnj
 2vu7+yE0UBTBwRVBtGFXz3igdofry4nf289S/tU7TEPtSIotxwyhZg1
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Print the extended operation types and affiliate info.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/mem-events.c | 66 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 80b3069427bc4bb5ffc3ab0856c01c76d9ba3ba6..c0aee982fb4f1a849c28a8bb01693855922832f6 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -413,11 +413,15 @@ static const char * const mem_hops[] = {
 
 static int perf_mem__op_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
-	u64 op = PERF_MEM_LOCK_NA;
+	union perf_mem_data_src data_src;
+	u64 op = PERF_MEM_OP_NA, ext_op = 0;
 	int l;
 
-	if (mem_info)
-		op = mem_info__const_data_src(mem_info)->mem_op;
+	if (mem_info) {
+		data_src = *mem_info__const_data_src(mem_info);
+		op = data_src.mem_op;
+		ext_op = data_src.mem_op_ext;
+	}
 
 	if (op & PERF_MEM_OP_NA)
 		l = scnprintf(out, sz, "N/A");
@@ -432,6 +436,19 @@ static int perf_mem__op_scnprintf(char *out, size_t sz, const struct mem_info *m
 	else
 		l = scnprintf(out, sz, "No");
 
+	if (ext_op == PERF_MEM_EXT_OP_MTE_TAG)
+		l += scnprintf(out + l, sz - l, " MTE");
+	else if (ext_op == PERF_MEM_EXT_OP_NESTED_VIRT)
+		l += scnprintf(out + l, sz - l, " NV");
+	else if (ext_op == PERF_MEM_EXT_OP_MEMCPY)
+		l += scnprintf(out + l, sz - l, " MEMCPY");
+	else if (ext_op == PERF_MEM_EXT_OP_MEMSET)
+		l += scnprintf(out + l, sz - l, " MEMSET");
+	else if (ext_op == PERF_MEM_EXT_OP_SIMD)
+		l += scnprintf(out + l, sz - l, " SIMD");
+	else if (ext_op == PERF_MEM_EXT_OP_GCS)
+		l += scnprintf(out + l, sz - l, " GCS");
+
 	return l;
 }
 
@@ -582,9 +599,6 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	size_t l = 0;
 	u64 mask = PERF_MEM_BLK_NA;
 
-	sz -= 1; /* -1 for null termination */
-	out[0] = '\0';
-
 	if (mem_info)
 		mask = mem_info__const_data_src(mem_info)->mem_blk;
 
@@ -600,6 +614,44 @@ int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
 	return l;
 }
 
+static int perf_mem__aff_scnprintf(char *out, size_t sz,
+				   const struct mem_info *mem_info)
+{
+	union perf_mem_data_src data_src;
+	size_t l = 0;
+
+	sz -= 1; /* -1 for null termination */
+	out[0] = '\0';
+
+	if (!mem_info)
+		goto out;
+
+	data_src = *mem_info__const_data_src(mem_info);
+
+	if (data_src.mem_dp)
+		l += scnprintf(out + l, sz - l, " DP");
+	if (data_src.mem_fp)
+		l += scnprintf(out + l, sz - l, " FP");
+	if (data_src.mem_pred)
+		l += scnprintf(out + l, sz - l, " PRED");
+	if (data_src.mem_atomic)
+		l += scnprintf(out + l, sz - l, " ATOMIC");
+	if (data_src.mem_excl)
+		l += scnprintf(out + l, sz - l, " EX");
+	if (data_src.mem_ar)
+		l += scnprintf(out + l, sz - l, " AR");
+	if (data_src.mem_sg)
+		l += scnprintf(out + l, sz - l, " SG");
+	if (data_src.mem_cond)
+		l += scnprintf(out + l, sz - l, " COND");
+
+out:
+	if (!l)
+		l += scnprintf(out + l, sz - l, " N/A");
+
+	return l;
+}
+
 int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *mem_info)
 {
 	int i = 0;
@@ -616,6 +668,8 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, const struct mem_info *
 	i += perf_mem__lck_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|BLK ");
 	i += perf_mem__blk_scnprintf(out + i, sz - i, mem_info);
+	i += scnprintf(out + i, sz - i, "|AFF");
+	i += perf_mem__aff_scnprintf(out + i, sz - i, mem_info);
 
 	return i;
 }

-- 
2.34.1

