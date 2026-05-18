Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F444D693
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122833; cv=none; b=gdJiyf0OolUwKMoiyYCxhDx/UYWvk/MSFW3+BWwPW+qjNTyRIAjf7wGcHTYR0I8ZKGALsUp4ck47+gKIZJq0Sx+pYxIeB8qA2ZOlQ4jFHsEd+rwehlbz42sK9mjp2b5b/9TrBUzOlqiRQuzyZh1bXvIBpSZN65JBUBW3CvE0Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122833; c=relaxed/simple;
	bh=vExJwZ1Fi/U6qrDvUw1g3cvUUpAk4rFfP72WbVGunzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FZahp7nwHK7+6W5rjECHzex1Y6cOv5aAjoEAHNme9h5JLduLVGn2awqWyVWlEQHg23ETXPFNwGATEJAWqDGe735OkwvF/hLuIMLFxf3T22G9c8n/1N+2p5EML39LR/jy+PO9CpTG45bGmSsL6RII04yVGCTys/a/9jEFEDv5ezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug3gpQYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug3gpQYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4708FC2BCB7;
	Mon, 18 May 2026 16:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779122833;
	bh=vExJwZ1Fi/U6qrDvUw1g3cvUUpAk4rFfP72WbVGunzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ug3gpQYuZdukgvhdXbn2LA4zRsA4W3gKbwGD9pSDQ9IfKSn8rzjds5kTgTrytrsCP
	 inUwnUYscOOIYWNMD/HMvZQDC1OqfUrituM+M+vSN2/yP6+hN1AvvRMzkx8HI2n7Z3
	 L1DJLImT6pcFWWfD4h0zTVbWpPT2OnSiboSg31e/pig7S5FOOE5bpU5mxpmtlXlN4y
	 ux3mG+si8x3IVye8kAkDQx3lMWAiK52j81hKTafxL7L3OJZ032AA9O0rjAGHuk3hTK
	 OzsXAl8iDGI/g2zOSEoj9OCO0Bj2hZG55EGpQO42oomm3/TyXAFx5NDR5dmcSFiLlD
	 iD8AIi//4kV1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260518153754.2795820-3-irogers@google.com>
References: <20260518153754.2795820-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:47:12 +0000
Message-Id: <20260518164713.4708FC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Size mismatch in synthesized attributes causes downstream pars=
er out-of-bounds reads and data corruption.
- [Medium] Missing implementation of intel-pt.c bug fixes claimed in commit=
 message.
--

commit 9f4d44a4d4fc78e9089af666b1106f4abf4ea03a
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

This commit addresses multiple issues in the generation of synthesized
branch stacks from AUX data. It adjusts sample types, fixes size
calculation bugs, prevents event truncation, and introduces safe handling
of read-only maps in perf_event__repipe_attr.

>     1. The synthesized samples were delivered without the
>        PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
>        sample_type. Fixed by using sample_type | evsel->synth_sample_type
>        in intel_pt_do_synth_pebs_sample.

[ ... ]

>     6. NULL Pointer Dereference in intel-pt.c: Addressed by updating the
>        condition in intel_pt_do_synth_pebs_sample to fill sample.
>        branch_stack if it warrants synthesis, even if not in the original
>        sample_type.

The commit message explicitly mentions fixes in
intel_pt_do_synth_pebs_sample() within intel-pt.c, but the patch does not
contain any modifications to that file.

Were these changes accidentally omitted from this patch?

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5f06ee1c14a08..2c17b652308f6 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c

[ ... ]

> @@ -231,7 +242,28 @@ static int perf_event__repipe_attr(const struct perf=
_tool *tool,
>  	if (!inject->output.is_pipe)
>  		return 0;
> =20
> -	return perf_event__repipe_synth(tool, event);
> +	if (!inject->itrace_synth_opts.set)
> +		return perf_event__repipe_synth(tool, event);
> +
> +	attr =3D event->attr.attr;
> +	if (event->header.size < sizeof(event->header) + event->attr.attr.size)=
 {
> +		pr_err("Attribute event size %u is too small\n", event->header.size);
> +		return -EINVAL;
> +	}
> +	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids /=3D sizeof(u64);
> +	ids =3D perf_record_header_attr_id(event);
> +
> +	attr.sample_type &=3D ~PERF_SAMPLE_AUX;
> +
> +	if (inject->itrace_synth_opts.add_last_branch) {
> +		attr.sample_type |=3D PERF_SAMPLE_BRANCH_STACK;
> +		if (attr.size < PERF_ATTR_SIZE_VER2)
> +			attr.size =3D PERF_ATTR_SIZE_VER2;
> +		attr.branch_sample_type |=3D PERF_SAMPLE_BRANCH_HW_INDEX;
> +	}
> +	return perf_event__synthesize_attr(tool, &attr, (u32)n_ids, ids,
> +					   perf_event__repipe_synth_cb);
>  }

Can this cause size mismatch issues downstream?

By performing a fixed-size struct copy attr =3D event->attr.attr, if the
incoming event's attribute is smaller (e.g., PERF_ATTR_SIZE_VER0), this will
copy the trailing id array into fields like branch_sample_type.

Then, when passing it to perf_event__synthesize_attr(), it hardcodes the new
event's header.size using sizeof(struct perf_event_attr) but leaves
attr.size as PERF_ATTR_SIZE_VER2.

Could downstream parsers calculating the number of IDs:

n_ids =3D (event->header.size - sizeof(header) - attr.size) / sizeof(u64)

end up hallucinating extra IDs because header.size accounts for 136 bytes
while attr.size is 80?

If the original attr.size was larger than 136, could this calculation
underflow to a negative value, causing the parser to read out of bounds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518153754.2795=
820-1-irogers@google.com?part=3D2
