Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E53B47D0;
	Thu,  6 Aug 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024408; cv=none; b=b6nEvVysqXrJQ9HE44SV7sZzFqkXq3/YUKdidt1LWtwWX13WWty3rDQyFIql48C0NNYRSDpmVBP3zyFp/2d5/+oZ5vbpaSg105icxLeKypJ147xjkYX6AEd7aKhSb4MNMMjz7SVbnwLiwGsgxMSgVUwbDEnhpX6lTXHdSEa8pQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024408; c=relaxed/simple;
	bh=/gUygZqG5iJqfrYiScFK1MMpZ5HE7PLQv++ImHqVe8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyUAIQG2/pPmJxpMTldP/3s791PdxfIVdwIqjwcpCNrM2tHEZcQnkDg2xR7Xz38SHyOZadGqjaNksbaCLV8ZjQxX7Tqr3y7ZJGCLUftvacY0knk5POteEmrPMXGJgNpeGQ9AcjlyZPDigg8gw1bKaOfCMHAIPH0MW72Jrlyv/BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp2tN+o3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp2tN+o3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B71F000E9;
	Thu,  6 Aug 2026 13:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024406;
	bh=9MvHu1Pl2ssBHzhmhTZmBr2JBtolR+FQT5i70MkMUxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vp2tN+o31EsdMyor7sYZoPaRvifAaVI0ng6axlV+D3HQZ87rBtnUL8FxPgESR/eDI
	 9fdM4SQ9ACgkezeHcW04FMFaql9Kc9HS9j98nmY02HT4aq4BjB+azty6HJ0TC8viGH
	 OHTurSNVGbLVxdOrIS0VEo/JvBDtm0nkMTyC0shIJqgDSgYYJaIm25iiVUAINwwHhL
	 8/3ZF10KVCp7Yp1PtMbSSe2DjxVAh69HMDlAyvLHou2ejEHUOA0nZju/1D6F8G8ZMp
	 Yfwt98mBfhcbk0xLoPkLu79bZhedv0iXd+GbPj0i1ykSn9dMI065p8MR7Nh2NWn0n+
	 dXYvxhXgj8iZw==
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
Subject: [PATCH v6 3/3] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
Date: Thu,  6 Aug 2026 06:52:23 -0700
Message-ID: <20260806135224.3267890-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806135224.3267890-1-puranjay@kernel.org>
References: <20260806135224.3267890-1-puranjay@kernel.org>
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

Only BRBE writes those two, and neither is written for every record.
brbe_set_perf_entry_type() leaves new_type alone for a branch type it
does not recognise, and priv is not set for source-only records.
arm_pmuv3.c allocates the per-CPU branch stack with kmalloc(), so such a
record carries whatever the slot held: uninitialised kmalloc() data on
the first pass over the buffer, the previous record's values after that.
Both reach userspace through the branch stack. Nothing under
arch/x86/events/ writes either field, so x86 is unaffected.

Clear the entry with a single struct assignment instead:

	*br = (struct perf_branch_entry){ };

The bitfields add up to exactly 64 bits, so there is no padding, and
every caller assigns from/to immediately afterwards, so zeroing those as
well changes nothing. PERF_BR_SPEC_NA is 0, so dropping the explicit
spec assignment leaves the behaviour unchanged. Nothing needs keeping in
sync when a field is added.

The helper no longer touches only bitfields, so rename it to
perf_clear_branch_entry().

Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
Suggested-by: James Clark <james.clark@linaro.org>
Reviewed-by: James Clark <james.clark@linaro.org>
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 arch/x86/events/amd/brs.c   |  2 +-
 arch/x86/events/amd/lbr.c   |  2 +-
 arch/x86/events/intel/lbr.c |  6 +++---
 drivers/perf/arm_brbe.c     |  2 +-
 include/linux/perf_event.h  | 16 ++--------------
 5 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 06f35a6b58a5b..68c5f42965e91 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -343,7 +343,7 @@ void amd_brs_drain(void)
 
 		rdmsrq(brs_from(brs_idx), from);
 
-		perf_clear_branch_entry_bitfields(br+nr);
+		perf_clear_branch_entry(br + nr);
 
 		br[nr].from = from;
 		br[nr].to   = to;
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 5b437dc8e4ce2..3639817456119 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -183,7 +183,7 @@ void amd_pmu_lbr_read(void)
 		    entry.to.split.reserved)
 			continue;
 
-		perf_clear_branch_entry_bitfields(br + out);
+		perf_clear_branch_entry(br + out);
 
 		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
 		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f8fadb0b16a45..6541c7046c2b3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -756,7 +756,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		perf_clear_branch_entry_bitfields(br);
+		perf_clear_branch_entry(br);
 
 		br->from	= msr_lastbranch.from;
 		br->to		= msr_lastbranch.to;
@@ -847,7 +847,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		perf_clear_branch_entry_bitfields(br+out);
+		perf_clear_branch_entry(br + out);
 		br[out].from	 = from;
 		br[out].to	 = to;
 		br[out].mispred	 = mis;
@@ -921,7 +921,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
-		perf_clear_branch_entry_bitfields(e);
+		perf_clear_branch_entry(e);
 
 		e->from		= from;
 		e->to		= to;
diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index ba554e0c846c4..effbdeacfcbb3 100644
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
index 48d851fbd8ea5..e034be4a473a8 100644
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

