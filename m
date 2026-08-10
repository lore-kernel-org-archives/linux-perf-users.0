Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C93B3AF66E;
	Mon, 10 Aug 2026 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370686; cv=none; b=ugSzw6XuIBZYgF/ielpLf6R+pbgrgxN42BgSa7NRLqjf1hdTzXNXiH47knNmrOcg/py+bMUZYn1KMXhjRVjZzid66o1TJ7AOvTDzMndGOmp8G6/DESq+ex0aTCVWcV15Ee8u+CgRO6Qwwi5eQBA2H5I3yJpIK00qoTCk22a9dY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370686; c=relaxed/simple;
	bh=EfA5qC3BXDimF69tKp65Bv6khfCvDWQAzu7iNI81N/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKiyVKke+1hlk6egq0bIjXgzNq9i3tAn1AacavqjwO9Ap1KSvlQJkLIcodaJ0OOxYG80/zNW1ceDCtybS8IPJPCNOV4KTRfsmuAHErOskHnjdiO0gK5AfrNgUA8HsATqEbItBswaQhfhzo/+Oj5Ss2hhHJkUyR4yVJaC7VYKJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtCko4s4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtCko4s4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2DD1F000E9;
	Mon, 10 Aug 2026 14:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786370685;
	bh=uzR1DoG4lPRIqgJkpj75RSBavLd3zOTESqrzJJ3i2vA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VtCko4s4iwsGMsCZUyWYh5d9VHfcK+pLnl71Tg9O5zQu/t3cla6WIcBZ+fPy7jrzy
	 DlUCTo/HBr+g0q3zMyGpcpQqHU4ud9paVXdB+aPvyAut3P7fBCPXr1uMqhYnG+H1YU
	 9q7pqkwf53LgfMEqr4IxU5hdA2+q+KeGeM5fslpXOm88EnWcn1jg8v/4WbIMqTDN0h
	 aBUJx07V+PUVGtdeWe3yCaaky82faw1K9XrhzAXou1ittrsNH/gZqF2w9u1hAMXsUa
	 Wlg+XKcrxS/O8oiOgKwRH87oXiYAq6GEORnqlaS1nT86De1o3sLb2imvjI/dn06AhE
	 3azBnvWHzE3yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] perf/core: Fill branch entries with a single
 assignment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260810133540.1947118-4-puranjay@kernel.org>
References: <20260810133540.1947118-1-puranjay@kernel.org>
 <20260810133540.1947118-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:04:44 +0000
Message-Id: <20260810140445.0D2DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The BPF branch snapshot helpers (__intel_pmu_snapshot_branch_stack=
 and amd_pmu_v2_snapshot_branch_stack) unconditionally copy stale branch re=
cords (LBRs) to BPF buffers, leading to cross-context information leaks.
--

--- Patch [3]: [PATCH v7 3/3] perf/core: Fill branch entries with a single =
assignment ---
commit f67f9ecd08216c6081d3d24e81906c232c6917fe
Author: Puranjay Mohan <puranjay@kernel.org>

perf/core: Fill branch entries with a single assignment

This commit replaces the field-by-field initialization of perf_branch_entry
with a single structure assignment. This automatically zeroes out any unnam=
ed
fields, removing the need to manually keep perf_clear_branch_entry_bitfields
in sync with the structure definition.

> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index cae2e02fe6cc4..539e9feffa356 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
[ ... ]
> @@ -847,14 +847,15 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cp=
uc)
>  		if (abort && x86_pmu.lbr_double_abort && out > 0)
>  			out--;
> =20
> -		perf_clear_branch_entry_bitfields(br+out);
> -		br[out].from	 =3D from;
> -		br[out].to	 =3D to;
> -		br[out].mispred	 =3D mis;
> -		br[out].predicted =3D pred;
> -		br[out].in_tx	 =3D in_tx;
> -		br[out].abort	 =3D abort;
> -		br[out].cycles	 =3D cycles;
> +		br[out] =3D (struct perf_branch_entry){
> +			.from		=3D from,
> +			.to		=3D to,
> +			.mispred	=3D mis,
> +			.predicted	=3D pred,
> +			.in_tx		=3D in_tx,
> +			.abort		=3D abort,
> +			.cycles		=3D cycles,
> +		};
>  		out++;
>  	}
>  	cpuc->lbr_stack.nr =3D out;

[Severity: High]
This is a pre-existing issue, but while reviewing how these branch entries
are populated and tracked by cpuc->lbr_stack.nr, I noticed a potential
information leak in the BPF branch snapshot helpers.

Does __intel_pmu_snapshot_branch_stack() unconditionally copy stale
branch records to the BPF buffer?

arch/x86/events/intel/core.c:__intel_pmu_snapshot_branch_stack() {
    ...
    cnt =3D min_t(unsigned int, cnt, x86_pmu.lbr_nr);
    memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
    ...
}

When the number of valid LBR entries (cpuc->lbr_stack.nr) is less than the
hardware capacity (x86_pmu.lbr_nr), this memcpy appears to copy the trailing
unwritten entries from cpuc->lbr_entries. This condition can happen routine=
ly
in call-stack mode with shallow stacks, or when Intel's double-abort erratum
skips an entry (as seen just above in this diff).

The AMD implementation seems to have the exact same logic error:

arch/x86/events/amd/core.c:amd_pmu_v2_snapshot_branch_stack() {
    ...
    cnt =3D min(cnt, x86_pmu.lbr_nr);
    memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * c=
nt);
    ...
}

Could this allow a BPF tracing program to read stale hardware branch records
left over from previously executed contexts, leaking execution history from
other tasks or the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810133540.1947=
118-1-puranjay@kernel.org?part=3D3
