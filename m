Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6593736212C
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832894; cv=none; b=Hks3XiydY3uQIocFu2F76oZ0InabhITB00weflhGtdjEEJO2N8YYY097XYrOA+vVKE5q7Em1BZNIiWCv9zHCN74DaMMI3wzTxLJkiQtp6tyD6GaTSR6gPGORd4lbzvFV4xM+sw/5521ldtmNJpohWEbjR1ZnP6aYD55VkztzvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832894; c=relaxed/simple;
	bh=iXYS+k6jgMWhFyegY/cxL48+3x8sQPqI/wd7p/NrPVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GR+jX7RBM+o0lubbEjJv9IQL1fqvBcEp+NNZ8Ttujlw0Ck31gyGD9jy1IGSN/7MHhm+ctjCQa2YIoN7uZOvwvGXYj5IwdbXhhh0qdcSGbdHuCLs8gW1pWkIgjMu8QpsKD1op2JW2xHamvsCCfKJP3f4JzdxFd3rFV3O6s4msHlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc7Sl8x/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc7Sl8x/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A611F000E9;
	Tue, 26 May 2026 22:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779832893;
	bh=HvtH8e6KN4iF0TPwUaF8BQFb4kt/Ffk3bxjz8z5s4AY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dc7Sl8x/aZPICgm3X0RuKHl7pLDFd4/ibBInDkowSut7oIiyS+DKrVmiUfH/TaZlI
	 n9jQAA6/FwfezUUkSzReRZ8ZoJhic8NUyFI5MQIePYX+9TJBw9zbw6eEtalAhGlaBI
	 FjOxzKZjlB1DKTAy7prx2uekalMipSQ4u4pzS1B2ZfFozLF5rhHtkolRgEtOdR6ODu
	 emt9T3+PWmRuAYRn6Q0j1LcUK39JGqqgdkZPchx+l0RCVO/m4OpeWa8sxEXFa99DVk
	 q2ZHdZCJ0WpeBC5hdqKp8F0NLcvyNIhgJzKmsfEO4SyFla8glTXGguw0XsVxAnsKc1
	 Qb7Mohidk6CYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/29] perf session: Validate HEADER_ATTR attr.size
 before swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260526211806.1193848-11-acme@kernel.org>
References: <20260526211806.1193848-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 22:01:32 +0000
Message-Id: <20260526220132.E3A611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing TOCTOU protection for `event->header.size` during valida=
tion on shared mmaps.
--

commit e4ad3606afbf2146d8e039237ce12985c68071fa
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: perf session: Validate HEADER_ATTR attr.size before swapping

This patch hardens PERF_RECORD_HEADER_ATTR handling against crafted perf.da=
ta
files. It validates attr.size, bounds the copy size to prevent leaking
adjacent event data, and retains the original attr.size for correct event
re-synthesis.

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 41a3721a194dc..d8cb1f562f690 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
[ ... ]
> @@ -244,24 +245,34 @@ static int perf_event__repipe_attr(const struct per=
f_tool *tool,
>  	if (!inject->itrace_synth_opts.set)
>  		return perf_event__repipe_synth(tool, event);
> =20
> -	if (event->header.size < sizeof(struct perf_event_header) + sizeof(u64)=
) {
> +	if (event->header.size < sizeof(struct perf_event_header) + PERF_ATTR_S=
IZE_VER0) {
>  		pr_err("Attribute event size %u is too small\n", event->header.size);
>  		return -EINVAL;
>  	}
> =20
> -	if (event->header.size - sizeof(event->header) < event->attr.attr.size)=
 {
> +	/*
> +	 * ABI0 pipe/inject events have attr.size =3D=3D 0; default to
> +	 * PERF_ATTR_SIZE_VER0 (the ABI0 footprint) for the bounded
> +	 * copy and ID array position.  Same pattern as
> +	 * perf_event__process_attr() in header.c.
> +	 */
> +	raw_attr_size =3D event->attr.attr.size;
> +	attr_size =3D raw_attr_size ?: PERF_ATTR_SIZE_VER0;
> +
> +	if (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
> +			      raw_attr_size > event->header.size - sizeof(event->header))) {
>  		pr_err("Attribute event size %u is too small for attr.size %u\n",
> -		       event->header.size, event->attr.attr.size);
> +		       event->header.size, raw_attr_size);
>  		return -EINVAL;
>  	}
> =20
>  	memset(&attr, 0, sizeof(attr));
>  	memcpy(&attr, &event->attr.attr,
> -	       min_t(size_t, sizeof(attr), (size_t)event->attr.attr.size));
> +	       min_t(size_t, sizeof(attr), attr_size));
> =20
> -	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids =3D event->header.size - sizeof(event->header) - attr_size;

[Severity: Medium]
Is it possible for event->header.size to change between the validation above
and this calculation?

Since raw_attr_size was explicitly snapshotted to prevent race conditions on
shared memory mappings, could a concurrently modified event->header.size
bypass the bounds check?

If event->header.size is shrunk concurrently after the validation, could th=
is
cause n_ids to underflow?

>  	n_ids /=3D sizeof(u64);
> -	ids =3D perf_record_header_attr_id(event);
> +	ids =3D (void *)&event->attr.attr + attr_size;
> =20
>  	attr.size =3D sizeof(struct perf_event_attr);
>  	attr.sample_type &=3D ~PERF_SAMPLE_AUX;

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f30e48eb3fc32..967c3d8ff12c8 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -5094,11 +5110,42 @@ int perf_event__process_attr(const struct perf_to=
ol *tool __maybe_unused,
>  			     union perf_event *event,
>  			     struct evlist **pevlist)
>  {
> -	u32 i, n_ids;
> +	struct perf_event_attr attr;
> +	u32 i, n_ids, raw_attr_size;
>  	u64 *ids;
> +	size_t attr_size, copy_size;
>  	struct evsel *evsel;
>  	struct evlist *evlist =3D *pevlist;
> =20
> +	/*
> +	 * HEADER_ATTR event layout (pipe/inject mode):
> +	 *
> +	 *   [header (8 bytes)] [attr (attr_size bytes)] [id0 id1 ... idN]
> +	 *   |<------------------ header.size --------------------------->|
> +	 *
> +	 * attr_size varies across perf versions: VER0 =3D 64 bytes,
> +	 * current sizeof(struct perf_event_attr) =3D larger.  A newer
> +	 * producer may emit a larger attr than we understand.
> +	 *
> +	 * attr.size =3D=3D 0 (ABI0) means the producer didn't set it
> +	 * (e.g., bench/inject-buildid, older perf).  Treat as VER0.
> +	 *
> +	 * Require 8-byte alignment so the u64 ID array is aligned
> +	 * and attr.size fits cleanly within the payload.
> +	 *
> +	 * Read attr.size once =E2=80=94 the event may be on a shared mmap
> +	 * and re-reading could yield a different value.
> +	 */
> +	raw_attr_size =3D event->attr.attr.size;
> +	if (event->header.size < sizeof(event->header) + PERF_ATTR_SIZE_VER0 ||
> +	    (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
> +			      raw_attr_size % sizeof(u64) ||
> +			      raw_attr_size > event->header.size - sizeof(event->header)))) {
> +		pr_err("PERF_RECORD_HEADER_ATTR: invalid attr.size %u (event size %u, =
min %d)\n",
> +		       raw_attr_size, event->header.size, PERF_ATTR_SIZE_VER0);
> +		return -EINVAL;
> +	}
> +
[ ... ]
> -	n_ids =3D event->header.size - sizeof(event->header) - event->attr.attr=
.size;
> +	n_ids =3D event->header.size - sizeof(event->header) - attr_size;

[Severity: Medium]
Could this calculation also suffer from the same race condition if
event->header.size is modified after the validation above?

If an attacker shrinks event->header.size concurrently, could n_ids underfl=
ow
and lead to an out-of-bounds memory read when allocating and populating the
IDs array?

>  	n_ids =3D n_ids / sizeof(u64);
>  	/*
>  	 * We don't have the cpu and thread maps on the header, so

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526211806.1193=
848-1-acme@kernel.org?part=3D10
