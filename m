Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC6371897;
	Wed, 16 Sep 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563110; cv=none; b=jYWHwvLP+U8bjgi+A3WigP+3tG6jS2AxzOUT0rEpvacoCIFCmdbUP5NHcWQah8DS/DJ/rueUj7lLOxEWztWti20Zb555bpKFZ016AYYHXJXt5D9F13gSn31iO+FKUFoZ2eo+6sLNNlRhAdumEJFfhjvUE8lbQnlQoU4mKGvPqvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563110; c=relaxed/simple;
	bh=TPQjG+w09wCHruYtAJmv+95BMyhOXGtFraaarwzEmGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bG6B+APvgD0Dw/mOYDatya9bEZ+yJ3JUu2c8m1RipFmvAhUoQvC0RP0VGXqXR90WrJsiEjmcHqv8K9U8VzGfwwdOBnsCLp2wAHKHE91iykUxEVagtt00TxNR1bD1+OZOBeLX084CKtW6HuJb5zlnU0eLC0fZvHcX65AuhUciHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvQDpGg7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvQDpGg7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E96F1F00893;
	Wed, 16 Sep 2026 12:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563106;
	bh=5skq9KdtHxqvy+/GURDRtaDb+8mGgfKxhyoDMzASm/g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lvQDpGg7b9bcTqBridJrwB2uKje++b26mj70H6HXku95fhb0I4eZhvB/ORjPpQM65
	 yQAVg8MxA0+DgybCaHwxu5Vq4CtO00Gd5n9II0dnDoMCf3XWnS9dmwxkiclNcCQeKP
	 CaexOU9xKEw7PrsamrtnAxX1ija05dGTVWjfbOvUtPikt2wL3OaFaRNT/wizpNNGli
	 +Elfn160XRmYu49sstS5IUWG0dJXOHAu92aXQLx2rXDtAQWnZmwUJB61G6V7DdWCdk
	 VXhXUZBdlA/aZCeQbAaY6R+P+d8ZLqHjC1v14RyIjNq69mm7N0/SfhU2FKKd1xjr5Y
	 GoxvZx0vp0xSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd: Reject AMD Merge event as a countable
 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luka Absandze" <absandze@amazon.de>
Cc: kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260916123315.89042-1-absandze@amazon.de>
References: <20260916123315.89042-1-absandze@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:51:45 +0000
Message-Id: <20260916125146.0E96F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/x86/amd: -EINVAL on AMD_MERGE_EVENT causes KVM retry storm
--

commit 74f1b4944fbb968a39b8b39a32bd5ffa921c5814
Author: Luka Absandze <absandze@amazon.de>

perf/x86/amd: Reject AMD Merge event as a countable event

This commit modifies amd_core_hw_config() to reject the AMD Merge event
(AMD_MERGE_EVENT) as a user-visible event by returning -EINVAL. It prevents=
 a
counter's PerfCtl from holding the Merge encoding inappropriately, which co=
uld
otherwise artificially inflate deltas.

> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 49b6b8fce5664..cb655c751e5b1 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -380,8 +380,12 @@ static int amd_core_hw_config(struct perf_event *eve=
nt)
[ ... ]
> -	if ((x86_pmu.flags & PMU_FL_PAIR) && amd_is_pair_event_code(&event->hw))
> -		event->hw.flags |=3D PERF_X86_EVENT_PAIR;
> +	if (x86_pmu.flags & PMU_FL_PAIR) {
> +		if ((event->hw.config & AMD64_EVENTSEL_EVENT) =3D=3D AMD_MERGE_EVENT)
> +			return -EINVAL;

[Severity: High]
Does returning a permanent -EINVAL error here cause an opportunistic retry =
storm
in KVM?

If a KVM guest programs a Large Increment per Cycle (LIPC) event by writing
AMD_MERGE_EVENT to an odd vPMC, KVM intercepts this and attempts to create a
raw host perf event.  When this fails with -EINVAL, KVM's reprogram_counter=
()
propagates the error to kvm_pmu_handle_event():

arch/x86/kvm/pmu.c:kvm_pmu_handle_event() {
    ...
		if (reprogram_counter(pmc))
			set_bit(pmc->idx, pmu->reprogram_pmi);
    ...
}

Because KVM treats all failures as transient and unconditionally re-adds the
failing counter to pmu->reprogram_pmi, on every subsequent PMU refresh KVM
will repeatedly retry the failed counter.

Could this create a permanent retry storm that degrades VM performance and
wastes host CPU cycles?

> +		if (amd_is_pair_event_code(&event->hw))
> +			event->hw.flags |=3D PERF_X86_EVENT_PAIR;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916123315.8904=
2-1-absandze@amazon.de?part=3D1
