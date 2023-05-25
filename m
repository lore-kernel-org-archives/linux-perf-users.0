Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65888C7EE2E
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 07:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjEYHUq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238828AbjEYHUl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 03:20:41 -0400
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 00:20:34 PDT
Received: from out-29.mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043D8E50
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 00:20:34 -0700 (PDT)
Date:   Thu, 25 May 2023 07:11:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684998707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iz6y8y6khpMjAIZq8YDzvt5EdSkB55kQXDEISakUjns=;
        b=n5fwCDL0eOfW/wMfQaEDC7YPW1PyI/z1kdA2egEpwnmCwAgLo6k/aKjPTwXqblxRRbrb1N
        8y4t1/2lEN/k8VnpE5HDLiWIQHitDjOln1g/tMw09KqO44sdTgg+9U1z3VDc+sRV6R0SgL
        b+rXGgr4sY4156ZeAAntGIINkL4C6IY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>, peterz@infradead.org,
        namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
Message-ID: <ZG8KLbZSECiYaKFc@linux.dev>
References: <20230504110003.2548-1-ravi.bangoria@amd.com>
 <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X>
 <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 25, 2023 at 10:46:01AM +0530, Ravi Bangoria wrote:
> On 25-May-23 3:11 AM, Nathan Chancellor wrote:
> > My apologies if this has already been reported or fixed already, I did a
> > search of lore.kernel.org and did not find anything. This patch as
> > commit 9551fbb64d09 ("perf/core: Remove pmu linear searching code") in
> > -next breaks starting QEMU with KVM enabled on two of my arm64 machines:
> > 
> > $ qemu-system-aarch64 \
> >     -display none \
> >     -nodefaults \
> >     -machine virt,gic-version=max \
> >     -append 'console=ttyAMA0 earlycon' \
> >     -kernel arch/arm64/boot/Image.gz \
> >     -initrd rootfs.cpio \
> >     -cpu host \
> >     -enable-kvm \
> >     -m 512m \
> >     -smp 8 \
> >     -serial mon:stdio
> > qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: No such device
> > qemu-system-aarch64: failed to set irq for PMU
> > 
> > In the kernel log, I see
> > 
> > [   42.944952] kvm: pmu event creation failed -2
> > 
> > I am not sure if this issue is unexpected as a result of this change or
> > if there is something that needs to change on the arm64 KVM side (it
> > appears the kernel message comes from arch/arm64/kvm/pmu-emul.c).
> 
> Thanks for reporting it.
> 
> Based on these detail, I feel the pmu registration failed in the host,
> most probably because pmu driver did not pass pmu name while calling
> perf_pmu_register(). Consequently kvm also failed while trying to use
> it for guest. Can you please check host kernel logs.

The PMUv3 driver does pass a name, but it relies on getting back an
allocated pmu id as @type is -1 in the call to perf_pmu_register().

What actually broke is how KVM probes for a default core PMU to use for
a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RAW and
reads the pmu from the returned perf_event. The linear search had the
effect of eventually stumbling on the correct core PMU and succeeding.

Perf folks: is this WAI for heterogenous systems?

Either way, the whole KVM end of this scheme is a bit clunky, and I
believe it to be unneccessary at this point as we maintain a list of
core PMU instances that KVM is able to virtualize. We can just walk
that to find a default PMU to use.

Not seeing any issues on -next with the below diff. If this works for
folks I can actually wrap it up in a patch and send it out.

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 45727d50d18d..cbc0b662b7f8 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -694,47 +694,26 @@ void kvm_host_pmu_init(struct arm_pmu *pmu)
 
 static struct arm_pmu *kvm_pmu_probe_armpmu(void)
 {
-	struct perf_event_attr attr = { };
-	struct perf_event *event;
-	struct arm_pmu *pmu = NULL;
-
-	/*
-	 * Create a dummy event that only counts user cycles. As we'll never
-	 * leave this function with the event being live, it will never
-	 * count anything. But it allows us to probe some of the PMU
-	 * details. Yes, this is terrible.
-	 */
-	attr.type = PERF_TYPE_RAW;
-	attr.size = sizeof(attr);
-	attr.pinned = 1;
-	attr.disabled = 0;
-	attr.exclude_user = 0;
-	attr.exclude_kernel = 1;
-	attr.exclude_hv = 1;
-	attr.exclude_host = 1;
-	attr.config = ARMV8_PMUV3_PERFCTR_CPU_CYCLES;
-	attr.sample_period = GENMASK(63, 0);
+	struct arm_pmu *arm_pmu = NULL, *tmp;
+	struct arm_pmu_entry *entry;
+	int cpu;
 
-	event = perf_event_create_kernel_counter(&attr, -1, current,
-						 kvm_pmu_perf_overflow, &attr);
+	mutex_lock(&arm_pmus_lock);
+	cpu = get_cpu();
 
-	if (IS_ERR(event)) {
-		pr_err_once("kvm: pmu event creation failed %ld\n",
-			    PTR_ERR(event));
-		return NULL;
-	}
+	list_for_each_entry(entry, &arm_pmus, entry) {
+		tmp = entry->arm_pmu;
 
-	if (event->pmu) {
-		pmu = to_arm_pmu(event->pmu);
-		if (pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_NI ||
-		    pmu->pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF)
-			pmu = NULL;
+		if (cpumask_test_cpu(cpu, &tmp->supported_cpus)) {
+			arm_pmu = tmp;
+			break;
+		}
 	}
 
-	perf_event_disable(event);
-	perf_event_release_kernel(event);
+	put_cpu();
+	mutex_unlock(&arm_pmus_lock);
 
-	return pmu;
+	return arm_pmu;
 }
 
 u64 kvm_pmu_get_pmceid(struct kvm_vcpu *vcpu, bool pmceid1)

-- 
Thanks,
Oliver
