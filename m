Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAE21D596
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781639129; cv=none; b=VC0pOE8kIkagX/ZO64eUF7l09UXP8ZF8fYzilNZYMdZoP4RzzoOLngUZmKmTPRdmb9h0ku0CN/zCGEZbE9smIZ1SZs20kASObugzHQbffcpcui8PDw+8vRTdEa+Tkx4NF6eUSz/yODyig1zXqRRfUNkoCV3PRIslYHUeyD1EMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781639129; c=relaxed/simple;
	bh=mp/9FskplwArFt/PmwCwX9yGq8CHc7ABG3aQu20nxwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fdRuCh67nShxxV17ludV+kZcMcRGjVPhNx+eXHXz18v4N2Q6NqGcPI35sW4Cw4XCFEB/uV2YfFhBvYt7ThLo62b25Ei7P/CDiqDjXABNarT6S1U7aiohEgbQAXk5cf4jGM8S4/WQRKK7gnFqo83rgFOAaVKuslB1+Ok4ArR8kJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2vxHOJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2vxHOJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C411F000E9;
	Tue, 16 Jun 2026 19:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781639128;
	bh=e2KnuKODUwmI3wQ4tt9yrnN+qwPsGdLIhNSgWIFbLrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C2vxHOJGTem8GhhA223GBkVW0Sz3u0LvGZVmn68zM2SezaGvOCEdPbNYXehdjQx7n
	 E7i90sn7pRTN+3HQ4f5zSzcQP5VRHc2XT8ZOFUlwVhRWiLpDAa+W1cP/kqekStWwJC
	 LgTsqhnMrLt6nklK4rXZIBBhTdy8oOwVVtA7SYs/FjjMuwZihjBfmyOmu3DZ3IqHk9
	 PXC9wIdeqoAEA6rDlh+us/X/XMhbAckSA42ZMENJqxAW+fNl9eMw21RIGUs2f0hT/F
	 k2egH8inT9hbx/0+0aLxG1pJfbtdRIamw5uOkOUjYxOTtfr+6D5PbStXMPNsYJ46Yv
	 GD4Aig85fLthQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] perf cs-etm: Require full global header in
 auxtrace_info size check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616193033.10035-5-acme@kernel.org>
References: <20260616193033.10035-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 19:45:27 +0000
Message-Id: <20260616194528.36C411F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The commit fixes an out-of-bounds read for the global header but l=
eaves identical vulnerabilities in the per-CPU metadata printing and parsin=
g paths. A crafted event with an untrusted `num_cpu` or dynamically read pa=
rameter offsets can trigger out-of-bounds memory reads and information leak=
s.
--

commit d5e67aa605749da8c7ff5a7e9079bf76e63f88c7
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf cs-etm: Require full global header in auxtrace_info size check

This commit includes CS_ETM_HEADER_SIZE in the minimum size check for
auxtrace_info events. This ensures that the global header entries fit within
the event, fixing an out-of-bounds read.

> diff --git a/tools/perf/util/cs-etm-base.c b/tools/perf/util/cs-etm-base.c
> index 4abe416e3febd..aebef71d3a0a1 100644
> --- a/tools/perf/util/cs-etm-base.c
> +++ b/tools/perf/util/cs-etm-base.c
> @@ -170,7 +170,9 @@ int cs_etm__process_auxtrace_info(union perf_event *e=
vent,
>  	u64 *ptr =3D NULL;
>  	u64 hdr_version;
> =20
> -	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE))
> +	/* Ensure priv[] is large enough for the global header entries */
> +	if (auxtrace_info->header.size < (event_header_size + INFO_HEADER_SIZE +
> +					  CS_ETM_HEADER_SIZE))
>  		return -EINVAL;
> =20
>  	/* First the global part */

[Severity: High]
This isn't a bug introduced by this patch, but while this size check fixes
the out-of-bounds read for the global header, does this code leave similar
out-of-bounds reads unaddressed in the per-CPU metadata processing?

When dump_trace is true, cs_etm__process_auxtrace_info() extracts num_cpu=20
and passes it to cs_etm__print_auxtrace_info():

    if (dump_trace) {
        num_cpu =3D ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
        cs_etm__print_auxtrace_info(ptr, num_cpu);
    }

Can a crafted perf.data file provide an untrusted num_cpu without it being
bounded against the remaining event size?

In cs_etm__print_auxtrace_info(), this loops num_cpu times and iteratively
calls metadata printing functions:

tools/perf/util/cs-etm-base.c:cs_etm__print_auxtrace_info() {
    ...
    for (i =3D CS_HEADER_VERSION_MAX; cpu < num; cpu++) {
        if (version =3D=3D 0)
            err =3D cs_etm__print_cpu_metadata_v0(val, &i);
    ...
}

Could this read unbounded parameters and potentially leak heap memory to
stdout?

Additionally, in the parsing loop, cs_etm__process_auxtrace_info_full()=20
calls cs_etm__create_meta_blk():

tools/perf/util/cs-etm.c:cs_etm__process_auxtrace_info_full() {
    ...
    for (int j =3D 0; j < num_cpu; j++) {
        if (ptr[i] =3D=3D __perf_cs_etmv3_magic) {
            metadata[j] =3D cs_etm__create_meta_blk(...);
    ...
}

Inside cs_etm__create_meta_blk(), parameter counts are read to advance the
parsing offset:

    nr_in_params =3D buff_in[i + CS_ETM_NR_TRC_PARAMS];
    ...
    i +=3D nr_in_params + nr_cmn_params;
    *buff_in_offset =3D i;

Since the offset i is advanced dynamically without validating against the
remaining event capacity, could the next iteration of the loop in
cs_etm__process_auxtrace_info_full() read ptr[i] out-of-bounds before the
post-loop size validation is reached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616193033.1003=
5-1-acme@kernel.org?part=3D4
