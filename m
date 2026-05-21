Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB3368D52
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 02:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331422; cv=none; b=Yv5gmZsytFFAfhJxNXv+iiFJI0pHuQCcgQeUow0qjTNH1lMKH0h5ZbemT9lfGHqgjWmjMsiQiwk+/ppaB/+jESesgAsXuIEbntVwXsqOLJ86IIzO9ioiKHE1zyH85w7EQFBtqDnDFsgsN3MRGwpY4hvG7y8LHLMhDXWsiS+qcwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331422; c=relaxed/simple;
	bh=+m5zoWyqX/uBRGiPYPbVlnEhjvTXOYHCwhpudUqUXDs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WccVsbzFARS+T6pbKC5+Y6f0/FcqvqCljolux57BFkHN9DyR4ZZ8qkXUPgL1/5R93UcKBNqf5rC8EVEFktJmfnBIsMAofGLg6rzl/LpdqPOqgrEUnK/8EUdX6/dKdZ/hNpxqxCFMB0N4ukzRP+Or5E4fJez5JLbvpvgqWA3oTgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPeVWyih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPeVWyih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346AE1F000E9;
	Thu, 21 May 2026 02:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779331418;
	bh=dFY4kNEqOqSFV0UYqueSd326Uk6+5FuT1ubYeD1R3VY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kPeVWyihh6d+A85lywR2gRNthzUXngF+IiLiF3DxGSQmyO8XO2bB8JS9wJqbuC+3Z
	 FKGiNzf9iEpnPeTzQ1n0derr+NcZkYJG0yQmxunvbEKu9TJaPNDcxMtsAqQ23XYpoS
	 lFKweFOxS3gGU/5SU6/8WXT2pwLHjeOt8/lBAj4B/pQA+XOKpbrEKSqF9YnlvCLbGE
	 HSleuSJRWrwizb+S3DUu/lnHDIxqsnZkhnZfDLKocKcOzcsCVLewe218hEAR2sEbjk
	 WRZAhrDwRI9+TFRuFQZSBZ7Od7ZpCn9x6MD9IdkZCOtPQHaQTqqW+sppt00gMkrFI0
	 Uy3oGZuO9joTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/27] perf session: Bound nr_cpus_avail and validate
 sample CPU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260521011027.622268-26-acme@kernel.org>
References: <20260521011027.622268-26-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 02:43:37 +0000
Message-Id: <20260521024338.346AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Clamping env->nr_cpus_avail in process_nrcpus breaks bounds checki=
ng in downstream header parsing, causing valid perf.data files from machine=
s with many cores to be rejected.

Pre-existing issues:
- [High] The new CPU bounds check explicitly bypasses clamping if sample.cp=
u =3D=3D (u32)-1, allowing out-of-bounds reads in downstream tools (report,=
 diff, sched, script, annotate).
--

commit 02f073a206c5c99ac57b234875b83bcb6a4e3aa5
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Bound nr_cpus_avail and validate sample CPU

This commit clamps nr_cpus_avail to MAX_NR_CPUS when reading HEADER_NRCPUS
and applies a bounds check to sample.cpu in perf_session__deliver_event().
It attempts to protect fixed-size arrays in downstream consumers while
preserving the (u32)-1 sentinel value for events without CPU info.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 8ab05d46021b7..8bc5904591d49 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2894,12 +2895,36 @@ static int process_nrcpus(struct feat_fd *ff, voi=
d *data __maybe_unused)
[ ... ]
> +	/*
> +	 * FIXME: Several downstream consumers use fixed-size arrays
> +	 * indexed by CPU (timechart MAX_CPUS, kwork/sched/annotate
> +	 * DECLARE_BITMAP(MAX_NR_CPUS)).  Until these are converted
> +	 * to dynamic allocation, clamp nr_cpus_avail so per-event
> +	 * CPU bounds checks reject samples above the array limit.
> +	 * Data from CPUs beyond MAX_NR_CPUS will be lost.
> +	 *
> +	 * Pipe-mode streams from pre-2017 perf or third-party tools
> +	 * that lack HEADER_NRCPUS will hit the MAX_NR_CPUS fallback
> +	 * in perf_session__deliver_event() instead.
> +	 */
> +	if (nr_cpus_avail > MAX_NR_CPUS) {
> +		pr_warning("WARNING: perf.data recorded on a %u-CPU machine but perf i=
s compiled with MAX_NR_CPUS=3D%d.\n"
> +			   "         Samples from CPUs >=3D %d will be clamped to CPU 0.  Con=
sider rebuilding\n"
> +			   "         perf with a larger MAX_NR_CPUS, or help convert fixed-si=
ze CPU arrays to\n"
> +			   "         dynamic allocation.\n",
> +			   nr_cpus_avail, MAX_NR_CPUS, MAX_NR_CPUS);
> +		nr_cpus_avail =3D MAX_NR_CPUS;
> +		if (nr_cpus_online > nr_cpus_avail)
> +			nr_cpus_online =3D nr_cpus_avail;
> +	}
> +
>  	env->nr_cpus_avail =3D (int)nr_cpus_avail;

[Severity: High]
Does clamping this value introduce a regression for header parsing on
machines with high core counts?

When process_cpu_topology() runs later, it uses env->nr_cpus_avail to
validate the number of sibling cores read from the file. If the file is
from a machine with 8192 cores, won't nr be 8192 while nr_cpus_avail was
clamped to MAX_NR_CPUS (e.g. 4096)?

This would cause the validation to fail and abort the entire session. Could
the clamp be applied dynamically during event delivery instead of modifying
the environment's true core count used for header validation?

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7e25f75de37ab..bf14fa8c52f65 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -2076,14 +2076,89 @@ static int perf_session__deliver_event(struct per=
f_session *session,
[ ... ]
> +		/*
> +		 * For perf.data files the MAX_NR_CPUS fallback in
> +		 * perf_session__read_header() guarantees this is set.
> +		 * For pipe mode, HEADER_NRCPUS may arrive late or not
> +		 * at all (pre-2017 perf, third-party tools).  Fall
> +		 * back to MAX_NR_CPUS so the bounds check still works
> +		 * against fixed-size downstream arrays.
> +		 */
> +		if (nr_cpus_avail <=3D 0) {
> +			nr_cpus_avail =3D MAX_NR_CPUS;
> +			perf_session__env(session)->nr_cpus_avail =3D nr_cpus_avail;
> +			pr_warning_once("WARNING: HEADER_NRCPUS not set, using MAX_NR_CPUS (%=
d) as CPU bound\n",
> +					MAX_NR_CPUS);
> +		}
> +		if (sample.cpu >=3D (u32)nr_cpus_avail &&
> +		    sample.cpu !=3D (u32)-1) {

[Severity: High]
This is a pre-existing issue, but does skipping the bounds check for
(u32)-1 leave downstream tools vulnerable to out-of-bounds reads?

The code explicitly avoids clamping when sample.cpu =3D=3D (u32)-1 to prese=
rve
it as a sentinel. However, downstream tools like perf report and perf sched
often call test_bit(sample->cpu, rep->cpu_bitmap).

Since test_bit() does not verify if the index is a sentinel, won't it
zero-extend the (u32)-1 sentinel to a massive index and perform an
out-of-bounds read on the fixed-size cpu_bitmap[] array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521011027.6222=
68-1-acme@kernel.org?part=3D25
