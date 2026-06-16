Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B14508E9;
	Tue, 16 Jun 2026 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625460; cv=none; b=mtaiAjCsjPwRgEg2FmNZ4us1QK1vVYwqVWMLfx7CU3yJ229thjwRP1rWsLiaVUFtNZe6MYcWzpuxmOHXUXYdyrRfMIOLGGqTG/6o11egXBcGdIc9Wooy/25H21V0awupvw1qKTS945MpdXPclIof3/NlhTaqdx4795QPBjKk1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625460; c=relaxed/simple;
	bh=/t22Ufo1TWQl+8eUGdEHLy9GAgphqs2agBvYPBixQ68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNFWYc68dSnmXmHorAdmQSoLCxiZViolP4gGrdFQaVWyl+V0+UcNDymQzKKhUk5NW2f8yDE4w2lvO93smjDpfTPAG/+WIuT9BCwFpqejmq8PsN4rTgrM4hG9R56JtVfy9B8wa/0LlTVLjpzZinqwSrW/UrWgylgJVPIsdIvxNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3MFfWnb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3MFfWnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2B81F00A3A;
	Tue, 16 Jun 2026 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625458;
	bh=+VVoEj6gKLm6QpDzoKPZEs8KuFBJW/1u5UDllJ4ILPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3MFfWnbbjmGUc3L793M2E9oL6Z2upxdxulI4iWXaWHZu6RksYYoKjmGSp+2GqfSy
	 cgFTdz9frDYcnMdcAtgpWTvoBl0VQGnLnXhIsNC3lJo4hgByeJe7UMBCqtI2/aA5O7
	 x51vWyjKqZthh0Oz6+ar5ipR5H0vXOr53neW+RVSU0MvfWJKSxhXzODdJHIj5yLI7o
	 ZxyVRLzixfwVnB8PZZevUGQ4L7xo/1tyBESPqKSrznvTVnH/rgfIXUs3t/6XngyqW8
	 IjhV5pqJcZ964PznEce84RdsNKWtl+4VQMfb8vQPsURaApZMx4ietWNOIk/1XgMQ9o
	 0wdLO3Ihu/qog==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v5 2/4] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
Date: Tue, 16 Jun 2026 08:57:07 -0700
Message-ID: <20260616155716.2631508-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616155716.2631508-1-puranjay@kernel.org>
References: <20260616155716.2631508-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_clear_branch_entry_bitfields() resets the bitfields of struct
perf_branch_entry one at a time and deliberately leaves from/to alone,
since callers overwrite those immediately. The list of assignments has to
be kept in sync with the struct by hand, and it has already drifted:
new_type and priv were added to perf_branch_entry but never cleared here,
so stale values can leak into the records handed to userspace.

Clear the entry with a single struct assignment instead:

	*br = (struct perf_branch_entry){ };

Every caller writes from/to right after the clear, so zeroing them as well
is harmless and the dead stores are elided on the x86 LBR read paths.
There is no longer anything to keep in sync when a field is added.

The helper no longer touches only the bitfields, so rename it to
perf_clear_branch_entry() and update the callers, fixing up the
br+nr/br+out spacing on the touched lines while at it.

Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
Suggested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/events/amd/brs.c   |  2 +-
 arch/x86/events/amd/lbr.c   |  2 +-
 arch/x86/events/intel/lbr.c |  6 +++---
 drivers/perf/arm_brbe.c     |  2 +-
 include/linux/perf_event.h  | 16 ++--------------
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5..68c5f42965e9 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -343,7 +343,7 @@ void amd_brs_drain(void)
 
 		rdmsrq(brs_from(brs_idx), from);
 
-		perf_clear_branch_entry_bitfields(br+nr);
+		perf_clear_branch_entry(br + nr);
 
 		br[nr].from = from;
 		br[nr].to   = to;
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index d24da377df77..08401fd60585 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -181,7 +181,7 @@ void amd_pmu_lbr_read(void)
 		    entry.to.split.reserved)
 			continue;
 
-		perf_clear_branch_entry_bitfields(br + out);
+		perf_clear_branch_entry(br + out);
 
 		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
 		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 72f2adcda7c6..295da179fa74 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -755,7 +755,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		perf_clear_branch_entry_bitfields(br);
+		perf_clear_branch_entry(br);
 
 		br->from	= msr_lastbranch.from;
 		br->to		= msr_lastbranch.to;
@@ -846,7 +846,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		perf_clear_branch_entry_bitfields(br+out);
+		perf_clear_branch_entry(br + out);
 		br[out].from	 = from;
 		br[out].to	 = to;
 		br[out].mispred	 = mis;
@@ -920,7 +920,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
-		perf_clear_branch_entry_bitfields(e);
+		perf_clear_branch_entry(e);
 
 		e->from		= from;
 		e->to		= to;
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c..effbdeacfcbb 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -604,7 +604,7 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 		return false;
 
 	brbinf = bregs.brbinf;
-	perf_clear_branch_entry_bitfields(entry);
+	perf_clear_branch_entry(entry);
 	if (brbe_record_is_complete(brbinf)) {
 		entry->from = bregs.brbsrc;
 		entry->to = bregs.brbtgt;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..e034be4a473a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1467,21 +1467,9 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
 	return size;
 }
 
-/*
- * Clear all bitfields in the perf_branch_entry.
- * The to and from fields are not cleared because they are
- * systematically modified by caller.
- */
-static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
+static inline void perf_clear_branch_entry(struct perf_branch_entry *br)
 {
-	br->mispred	= 0;
-	br->predicted	= 0;
-	br->in_tx	= 0;
-	br->abort	= 0;
-	br->cycles	= 0;
-	br->type	= 0;
-	br->spec	= PERF_BR_SPEC_NA;
-	br->reserved	= 0;
+	*br = (struct perf_branch_entry){ };
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
-- 
2.53.0-Meta

