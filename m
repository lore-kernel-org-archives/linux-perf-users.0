Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96DA38759C
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331118; cv=none; b=a1XdpRLmnxcoIaqtG5ZVwQ2TOWK/u0bgfvqqZ4zKkunEzpF6w+IlVk3Pu3GIBhp9WkmqOgwZCbPDASD8PXiyapBO50QSR/A2EHNb1/cInuzMvuzJqTErsH0YoUyPiwGKaDFrsguh0snQJyzdzc2ewwzvDvx0qQIBACfgxtacVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331118; c=relaxed/simple;
	bh=tekBi0dMMgxusMnpmvlWWBQEgepsgGjOYKnDDTNaT5s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KiguvNbkVYUj7nd0XjhdIOX41/ZBoE6vJ/nYuxsz0aFNd7fd35jiLG2Fa3o0BarXnn7FIxv9UwRSTW+IQg8/RKtJiQBBFya0ErJCNjkUV0xDZp9E5lbUy3SNjnFtkLxczwS3zGnQu7u286kBZzwopj5v2daV+QqluTpOL21ruKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUfcadJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUfcadJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399791F0089B;
	Tue,  6 Oct 2026 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331117;
	bh=kRWsVIbkZ5sn4VPHgsHLdGMMwsvOHW0AzZ59ap2kejM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CUfcadJ1iKf9eLbxgrkgP6dU8ynbaWaUzU1+ZxSq96+0sDo9LFHz93qK14KSQBQ5r
	 mrtt3uEF5UE920uKqfVvx4GBgZJnpenTT7a1dkZ2SsgY4jJqv5dXvX9tUWv+lrsg2H
	 e05ViXNEH4cG8m11WfZhd3s112g4xHM6ILPL1NbGhZpUWa15w57zMwvo0kVpT9ekQr
	 IX16umMB+xm0gnj8O223XsXRbaGbrev4HTX0EigZerKYSBDwV2jB2Y03AR1jYW8Dm0
	 +kXS9OqmUTacaiOFTRB36aefvDGxumSAY5PDxpln5Mozh+k+z+Lt9wVZDn/YKOnnWC
	 Be4weRSulGQEA==
Message-ID: <sashiko-outbox-162542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] perf symbol: Set binary/symtab type for split
 kallsyms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-5-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:58:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: Incorrect binary_type copied to split kallsyms DSOs
--

commit caef899ba7808ad89c1adfe535b155dac7c2ebd1
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Set binary/symtab type for split kallsyms

When it creates new DSOs for split kallsyms, set the binary and symtab
type to KALLSYMS properly.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index cf099cbd29f26..fc6e4dff282bc 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1099,6 +1099,8 @@ static int maps__split_kallsyms(struct maps *kmaps,=
 struct dso *dso, u64 delta,
>  				return -1;
> =20
>  			dso__set_kernel(ndso, dso__kernel(dso));
> +			dso__set_binary_type(ndso, dso__binary_type(dso));
> +			dso__set_symtab_type(ndso, dso__symtab_type(dso));

[Severity: Medium]
Are we copying an outdated binary_type into the new split DSOs here?

Looking at the execution flow, maps__split_kallsyms() is called via
dso__load_kallsyms() from within dso__load_kernel_sym():

dso__load_kernel_sym() {
	...
do_kallsyms:
	err =3D dso__load_kallsyms(dso, kallsyms_filename, map);
	...
	if (err > 0 && !dso__is_kcore(dso)) {
		...
		dso__set_binary_type(dso, DSO_BINARY_TYPE__KALLSYMS);
	...
}

Because dso__load_kallsyms() executes before dso__load_kernel_sym() updates
the parent dso's binary_type to DSO_BINARY_TYPE__KALLSYMS, the value return=
ed
by dso__binary_type(dso) during the split operation may still be the old
stale value.

Could this prevent the split kallsyms DSOs from receiving the correct
binary and symtab types?

>  			dso__set_loaded(ndso);
> =20
>  			curr_map =3D map__new2(pos->start, ndso);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D4
