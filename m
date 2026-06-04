Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8247394497
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607345; cv=none; b=ulzYw8heTEXWoMaBK+IYYQFKEKJilZCo8j9HcNse7CSKv8QsncbTdY0KxMuHQvriuMc45jELDbaaI2v9bRviHczeHz++ccFLTg48zeAGJqxnIbj4zJmcHK1h7SkqPDeV+xo6lTgDtaH1aWPPMSbzhV+07no3jtL2kCt8S/9iCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607345; c=relaxed/simple;
	bh=AGGsXXtAqRcuEIRTKN4rfaoQeAiiPERjE2bZv0aSGTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7eK31knc9lx/nudlt3W3IkEyI8vnnVpsp+yTpkDKL4fB8oWQEe6jiQQQefRyLiwWFfBM6hQJpzJukJA5gAlMdExWjrTj0GWPvnLNkiGyA2ajXrlN+QEuVJr5+dcDIIlB0ZuAmjYIn+aebYzF2db9EGbo4RmEKLP4tDx04Oa3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfxwFqKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfxwFqKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468941F00893;
	Thu,  4 Jun 2026 21:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607344;
	bh=xhPH/KmzQ4tAwGHSQgGkLnzXPnOvz4v+k8V4MESALq8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IfxwFqKR25RHgsgAyK1ObzWHxRrAt/8/nhWf4G2l43qVKuJh1XNtoKH3vuJRHQfsU
	 35wiiIFEhG4pX/eplNglskXa8ACLoi4NUbx2dazfFTaVZwN5w9KhXu8xC2NUDBPCcS
	 aZ9AYLCRDXYKPEhfEHiEIpyp0XIdP6aPcuJzIc0V0VlQzc11wqYcc8rHzc4tNMCKab
	 4T1Ppzstsgnk1wYuLjFjbes4UHf/vSjS/zdQ3seQdQ4IwmG9WQzHRZVhuuEiDu1+sD
	 QKDdC4lEnD41VXV7Hj2g+KcYich7cin9vFIdi01d21Xy7R6PEK4imL6rxigcSIlgFd
	 AowuNINnSbhWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf tools: Guard test_bit from out-of-bounds
 sample CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260604204921.1707333-2-acme@kernel.org>
References: <20260604204921.1707333-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 21:09:03 +0000
Message-Id: <20260604210904.468941F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch adds `MAX_NR_CPUS` bounds checks to several call sites o=
f `test_bit()` to prevent out-of-bounds reads from corrupted `sample->cpu` =
values, but misses an identical vulnerability in `tools/perf/util/auxtrace.=
c`.
--

commit 086b55e55838d35a34eaf71d763ccfabb74ba9a3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Guard test_bit from out-of-bounds sample CPU

This commit adds guards against MAX_NR_CPUS before test_bit() calls across
several built-in tools to prevent out-of-bounds reads on corrupted
sample->cpu values.

> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index b918f9eed5fd2..8a0eb30eac24f 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -295,7 +295,8 @@ static int process_sample_event(const struct perf_too=
l *tool,
>  		goto out_put;
>  	}
> =20
> -	if (ann->cpu_list && !test_bit(sample->cpu, ann->cpu_bitmap))
> +	if (ann->cpu_list && (sample->cpu >=3D MAX_NR_CPUS ||
> +			     !test_bit(sample->cpu, ann->cpu_bitmap)))
>  		goto out_put;

[Severity: High]
This isn't a bug introduced by this patch, but does a similar out-of-bounds
read of cpu_bitmap exist in tools/perf/util/auxtrace.c?

Looking at filter_cpu() in tools/perf/util/auxtrace.c:

        return cpu_bitmap && cpu.cpu !=3D -1 && !test_bit(cpu.cpu, cpu_bitm=
ap);

Since auxtrace events can bypass the upstream clamping logic in
perf_session__deliver_event(), could a corrupted cpu value from a
perf.data file exceed the bitmap size?

Should filter_cpu() also verify cpu.cpu < MAX_NR_CPUS before calling
test_bit() to prevent reading past the allocation?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604204921.1707=
333-1-acme@kernel.org?part=3D1
