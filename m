Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC663EF64A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966031; cv=none; b=MfU5QLYQzgJ3loHClhj5Z+2XxXPWdBJL/bNvpL73FpOh2IxH2sOI7OriR0w7BSVFN1fpHfgMKauGOxmO+5Hr31ljP8rBNyeD/u5Srq7N8XVz3v6OoEY56T8aSJyGnYstAxC/IPT4A2MTJmE7Ju+tViqhMuetjNLE9Jr08j7cgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966031; c=relaxed/simple;
	bh=m80hXZtN9eCK+yBLKqmK7MwdEw+2fIIfbcwN7Y/9bsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nr4KI8YgK3koMSIxvUYXJFosoEeSz/mlu6m7KRJ3DGR3CcjOoEeR14iwnpRxkaoaiFOqxgT7gazdK8BRlEbG4T5rSlKASey7sNCdZyLMa0CvtK/gXqZHTvNXB4qIj1+56ZyuhoO2tERbRoh0KgRwXsedUyzWFF/P1oZ/gO4OJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kwb9bNWU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kwb9bNWU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D1A1F000E9;
	Wed,  5 Aug 2026 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966029;
	bh=KuI9ETpQ+z0gapywWovBQuTOHoYT66Ttl9cmBzrQXfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kwb9bNWUKbtJYvCVpMmHFlJiKuT8VL3Z5QOm9x0GSomVrZh7g846IsfG3oNEggoPy
	 L7M47yqCsiwZI9LBlZiOq5a9rZAcrtl9dUEluoiQzTas5w7vBfZRFrzHw1eSUIL5BK
	 Rlwy7DHX5XouIwZZZNH0+yGT+v/XExLpYHopiKQ7l8PZPHwR1Tpl3TbUP1NCqbmdq7
	 uSW4Hb4a6xnxkf2me+4fFuFC8JlOYeTXi0JFoU/MHyErA0SgdnU1aIb2ybYmwEvHQT
	 ULb7ucBkrPoXbTXB+db0+7i+0aeWhCIxB4lHqa+GEB9UdGbehnIJ2aVWWJ/rgkno+W
	 Wlkq6gDaJg2OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] perf jitdump: Check snprintf return before
 computing header size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260805212704.267779-6-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
 <20260805212704.267779-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:40:28 +0000
Message-Id: <20260805214029.43D1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] In `jit_repipe_code_move`, an out-of-bounds heap read occurs when =
the required event size exceeds the allocated buffer, leaking heap memory i=
nto the `perf.data` file.
- [High] The dynamically allocated `event` buffer in `jit_repipe_code_move`=
 is never freed, resulting in a memory leak.
- [Medium] The JIT event injection logic violates the perf ABI's dynamic pa=
cking rules for the `sample_id_all` suffix, leading to event data corruptio=
n.
- [Medium] The `uint64_t` variable `jd->unwinding_mapped_size` is silently =
truncated to a 32-bit signed `int`, potentially corrupting the event length.
--

--- Patch [5]: [PATCH 05/12] perf jitdump: Check snprintf return before com=
puting header size ---
commit ec3758fe10c5b2ae1b52a849ea060531bfeec315
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

    perf jitdump: Check snprintf return before computing header size

This commit fixes a heap corruption in the jitdump mmap injection code.
It clamps the return value of snprintf to the filename buffer size in both
jit_repipe_code_load() and jit_repipe_code_move() to prevent oversized
header computations when the jitted filename exceeds PATH_MAX.

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 078d3304d2b7e..d7e3dcfc63b78 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  			jd->dir,
>  			nspid,
>  			count);
> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D sizeof(event->mmap2.filename))
> +		size =3D sizeof(event->mmap2.filename) - 1;
> =20
>  	size++; /* for \0 */
> =20

[Severity: Medium]
This is a pre-existing issue, but does the sample ID injection in
jit_repipe_code_load() violate the dynamic packing rules for the sample_id_=
all
suffix?

The code casts the suffix payload to a static struct and unconditionally wr=
ites
the timestamp at offset 8:

	struct {
		u32 pid, tid;
		u64 time;
	} *id;
...
	if (jd->sample_type & PERF_SAMPLE_TIME)
		id->time =3D convert_timestamp(jd, jr->load.p.timestamp);

If PERF_SAMPLE_TID is disabled but PERF_SAMPLE_TIME is present, shouldn't t=
he
timestamp be placed at offset 0?

Leaving offset 0 uninitialized and forcing the timestamp into offset 8 could
corrupt the parsed timestamp and subsequent fields.

[Severity: Medium]
This is also a pre-existing issue, but does jit_repipe_code_load() silently
truncate the 64-bit unwinding mapped size?

The function assigns a uint64_t from the untrusted jitdump file to a signed
32-bit int:

	int ret, csize, usize;
...
	usize =3D jd->unwinding_mapped_size;

If the mapped_size is larger than INT_MAX, wouldn't this truncate into a
negative value?

This could then be added to the code size to compute event->mmap2.len, caus=
ing
unintended subtraction or massive wraparound.

> @@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	         jd->dir,
>  		 nspid,
>  		 jr->move.code_index);
> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D sizeof(event->mmap2.filename))
> +		size =3D sizeof(event->mmap2.filename) - 1;
> =20
>  	size++; /* for \0 */
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does jit_repipe_code_move()
have an out-of-bounds heap read when calculating the event size?

The event buffer is allocated with a hardcoded size:

	event =3D calloc(1, sizeof(*event) + 16);

But the header.size is dynamically computed using idr_size:

	event->mmap2.header.size =3D (sizeof(event->mmap2) - (sizeof(event->mmap2.=
filename) - size) + idr_size);

Since idr_size can be up to 64 bytes depending on the active sample_type, t=
he
calculated header.size can exceed the allocated buffer by up to 48 bytes.

When perf_data__write() is later called in jit_inject_event(), couldn't this
read past the end of the allocation and leak heap memory into the perf.data
file?

[Severity: Medium]
This is a pre-existing issue, but does jit_repipe_code_move() also suffer f=
rom
the same dynamic packing violation as jit_repipe_code_load()?

The same static struct layout is used for the sample ID fields:

	struct {
		u32 pid, tid;
		u64 time;
	} *id;
...
	if (jd->sample_type & PERF_SAMPLE_TIME)
		id->time =3D convert_timestamp(jd, jr->load.p.timestamp);

This appears to corrupt the event data if PERF_SAMPLE_TID is disabled.

[Severity: High]
This is a pre-existing issue, but does jit_repipe_code_move() leak the event
buffer?

The buffer is dynamically allocated, but the function appears to return wit=
hout
freeing it:

	event =3D calloc(1, sizeof(*event) + 16);
	if (!event)
		return -1;
...
out:
	perf_sample__exit(&sample);
	return ret;

Since a jitdump file can contain thousands of code move events, wouldn't th=
is
consume significant memory and potentially lead to out-of-memory errors dur=
ing
processing?

[Severity: Medium]
This is a pre-existing issue, but does jit_repipe_code_move() also truncate=
 the
unwinding mapped size into a 32-bit integer?

Just like in jit_repipe_code_load(), the size is assigned to an int:

	int usize;
...
	usize =3D jd->unwinding_mapped_size;

Could this cause the same event length corruption if the mapped_size exceeds
INT_MAX?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805212704.2677=
79-1-acme@kernel.org?part=3D5
