Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC652E8DEF
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350776; cv=none; b=XwlTbL0tUr08nCtwKwzNSlEBwPOTbQqF0s+8i+dkL4jdEm6YZdJLJgAb7e1ddUaPsWiFH7mTvd7VUU5uSW76bYoGIjesi+5MA7ku+8Eum6OH7Em30iPjnETLm5yRsG9urhYfF8kyv6yZEBQajEhP+3i7J68ba/BSP6a0NPY5nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350776; c=relaxed/simple;
	bh=rJcARZcqpKMuEzvaqxtHDcHC2NHOhx9tTmK+3Q0syu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ga9Mv6hF01C7ttZM5cAiVlvwoc+9cEitUM5fsa51Xd4FyNCnk0L1mqMuun+aSaaY/K6VG7x+pj70QFBQtlG8aNNf38bJU14MISNdNImyPzrH/uwc7bQgqO7+BcDDSanfysEC7NEXafbG/0r7bKnPe1kO0vLryK6S7k2k7pvtFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjkfppBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjkfppBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D043B1F000FF;
	Mon, 14 Sep 2026 01:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789350775;
	bh=mhFSxlTR56AtT1h6Xx37+svLr4RaKeMEAjfIu+kSf/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjkfppBaezEnRUtbahqUM/8nky1T8IIW2/UpaqzV2G3pt0Uj3kLDDzQ+Le+/JIG3i
	 ATHGKjQqP7qDGJCN9AQToAUMyv0SycOtSF1j6NDHw+ooNsSDswVD8gtg2QMhZT7gH4
	 VhwxGqb4ENJH8qrPeE+KAGOaMgo+I18UvwNQZaVYjdFY+gHzB3izY/o/hjHMS95zJg
	 djyM2csPtEZZxSVRcfXdPkX0/E1DB8Vok6oR2uUnA8YV08hao7neTU13x4/hKPGSfK
	 g506tols7QC/mx9Ai0x77raPBpAV1PBGZh0EnCx6URXrZJZ+2vknsT16O8FL9SHE9t
	 qOJgHK6ad4p1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914013604.7702-9-acme@kernel.org>
References: <20260914013604.7702-1-acme@kernel.org>
 <20260914013604.7702-9-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:52:54 +0000
Message-Id: <20260914015254.D043B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow in `rec_argv` due to insufficient allocation =
for appended arguments.
--

commit ac341d4bfb0aa8a3024f56539bc9bb8653d870f1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf mem record: Request PERF_SAMPLE_CPU by default

This commit adds --sample-cpu by default to perf mem record to ensure the
CPU id is captured. This allows per-sample analysis to distinguish reads
and writes to the same data from different cores.

> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 6101a26b3a781..a708e2549bae4 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -135,6 +135,15 @@ static int __cmd_record(int argc, const char **argv,=
 struct perf_mem *mem,
> =20
>  	rec_argv[i++] =3D "-d";
> =20
> +	/*
> +	 * The data-type profiling per-sample stream keys cross-CPU
> +	 * contention on sample->cpu (PERF_SAMPLE_CPU); without it the cpu
> +	 * field is the (u32)-1 'no CPU info' sentinel and same-instance
> +	 * reads and writes from different cores are indistinguishable
> +	 * from same-CPU traffic.
> +	 */
> +	rec_argv[i++] =3D "--sample-cpu";
> +

[Severity: High]
This is a pre-existing issue, but does adding --sample-cpu here
unconditionally push rec_argv further towards a heap buffer overflow?

Looking at the allocation of rec_argv earlier in __cmd_record():

    rec_argc =3D argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
    if (mem->cpu_list)
        rec_argc +=3D 2;
    rec_argv =3D calloc(rec_argc + 1, sizeof(char *));

It reserves 9 extra slots for a single PMU system. However, the explicitly
appended arguments can exceed this limit when multiple flags are used
(e.g., -W, -d, --sample-cpu, --phys-data, --data-page-size, --all-user,
--all-kernel).

When copying the original arguments at the end of the function:

    for (j =3D 0; j < argc; j++, i++)
        rec_argv[i] =3D argv[j];

If the user supplies valid memory profiling arguments that trigger the
appending of these extra flags, the total number of arguments will exceed
the reserved slots. This final loop will then write past the bounds of the
allocated array.

Should the allocation size calculation for rec_argc be updated to account
for all possible appended arguments?

>  	if (mem->phys_addr)
>  		rec_argv[i++] =3D "--phys-data";
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013604.7702=
-1-acme@kernel.org?part=3D8
