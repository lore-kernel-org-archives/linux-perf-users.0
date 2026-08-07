Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015D3F4827;
	Fri,  7 Aug 2026 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098597; cv=none; b=KQnj4oDhjATr/muT9xxofn9mIWxnPfjrZ+8bW3EbINrjSFEYqAaXJCRc1w4bXarxOzmT9LWDRjpIXKGiIoqz/r4JeADNRqQF6zc7Glf4YklpjCoei7GDeiS3klJ2tF2br43a260tinpsCWiFfjAHd+MYBoaec2fIAOW8gme55kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098597; c=relaxed/simple;
	bh=oCYr1Z6scAsEMdC1FW1GwaB7B/b2lTDGnqxBtUg6hh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqZBrSPsHHffzUOPkfTi6fC/LxQ/jghZ4DiZ7GJH/CqzYE4wJbSeo/bxHsWm1WEu01puO9c7C8yGC7Eh37FvHWQHjaKxKssNV0M8jtgz4YX0RSaGmoA8OZHjbDzf0spwzM/XFxqveYOakEhUZ1KZNQ8M+4EmoC2kqyyKO1IwujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L7Lyf3TU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7Lyf3TU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NDy+h31L8H5YXIik8yzC/aAEhJyoZTq0JWluwM7qX3w=; b=L7Lyf3TUsL8AV+RqTgzwx2pGgb
	A2ShCMQqHk51lDNtN2hmTxdAdXRxuOH62IN28x5gnGLGl2gSfeFCYcji94dcIgTLZX9734vZkULyv
	aI6ZrlI58+HytfI5kyQWPPx0Jzgp+mo6bhIpavmUnk9Bylaz2JT00MavmKib4Otl+afHbRKgCZZDx
	Aq/Lq8vJY+lMi0hTO4rS1VVlBig5hmvV6WSzaEZc8xQLojQPiXa1vzNF42Ccxc9abat0FFXS+Wv6P
	5FFqI28lVR3eXPwZ1YmmgWbrn3Mc3Zp46Ox4b8SunkX3Le7wzx7O+G0PDV48dKpohkgE2PQk0Sp3y
	0p7f7AiQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wsHpW-0000000CHpr-0ecL;
	Fri, 07 Aug 2026 10:29:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0E143004C9; Fri, 07 Aug 2026 12:29:32 +0200 (CEST)
Date: Fri, 7 Aug 2026 12:29:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Usama Arif <usama.arif@linux.dev>, Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] perf/core: Clear the whole branch entry in
 perf_clear_branch_entry()
Message-ID: <20260807102932.GU776954@noisy.programming.kicks-ass.net>
References: <20260806135224.3267890-1-puranjay@kernel.org>
 <20260806135224.3267890-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806135224.3267890-4-puranjay@kernel.org>

On Thu, Aug 06, 2026 at 06:52:23AM -0700, Puranjay Mohan wrote:
> perf_clear_branch_entry_bitfields() clears the bitfields of struct
> perf_branch_entry one by one and leaves from/to alone, since callers
> overwrite those straight away. The list has to be kept in sync with the
> struct by hand and has already fallen behind: new_type and priv were
> added to perf_branch_entry and never added here.
> 
> Only BRBE writes those two, and neither is written for every record.
> brbe_set_perf_entry_type() leaves new_type alone for a branch type it
> does not recognise, and priv is not set for source-only records.
> arm_pmuv3.c allocates the per-CPU branch stack with kmalloc(), so such a
> record carries whatever the slot held: uninitialised kmalloc() data on
> the first pass over the buffer, the previous record's values after that.
> Both reach userspace through the branch stack. Nothing under
> arch/x86/events/ writes either field, so x86 is unaffected.
> 
> Clear the entry with a single struct assignment instead:
> 
> 	*br = (struct perf_branch_entry){ };
> 
> The bitfields add up to exactly 64 bits, so there is no padding, and
> every caller assigns from/to immediately afterwards, so zeroing those as
> well changes nothing. PERF_BR_SPEC_NA is 0, so dropping the explicit
> spec assignment leaves the behaviour unchanged. Nothing needs keeping in
> sync when a field is added.
> 
> The helper no longer touches only bitfields, so rename it to
> perf_clear_branch_entry().

Fair enough I suppose, but then why not write it like so?

---
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -343,11 +343,7 @@ void amd_brs_drain(void)
 		if (!amd_brs_match_plm(event, from, to))
 			continue;
 
-		perf_clear_branch_entry_bitfields(br+nr);
-
-		br[nr].from = from;
-		br[nr].to   = to;
-
+		br[nr] = (struct perf_branch_entry){ from, to };
 		nr++;
 	}
 empty:
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -184,12 +184,6 @@ void amd_pmu_lbr_read(void)
 		    entry.to.split.reserved)
 			continue;
 
-		perf_clear_branch_entry_bitfields(br + out);
-
-		br[out].from	= sign_ext_branch_ip(entry.from.split.ip);
-		br[out].to	= sign_ext_branch_ip(entry.to.split.ip);
-		br[out].mispred	= entry.from.split.mispredict;
-		br[out].predicted = !br[out].mispred;
 
 		/*
 		 * Set branch speculation information using the status of
@@ -208,7 +202,13 @@ void amd_pmu_lbr_read(void)
 		 * speculative and took the correct path
 		 */
 		idx = (entry.to.split.valid << 1) | entry.to.split.spec;
-		br[out].spec = lbr_spec_map[idx];
+		br[out] = (struct perf_branch_entry) {
+			.from      = sign_ext_branch_ip(entry.from.split.ip),
+			.to        = sign_ext_branch_ip(entry.to.split.ip),
+			.mispred   = entry.from.split.mispredict,
+			.predicted = !entry.from.split.mispredict,
+			.spec      = lbr_spec_map[idx],
+		};
 		out++;
 	}
 
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -756,10 +756,10 @@ void intel_pmu_lbr_read_32(struct cpu_hw
 
 		rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		perf_clear_branch_entry_bitfields(br);
-
-		br->from	= msr_lastbranch.from;
-		br->to		= msr_lastbranch.to;
+		*br = (struct perf_branch_entry){
+			.from = msr_lastbranch.from,
+			.to   = msr_lastbranch.to,
+		};
 		br++;
 	}
 	cpuc->lbr_stack.nr = i;
@@ -847,14 +847,15 @@ void intel_pmu_lbr_read_64(struct cpu_hw
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
+		br[out] = (struct perf_branch_entry) {
+			.from      = from,
+			.to        = to,
+			.mispred   = mis,
+			.predicted = pred,
+			.in_tx     = in_tx,
+			.abort     = abort,
+			.cycles    = cycles,
+		};
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
@@ -921,24 +922,25 @@ static void intel_pmu_store_lbr(struct c
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
+		*e = (struct perf_branch_entry){
+			.from      = from,
+			.to        = to,
+			.mispred   = get_lbr_mispred(info),
+			.predicted = !get_lbr_mispred(info),
+			.in_tx     = !!(info & LBR_INFO_IN_TX),
+			.abort     = !!(info & LBR_INFO_ABORT),
+			.cycles    = get_lbr_cycles(info),
+			.type      = get_lbr_br_type(info),
+
+			/*
+			 * Leverage the reserved field of cpuc->lbr_entries[i]
+			 * to temporarily store the branch counters
+			 * information. The later code will decide what
+			 * content can be disclosed to the perf tool. Pleae
+			 * see intel_pmu_lbr_counters_reorder().
+			 */
+			.reserved  = (info >> LBR_INFO_BR_CNTR_OFFSET) & LBR_INFO_BR_CNTR_FULL_MASK,
+		};
 	}
 
 	cpuc->lbr_stack.nr = i;
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -604,7 +604,7 @@ static bool perf_entry_from_brbe_regset(
 		return false;
 
 	brbinf = bregs.brbinf;
-	perf_clear_branch_entry_bitfields(entry);
+	*entry = (struct perf_branch_entry) { };
 	if (brbe_record_is_complete(brbinf)) {
 		entry->from = bregs.brbsrc;
 		entry->to = bregs.brbtgt;
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1467,23 +1467,6 @@ static inline u32 perf_sample_data_size(
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
