Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06D189F3B;
	Sat, 22 Mar 2025 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742628265; cv=none; b=Y/75peuG8WWbeTctOgdZuLRs7KXiZu3tdTNW1z3XY4gOtp6RW/oIf7yfb4MMkUwirec4eJaHu8IJchVixm59HCT1T4TI8FONtFLu5s/bQq3miCHRGhSvkznYViXlvMd4mJbJZ0P5nq0s8nyz+2K9zEldzyIWVEMM+VrByEk9hoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742628265; c=relaxed/simple;
	bh=2mH3DfhF8nEJy0oHLRCB3ZZUif9mdKrgzPAnKF/tj6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRxxgUM0XKSrr37zX5/eP/RBzxqyzdWg4Z2e7Yh9GFesw7KAAMboWEnVODHdPeSaSPAMAIXYOTDXc8arhM3HxV+9jSU3vdpEw5F9iQ8u1cRFXbpY3W+NHG5sQfwmy8wqxaibNZVbyx/i797edZn0zqblCKj5jxqF0s0R8FLXQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOYz/J+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOYz/J+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8566DC4CEDD;
	Sat, 22 Mar 2025 07:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742628264;
	bh=2mH3DfhF8nEJy0oHLRCB3ZZUif9mdKrgzPAnKF/tj6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BOYz/J+Q06r8oxS+1mL0t4Xy+3bJl7nMZaST+5kzuKGDziUiJgB5mx/YxeNeyR1BP
	 yVTTNtIf7b0Gk9URcVLiBxHkXrgmx2WqiN8g4HEbZxzHn3ezzF90970SH4P26vT9c3
	 OLNBJ0m52aMf7UIvvpMc5jAs4Ga/ZeZ6SwIpeYGlVvp6zijWPXLDkOynWsmGP821bG
	 pK557hg4JeRBRf6CL6nfm8CHShS4L93mP6yoWfM3izvq65iuebs+OxvKogArWHoUL9
	 LSSJQ61rK7LPdo6GfxElwWrw4Yo3RqgFsI2/ftpUQ8xm6SVvVq23WN3V5fFYFSgIXI
	 ZrSGjhO92Zd+A==
Date: Sat, 22 Mar 2025 08:24:19 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@redhat.com,
	acme@kernel.org, kan.liang@linux.intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	matteorizzo@google.com, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive
 data to userspace
Message-ID: <Z95lo6J37emCRvme@gmail.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321161251.1033-1-ravi.bangoria@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> From: Namhyung Kim <namhyung@kernel.org>
> 
> Although IBS "swfilt" can prevent leaking samples with kernel RIP to the
> userspace, there are few subtle cases where a 'data' address and/or a
> 'branch target' address can fall under kernel address range although RIP
> is from userspace. Prevent leaking kernel 'data' addresses by discarding
> such samples when {exclude_kernel=1,swfilt=1}.
> 
> IBS can now be invoked by unprivileged user with the introduction of
> "swfilt". However, this creates a loophole in the interface where an
> unprivileged user can get physical address of the userspace virtual
> addresses through IBS register raw dump (PERF_SAMPLE_RAW). Prevent this
> as well.
> 
> Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
> v2: https://lore.kernel.org/r/20250317163755.1842589-1-namhyung@kernel.org
> 
>  arch/x86/events/amd/ibs.c | 76 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)

Since the initial fix is already upstream, I created a delta fix below 
for the PERF_SAMPLE_RAW fixes in -v3.

How well was this tested? v6.14 will be released tomorrow most likely, 
so it's a bit risky to apply such a large patch so late. Applying the 
-v1 fix was a bit risky already.

Thanks,

	Ingo

====================>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 22 Mar 2025 08:13:01 +0100
Subject: [PATCH] perf/amd/ibs: Prevent leaking sensitive data to userspace

Although IBS "swfilt" can prevent leaking samples with kernel RIP to the
userspace, there are few subtle cases where a 'data' address and/or a
'branch target' address can fall under kernel address range although RIP
is from userspace. Prevent leaking kernel 'data' addresses by discarding
such samples when {exclude_kernel=1,swfilt=1}.

IBS can now be invoked by unprivileged user with the introduction of
"swfilt". However, this creates a loophole in the interface where an
unprivileged user can get physical address of the userspace virtual
addresses through IBS register raw dump (PERF_SAMPLE_RAW). Prevent this
as well.

This upstream commit fixed the most obvious leak:

  65a99264f5e5 perf/x86: Check data address for IBS software filter

Follow that up with a more complete fix.

Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250321161251.1033-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 84 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index c46500592002..e36c9c63c97c 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -941,6 +941,8 @@ static void perf_ibs_get_mem_lock(union ibs_op_data3 *op_data3,
 		data_src->mem_lock = PERF_MEM_LOCK_LOCKED;
 }
 
+/* Be careful. Works only for contiguous MSRs. */
+#define ibs_fetch_msr_idx(msr)	(msr - MSR_AMD64_IBSFETCHCTL)
 #define ibs_op_msr_idx(msr)	(msr - MSR_AMD64_IBSOPCTL)
 
 static void perf_ibs_get_data_src(struct perf_ibs_data *ibs_data,
@@ -1036,6 +1038,67 @@ static int perf_ibs_get_offset_max(struct perf_ibs *perf_ibs, u64 sample_type,
 	return 1;
 }
 
+static bool perf_ibs_is_kernel_data_addr(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data)
+{
+	u64 sample_type_mask = PERF_SAMPLE_ADDR | PERF_SAMPLE_RAW;
+	union ibs_op_data3 op_data3;
+	u64 dc_lin_addr;
+
+	op_data3.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)];
+	dc_lin_addr = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCLINAD)];
+
+	return unlikely((event->attr.sample_type & sample_type_mask) &&
+			op_data3.dc_lin_addr_valid && kernel_ip(dc_lin_addr));
+}
+
+static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
+					 struct perf_ibs_data *ibs_data,
+					 int br_target_idx)
+{
+	union ibs_op_data op_data;
+	u64 br_target;
+
+	op_data.val = ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA)];
+	br_target = ibs_data->regs[br_target_idx];
+
+	return unlikely((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+			op_data.op_brn_ret && kernel_ip(br_target));
+}
+
+static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
+				    int br_target_idx)
+{
+	if (perf_exclude_event(event, regs))
+		return true;
+
+	if (perf_ibs != &perf_ibs_op || !event->attr.exclude_kernel)
+		return false;
+
+	if (perf_ibs_is_kernel_data_addr(event, ibs_data))
+		return true;
+
+	if (br_target_idx != -1 &&
+	    perf_ibs_is_kernel_br_target(event, ibs_data, br_target_idx))
+		return true;
+
+	return false;
+}
+
+static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
+				   struct perf_ibs_data *ibs_data)
+{
+	if (perf_ibs == &perf_ibs_op) {
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
+		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
+		return;
+	}
+
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
+	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
+}
+
 static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 {
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
@@ -1048,6 +1111,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
+	int br_target_idx = -1;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -1102,6 +1166,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		if (perf_ibs == &perf_ibs_op) {
 			if (ibs_caps & IBS_CAPS_BRNTRGT) {
 				rdmsrl(MSR_AMD64_IBSBRTARGET, *buf++);
+				br_target_idx = size;
 				size++;
 			}
 			if (ibs_caps & IBS_CAPS_OPDATA4) {
@@ -1128,16 +1193,20 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if (perf_ibs == &perf_ibs_op)
-		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
-
 	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (perf_exclude_event(event, &regs) ||
-	     ((data.sample_flags & PERF_SAMPLE_ADDR) &&
-	      event->attr.exclude_kernel && kernel_ip(data.addr)))) {
+	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
+	/*
+	 * Prevent leaking physical addresses to unprivileged users. Skip
+	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
+	 * unprivileged users.
+	 */
+	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
+	    perf_allow_kernel(&event->attr)) {
+		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
+	}
 
 	if (event->attr.sample_type & PERF_SAMPLE_RAW) {
 		raw = (struct perf_raw_record){
@@ -1149,6 +1218,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		perf_sample_save_raw_data(&data, event, &raw);
 	}
 
+	if (perf_ibs == &perf_ibs_op)
+		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from
