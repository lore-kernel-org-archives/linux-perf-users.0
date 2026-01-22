Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054E342507
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101989; cv=none; b=d7k4VgBosroN0UyrAm/r+6g5Xh0+0Bar/f8sOQo719V3KByTqCU205IZHIAzWaf2L4i9EwciidAkKb0HhZHz2AOYxd8Po0A5imb/0FebQkmM6hZa+apNyQ+Xr/+lvar4FWg7DljK2xec7rOkL0Wcq7Us+Ze8W43ZgEM6EvBRMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101989; c=relaxed/simple;
	bh=mcx4XvLkHggV0fRu5lan02/evHxE726XWNxe3btPGto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GMp/exswsiSa1kDXSgHwoHWQHQIdPwoEHfX+0OPZyAouWlyYxjit7Rtvh4AP+3NJBsqrozolY8uHSFwXie20lxBBMlP2o1pToLPxsCDQ48jqb7WX3yng6IUwO8NnKteiTbJMRYoB5IkzbqKNotANbh1Iy5dHxwCp/KmZEMfVUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wRFgeApm; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRFgeApm"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a13be531b2so12610985ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769101977; x=1769706777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tY6gvpG5zxtSlYaXqjyYbiaqgPJDTjCiqC6J9d+kcsc=;
        b=wRFgeApmLM+cqLhqQQeNNO0yhGzF0qtiXIB6FF7gDMyS8FrumkQcPHQYcEUFPzb5io
         i80BaHrxecRBdoRUPjeYLIokAviULCHEbPimmpkUUpxYTB45P2uh5w6JdKKsJElUp4mn
         iAnh2KLexN2Om6SMG5RUZx9GKso5qGTM/JU4e4r2s1Iuj5lw3B28kbl9OCe6J5ZZLbuF
         MQvIeNbUiW6XiYFqqGUXmzj3+81ybTd5k02hBnZwZJC7n6XmI8d65fXaKlqtWjO6zwLR
         grUvU9xN3RfpR8ftSbnjK19mPlpYYvh1ScnO6e0VJvN9IKKEIPBBQTYBX2p/6Ex7TBEW
         ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101977; x=1769706777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tY6gvpG5zxtSlYaXqjyYbiaqgPJDTjCiqC6J9d+kcsc=;
        b=T4DHY/vg3yiYHQQUsyHtlAIBqwPgisvrxV7qU/puZFC7hqjJpphMulpwve9rN1o44g
         uStJhVqa5u4LVut4e18Y8xAYXZhePiN6g+H6q82iA6MAhWcfGOa0jZVfHd59OOaRGCHg
         GruM7Zyt8sNUFtCiyr1wFNNHcc8x0ycryQVPJPNFmOnYqKaLMwNKR4P2f/tMUkBRLyjX
         MolMgF+4QqO3CdRgv96OU4cbZPL0OiwIp10ejeZYh1sGI3+DiZYl/1LQlzO85j75MRPw
         l60SrIY97wix9V1h8bV/OcTslZAQWl87PyLrPfw833uCd7MZAmHp79wu9zJxaSVQhHZM
         b5dw==
X-Forwarded-Encrypted: i=1; AJvYcCXCwz6wsRiabj+oRIIt64oiJf4iTy+0D/NESKXVAXPpT69RfWIeG2K1FNL1yuRAYkR4dX+odukcwFvHpPyVSKhI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7ZJbrhE2P2/lMWxxKIB71uB5l0+EpIEjtYuMtD/EEF5zqtR0
	vQimbiAXc+zDK4Rxc/D98gidDLhn+TPCMYGxo7PDQuPo+bAb7tyXxyEkSEuRIqYrmZ7i1QCaL0W
	N6jLDPw==
X-Received: from pllq3.prod.google.com ([2002:a17:902:7883:b0:2a7:73ca:9132])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:18c:b0:2a7:5171:9221
 with SMTP id d9443c01a7336-2a7fe745737mr714765ad.42.1769101976816; Thu, 22
 Jan 2026 09:12:56 -0800 (PST)
Date: Thu, 22 Jan 2026 09:12:55 -0800
In-Reply-To: <20260121225438.3908422-7-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-7-jmattson@google.com>
Message-ID: <aXJal3srw2-3J5Dm@google.com>
Subject: Re: [PATCH 6/6] KVM: selftests: x86: Add svm_pmu_hg_test for HG_ONLY bits
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 21, 2026, Jim Mattson wrote:
> Add a selftest to verify KVM correctly virtualizes the AMD PMU Host-Only
> (bit 41) and Guest-Only (bit 40) event selector bits across all relevant
> SVM state transitions.
> 
> For both Guest-Only and Host-Only counters, verify that:
>   1. SVME=0: counter counts (HG_ONLY bits ignored)
>   2. Set SVME=1: counter behavior changes based on HG_ONLY bit
>   3. VMRUN to L2: counter behavior switches (guest vs host mode)
>   4. VMEXIT to L1: counter behavior switches back
>   5. Clear SVME=0: counter counts (HG_ONLY bits ignored again)
> 
> Also confirm that setting both bits is the same as setting neither bit.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/x86/svm_pmu_hg_test.c       | 297 ++++++++++++++++++
>  2 files changed, 298 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_hg_test.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index e88699e227dd..06ba85d97618 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -112,6 +112,7 @@ TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
>  TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
>  TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
>  TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
> +TEST_GEN_PROGS_x86 += x86/svm_pmu_hg_test

Maybe svm_nested_pmu_test?  Hmm, that makes it sound like "nested PMU" though.

svm_pmu_host_guest_test?

> +#define MSR_F15H_PERF_CTL0	0xc0010200
> +#define MSR_F15H_PERF_CTR0	0xc0010201
> +
> +#define AMD64_EVENTSEL_GUESTONLY	BIT_ULL(40)
> +#define AMD64_EVENTSEL_HOSTONLY		BIT_ULL(41)

Please put architectural definitions in pmu.h (or whatever library header we
have).

> +struct hg_test_data {

Please drop "hg" (I keep reading it as "mercury").

> +	uint64_t l2_delta;
> +	bool l2_done;
> +};
> +
> +static struct hg_test_data *hg_data;
> +
> +static void l2_guest_code(void)
> +{
> +	hg_data->l2_delta = run_and_measure();
> +	hg_data->l2_done = true;
> +	vmmcall();
> +}
> +
> +/*
> + * Test Guest-Only counter across all relevant state transitions.
> + */
> +static void l1_guest_code_guestonly(struct svm_test_data *svm,
> +				    struct hg_test_data *data)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +	uint64_t eventsel, delta;
> +
> +	hg_data = data;
> +
> +	eventsel = EVENTSEL_RETIRED_INSNS | AMD64_EVENTSEL_GUESTONLY;
> +	wrmsr(MSR_F15H_PERF_CTL0, eventsel);
> +	wrmsr(MSR_F15H_PERF_CTR0, 0);
> +
> +	/* Step 1: SVME=0; HG_ONLY ignored */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 2: Set SVME=1; Guest-Only counter stops */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_EQ(delta, 0);
> +
> +	/* Step 3: VMRUN to L2; Guest-Only counter counts */
> +	generic_svm_setup(svm, l2_guest_code,
> +			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
> +	GUEST_ASSERT(data->l2_done);
> +	GUEST_ASSERT_NE(data->l2_delta, 0);
> +
> +	/* Step 4: After VMEXIT to L1; Guest-Only counter stops */
> +	delta = run_and_measure();
> +	GUEST_ASSERT_EQ(delta, 0);
> +
> +	/* Step 5: Clear SVME; HG_ONLY ignored */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	GUEST_DONE();
> +}
> +
> +/*
> + * Test Host-Only counter across all relevant state transitions.
> + */
> +static void l1_guest_code_hostonly(struct svm_test_data *svm,
> +				   struct hg_test_data *data)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +	uint64_t eventsel, delta;
> +
> +	hg_data = data;
> +
> +	eventsel = EVENTSEL_RETIRED_INSNS | AMD64_EVENTSEL_HOSTONLY;
> +	wrmsr(MSR_F15H_PERF_CTL0, eventsel);
> +	wrmsr(MSR_F15H_PERF_CTR0, 0);
> +
> +
> +	/* Step 1: SVME=0; HG_ONLY ignored */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 2: Set SVME=1; Host-Only counter still counts */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 3: VMRUN to L2; Host-Only counter stops */
> +	generic_svm_setup(svm, l2_guest_code,
> +			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
> +	GUEST_ASSERT(data->l2_done);
> +	GUEST_ASSERT_EQ(data->l2_delta, 0);
> +
> +	/* Step 4: After VMEXIT to L1; Host-Only counter counts */
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 5: Clear SVME; HG_ONLY ignored */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	GUEST_DONE();
> +}
> +
> +/*
> + * Test that both bits set is the same as neither bit set (always counts).
> + */
> +static void l1_guest_code_both_bits(struct svm_test_data *svm,

l1_guest_code gets somewhat redundant.  What about these to be more descriptive
about the salient points, without creating monstrous names?

	l1_test_no_filtering // very open to suggestions for a better name
	l1_test_guestonly
	l1_test_hostonly
	l1_test_host_and_guest

Actually, why are there even separate helpers?  Very off the cuff, but this seems
trivial to dedup:

static void l1_guest_code(struct svm_test_data *svm, u64 host_guest_mask)
{
	const bool count_in_host = !host_guest_mask ||
				   (host_guest_mask & AMD64_EVENTSEL_HOSTONLY);
	const bool count_in_guest = !host_guest_mask ||
				    (host_guest_mask & AMD64_EVENTSEL_GUESTONLY);
	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
	struct vmcb *vmcb = svm->vmcb;
	uint64_t eventsel, delta;

	wrmsr(MSR_F15H_PERF_CTL0, EVENTSEL_RETIRED_INSNS | host_guest_mask);
	wrmsr(MSR_F15H_PERF_CTR0, 0);

	/* Step 1: SVME=0; host always counts */
	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
	delta = run_and_measure();
	GUEST_ASSERT_NE(delta, 0);

	/* Step 2: Set SVME=1; Guest-Only counter stops */
	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
	delta = run_and_measure();
	GUEST_ASSERT(!!delta == count_in_host);

	/* Step 3: VMRUN to L2; Guest-Only counter counts */
	generic_svm_setup(svm, l2_guest_code,
			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);

	run_guest(vmcb, svm->vmcb_gpa);

	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
	GUEST_ASSERT(data->l2_done);
	GUEST_ASSERT(!!data->l2_delta == count_in_guest);

	/* Step 4: After VMEXIT to L1; Guest-Only counter stops */
	delta = run_and_measure();
	GUEST_ASSERT(!!delta == count_in_host);

	/* Step 5: Clear SVME; HG_ONLY ignored */
	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
	delta = run_and_measure();
	GUEST_ASSERT_NE(delta, 0);

	GUEST_DONE();
}

> +				    struct hg_test_data *data)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +	uint64_t eventsel, delta;
> +
> +	hg_data = data;
> +
> +	eventsel = EVENTSEL_RETIRED_INSNS |
> +		AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY;
> +	wrmsr(MSR_F15H_PERF_CTL0, eventsel);
> +	wrmsr(MSR_F15H_PERF_CTR0, 0);
> +
> +	/* Step 1: SVME=0 */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 2: Set SVME=1 */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 3: VMRUN to L2 */
> +	generic_svm_setup(svm, l2_guest_code,
> +			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
> +
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
> +	GUEST_ASSERT(data->l2_done);
> +	GUEST_ASSERT_NE(data->l2_delta, 0);
> +
> +	/* Step 4: After VMEXIT to L1 */
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	/* Step 5: Clear SVME */
> +	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
> +	delta = run_and_measure();
> +	GUEST_ASSERT_NE(delta, 0);
> +
> +	GUEST_DONE();
> +}
> +
> +static void l1_guest_code(struct svm_test_data *svm, struct hg_test_data *data,
> +			  int test_num)
> +{
> +	switch (test_num) {
> +	case 0:

As above, I would much rather pass in the mask of GUEST_HOST bits to set, and
then react accordingly, as opposed to passing in a magic/arbitrary @test_num.
Then I'm pretty sure we don't need a dispatch function, just run the testcase
using the passed in mask.

> +		l1_guest_code_guestonly(svm, data);
> +		break;
> +	case 1:
> +		l1_guest_code_hostonly(svm, data);
> +		break;
> +	case 2:
> +		l1_guest_code_both_bits(svm, data);
> +		break;
> +	}
> +}

...

> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +	TEST_REQUIRE(kvm_is_pmu_enabled());
> +	TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
> +
> +	run_test(0, "Guest-Only counter across all transitions");
> +	run_test(1, "Host-Only counter across all transitions");
> +	run_test(2, "Both HG_ONLY bits set (always count)");

As alluded to above, shouldn't we also test "no bits set"?
> +
> +	return 0;
> +}
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
