Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BA3CFF79;
	Tue,  9 Jun 2026 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780986024; cv=none; b=dpoPDirY1fw6VRs9kDa61lbMyQUahEYU9aztgLw7A9xVAcvAGHSlxZ35Gg0LDAwaRyaaj7encUJ/hGOVKSjbsizmMZarF6R0PiiVL//FG0BgYtWALE9q+NeSNukKpknCJqkF2HhE6ZucDf9zOHphyTVJK+iK4j8zSk6f9oRfHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780986024; c=relaxed/simple;
	bh=c5kmYxssNv2+QXBcadNsd7DLYqyE697n8amtj1pt1eI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TxyR0WOr0dWU/bLUqY4y980sdCG6Rkz9fu+e1NJD0H70EvfPAhWWrocndz5YvkJBaZcSgfh0W5g8BkMdzgeWeIkiWkWxhxgal+AmPH3osAWU15L0yNrkoJVQhXqRWduOHOmLUV710Yy9PansFwiA8WRDNvkwnxZTg1NDtrgp16M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMOyw7g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMOyw7g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D53F1F00893;
	Tue,  9 Jun 2026 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780986023;
	bh=GoL3sDyMYstwQ+9iJfrdUBueQBxXD/l/4UJapYSHDhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nMOyw7g3punLJHEZRYLlgp8Ekjr/PPuiPAIZs8USNg0O32aT+GByOato/T5njXkX7
	 DAtAK4/tQhOiGAZqg5zy17v56624fzYwc20g0vkFmCHv3CqZ3kiP0Xa4vD6z7v9xCa
	 BhX3aQsu+nDqryN9pnj8S8BBxVUOMJ9M9I0PjPgccCd1ytpXD8ZxHlaZwnLSm92/MC
	 GEeg1mzrCl3Ma1nVREHg+k9VHYm56qwvYiZ3AJzX5YxqFOpW9tgnmonmPo4XjfCXVU
	 /PGWBtYbM6puGZBUgLatIYouCd1vuujQPJZE6q4W17cgvitJJ47vmoNEgLIi4Lp1Ri
	 eqt9FHt6wQKlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/21] TEST(do-not-upstream): fake qemu vendor JSON +
 mapfile entry for CounterIDMask path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atish Patra" <atish.patra@linux.dev>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260608-counter_delegation-v6-21-285b72ed65a9@meta.com>
References: <20260608-counter_delegation-v6-21-285b72ed65a9@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 06:20:22 +0000
Message-Id: <20260609062023.0D53F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] This patch is explicitly marked 'TEST(do-not-upstream)' and adds=
 fake testing events, which should not be merged into the mainline kernel.

Pre-existing issues:
- [High] Unconditional NULL pointer dereference in `get_cpuid`.
--

commit d0ac889c30ab39821cba995143de6c24abe2efcc
Author: Atish Patra <atishp@meta.com>

TEST(do-not-upstream): fake qemu vendor JSON + mapfile entry for CounterIDM=
ask path

This patch adds fake QEMU vendor JSON events and a corresponding mapfile en=
try
for the CounterIDMask path to test PMU masking.

> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index 87cfb0e0849fc..3533a8c0253f7 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -24,3 +24,4 @@
>  0x602-0x3-0x0,v1,openhwgroup/cva6,core
>  0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
>  0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> +0x0-0x0-0x0,v1,qemu/virt,core

[Severity: Medium]
Since this patch is explicitly marked "TEST(do-not-upstream)" and adds fake
PMU events strictly for testing, should it be merged into the mainline
kernel?

Merging this will populate the perf tool's PMU event tables with non-existe=
nt
hardware events.

> diff --git a/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json b/too=
ls/perf/pmu-events/arch/riscv/qemu/virt/events.json
> new file mode 100644
> index 0000000000000..294c4ed645f67
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/qemu/virt/events.json
> @@ -0,0 +1,26 @@
> +[
> +  {
> +    "EventName": "fake-json-any",

[ ... ]

While reviewing this, I also noticed a pre-existing issue in
tools/perf/arch/riscv/util/header.c:

tools/perf/arch/riscv/util/header.c:get_cpuid() {
    ...
	char *cpuid =3D _get_cpuid();
	int ret =3D 0;

	if (sz < strlen(cpuid)) {
		ret =3D -EINVAL;
		goto free;
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but can get_cpuid() cause a segmentation fault
here? If _get_cpuid() returns NULL (for example, if /proc/cpuinfo is missing
or lacks specific fields in a container or QEMU without proper emulation), =
it
appears the unconditional call to strlen(cpuid) will dereference that NULL
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-counter_de=
legation-v6-0-285b72ed65a9@meta.com?part=3D21
