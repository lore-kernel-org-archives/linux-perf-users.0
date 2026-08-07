Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8F363096;
	Fri,  7 Aug 2026 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092104; cv=none; b=PTeY0b1c0Uu34mSZuvFq8wJ6r4L3DY3j91D1wvTaaIeTyExeG2b0OvEjyddM4nfo9Pg11IFOVdC0VuPLbhzmP2wOHl2XvtHxvFHWYIyTQRV17sGNZUzB01NfCrXuRFo8SSc9WzJnwkBWuJ7660Tj8L/fK44gGGnAuu0YRoL0gzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092104; c=relaxed/simple;
	bh=WZmABFRX8SqD4swuIr4Q6Eup6HimZVX6eYqNXiYo3OQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqVkVNiPA36I3ln46+3HL+F9j9MEZgt9xxYMzkZNUetkRJDZvZzPM346mezxKPSGauZJ6FMpVeDtsHEhsE3/YitmKXaK2mLKdCTzrlkjSBnaGsWJ3oNhWZNXd2z8lRUWIEezTe3xfLhVlWa+L9AYsubV37polLeO2LMyBMm6sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWXS77Ik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWXS77Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6B1F000E9;
	Fri,  7 Aug 2026 08:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092103;
	bh=bX0GZKwxVAysxgoEHnJMUji0cVP9kGDu6MBONJnEOy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWXS77IkcFSSEdGgAw6XDmw8m/FGZ0TkI4YeLP8AyFOH9M8DuGmMrVi8OlF/FHJge
	 uCl/qINBHlrAsg95GlMtk3gzZlVFH5/Uog3nhTsrLHx/XrJp34/o15wFlwGP4VKx61
	 XMtU/PjhuD//5732KjK4BKuMAAMp/JHh0H6RKF9Qf7f72vYrsV6QPYMTAv4aAVbWuY
	 Dut8CETWHYfjcjNmrJvwOn2/p+oUxx9KRqyUJVBM5ZKbBk2HCceSAAcq/SsTkmxAg0
	 iiS5XHoQ5MbZCj/ML4qe862gWEemLRlONSy6Ax5Uh9MPQWFveHTdZ97hMZk7Gd+ajd
	 R8rMDT93ITiqQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 5/8] perf tools: Internal support for
 BUILD_ID_OFFSET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-6-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 08:41:42 +0000
Message-Id: <20260807084143.0FE6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Synthesizing an event with PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET b=
ut without PERF_SAMPLE_CALLCHAIN causes a NULL pointer dereference.
- [High] Copying `callchain_bids` during event synthesis uses the potential=
ly unrelated length `sample->callchain->nr`, leading to a heap buffer over-=
read.
- [High] Array access on `sample->callchain_bids` uses the unverified index=
 `j` derived from `chain->nr`, leading to a heap buffer over-read.
- [High] `add_callchain_ip` ignores the `bid` and `offset` arguments when `=
cpumode` is set, breaking callchain resolution for `PERF_SAMPLE_CALLCHAIN_B=
UILD_ID_OFFSET`.
- [High] Missing `OVERFLOW_CHECK` when parsing `PERF_SAMPLE_BUILD_ID_OFFSET=
` allows out-of-bounds reads on malformed events.
- [Medium] `__evsel__parse_sample` fails to unswap the byte layout of `stru=
ct perf_build_id` when `swapped` is true, corrupting cross-endian perf.data=
 analysis.
- [Medium] The test suite in `sample-parsing.c` is not updated for the new =
flags, causing immediate failure.
- [Medium] `thread__find_map` fails to resolve build IDs because `sample->i=
p` takes precedence over `sample->bid.bid`, misinterpreting the offset as a=
 virtual address.
- [Medium] `leaf_frame_caller` incorrectly inherits the build ID and offset=
 of its callee in `thread__resolve_callchain_sample`.
--

--- Patch [5]: [RFC PATCH v1 5/8] perf tools: Internal support for BUILD_ID=
_OFFSET ---
commit fbd06af754237e67a7a1661b582808d4407ddb3e
Author: Ian Rogers <irogers@google.com>
Subject: perf tools: Internal support for BUILD_ID_OFFSET

This patch implements user-space parsing for the new sample types in evsel.
It updates perf_event_attr_fprintf to display the new bits in 'perf report =
-D'
and updates synthetic event parameter names.

[Severity: Medium]
There appears to be an omission outside of the files modified by this patch:
Has test__sample_parsing() in tools/perf/tests/sample-parsing.c been
updated for the new flags? If PERF_SAMPLE_MAX was updated, the hardcoded
safety check:

    if (PERF_SAMPLE_MAX > PERF_SAMPLE_WEIGHT_STRUCT << 1)

might cause the test suite to unconditionally abort.

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -740,15 +734,33 @@ struct map *thread__find_map(struct thread *thread,=
 struct perf_sample *sample,
> =20
>  		return NULL;
>  	}
> -	al->map =3D maps__find(maps, al->addr);
> -	if (al->map !=3D NULL) {
> -		/*
> -		 * Kernel maps might be changed when loading symbols so loading
> -		 * must be done prior to using kernel maps.
> -		 */
> -		if (load_map)
> -			map__load(al->map);
> -		al->addr =3D map__map_ip(al->map, al->addr);
> +
> +	if (sample->ip) {
> +		al->addr =3D sample->ip;
> +		al->map =3D maps__find(maps, al->addr);

[Severity: Medium]
When resolving callchains, sample->ip is typically populated with the file
offset. Because sample->ip takes precedence in this if/else chain, will the
offset be incorrectly evaluated as a virtual address via maps__find(),
causing the resolution to skip maps__find_by_build_id() entirely?

> +		if (al->map !=3D NULL) {

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3778,6 +3778,30 @@ int __evsel__parse_sample(struct evsel *evsel, uni=
on perf_event *event,
>  		array =3D (void *)array + sz;
>  	}
> =20
> +	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
> +		data->bid.bid =3D (struct perf_build_id *) array;

[Severity: Medium]
During cross-platform analysis of perf.data files from a different
endianness, the event array is 64-bit byte-swapped prior to parsing. Since
struct perf_build_id contains mixed-size fields (8-bit, 16-bit, 32-bit,
and a byte array), does this code need to unswap the layout similar to how
PERF_SAMPLE_AUX uses mem_bswap_64() to prevent data corruption?

> +		array +=3D sizeof(struct perf_build_id) / sizeof(u64);
> +		data->bid.offset =3D *array;
> +		array++;

[Severity: High]
Should there be an OVERFLOW_CHECK_u64(array) before dereferencing array
for the offset? Since PERF_SAMPLE_BUILD_ID_OFFSET is not part of
PERF_SAMPLE_MASK, its size isn't included in evsel->sample_size,
which could allow an out-of-bounds read on truncated events.

> +	} else {
> +		data->bid.bid =3D NULL;
> +		data->bid.offset =3D 0;
> +	}

[ ... ]

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2216,7 +2216,9 @@ static int add_callchain_ip(struct thread *thread,
>  			    struct branch_flags *flags,
>  			    struct iterations *iter,
>  			    u64 branch_from,
> -			    bool symbols)
> +			    bool symbols,
> +			      struct perf_build_id *bid,
> +			      u64 offset)
>  {
>  	struct map_symbol ms =3D {};
>  	struct addr_location al;
> @@ -2230,7 +2232,9 @@ static int add_callchain_ip(struct thread *thread,
>  	al.srcline =3D NULL;
>  	if (!cpumode) {
>  		thread__find_cpumode_addr_location(thread,
> -					   &(struct perf_sample){.ip =3D ip},
> +					   &(struct perf_sample){.ip =3D ip,
> +								 .bid =3D { .bid =3D bid,
> +									  .offset =3D offset }},
>  					   symbols, &al);
>  	} else {

[Severity: High]
In thread__resolve_callchain_sample(), cpumode is initialized locally and
its address (&cpumode) is passed to add_callchain_ip(), meaning cpumode is
never NULL. Doesn't this force execution into the else branch here?

The else branch constructs a temporary struct perf_sample that omits the
new bid and offset parameters, which silently drops the data before
map/symbol resolution.

[ ... ]

> @@ -2979,13 +3003,19 @@ static int thread__resolve_callchain_sample(struc=
t thread *thread,
>  			continue;
>  #endif
>  		ip =3D chain->ips[j];
> +		if (sample->callchain_bids) {
> +			bid =3D (struct perf_build_id *)&((u64 *)sample->callchain_bids)[j * =
4];
> +			offset =3D ((u64 *)sample->callchain_bids)[j * 4 + 3];
> +		}

[Severity: High]
Since the loop index j is bounded by chain->nr rather than
sample->callchain_bids_nr, could a malformed event where chain->nr exceeds
the actual length of callchain_bids cause a heap buffer over-read here?

>  		if (ip < PERF_CONTEXT_MAX)
>                         ++nr_entries;

[ ... ]

> @@ -3011,21 +3041,28 @@ static int thread__resolve_callchain_sample(struc=
t thread *thread,
> =20
>  				err =3D add_callchain_ip(thread, cursor, parent,
>  						root_al, &cpumode, leaf_frame_caller,
> -						false, NULL, NULL, 0, symbols);
> -				if (err)
> -					return (err < 0) ? err : 0;
> +						false, NULL, NULL, 0, symbols, bid, offset);

[Severity: Medium]
When synthesizing a missing caller frame (leaf_frame_caller), this passes
the bid and offset variables belonging to the current frame (j, the callee)
into add_callchain_ip(). Does this incorrectly associate the synthesized
caller's IP with the callee's build ID?

> +				if (err) {
> +					err =3D (err < 0) ? err : 0;
> +					goto out;
> +				}

[ ... ]

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1701,6 +1701,13 @@ size_t perf_event__sample_event_size(const struct =
perf_sample *sample, u64 type,
>  		result +=3D sample->aux_sample.size;
>  	}
> =20
> +	if (type & PERF_SAMPLE_BUILD_ID_OFFSET)
> +		result +=3D sizeof(struct perf_build_id) + sizeof(u64);
> +
> +	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET)
> +		result +=3D sizeof(u64) + sample->callchain->nr *
> +			  (sizeof(struct perf_build_id) + sizeof(u64));
> +
>  	return result;
>  }

[Severity: High]
If an event contains PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET but not
PERF_SAMPLE_CALLCHAIN, sample->callchain will be NULL. Does this sequence
unconditionally dereference sample->callchain->nr and cause a crash?

[ ... ]

> @@ -1933,6 +1940,19 @@ int perf_event__synthesize_sample(union perf_event=
 *event, u64 type, u64 read_fo
>  		array =3D (void *)array + sz;
>  	}
> =20
> +	if (type & PERF_SAMPLE_BUILD_ID_OFFSET) {
> +		memcpy(array, sample->bid.bid, sizeof(struct perf_build_id));
> +		array +=3D sizeof(struct perf_build_id) / sizeof(u64);
> +		*array++ =3D sample->bid.offset;
> +	}
> +
> +	if (type & PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET) {
> +		*array++ =3D sample->callchain->nr;
> +		sz =3D sample->callchain->nr * (sizeof(struct perf_build_id) + sizeof(=
u64));
> +		memcpy(array, sample->callchain_bids, sz);

[Severity: High]
Should this use sample->callchain_bids_nr instead of sample->callchain->nr
for the copy size calculation? If a malformed event provides a chain->nr
that is larger than the true bounds of callchain_bids, could this
copy out-of-bounds heap memory into the synthesized event stream?

> +		array +=3D sz / sizeof(u64);
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D5
