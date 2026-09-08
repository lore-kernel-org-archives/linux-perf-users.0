Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DA5616DC
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873309; cv=none; b=a9CauPCSI+eVc8023E7DwV9DiA/0Ns5kADsRpZeHKXK9VSn43q6k+8X3bb/KweEy06KjJcHA2iYXCvRh5VebJlut/WqpSoOi+oGKQDGTmja6H0XtAoKnLBFap6XS0KBrXzK2zI9cctqCw/1KynRmCK0q2REz1+zZuC4LCCpSGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873309; c=relaxed/simple;
	bh=4O3Y9M64OcKkuefVVo9+pWmvw+RyKny5TCwoX3oingA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TMl6CID60Eaylw/aGNJdHkxNBT10KQZv6cj3XUI3xkSEzy01lQNd0EKijpzNxxjoV4aXN7aXZKWSbWAGJP0mCEBLev0VyLieGpOGDIy+V40NkSZRpgevQOtcjuBC4Vd0NRu7HwNGEYZZQ+PzevKw8Zmyy1GNs0BjHI7LzK0O/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbrAwGgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbrAwGgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916951F00A3A;
	Tue,  8 Sep 2026 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873300;
	bh=3uYhdVB4JFNdWtkccDFURK95ssN/ZSOoxvdlY6oVST0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FbrAwGgR/W5uqRD1X/qv/7qbh4OQRKoIkkWHdsKoMwTJX2Sz6ayxp8uk8trPZLGRV
	 BXDUaPx7NDCFI54lrBZdtydkhYKoxgdXxwRhaCbx21fS69r+lxKZT4Q2vfaxWBzm09
	 dmvVrxKduzVNfsVoYDsJrWp3sAbSgAPevOwa1qg0n5Xg0/B2n85pPzGAM4WCxs5mfj
	 xx5yxj8YXdT5Y3074YypgqtAVFnWmPsrbLVdE2qvP01ZmvpM6/01xcr2vFkWrskmpb
	 Blbibh+v50dv98LL35GsoaNMNVisna/dSCOGac3Gbp7vVilLkH7yeoymreCw3zFfu/
	 aqcXCSRhqJ47g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/26] perf annotate: Default to --itrace=i1i for
 data type profiling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a30bf174539765875129c06381932702934fd0c9.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a30bf174539765875129c06381932702934fd0c9.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:15:00 +0000
Message-Id: <20260908131500.916951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The default_single_event_per_ip option is explicitly ignored for=
 Intel PT, Intel BTS, and CS-ETM decoders, leading to skewed data type prof=
iling statistics on those PMUs.
--

commit 177095456668310745d79faec9f1ed30c358ec07
Author: Tengda Wu <wutengda@huaweicloud.com>

perf annotate: Default to --itrace=3Di1i for data type profiling

This commit introduces a `default_single_event_per_ip` option to the
`itrace_synth_opts` structure. It aims to prevent duplicate sample counts w=
hen
data type profiling is enabled by synthesizing at most one event per IP,
avoiding skewed statistics on hardware tracing PMUs.

> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 114b3cd2da495..2d1ab34f7b6b5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -3626,7 +3626,7 @@ int cs_etm__process_auxtrace_info_full(union perf_e=
vent *event,
>  		etm->synth_opts =3D *session->itrace_synth_opts;
>  	} else {
>  		itrace_synth_opts__set_default(&etm->synth_opts,
> -				session->itrace_synth_opts->default_no_sample);
> +				session->itrace_synth_opts->default_no_sample, false);

[Severity: Medium]
Does hardcoding false here defeat the purpose of the fix for CS-ETM traces?

When perf annotate --data-type runs without an explicit --itrace option,
cs_etm__process_auxtrace_info_full() ignores the new
default_single_event_per_ip configuration.

This causes CS-ETM to synthesize both instructions and branches for a singl=
e IP,
duplicating sample counts and skewing data type profiling statistics.

Should it pass session->itrace_synth_opts->default_single_event_per_ip inst=
ead?

[ ... ]

> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 02df3e4604891..4c9cca3acb6ca 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -877,7 +877,7 @@ int intel_bts_process_auxtrace_info(union perf_event =
*event,
>  		bts->synth_opts =3D *session->itrace_synth_opts;
>  	} else {
>  		itrace_synth_opts__set_default(&bts->synth_opts,
> -				session->itrace_synth_opts->default_no_sample);
> +				session->itrace_synth_opts->default_no_sample, false);

[Severity: Medium]
Similarly, is there a specific reason to hardcode false for Intel BTS in
intel_bts_process_auxtrace_info()?=20

This explicitly ignores the single event per IP option for BTS profiles, wh=
ich
may also lead to skewed statistics.

[ ... ]

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 9d6628169fd95..8c21c9f52d572 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -4463,7 +4463,8 @@ int intel_pt_process_auxtrace_info(union perf_event=
 *event,
>  	} else {
>  		struct itrace_synth_opts *opts =3D session->itrace_synth_opts;
> =20
> -		itrace_synth_opts__set_default(&pt->synth_opts, opts->default_no_sampl=
e);
> +		itrace_synth_opts__set_default(&pt->synth_opts,
> +					opts->default_no_sample, false);

[Severity: Medium]
Does Intel PT also need to support this new option?

Hardcoding false here in intel_pt_process_auxtrace_info() forces Intel PT to
ignore opts->default_single_event_per_ip. This allows it to synthesize
multiple events per instruction (such as transactions or ptwrites), which c=
an
distort data type profiles just like ARM SPE did before this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D10
