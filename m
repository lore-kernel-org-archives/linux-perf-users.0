Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A713ED3A9
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414772; cv=none; b=oJukGU0hkiopESv1JIWwuO2lVHTg0YNQsokFz18Vd5LvtfTcFKtbzDZfKBssQQWxIdN+OfYAi+yA0a9fmqIYoV3E15QnhAyG+91qqq3YHDU/zgOnlqw8CqBRvRKFIYTQJNUpR/s/rQYA1Q5KueKZsyiWDs+56fW26BH5a3HwSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414772; c=relaxed/simple;
	bh=WK4U8H9z28idl/3Xx4+Cg56WTACpARG769++1VCNH9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IQ5BWDuBBK2PBBcvc97H1Dnw94al76wl0OdQGoxy2nDeecIlgBdcMFq7smGwGaPzhAmVtLTaVJbs/25Tn/aFBhff0TtZn06YwIcsR1XkUnQmNEE4f1Z64dB9MliltiSLA4bk59I8lR0VfX5PbHDBHv6XQY1YH0rnWYC38O/hFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdIhrHRY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdIhrHRY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE001F00893;
	Tue,  2 Jun 2026 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414770;
	bh=oDsUeojZ/0jByt9TWxqCFItT1/kiVczV+0YREHwcMNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdIhrHRYAQyR+hWJYQSx3WgHOAE9EmQlL9SqZTup1moSlE7pdXQ8nl/QA4b2KPveP
	 FZ4hQXl/hD56dBLrBUW+d0DYiZS7Q6JQHmk4PIthScxZNQCQf2Wa/XPCss/tznUG+m
	 SSPoqyuLirIPcnyP+TNQmdxEO3z3vSnCfrAfC+14mgWNl4IAC0iKz3nRNFd/d1ZTrY
	 MGCCkk3Wow8jJG3O2IFrv2k3ENHv/GwaWhcBLnnZZM3MYQLxm+BvL9SMJZb2NTdV1F
	 qsyrjOoej8x/0KoawjYJ4D2bKzI7OB1GLENi7e9UBxe7bUCV+Bokrf8KUCYv4x2wb7
	 dfaRlQMKBjoMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 2/7] perf/x86/intel/uncore: Guard against invalid box
 control address
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zide Chen" <zide.chen@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602144908.263680-3-zide.chen@intel.com>
References: <20260602144908.263680-3-zide.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:39:30 +0000
Message-Id: <20260602153930.BCE001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing memory barriers when publishing and reading `pmu->boxes[di=
e]`, which can cause `uncore_pmu_event_init()` to use a completely uninitia=
lized PMU box.
--

commit a8ebe9f88eb163279373dfcbb348bed622973d26
Author: Zide Chen <zide.chen@intel.com>

perf/x86/intel/uncore: Guard against invalid box control address

This commit adds null pointer checks against the return value of
intel_generic_uncore_box_ctl() to prevent invalid hardware accesses
when a CPU die is offline during uncore enumeration.

> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/i=
ntel/uncore_discovery.c
> index 60e1200c4691d..af7e80fee81fb 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does the initialization of PMU boxes lack
necessary memory barriers?

In arch/x86/events/intel/uncore.c, a new PMU box is allocated, initialized,
and published to the array without a write memory barrier:

arch/x86/events/intel/uncore.c:allocate_boxes() {
    ...
    box->pmu->boxes[die] =3D box;
    ...
}

Because MSR/MMIO PMUs are registered to the perf core before allocate_boxes=
()
is invoked via CPU hotplug callbacks, could userspace concurrently invoke
perf_event_open()?

This would trigger uncore_pmu_event_init(), which locklessly reads the box
without a read memory barrier:

arch/x86/events/intel/uncore.c:uncore_pmu_to_box() {
    ...
    return dieid < uncore_max_dies() ? pmu->boxes[dieid] : NULL;
}

This data race might allow the CPU to observe the box pointer before its
contents (such as box->cpu and box->pmu) are fully initialized or zeroed.
If the uninitialized memory happens to have a value >=3D 0 for box->cpu,
would it bypass the validation check?

arch/x86/events/intel/uncore.c:uncore_pmu_event_init() {
    ...
    if (!box || box->cpu < 0)
        return -EINVAL;
    ...
}

Consequently, a partially initialized box might be associated with the even=
t,
and when the event is later added or scheduled, uninitialized fields like
box->pmu could be dereferenced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144908.2636=
80-1-zide.chen@intel.com?part=3D2
