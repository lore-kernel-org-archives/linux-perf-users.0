Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481521;
	b=5nS7SPzXkqmA+GvA9qiUUQz5pN0bjdzxZ/OpNTY7TG9GdFDdpHgeazSBJTDQoRBasa9F
	 K7VozW7QioWFCzorBQWc4bgOXnYO/euW166vdsG2yJmeea0dho3PtP2BZpstB1v4td2UW
	 W6mTgilRZLZY/L1wZFuqhqyoNw+V4bypF2dLNYvNFl8ZLMQO4tfnC3Sel03v8gtsnxxWr
	 BrsKetwJjtt2Wjmy5z0v3hWcGyLfUsAfmCX09BxRE5r6M/ot3+AU1mOgqgJY2xJ9knQcp
	 KEAXCJ/3ol9wf51qKdNVaIMy+W1uFLyifAoSDXqEEYXE5XRlZxWMBpskTU+2GmfspcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481521;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cMuTBRllS9iEE31lCe0NADjDs33NKJp62ZH34fgqRlQ=;
	b=i24B5tzH4s0T0i+b97xmcG29LKUS/Gv6uUJxnlkehrnPMstWZroxulOCGzZVf/8K5C93
	 ZVdrzZxVw0YWm/Tnam0/TLhLuyTFExuDWT3Oxf247TH117K/vPBNNqHhex+BjTmrpofGp
	 X3oeF9rMl/P1278xqQwhCTWINHmRtSTsL8NWvxP7KtovULE7q4cK5Tny/kWa13FCHOmee
	 Vfzuh6EpuDPJwtzMhSicRbzJBfb+w77Xe81G3HNjru4+toYzFYxJ6uCkp/SxhmZqwlTHv
	 VZxcVoprHoWH2CLBo+H+THdLsxtKbPTcEEgVUZ0LtlPX+bQ/g383onpqG4ZhkENVong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0xWmqSP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5217606A31E;
	Tue, 24 Nov 2026 00:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0xWmqSP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB871F000C0;
	Tue, 24 Nov 2026 00:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795481520;
	bh=cMuTBRllS9iEE31lCe0NADjDs33NKJp62ZH34fgqRlQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0xWmqSPlAqRq9AOfMxV7xVfrcmg3QfwzCFi2aFafvSaETcog09B8bLr75vZRN501
	 WkKoU6HMiRqbuTwD4TXBDyYmc8IqxsX/dnw9gLXmE5nnjYMXVnEZ0WixSkIpBiqSIo
	 xDlEoc4mpnuyjkOn1yUQLZGmVDkpf9Xujzgb0rgP3mn/9ZseEgvIJRhGfC8zw00Vag
	 tAI/dIkH/rItJWlceeIDR7Ud82kChtBGp80X2r0cwcAeJzNL63owC3zLo+/jl0Mnk0
	 EQJcLSVAmRamRWZis2qjS2hB7rnpMdzPzcJbtjahH7UQFywmndO6LqyZWGzaiPBM6d
	 dXeVhbvtoLQOQ==
Message-ID: <sashiko-outbox-230318@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/26] perf: Track mediated PMU conflicts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261124002303.1785363-11-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-11-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 00:52:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf: missed conflict accounting for grouped events in
  account_mediated_pmu_conflicts()
--

commit d02999449ac3f60478e5b2d635e9ec7e78dbd825
Author: Yosry Ahmed <yosry@kernel.org>

perf: Track mediated PMU conflicts

This commit tracks perf events that conflict with a guest mediated PMU in
perf_event_context and exposes perf_has_mediated_pmu_conflicts() for KVM,
marking Intel PT and Intel BTS with PERF_PMU_CAP_USES_MEDIATED_PMI.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 99aa56ced8253..33422b92dc0db 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1989,6 +1989,22 @@ static inline bool has_inherit_and_sample_read(str=
uct perf_event_attr *attr)
>  	return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
>  }
> =20
> +#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
> +static void account_mediated_pmu_conflicts(struct perf_event *event,
> +					   struct perf_event_context *ctx,
> +					   int nr)
> +{
> +	if (event->pmu_ctx->pmu->capabilities &
> +	    (PERF_PMU_CAP_MEDIATED_VPMU | PERF_PMU_CAP_USES_MEDIATED_PMI))
> +		WRITE_ONCE(ctx->nr_mediated_pmu_conflicts,
> +			   ctx->nr_mediated_pmu_conflicts + nr);
> +}

[Severity: Medium]
Should account_mediated_pmu_conflicts() check event->pmu->capabilities
rather than event->pmu_ctx->pmu->capabilities?

Both Intel PT and Intel BTS set task_ctx_nr =3D perf_sw_context, so
__do_sys_perf_event_open() gives their events PERF_EV_CAP_SOFTWARE.  When
an Intel PT or Intel BTS event is grouped with a non-software event on a
PMU without PERF_PMU_CAP_MEDIATED_VPMU or PERF_PMU_CAP_USES_MEDIATED_PMI
(for example via aux_output or move_group), event->pmu still points to
pt_pmu or bts_pmu, but event->pmu_ctx->pmu points to the other PMU:

kernel/events/core.c:__do_sys_perf_event_open() {
    ...
		if (is_software_event(event) &&
		    !in_software_context(group_leader)) {
			pmu =3D group_leader->pmu_ctx->pmu;
		} else if (!is_software_event(event)) {
			if (is_software_event(group_leader) &&
			    (group_leader->group_caps & PERF_EV_CAP_SOFTWARE)) {
				move_group =3D 1;
			}
    ...
}

In that case ctx->nr_mediated_pmu_conflicts is left at 0 while the PT or
BTS event is installed, so perf_has_mediated_pmu_conflicts() returns false
and KVM leaves the guest mediated PMU context loaded during slowpath
VM-exit handling.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124002303.1785=
363-1-yosry@kernel.org?part=3D10
