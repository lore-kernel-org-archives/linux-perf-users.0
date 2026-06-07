Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C8280338
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780813663; cv=none; b=T2/V2XADqtAodFMrVWryfPH4b23EYKM0/j3QtAVKE2xCRnVdi7QGHKQ+6iU7U+VdVhxO7by+0824CqOjR+NK2dR7RloP6B5Qq9NrenTJMVLLOcIcnxglwPDJH7vGETVjthDiDKMaxuxy2sNKSXcPfkw3OoYoKrIS5UgJoQNDHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780813663; c=relaxed/simple;
	bh=gyEayds/WHkYmLOfWkmQBN2ekWIwCt5EiqnH7sHI2EM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMqck7b+GhkD11GF/3X5LyXI+oKQBHXpcBu9VVryr3YYCki3ykwSfR1/Ki8EaqaH1/hl0kK0cgmnKM4XvCWrMPZbcYDaEjaa1RGn/nXINumonKLRbQcS4jWjmRk9tUEo3hgb2GJAUL43ujKMXC96amBgnC5me50MDiH/CrroexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW8hU4Pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW8hU4Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C421F00893;
	Sun,  7 Jun 2026 06:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780813661;
	bh=qfTRqqh5MoalMFiaLCNHXwLFDlU6m+l9rGt7kToUjVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CW8hU4PvOSG8UW0blhgjpYHR6o39JDWSmpVnB3SX1EXlCxgLNG4+0sqQ/hdl9h+1R
	 RjbGyEtAJx6ox0kSf2vSX2oS7h7NE8VWAqYU6lv0GjPVCYNe9Dakv8SekGFSpMd9sl
	 /ryCFowUGwYzjoA9QNoevlYC7c+BKBhe/5SmZS3p2UKhpaHQ9mkSBGQPlSQPmtpb4w
	 SLZQum1RNTn5fucCuxrQaZPxiQ/dPCJ3qMubOLvVM220kfJ0n4lhYtEGK9URCoQhTm
	 gZpCJVOJ4K0T0woPZbd9xLD9p3qPIPnDfzayTWIczy3pL4TtydRBx5gBrdNMivcnOJ
	 e7EmQ5/c0uZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 4/5] perf aslr: Strip sample registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607060933.3274263-5-irogers@google.com>
References: <20260607060933.3274263-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 06:27:41 +0000
Message-Id: <20260607062741.A4C421F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ASLR stripping of breakpoint and kprobe/uprobe fields is bypassed,=
 and sample_type is corrupted, when processing cross-endian traces due to i=
ncorrect bswap logic.
--

commit dd031a94e79bda6ae3f56773d70deec897c2f043
Author: Ian Rogers <irogers@google.com>

perf aslr: Strip sample registers

Extend the ASLR tool stripping helpers to drop register dump payloads
by masking out the relevant perf_event_attr fields (sample_regs_user,
sample_regs_intr) when the delegated tool is handling the data.

struct aslr_evsel_priv maintains the original perf_event_attr values
and is looked up via the evsel_orig_attrs hashmap so that sample sizes
can be properly parsed even when bits are stripped from the pipeline.

> diff --git a/tools/perf/util/aslr.c b/tools/perf/util/aslr.c
> index 8980599b0158f..bf6bb27153573 100644
> --- a/tools/perf/util/aslr.c
> +++ b/tools/perf/util/aslr.c
[ ... ]
> @@ -1120,43 +1200,44 @@ static int aslr_tool__process_auxtrace_error(cons=
t struct perf_tool *tool __mayb
>  	return 0;
>  }
> =20
> -
> -void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
**pevlist)
> +void aslr_tool__strip_attr_event(union perf_event *event, struct evlist =
*evlist)
>  {
>  	struct evsel *evsel;
>  	bool needs_swap =3D false;
> =20
[ ... ]
>  	if (event->header.size >=3D (offsetof(struct perf_record_header_attr,
>  					    attr.sample_type) + sizeof(u64))) {
> -		u64 st =3D event->attr.attr.sample_type;
> -
> -		if (needs_swap)
> -			st =3D bswap_64(st);
> -
> -		st &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		if (needs_swap) {
> +			u64 st =3D bswap_64(event->attr.attr.sample_type);
> =20
> -		if (needs_swap)
> -			st =3D bswap_64(st);
> +			st &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +			event->attr.attr.sample_type =3D bswap_64(st);

[Severity: High]
Does this code inadvertently corrupt the sample_type bitmask?

Since perf_session__process_user_event() calls event_swap(), which delegates
to perf_event__hdr_attr_swap(), the event->attr.attr structure is already
byte-swapped in-place to native endianness before the tool->attr() callback
is invoked.

Swapping it again here when needs_swap is true would corrupt the value befo=
re
applying the ASLR_SUPPORTED_SAMPLE_TYPE mask.

> +		} else {
> +			event->attr.attr.sample_type &=3D ASLR_SUPPORTED_SAMPLE_TYPE;
> +		}
> =20
> -		event->attr.attr.sample_type =3D st;
> +		if (event->header.size >=3D
> +		    (offsetof(struct perf_record_header_attr, attr.sample_regs_user) +=
 sizeof(u64)))
> +			event->attr.attr.sample_regs_user =3D 0;
> +		if (event->header.size >=3D
> +		    (offsetof(struct perf_record_header_attr, attr.sample_regs_intr) +=
 sizeof(u64)))
> +			event->attr.attr.sample_regs_intr =3D 0;
>  	}
> =20
>  	if (event->header.size >=3D (offsetof(struct perf_record_header_attr,
>  					    attr.type) + sizeof(u32))) {
> -		u32 type =3D event->attr.attr.type;
> -
> -		if (needs_swap)
> -			type =3D bswap_32(type);
> +		u32 type =3D needs_swap ? bswap_32(event->attr.attr.type) : event->att=
r.attr.type;

[Severity: High]
Is it possible this logic bypasses ASLR scrubbing for cross-endian traces?

Because event->attr.attr.type was already swapped to native endianness prio=
r to
this tool callback, calling bswap_32() here would cause the type =3D=3D
PERF_TYPE_BREAKPOINT check below to evaluate to false (e.g., native 5
becomes 0x05000000).

This would bypass the scrubbing of bp_addr, config1, and config2, potential=
ly
leaking kernel ASLR addresses.

> =20
>  		if (type =3D=3D PERF_TYPE_BREAKPOINT &&
>  		    event->header.size >=3D (offsetof(struct perf_record_header_attr,
> -						    attr.bp_addr) + sizeof(u64))) {
> +							attr.bp_addr) + sizeof(u64))) {
>  			event->attr.attr.bp_addr =3D 0;
>  		} else if (type >=3D PERF_TYPE_MAX) {
>  			struct perf_pmu *pmu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607060933.3274=
263-1-irogers@google.com?part=3D4
