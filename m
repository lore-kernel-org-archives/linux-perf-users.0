Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC237DE84
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701471; cv=none; b=N3rSHcNRa2Fy/JHk3NlzDBwPfoNW5VoIInu/HPXuQhnWtSO0m5IUNOvPGYkMygvazaoCaAiIgpvVRrsoEQaRRDZ9noCjVoTgM41wTks0qcbkyDOCS2UPX2ApMGz9BMj3NV0wD2fuCs5OiGHTGkh7i2qOzD8sYQZ4Z3MrBZ77r48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701471; c=relaxed/simple;
	bh=A7z75Vd7WgM58t9nkDgli4cZl3VZt/EOGyOq6ww/pCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F9bLthULgCxwfZ9ZMafWqY52YcPRftJmefup6dJFhMwOI8Y5AtbSgAyJCCRYzxyYIr2iv08C6W/mI2GRajEOMZIFNVhXCsoMDKwdbV6lcLF8MqZU0OVvqcDcEj1d/Uwk0DT2rpMQl6Cyipmi3nY6WTbO8SRnga031ZLitt7HrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMQYYc+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMQYYc+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A2E1F00893;
	Fri,  5 Jun 2026 23:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701469;
	bh=4+6RoUgkC2oVvHdACs1MV5EfDXQ2QnP97pQp1hX3Sus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XMQYYc+6A+Q33iCgH4IUViRWwGnvD4Pgv5RUys6xWpiO6EiTZ1vqM4thJGdEHkh8e
	 cYZqNvoFagvSAn3xOE4ek/OJXRFJB5JD0e5cj2deyAKQ1TVtj7uOG4Hs+Can9RU6vp
	 G/O6ythLRSU1C5vTpl5/Iw24Z9i89uG47o6mE+Mc++o3ViLEXwp3rK28iJpcznjJWL
	 MW92zfkFHltmWOIV1f+rry1eAAgzpRHfPww+O+wm/DTCJtqUkUKfaK8KIttKZARuGF
	 sbbXp3g1QDIRb4pgn4I+exEM9/63C7xq8w8EoBo4bTPB5qcOhDcUrD+bmXKHv2tGdu
	 fsMasUl3Q8PeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260605205649.2566948-4-irogers@google.com>
References: <20260605205649.2566948-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 23:17:49 +0000
Message-Id: <20260605231749.A3A2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Double-swapping of branch stack flags on cross-endian hosts corr=
upts output file branch metadata.
--

commit dcb8e448dca91e01727a6cd53948bd906dde4043
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This commit adds sample address remapping logic to the ASLR tool. It parses
sample events, remaps IPs, addresses, callchains, and branch stacks, and
filters out potential leak sources like raw samples.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c

[ ... ]

> @@ -560,13 +614,400 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,

[ ... ]

> +	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {

[ ... ]

> +		for (u64 cntr =3D 0; cntr < nr; cntr++) {
> +			out_array[j++] =3D aslr_tool__remap_address(aslr, thread,
> +								  sample->cpumode,
> +								  in_array[i++]); /* from */
> +			out_array[j++] =3D aslr_tool__remap_address(aslr, thread,
> +								  sample->cpumode,
> +								  in_array[i++]); /* to */
> +			out_array[j++] =3D in_array[i++]; /* flags */
> +		}

[ ... ]

> +	new_event->sample.header.size =3D sizeof(struct perf_event_header) + j =
* sizeof(u64);
> +
> +	perf_sample__init(&new_sample, /*all=3D*/ true);
> +	ret =3D evsel__parse_sample(evsel, new_event, &new_sample);

[Severity: Medium]
On cross-endian hosts, does calling evsel__parse_sample() here corrupt the
branch stack flags?

The initial pipeline already called evsel__parse_sample() on the original
event, which performs an in-place bitfield swap on the branch stack flags
to match the host layout when evsel->needs_swap is true.

When aslr_tool__process_sample() copies these already-swapped flags into
the new event array and then calls evsel__parse_sample() a second time on
the new event, won't this trigger the in-place bitfield swap again?

This double-swap would revert the flags back to the file endianness layout
within a host-endian output file, potentially corrupting branch stack
metadata (like mispredicts or cycles) for downstream tools.

> +
> +	if (ret) {
> +		perf_sample__exit(&new_sample);
> +		goto out_put;
> +	}
> +
> +	new_sample.evsel =3D evsel;
> +	ret =3D delegate->sample(delegate, new_event, &new_sample, machine);
> +	perf_sample__exit(&new_sample);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605205649.2566=
948-1-irogers@google.com?part=3D3
