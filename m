Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE813F0A96
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190399; cv=none; b=VS8GuBrnFqowboW6XwRwfFC+/LfG87kHJtth0IY4fTDT/HdZp+vYD1PDWZHtiTQbO6wG87Eox/RGWy9YzJ+en8L5/LuqTvdPhqoa0pCIyibishMrQcoWgiQ6tL21oz/8t4E5FWSgEYdcmvc+Ym0XEvxQ7YOHEatGwXR5CwB3f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190399; c=relaxed/simple;
	bh=IIEKDU3lkgZJ9VPdhFXqk1cZs2JwxSnqSU2XoDBJiOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ujux4nTIjTJwZcI7HNFULliUjyv6hWiqU1Q/4CbxOcaXMC9qqtMU+oQdKNVjtpUfnx0lmQtTjwXDET/G7rwIYwHPVZsqTGyP/i2vt9xPNzQpv8mqRf1Tt0VGwIwi4oJcjRAIV2So/oMreOsPx0REIWsydh1Xric3ScJMJ35L80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYVHVl6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYVHVl6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846891F00893;
	Thu, 11 Jun 2026 15:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190397;
	bh=CbONITdoYF8/wpO9bi5xKMPabbm19vJWhS1kXfpt7KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lYVHVl6TKKzESD3F9QNLwz0476Nl2Qh9KLhduvQcYVBTIVedvCWQbqLitMMDAzO/3
	 cnF2qhAqUWNn/n0CQZ2wNFjWQSnVE/rrE0wFKATLowVftemBA2lvut0ujsPD3mP7U7
	 FCP5p8rkO6TWoCNAs2pgHvjTmF0jbwvijCyQqbJppTP5jx4Zxsg6vVph4lwyr3W5nY
	 gT32+c1daIgUoXfjXRZurDckzTcvwJ505Ntu7PRm/gauzl7/Fx2SpSaOT3yu5Iay2X
	 lrpL7zOtX9X1FJpnTkO+gxW4j+W/iy77ROzkUKjTt4LzoRORBCRp7FFVAKI2Ql1e3C
	 0zLeDMpWvqfyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] perf cs-etm: Flush thread stacks after decoder
 reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611-b4-arm_cs_callchain_support_v1-v8-5-737948584fea@arm.com>
References: <20260611-b4-arm_cs_callchain_support_v1-v8-5-737948584fea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 15:06:37 +0000
Message-Id: <20260611150637.846891F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Guest machine thread stacks (including host kernel threads runni=
ng at EL1 when context IDs are not traced) are not flushed during a global =
trace discontinuity when the PID format is CS_ETM_PIDFMT_NONE, leaving the =
original stale callchain bug unresolved for these threads.
--

commit e81263c0c86921f0a88062b716b3451f486dd401
Author: Leo Yan <leo.yan@arm.com>

perf cs-etm: Flush thread stacks after decoder reset

This commit addresses global trace discontinuities when perf resets the
CoreSight decoder. It flushes host thread stacks (and guest thread stacks
when virtualization is supported) to prevent stale call/return history
from producing incorrect synthesized callchains.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8798bf0471faf..7069b4990e610 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c

[ ... ]

> @@ -1997,6 +1997,37 @@ static int cs_etm__end_block(struct cs_etm_queue *=
etmq,

[ ... ]

> +static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
> +{
> +	enum cs_etm_pid_fmt pid_fmt =3D cs_etm__get_pid_fmt(etmq);
> +
> +	if (!etmq->etm->synth_opts.last_branch)
> +		return;
> +
> +	cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
> +
> +	/* Clear the guest stack if virtualization is supported */
> +	if (pid_fmt =3D=3D CS_ETM_PIDFMT_CTXTID2)
> +		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);

[Severity: Medium]
Will this leave guest machine thread stacks unflushed if the PID format is
CS_ETM_PIDFMT_NONE?

When no context IDs are traced, the fallback logic in cs_etm__get_machine()
assigns EL1 traces to the guest machine:

tools/perf/util/cs-etm.c:cs_etm__get_machine() {
        ...
        switch (el) {
        case ocsd_EL1:
                return machines__find_guest(&etmq->etm->session->machines,
                                            DEFAULT_GUEST_KERNEL_ID);
        ...
}

Since the flush here is strictly gated on CS_ETM_PIDFMT_CTXTID2, does this
skip flushing those threads and leave their original stale call/return
history unresolved?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-b4-arm_cs_=
callchain_support_v1-v8-0-737948584fea@arm.com?part=3D5
