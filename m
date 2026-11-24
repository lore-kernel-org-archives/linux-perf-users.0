Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795481119;
	b=GrlyB3/AYyd75NrNfco0UdRHk7oSrCfyKhs1eLSC5NkLGui+5M3XzmJJiQb2R9fpztFp
	 pmMVTBMgaIn0aNXHi45iVDfvwRmlC6VMp7b/ixNnJjUYNttczQWJH1FKbgQOWMy7LE0No
	 YsgpnDVOYn9uTlGDnRfPAyJ6ePCDXjeY6BNeuFGNrKF9RUIeXpxvUo54ndDhIn1uFMd+H
	 6sI9x7H6Y2rq0paXSZZ4bms477PoYMOAW9jFJ/CLnu8F953TO7hS3ovbikzlFpW4oRUVH
	 7GNw4+MO9pECFis6hrbQzRFz31IUiOvdePaEIbEEodQlreBZAFihmL4H25NDxl858aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795481119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yyDhdgujbPX0l3lQmsTDPSCtdDAWkRVBlqZhTWoZoHE=;
	b=Qx54zoxUAhxkmx8nFJcN5HR2ru9V+qrbz2htWNX156BCM8avEgBfcKbx9M2Mbn2VzXno
	 t8Nd4l/Ey1jy60vStMT7VyfBDucNzIVLaT0hkWwkpCMTViOymx3scCUuW7XGyXp2ub0z5
	 ked14v+4zRYikS+m0JotjHMiqebNH+ct6tHdiGwaNJshkn1DFehyamlgDvbW7YbKBV1BV
	 4mqunsITFqV1kGPG7oUPMV3JvfDfwxdcwKyTn5pLzOEXe+egqGUp5wxj9h3SyH0bmS/m+
	 swWTE2Cf1lsXIqCtrWCrRyrnmfMOP4QUlzd0+VzdEzckukj3A0f+f0qeL6841abKw8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpyGGxAN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A218606A32A;
	Tue, 24 Nov 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpyGGxAN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2AC1F000CA;
	Tue, 24 Nov 2026 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795481119;
	bh=yyDhdgujbPX0l3lQmsTDPSCtdDAWkRVBlqZhTWoZoHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpyGGxANyWbMcfA27xLP3PNn7yiB9VronFMNZRGFu5vwcuD5BiEKHYNjcTGkebrtQ
	 O0oteHxEQtJhfxkWdXS84ozQBqjgJXG1Mo2BpX57BAGQqiXIxHV/6lK68Rq5tiK2nh
	 A+/gUOQcl03wC3Q+nYUEodNea7Xl872I1Hh0o6sYpbqjZffn77ZGt+NiGfUjwKMZF2
	 9C92YqETiQZlRVmlDC6lZz4CLFNt52u95b21+tHUgI0rp4fVS0Vd8kP+ozVOU87a1W
	 h8IRW8liano8KS7Pl+wC25Ok4CX9LCqS4xzCMPk8f14AnuX1vY1IlrqJGeS5Az3Toc
	 eGu8NnVNokQvQ==
Message-ID: <sashiko-outbox-230300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/26] perf/core: Don't subtract guest time for
 events that keep counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20261124002303.1785363-3-yosry@kernel.org>
References: <20261124002303.1785363-1-yosry@kernel.org>
 <20261124002303.1785363-3-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 00:45:18 +0000
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
- [High] perf/core: NULL pointer deref in
  perf_event_exclude_guest_time()
--

commit db83e3f1bd6bd93912ce35d2e1ee8eb8daf9be37
Author: Yosry Ahmed <yosry@kernel.org>

perf/core: Don't subtract guest time for events that keep counting

This commit restricts guest time subtraction to host-only events in a
mediated-capable PMU context so that events in non-mediated PMU contexts
do not have guest time subtracted while they continue counting.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6f076e5483cb7..5a3e40155ce70 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -872,12 +873,22 @@ static_assert(offsetof(struct perf_event_context, t=
imeguest) -
>  #define T_TOTAL		0
>  #define T_GUEST		1
> =20
> +/*
> + * Exclude guest time only for host-only events in a mediated PMU contex=
t, as
> + * those are scheduled out while a guest with a mediated vPMU runs.
> + */
> +static inline bool perf_event_exclude_guest_time(struct perf_event *even=
t)
> +{
> +	return event->attr.exclude_guest &&
> +	       (event->pmu_ctx->pmu->capabilities & PERF_PMU_CAP_MEDIATED_VPMU);
> +}

[Severity: High]
Can event->pmu_ctx be NULL here when reading a revoked event?

When perf_pmu_unregister() detaches an event, __pmu_detach_event() puts
and clears event->pmu_ctx while event->ctx remains valid until the last
file reference is dropped.  If an event with exclude_guest=3D1 is held in a
BPF_MAP_TYPE_PERF_EVENT_ARRAY map after its PMU is unregistered, calling
bpf_perf_event_read_value() reaches perf_event_read_local() ->
calc_timer_values() -> perf_event_time_now() ->
perf_event_exclude_guest_time(), causing a NULL pointer dereference on
event->pmu_ctx.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124002303.1785=
363-1-yosry@kernel.org?part=3D2
