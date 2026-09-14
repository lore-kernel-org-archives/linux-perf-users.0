Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF6C47D463
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395135; cv=none; b=izf95NUNrctHT2Z9bQ+chqmo5gejvMtSuJdCJU/cwTdvqz19ncp0kIfxTOUF0wgoPuYOc8IlbDumbbSD+Q7f0i1HitedzhadlrtkMoaR0NhF99WXqM7adaqR7HjyAHjQMf2QLMAfxd5mWgmcp1/q86czrw48ikfoFm7tL68+GWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395135; c=relaxed/simple;
	bh=I9bZanExW1ImjOD8wx6uOyrB4k3v6spRcTHzS/Pc2Nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V+bmQW95OFXOs94so+fCbSb0Hu2NRZhDhLzeSSX1rBIE4o7nLXhPrc45JiIpJWrrTx0KWPHkavFcEp0/WtuBFz/V5jqD7kcsEsmquIj+ue/N87BUEE/lGuyy0eX+9+u51njY6+BftU2H024a5s8DcWcrOUGeYvUkVshHcYv2be0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKqeOUb+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKqeOUb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FA21F000FF;
	Mon, 14 Sep 2026 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395118;
	bh=VRJlB+mVEEoiJJ9luX2RkcCH5yeiQcjxwnPlZKYfXBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKqeOUb+xWaG20R0mIGaT4bqIrNmhgA1baEt/IcvAJ0DaGQcQt7+yb00j2T+kumrp
	 haLFFgErNAu4R3oK6MaRw5Y5XYepoIrRE9ntMwkskQ5L9zDQuVxBOqdbf1dTbdrsr9
	 S3e3FgkdMJJpq2x5tq/GMin9GxxFepVxnN/w9d0/hzDqHQWDemFjWVWIesjFRi94Im
	 /VhEnd1P34LiVGN/xMb5ry+ObESBFDR7HWKsgL8zmmxM6hDajzmSL5Ge4FT/pBDgZW
	 Q58JJLfLIgOYjgxa89XlT7OgzzJAx4ifblyt6ZBWblaK2S2aeSPUZP1aacxbmchBlp
	 lU7JojZN98IeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914125451.2045-9-acme@kernel.org>
References: <20260914125451.2045-1-acme@kernel.org>
 <20260914125451.2045-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:11:57 +0000
Message-Id: <20260914141157.C1FA21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow when constructing `rec_argv` in `builtin-c2c.=
c` for systems with a single memory PMU and multiple memory events.
--

commit 6b306f5272233833a7987c9e447a8e3a91ccaf75
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf mem record: Request PERF_SAMPLE_CPU by default

This commit enables requesting PERF_SAMPLE_CPU by default for perf mem reco=
rd.
It allows the false-sharing detector to distinguish between reads and writes
from different cores and same-CPU traffic by providing a valid cpu field.
Additionally, it explicitly increases the rec_argv array allocation size to
prevent buffer overflows when adding these extra arguments.

[ ... ]

> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 6101a26b3a781..6f38cda1a45ad 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -99,8 +99,13 @@ static int __cmd_record(int argc, const char **argv, s=
truct perf_mem *mem,
>  	argc =3D parse_options(argc, argv, options, record_usage,
>  			     PARSE_OPT_KEEP_UNKNOWN);
> =20
> -	/* Max number of arguments multiplied by number of PMUs that can suppor=
t them. */
> -	rec_argc =3D argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
> +	/*
> +	 * Max number of arguments multiplied by number of PMUs that can
> +	 * support them, plus the arguments added directly below, at most:
> +	 * "record", "-W", "-d", "--sample-cpu", "--phys-data",
> +	 * "--data-page-size", "--all-user" and "--all-kernel".
> +	 */
> +	rec_argc =3D argc + 8 + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1=
);

[Severity: High]
This isn't a bug introduced by this patch, but since this explicitly fixes =
an
allocation under-sizing here, should a similar fix be applied to the
copy-pasted code in builtin-c2c.c?

In tools/perf/builtin-c2c.c:perf_c2c__record():

        /* Max number of arguments multiplied by number of PMUs that can su=
pport them. */
        rec_argc =3D argc + 11 * (perf_pmu__mem_events_num_mem_pmus(pmu) + =
1);

        rec_argv =3D calloc(rec_argc + 1, sizeof(char *));

        ...

        for (j =3D 0; j < argc; j++, i++)
                rec_argv[i] =3D argv[j];

If a user runs perf c2c record -e spe-load,spe-store,spe-ldst -u -k on a
system with a single memory PMU, rec_argc scales as argc + 11 * 1. However,
5 fixed flags are added, followed by 6 event flags (2 for each of the 3
events), and then 2 optional flags (-u, -k).

This totals 13 flags added, which would write 2 pointers past the allocated
bounds in the final loop. Since this also overwrites calloc's implicit NULL
terminator, cmd_record will then read out-of-bounds.

Can this heap buffer overflow crash the perf tool?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125451.2045=
-1-acme@kernel.org?part=3D8
