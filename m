Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE03E3159;
	Mon, 10 Aug 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368959; cv=none; b=PJ1NkRecZDorD82h3Pw478zyqIDvUVjY7V8Ngkt4hUn0hAGAyeej9sG9bzcIj27fc36zu6gqj3PjizUdH62m2xv5oy36TPF1XlP45t4vu2bbNJmKDghCXmO+/BPJJwuaBA8LG+Uid5l87PngCfe5izzg00FNYjFjmfbrWjhF/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368959; c=relaxed/simple;
	bh=O8IjTvx7ifftU2TvVuTVQDB1ccGcZuEgUJtDUCq73so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1UDoaHk+oAN1Om4FqgyIJk0rj6fQ3xTlEd+AM4mazoic85XMd/Y4dqC8vzFK6stz7Ji9ujJAUzxgvqOMV4fYqjRI+yAN/BiFnk+PoiWNPNkjjrNmgAbtG3fFXU4Grn8DtcWMto3l+R/takySpAtnsb5LPKHAWAe2e4bMCPp6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4vhV/b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4vhV/b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B2E1F000E9;
	Mon, 10 Aug 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786368957;
	bh=hFHU+itqilLFa2LW0TtwgKnJ6JyHbm/bvFBqWleVcaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4vhV/b0nCCPFZdxOdMKj8mLQsh5U7ab1MRrcw7L0WVBcQHZnHZz0nN4rFe7Ob8wh
	 rUfUn7rFK4T/fWbLJynD9pFEnSgUAjO+Cntd/9xkrRjG4UJu7zgI2Qi9flHLTP/Y4M
	 3mRATErduz+Tat/u/n1GLiphCpEACk89Jn8hmYFaNHcRq0Lo3D8ClL+MUWZG/PUvra
	 8sJbQVLBPat1wGl0tHbl53NdqYxEfnZQZRNrD0PIQUjcJKPR3XG3gLVXnoPk2SBnt6
	 98XGgONqvKeSdB2lRlo2rXS6SesDbsblbrblCaB8GFY1fzdH3QlereB3PBCbaSHD19
	 9qCXnfJekK6pw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] perf/core: Fill branch entries with a single assignment
Date: Mon, 10 Aug 2026 06:35:36 -0700
Message-ID: <20260810133540.1947118-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810133540.1947118-1-puranjay@kernel.org>
References: <20260810133540.1947118-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_clear_branch_entry_bitfields() clears the bitfields of struct
perf_branch_entry one by one and leaves from/to alone, since callers
overwrite those straight away. The list has to be kept in sync with the
struct by hand and has already fallen behind: new_type and priv were
added to perf_branch_entry and never added here.

Only BRBE writes those two, and neither for every record.
brbe_set_perf_entry_type() leaves new_type alone for a branch type it
does not recognise, and priv is not set for source-only records.
arm_pmuv3.c allocates the per-CPU branch stack with kmalloc(), so such a
record reaches userspace with whatever the slot held: uninitialised
kmalloc() data on the first pass over the buffer, the previous record's
values after that. Nothing under arch/x86/events/ writes either field,
so only arm64 is affected.

Assign the whole entry at each site instead. Everything not named is
then zero, and there is no list to keep in sync. The bitfields add up to
exactly 64 bits, so the struct has no padding to leave undefined.

perf_clear_branch_entry_bitfields() has no callers left, so remove it.
perf_entry_from_brbe_regset() assigns an empty literal instead, since it
fills from/to conditionally. PERF_BR_SPEC_NA is 0, so dropping the
explicit spec assignment changes nothing.

Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/events/amd/brs.c   |  9 +++--
 arch/x86/events/amd/lbr.c   | 16 ++++-----
 arch/x86/events/intel/lbr.c | 65 ++++++++++++++++++++-----------------
 drivers/perf/arm_brbe.c     |  2 +-
 include/linux/perf_event.h  | 17 ----------
 5 files changed, 48 insertions(+), 61 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index dc564688f3d73..54b13faba116c 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -343,11 +343,10 @@ void amd_brs_drain(void)
 		if (!amd_brs_match_plm(event, from, to))
 			continue;
 
-		perf_clear_branch_entry_bitfields(br+nr);
-
-		br[nr].from = from;
-		br[nr].to   = to;
-
+		br[nr] = (struct perf_branch_entry){
+			.from	= from,
+			.to	= to,
+		};
 		nr++;
 	}
 empty:
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 9d9c961989d51..a55646fcb8465 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -184,13 +184,6 @@ void amd_pmu_lbr_read(void)
 		    entry.to.split.reserved)
 			continue;
 
-		perf_clear_branch_entry_bitfields(br + out);
-
-		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
-		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
-		br[out].mispred	= entry.from.split.mispredict;
-		br[out].predicted = !br[out].mispred;
-
 		/*
 		 * Set branch speculation information using the status of
 		 * the valid and spec bits.
@@ -208,7 +201,14 @@ void amd_pmu_lbr_read(void)
 		 * speculative and took the correct path
 		 */
 		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
-		br[out].spec = lbr_spec_map[idx];
+
+		br[out] = (struct perf_branch_entry){
+			.from		= sign_ext_branch_ip(entry.from.split.ip),
+			.to		= sign_ext_branch_ip(entry.to.split.ip),
+			.mispred	= entry.from.split.mispredict,
+			.predicted	= !entry.from.split.mispredict,
+			.spec		= lbr_spec_map[idx],
+		};
 		out++;
 	}
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f8fadb0b16a45..0a9b34261ebe3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -756,10 +756,10 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		perf_clear_branch_entry_bitfields(br);
-
-		br->from	= msr_lastbranch.from;
-		br->to		= msr_lastbranch.to;
+		*br = (struct perf_branch_entry){
+			.from	= msr_lastbranch.from,
+			.to	= msr_lastbranch.to,
+		};
 		br++;
 	}
 	cpuc->lbr_stack.nr = i;
@@ -847,14 +847,15 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		perf_clear_branch_entry_bitfields(br+out);
-		br[out].from	 = from;
-		br[out].to	 = to;
-		br[out].mispred	 = mis;
-		br[out].predicted = pred;
-		br[out].in_tx	 = in_tx;
-		br[out].abort	 = abort;
-		br[out].cycles	 = cycles;
+		br[out] = (struct perf_branch_entry){
+			.from		= from,
+			.to		= to,
+			.mispred	= mis,
+			.predicted	= pred,
+			.in_tx		= in_tx,
+			.abort		= abort,
+			.cycles		= cycles,
+		};
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
@@ -905,6 +906,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 	struct perf_branch_entry *e;
 	struct lbr_entry *lbr;
 	u64 from, to, info;
+	bool mispred;
 	int i;
 
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
@@ -921,24 +923,27 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
-		perf_clear_branch_entry_bitfields(e);
-
-		e->from		= from;
-		e->to		= to;
-		e->mispred	= get_lbr_mispred(info);
-		e->predicted	= !e->mispred;
-		e->in_tx	= !!(info & LBR_INFO_IN_TX);
-		e->abort	= !!(info & LBR_INFO_ABORT);
-		e->cycles	= get_lbr_cycles(info);
-		e->type		= get_lbr_br_type(info);
-
-		/*
-		 * Leverage the reserved field of cpuc->lbr_entries[i] to
-		 * temporarily store the branch counters information.
-		 * The later code will decide what content can be disclosed
-		 * to the perf tool. Pleae see intel_pmu_lbr_counters_reorder().
-		 */
-		e->reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) & LBR_INFO_BR_CNTR_FULL_MASK;
+		mispred = get_lbr_mispred(info);
+
+		*e = (struct perf_branch_entry){
+			.from		= from,
+			.to		= to,
+			.mispred	= mispred,
+			.predicted	= !mispred,
+			.in_tx		= !!(info & LBR_INFO_IN_TX),
+			.abort		= !!(info & LBR_INFO_ABORT),
+			.cycles		= get_lbr_cycles(info),
+			.type		= get_lbr_br_type(info),
+			/*
+			 * Leverage the reserved field of
+			 * cpuc->lbr_entries[i] to temporarily store the
+			 * branch counters information. The later code will
+			 * decide what content can be disclosed to the perf
+			 * tool. Pleae see intel_pmu_lbr_counters_reorder().
+			 */
+			.reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) &
+					  LBR_INFO_BR_CNTR_FULL_MASK,
+		};
 	}
 
 	cpuc->lbr_stack.nr = i;
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c4..254be4da8ae29 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -604,7 +604,7 @@ static bool perf_entry_from_brbe_regset(int index, struct perf_branch_entry *ent
 		return false;
 
 	brbinf = bregs.brbinf;
-	perf_clear_branch_entry_bitfields(entry);
+	*entry = (struct perf_branch_entry){ };
 	if (brbe_record_is_complete(brbinf)) {
 		entry->from = bregs.brbsrc;
 		entry->to = bregs.brbtgt;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea5..310681cccb50a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1467,23 +1467,6 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
 	return size;
 }
 
-/*
- * Clear all bitfields in the perf_branch_entry.
- * The to and from fields are not cleared because they are
- * systematically modified by caller.
- */
-static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
-{
-	br->mispred	= 0;
-	br->predicted	= 0;
-	br->in_tx	= 0;
-	br->abort	= 0;
-	br->cycles	= 0;
-	br->type	= 0;
-	br->spec	= PERF_BR_SPEC_NA;
-	br->reserved	= 0;
-}
-
 extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
-- 
2.53.0-Meta

