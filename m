Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD357ED91
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970340; cv=none; b=rbiNTQfCkta9HYkQtg25SO18Y2MxBJu/nHs+5U0GRVjxkpFU8zKFD+0yQEWJdAeDu7n41JtKIRbIXgMtdKY8mB67Mwue0ceZKPXv7vwG85gpsf2/OtiKSelEqM2ggSuuyyMFvxQ84UZIAdAUSYlwAaU3bCZehc1zLujrQHal48Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970340; c=relaxed/simple;
	bh=jDvze47RTIlSlQSBtRSj4tA7NRzYu31aW2Dzoy9dDck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VZ23srIVLubeC2EGsPyUK1XVzGn4+v9iyV3yDpiYjTJP/TbpsC62kD2UzsaAsPZH5A3syeIsZfkn/bUFh9Nv7KuRVTU7OPHAK3NU8rAyYKxAXWf7BuJUXb80PIPOZLo2fy8sUOVXauwC4uFiGk45gxblJBwkBYtD1/ebUKmYhcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+gs9ixt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+gs9ixt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4351F00A3D;
	Wed,  9 Sep 2026 16:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970338;
	bh=c0YwbXwLEconuY4IojKYe3wkpuM/kxg95M5Ki+MvbPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+gs9ixtzjdRABwDCa1dTs3+ApJKq5YjPRwiP8xM9aGCN5giQCIhmsO+4WZMxJ+Ie
	 Eh1dX1y7t0EmZuechwBq21aqQ8yISnn1x5dutpXBuZQOD7JVsijPgbKS8H6dlNtHrY
	 yBg/5TCFLsIupwX9GVHRberI9SUEcxRm+C80ljv+1n0He80JWTUMORV3/RLpMEQjcg
	 ctMp4bQ+/cDRJjYRVOz5FuvUibOD7zHTn4VC/Y7X0Rrx+mM9L3IW0oSajBKxBMSt65
	 SZlQEijGkbQlHIm1Iljh6Mk/io/vL9mID3p3FD9VM9I0mPJaGilL/cJpwC8xN3JKSJ
	 Qatnp0MVbqIUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260909160218.174928-2-thomas.falcon@intel.com>
References: <20260909160218.174928-1-thomas.falcon@intel.com>
 <20260909160218.174928-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 16:12:18 +0000
Message-Id: <20260909161218.BD4351F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unsafe string formatting and size tracking in `perf_script__me=
minfo_scnprintf` and its helper functions lead to severe integer underflows=
 and stack buffer overflows.
--

commit c7ba4f7e986e052ba237f51f607c40edec278ce2
Author: Thomas Falcon <thomas.falcon@intel.com>

perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fcc..4e490f9cd3488 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);

[Severity: Critical]
This isn't a bug introduced by this patch, but since the patch attempts to =
fix
size tracking, are there still missing bounds checks and integer underflows
here?

If i >=3D sz because previous helper functions return a length greater than=
 the
remaining size, the calculation sz - i underflows to a massive unsigned val=
ue,
defeating the bounds tracking.

Furthermore, inside perf_mem__lvl_scnprintf() and similar helpers, sz is
subtracted and unchecked strcat calls are used, which can result in stack
buffer overflows:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
	...
	sz -=3D 1; /* -1 for null termination */
	out[0] =3D '\0';
	...
		if (data_src.mem_remote) {
			strcat(out, "Remote ");
			l +=3D 7;
		}
	...
		if (printed++) {
			strcat(out, " or ");
			l +=3D 4;
		}
		l +=3D scnprintf(out + l, sz - l, mem_lvl[i]);
	...
}

If sz is 0, sz -=3D 1 underflows to SIZE_MAX, and a null byte is written ou=
t of
bounds.

The unchecked strcat writes past bounds, and the unconditional increment of=
 l
causes the inner sz - l calculation to underflow, disabling bounds checks f=
or
subsequent scnprintf calls.

Can a maliciously crafted perf.data file trigger this overflow on the stack
buffer in data_src__fprintf()?

>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");
>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909160218.1749=
28-1-thomas.falcon@intel.com?part=3D1
