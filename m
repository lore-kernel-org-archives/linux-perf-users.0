Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26CF3A6B6C
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213339; cv=none; b=X3C6B79Bh6Et1Cn82ptKFHMWqZ3mD0YzAoK0AJU4dGMbwTjGb3ggnj/+UFILeG6jQCJSxWlHUI9jcGliH3VQy0jhIOze4Km6GBAER30Kq9ukdZFQiLBWEnMR9BiDPx8+lQ2obRAKsQK/HWugVTO4Ce705fZyT3gJ/k7PFDRoMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213339; c=relaxed/simple;
	bh=tUSoo9JdCLHzPDsRkNXY/ljmCaEa1BiJxFtxjciklwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uflvWtTjhZ6GR1UYNrUXrVYkv176+M7wyX4diW5UV7nT2bQc2A4Yf9riGlBsh2zmMAzc811d31F/fTcXxNiwyMr6dKpVL1i2qZA5nYEe7DRL0/Uw1zmb/0zYWmHg3HZVxDdtxuW+ifmYy4QYeaMC2VeOj4iGmeG8jkhw6aH20Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l87HWevw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l87HWevw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC761F000E9;
	Mon, 31 Aug 2026 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213334;
	bh=E7xVLACHTpLFDXVKU2+cJTuBgV9H2ajO3dj0Gjin9sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l87HWevwW7TPakGHS+cLIg9O8RveZALcCUK76oGQClRkPZ5zia5u7S8ECZweUefR0
	 JD0mKolypviuvavxbSVcbvAjUgYERfNyuQ4ZIO0IxTgxD4koSSHhuk7MK6dxeXyM2T
	 P+Pt7wVRl8fIDlfElLBG2Dnh98oeWcKLgmfn9rWDd3vgeWNjMUGxB84VrEkVEdix7o
	 myrqaoV34UMU63im/XCQvmlgNsGAwsiSEdBlmhrFKBbKsUDyv8/KE3C07J/ldkVebD
	 TmMXBWo316k92/Z/SSag+Bvr/LS3mxcjRHW7IqaqLC483R3X47JbymL5SFY3BvM3CM
	 FX3p7Jx0Dolxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831204613.2793526-2-thomas.falcon@intel.com>
References: <20260831204613.2793526-1-thomas.falcon@intel.com>
 <20260831204613.2793526-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:55:33 +0000
Message-Id: <20260831215534.5FC761F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Unbounded string concatenations (`strcat`) and integer underflow=
s of remaining buffer size limits (`sz - l`) cause severe stack buffer over=
flows when processing memory events.
- [Medium] Integer underflow of the initial buffer size decrement (`sz -=3D=
 1`) leads to an out-of-bounds null byte write.
- [Medium] Out-of-bounds array access on the `mem_hops` string array.
- [Medium] Memory leak of `cpu_map` on the error path in `perf_mem_events__=
record_args`.
--

commit 6817197b03ba87e0b80a68302df13245c2c2a0e9
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

[Severity: Medium]
This is a pre-existing issue, but passing sz - i can now propagate a zero o=
r=20
small size to perf_mem__lvl_scnprintf(). If sz =3D=3D 0 (or sz - i =3D=3D 0=
), the=20
initial size decrement in the helper underflows:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
	...
	sz -=3D 1; /* -1 for null termination */
	out[0] =3D '\0';
	...
}

Will this cause an out-of-bounds null byte write and result in sz becoming=
=20
SIZE_MAX for subsequent operations?

[Severity: Medium]
This isn't a bug introduced by this patch, but with the caller passing sz -=
 i,
is there a risk of unbounded strcat overflows?

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
	...
	for (i =3D 0; lvl && i < ARRAY_SIZE(mem_lvl); i++, lvl >>=3D 1) {
		...
		if (printed++) {
			strcat(out, " or ");
			l +=3D 4;
		}
		l +=3D scnprintf(out + l, sz - l, mem_lvl[i]);
	}
	...
}

If the appended length l exceeds sz, sz - l underflows to SIZE_MAX,=20
disabling bounds checks for subsequent scnprintf calls. The identical=20
logic exists in perf_mem__snp_scnprintf(). Could this allow stack=20
corruption when processing untrusted perf.data?


While reviewing this file, I noticed a couple of other pre-existing issues:

[Severity: Medium]
This is a pre-existing issue, but does this code read out-of-bounds?

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
    ...
		if (data_src.mem_hops)
			l +=3D scnprintf(out + l, sz - l, "%s ", mem_hops[data_src.mem_hops]);
    ...
}

The mem_hops bitfield in the perf_mem_data_src structure is 3 bits wide,=20
so it can hold values up to 7, but the mem_hops string array only has=20
5 elements. Could a crafted perf.data file providing a mem_hops value of=20
5, 6, or 7 cause an out-of-bounds read?

[Severity: Medium]
This isn't a bug introduced by this patch, but does this code leak cpu_map?

tools/perf/util/mem-events.c:perf_mem_events__record_args() {
    ...
			ret =3D perf_cpu_map__merge(&cpu_map, pmu->cpus);
			if (ret < 0) {
				free(event_name_storage);
				return ret;
			}
    ...
}

If perf_cpu_map__merge() returns a negative error code, the caller returns=
=20
immediately and fails to call perf_cpu_map__put(cpu_map), leaking the=20
previously accumulated CPU map reference. Is this cpu_map leak expected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831204613.2793=
526-1-thomas.falcon@intel.com?part=3D1
