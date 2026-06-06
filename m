Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4652798F3
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780731418; cv=none; b=PmkwBK+e6t5yHLrKmAjWz4Gp5XEn0D7Jb/xT9v21jRouPCZkQptczrNB6rMWjgNoVKq9K1aT+FDypr1GJwoi0kaT5dwE8Ag5vOahMbIcil8YE37+DJUPzJO2w2kqF8nUSD9LqE/IJ54UK6FgdBsylTmitO8I2Ey+PgA3wwqtg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780731418; c=relaxed/simple;
	bh=C+r0cnXYy8uNvz2PY55v5B0xXMGepRu7tRpYXqzw6MI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXTpZEJ4MMd0rt8nMYUcG00r1JxvBRY/tGCSpjk7DpvYizmjJvosPTcwWVt+fhEaKGDcfJvIBesXKAbknnnY+viB2Ox8aUrZurEnZTM3bYrz76BNokgRVG6egxgZ0nJdxn9++FiQI1yyIzr7L+r/fnW+T/Z+m87epd+dfO5wMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPuh/l5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPuh/l5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E411F00893;
	Sat,  6 Jun 2026 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780731417;
	bh=zO1iK4T2VBCHumYv5OicmV9a/5G3pEVBhZiQlwVhzIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jPuh/l5JqFo2gypkpc4x/eFnJCYR1a9vudKUZ8vts92nFAbHptPTOx9iu1pK9rfSN
	 HE/qLxy4hao6qNHaxnLi9Stbl/OudUFv9Ipt8paqwH6lzjp9u3NkI7nBqLh7VMpYHO
	 I+DWpEDNaIHVRjUbUEeHHZcorJU/KsWPxbnZYJPXDfV24f+XvaqrCTCCz/SQmThWp5
	 nwQYb+SnNTwW4b1NhLTOW6qHZzFGqI79exvq0IkuckjYOa8YRRjtHIjTKwwO0UiKVP
	 RhyGtqpWLjdcnlpDhjfhgqgOo9pPGl63iHDBPhBevsaZYDfQ8R5Cyv5AcudF3djK1B
	 IWGoziKVs05yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/5] perf inject/aslr: Implement sample address
 remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606072125.2786845-4-irogers@google.com>
References: <20260606072125.2786845-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 07:36:57 +0000
Message-Id: <20260606073657.76E411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent Drop of Entire Sample for recordings with branch counters
--

commit 626067d9ffedea6b6e512a71e2a2cb18442024b3
Author: Ian Rogers <irogers@google.com>

perf inject/aslr: Implement sample address remapping

This commit adds sample address remapping logic to the ASLR tool. It parses
sample events and remaps IPs, addresses, callchains, and branch stacks
while dropping potentially leaking information like raw and stack samples.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -583,13 +637,405 @@ static int aslr_tool__process_sample(const struct =
perf_tool *tool,
[ ... ]
> +		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)=
 {
> +			if (nr > max_i - i || nr > max_j - j) {
> +				ret =3D -EFAULT;
> +				goto out_put;
> +			}
> +			memcpy(&out_array[j], &in_array[i], nr * sizeof(u64));
> +			i +=3D nr;
> +			j +=3D nr;
> +			/* TODO: confirm branch counters don't leak ASLR information. */
> +			pr_debug("Dropping sample branch counters as possible ASLR leak\n");
> +			ret =3D 0;
> +			goto out_put;
> +		}

[Severity: High]
Does this code unintentionally drop the entire sample?

The code copies the branch counters into the new array but then immediately
executes ret =3D 0; goto out_put; within aslr_tool__process_sample(). This =
aborts
processing of the sample entirely and skips delegating the sample to the ou=
tput,
dropping it completely.

Since branch_sample_type is an attribute of the event, won't this result in
all samples being silently dropped, leading to an empty output file for any
recording that includes branch counters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606072125.2786=
845-1-irogers@google.com?part=3D3
