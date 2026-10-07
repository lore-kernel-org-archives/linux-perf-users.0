Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50AA361640
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384969; cv=none; b=BO7fZQOMyo7S4nH6SMzC2gnmLvokUm7aXki15MIFxhW+qFGR5zTb/I5/7T4vJZfaYkR4qSOklS2suz+NNvX8uRuB4CdxO2j/sUjMXd/YBEKYCAgvnwq84e9wkNmLnpfL9p75SQ4Kyx54hodQXpT2MeHniJkmU7je0LqEajwKLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384969; c=relaxed/simple;
	bh=BVm7fr6EUOsMHRqoRCndhkMaModTQtoxffqSxj9qBE8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a/Pecye7AEEcCKrWYDUBEUnzgJ9Hz95/Z+B4VPRrv9E9f4ip7xRvhH/krGqQpcEi6EawP4kQlrGvY+X+pHzJvosdbZKxvUYEVyGiki6r23tq1Plm1d/C8MHpClcJb6Oz3C8dL6GI1RurNUr5xBHGBzEqFIYJ1B2+6PP5v990BMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwzMWOjV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwzMWOjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F1E1F000FF;
	Wed,  7 Oct 2026 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791384966;
	bh=zuwUbZtQ3/7yB+/MEhrhslE3sHlxHVyvfzGZ6CYH7GM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwzMWOjVpinESvJKRMPieHdC+fiGcWUwAItZ+a63b+KDLyemK+QvOfHPvn1HtzJCq
	 BgS5oEoPMCo7afsPZzug9XpHrpIn5bhghDYLyx0n3WK5g0vXaViN1zFkqzGr4F9KX2
	 AdOUDqA/V2MB1ZAplBOM0dwuTphyULi/Bt7Ezae8QCz3BqeN7hXoWntp5X0CjYB6E3
	 x7TW8KR3abQ9UwZ0VA/ZhqzjGxoRX+sGzPKtUO0DLz+6Skn4mW2Atpe83eb0Y9etHa
	 SMcqkv8UzFxJrN84nhtvpjoecK+A2fOirhJQrJ6Ya9SA90QqH1G1N6dyo91CfntC8v
	 6cBEF8GndfGkQ==
Message-ID: <sashiko-outbox-163130@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/lbr: Compress branch stack in a single
 pass
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007144416.3446108-1-sandipan.das@amd.com>
References: <20261007144416.3446108-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:56:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: info leak of uncleared LBR tail entries via branch snapshot=
 API
--

commit ed8227763c0f1dd19117eba0f7a4a321639e9390
Author: Sandipan Das <sandipan.das@amd.com>

perf/x86/amd/lbr: Compress branch stack in a single pass

This commit optimizes the software filtering of branch records by packing t=
he
remaining valid entries towards the front of the array in a single pass,
rather than shifting the tail down for each dropped entry.

> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 9d9c961989d51..abb636d48df09 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -141,17 +141,14 @@ static void amd_pmu_lbr_filter(void)
>  		return;
> =20
>  	/* Remove all invalid entries */
> -	for (i =3D 0; i < cpuc->lbr_stack.nr; ) {
> -		if (!cpuc->lbr_entries[i].from) {
> -			j =3D i;
> -			while (++j < cpuc->lbr_stack.nr)
> -				cpuc->lbr_entries[j - 1] =3D cpuc->lbr_entries[j];
> -			cpuc->lbr_stack.nr--;
> -			if (!cpuc->lbr_entries[i].from)
> -				continue;
> -		}
> -		i++;
> +	for (i =3D 0, j =3D 0; i < cpuc->lbr_stack.nr; i++) {
> +		if (!cpuc->lbr_entries[i].from)
> +			continue;
> +		if (j !=3D i)
> +			cpuc->lbr_entries[j] =3D cpuc->lbr_entries[i];
> +		j++;
>  	}
> +	cpuc->lbr_stack.nr =3D j;

[Severity: Medium]
Does this code leave stale entries at the tail of the cpuc->lbr_entries arr=
ay?

When a privileged BPF program calls bpf_get_branch_snapshot(), it invokes
perf_snapshot_branch_stack(), which calls amd_pmu_v2_snapshot_branch_stack(=
).

Looking at amd_pmu_v2_snapshot_branch_stack() in arch/x86/events/amd/core.c,
it unconditionally copies cnt (up to x86_pmu.lbr_nr) entries instead of
cpuc->lbr_stack.nr:

	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);

Since amd_pmu_lbr_filter() drops invalid entries and shrinks
cpuc->lbr_stack.nr but doesn't clear the tail elements, will these uncleared
tail elements (which could contain filtered branches or branches from other
contexts) be leaked to BPF programs?

Additionally, if cpuc->lbr_users =3D=3D 0, the LBRs are not read and the en=
tire
stale array from a previous task could be leaked.

Should the remaining entries from j to the original cpuc->lbr_stack.nr be
zeroed out here, or should the snapshot APIs be updated to only copy
cpuc->lbr_stack.nr entries?

Note that Intel's BPF snapshot implementation
(__intel_pmu_snapshot_branch_stack in arch/x86/events/intel/core.c) and LBR
filter (intel_pmu_lbr_filter in arch/x86/events/intel/lbr.c) appear to have=
 a
similar behavior where nr is shrunk without clearing tail elements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007144416.3446=
108-1-sandipan.das@amd.com?part=3D1
