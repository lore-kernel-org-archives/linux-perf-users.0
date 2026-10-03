Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA4375F97
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991205; cv=none; b=mZ6bkQVpEdcGSTwGvwLyCspu2jtbdCaXV7YYCrk+FAjJr3yFKV7PJpaSpF0nrvaU1Po35hVe3j0mvnRoQjE3vmxDWeyymRm+H2Ozpqnde5yS6k3I7vpLLql6dpkJ4MYROzmm1JbX++w641dhmpCMdbpwrN9KTXYefcjGI8YHs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991205; c=relaxed/simple;
	bh=VhdonmycUa3CYW+qqAYPwL7iL1S/M9xavxOTmar9dsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h0XRIFKvUSwT4OjAqyh2v6qXJEIadvhmdHiA2d3NFJgOmB6B+Za2JGSRZfP+1bMdyLRz6EIH9+wG/VeofLuTxvYkjrejMaD9qKpxw6z+d3IR/BWLb18usgaK7WGWcRn3C+zxcNYHy57hR6VN7m0k9gbFbp6T9AUV+WIMUK/JlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V38FZaqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V38FZaqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BDD1F00898;
	Sat,  3 Oct 2026 01:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991204;
	bh=55eS4FEDuQwzyLoqx7grmFWv+xNHFlzUJtxIZjpRc/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V38FZaqGQ9dBd7oijbYPb/UBbBGRRZ8x0bKZmj7c2h7w5KkihPw6Pu23Dx4EgDh4K
	 WZUXmV8dnuRFXt1Aex8SESfTSMWyqKewZxVeSBdwuyqcJXILbEPKQQYqot0wsw8hnb
	 d4O5JgbeS+PupJBGxVLcK7LXwped/FtTZrW/86GVY1LZMK4og3S0M1OVeE2ZKTNghp
	 VZ5zg1CVL/2PDC19ClmHp/6RPMPdA5nDYd4tr/0rOBh1mWi0wrRkZsZZw74jEgPc2a
	 wPBjP/Z+ZmrnLxR4aqhq6PAe3XxrXeWSnz31CU2a8ff2zObHg+qWspt7szZDrYUO6t
	 di33uU3HYZgFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] perf inject: Extend perf inject to support
 bid_offset conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002173848.3228217-7-irogers@google.com>
References: <20250424061943.1321025-1-irogers@google.com>
 <20261002173848.3228217-1-irogers@google.com>
 <20261002173848.3228217-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:23 +0000
Message-Id: <20261003013324.02BDD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: strict aliasing violation via incompatible u32* cast
--

commit e992f40013df71934d4af6ea3359426fe5b0f8a1
Author: Ian Rogers <irogers@google.com>

perf inject: Extend perf inject to support bid_offset conversion

This commit adds the --sample-buildids option to perf inject, allowing it to
drop MMAP events and rewrite samples to use build IDs and offsets instead
of virtual addresses.

> diff --git a/tools/perf/util/inject_bid_offset.c b/tools/perf/util/inject=
_bid_offset.c
> new file mode 100644
> index 0000000000000..25e8f21a2d5aa
> --- /dev/null
> +++ b/tools/perf/util/inject_bid_offset.c
[ ... ]
> @@ -0,0 +1,680 @@
[ ... ]
> +	if (sample_type & PERF_SAMPLE_RAW) {
> +		size_t bytes =3D sizeof(u32) + sample->raw_size;
> +		u64 words =3D DIV_ROUND_UP(bytes, sizeof(u64));
> +		u32 *out_raw =3D (u32 *)&out_array[j];
> +
> +		if (i > max_i || words > max_i - i)
> +			goto err;
> +		out_array[j + words - 1] =3D 0;
> +		*out_raw =3D sample->raw_size;

[Severity: High]
Does this pointer cast and dereference in inject_bid_offset_tool__sample()
violate strict aliasing rules?

Since out_raw is an incompatible u32 pointer cast from the underlying u64
array, the compiler is allowed to assume the stores do not overlap. This
means the compiler can reorder the u64 store (out_array[j + words - 1] =3D =
0)
and the u32 store (*out_raw =3D sample->raw_size).

If words =3D=3D 1 (for example, when sample->raw_size <=3D 4), both assignm=
ents
target the exact same 8-byte memory region. Under type-based alias analysis,
reordering these independent stores could result in raw_size being zeroed
out, corrupting the perf data output.

This occurs when using --sample-buildids on an input perf.data file
containing events with PERF_SAMPLE_RAW. Unlike core kernel space, the tools/
directory assumes -fstrict-aliasing by default.

> +		memcpy(out_raw + 1, sample->raw_data, sample->raw_size);
> +		i +=3D words;
> +		j +=3D words;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002173848.3228=
217-1-irogers@google.com?part=3D6
