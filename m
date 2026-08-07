Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E180E3F5BDA;
	Fri,  7 Aug 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096718; cv=none; b=luplisisgCbDsfNBCg1l2892ExviaVRBHvkjkqri7TC57f9QELZtqu5i4athuqZ6AhpWzB6QIC5SIC1O9Z5IR5P4y1bWGtpX3fe8Nh64GZrVzIp0KlV9fm0rapRGBquc2R+mYkiD7rsNzLdsRazlpl6oqkoZ0m3Y9gf3i3eZZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096718; c=relaxed/simple;
	bh=dHXjSK3Y5VZVc45dxUTBm4gB1yLtiuE0nUez2OZlQ6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqwcnAnj6XkHG3iseBXLY0xpoD08yNDNyZ4jc/y3qI2kTbB89bDBhMC3JzIo3sTurtFpSY1x2HUYEw/CRm58AbUIX78+5KiNKe23BY8cr071LGyGt5NGFAHsTLQthhdQJ2pU6GW6UwpfxBJB70OIKe+dmuJMA9VkY6HULbB1MRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqp7+MDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqp7+MDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572991F000E9;
	Fri,  7 Aug 2026 09:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096716;
	bh=hKSFDm+AjOVa9kFTzagdBZAsoRn20JUQxy3iWX54E7w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wqp7+MDBcOxxTKWrKm/BQPyHpZeUQt/1ROeQEpz3AwOV0ROA8fTYNzwghKkXZbP5Z
	 NkCmVoTxBpvaeorx0uk7ETVycgMxxl2Mt0K/Thz/y8MGDKAKwzAAaL+4XFANht56pN
	 ud2krvgRTAXep7wXvlHKBBgj+1xQpB9E4hdbm/hWTKd4a/yLxzF2emw31iUE6v+d+y
	 VQ7FoDTXLZAdSdu64XW2diV+FoeV9hOz22NeGFk1uCOymS+t5I5bRcoXisACyimgRf
	 JiEx6n2cqVlJ+DMaIOF5ku7/GNJOEnZ17p2r7cQdXJS7fScUg1zTWIHzO/ZEE+ql+s
	 uXi6RX9YzRc3Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 8/8] perf tests: Add build_id_offset test
 coverage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-9-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:58:35 +0000
Message-Id: <20260807095836.572991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] Heap Use-After-Free of `thread` reference handle in `mmap_events=
`.
- [Medium] Raw pointer comparison of reference-counted `struct map` handles=
 causes spurious test failures.
- [Medium] Silent test bypass due to missing validation of `PERF_SAMPLE_BUI=
LD_ID_OFFSET` fields.
- [Medium] Stack Out-Of-Bounds Read when synthesizing `PERF_SAMPLE_CALLCHAI=
N_BUILD_ID_OFFSET`.
- [Low] Missing explicit `<string.h>` inclusion causes compilation failures=
 on musl libc.
--

--- Patch [8]: [RFC PATCH v1 8/8] perf tests: Add build_id_offset test cove=
rage ---
commit 2b1a4526386e7ebd56cc41f452ac5f172c32e199
Author: Ian Rogers <irogers@google.com>

perf tests: Add build_id_offset test coverage

Test the kernel interface using sys_perf_event_open, test perf inject
--sample-buildids with pipe mode and callchains, and test perf record
--buildid-offset across multiple sampling modes.

> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mma=
p-thread-lookup.c
> index dca8bbfe780a7..65c72ed896ac2 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
[ ... ]
> @@ -211,6 +213,40 @@ static int mmap_events(synth_cb synth)
> =20
>  		pr_debug("map %p, addr %" PRIx64 "\n", al.map, map__start(al.map));
> =20
> +		/* Verify lookup by build ID and offset */
> +		{
> +			struct dso *dso =3D dso__get(map__dso(al.map));
> +
> +			if (dso) {
> +				const struct build_id *bid =3D dso__bid(dso);
> +
> +				if (bid && bid->size > 0) {
> +					struct addr_location al2;
> +					struct perf_build_id pbid =3D { .size =3D bid->size };
> +					u64 offset =3D map__dso_map_ip(al.map,
> +								     (unsigned long)(td->map + 1));
> +
> +					memcpy(pbid.data, bid->data, bid->size);

[Severity: Low]
Does this code need to explicitly include <string.h>?

Without the explicit include, calling memcpy() causes compilation failures =
on
systems using musl libc.

> +					addr_location__init(&al2);
> +					thread__find_map(thread, &(struct perf_sample){

[Severity: Medium]
Can this use-after-free the thread reference handle?

Looking at mmap_events(), thread__put(thread) is called right after the fir=
st
thread__find_map() call.

This means the newly added test code dereferences the freed thread pointer
here. Under REFCNT_CHECKING (ASAN), this invalidates the handle and poisons
the memory.

> +								.cpumode =3D PERF_RECORD_MISC_USER,
> +								.ip =3D 0,
> +								.bid =3D {
> +									.bid =3D &pbid,
> +									.offset =3D offset,
> +								},
> +							 }, &al2);
> +
> +					if (al2.map !=3D al.map) {

[Severity: Medium]
Will this raw pointer comparison of reference-counted struct map handles ca=
use
spurious test failures?

When perf is compiled with REFCNT_CHECKING, map__get() creates a newly
allocated wrapper struct for each reference, meaning two handles to the same
underlying map will have different pointer addresses.

Should this use RC_CHK_EQUAL(al2.map, al.map)?

> +						pr_debug("failed, couldn't find map by build id and offset\n");
> +						err =3D -1;
> +					}
> +					addr_location__exit(&al2);
> +				}
> +				dso__put(dso);
> +			}
> +		}
> +
>  		addr_location__exit(&al);
>  		if (err)
>  			break;

> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-=
parsing.c
> index 20cab91ceaeb2..b49b6dcf10cdd 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
[ ... ]
> @@ -229,6 +229,36 @@ static int do_test(u64 sample_type, u64 sample_regs,=
 u64 read_format)
>  	const u32 raw_data[] =3D {0x12345678, 0x0a0b0c0d, 0x11020304, 0x0506070=
8, 0 };
>  	const u64 data[] =3D {0x2211443366558877ULL, 0, 0xaabbccddeeff4321ULL};
>  	const u64 aux_data[] =3D {0xa55a, 0, 0xeeddee, 0x0282028202820282};
> +	const struct perf_build_id bid =3D {
> +		.size =3D 20,
> +		.data =3D {
> +			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
> +			'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
> +		}
> +	};
> +	const struct perf_build_id callchain_bids[] =3D {

[Severity: Medium]
Will this result in a stack out-of-bounds read when synthesizing
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET?

callchain_bids is declared as an array of 3 struct perf_build_id elements
(3 * 24 =3D 72 bytes).

However, perf_event__synthesize_sample() expects this array to contain
elements of size sizeof(struct perf_build_id) + sizeof(u64) (32 bytes).
It calculates the size as 96 bytes and calls memcpy(), reading past the end
of the stack array.

> +		{
> +			.size =3D 20,
> +			.data =3D {
> +				'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
> +				'9', '8', '7', '6', '5', '4', '3', '2', '1', '0',
> +			}
> +		},
[ ... ]
> @@ -277,6 +307,11 @@ static int do_test(u64 sample_type, u64 sample_regs,=
 u64 read_format)
>  			.size	=3D sizeof(aux_data),
>  			.data	=3D (void *)aux_data,
>  		},
> +		.bid		=3D {
> +			.bid =3D (struct perf_build_id *)&bid,
> +			.offset =3D 0,
> +		},
> +		.callchain_bids =3D (struct perf_build_id *)callchain_bids,

[Severity: Medium]
Are the new PERF_SAMPLE_BUILD_ID_OFFSET fields actually being validated?

do_test() synthesizes events with bid and callchain_bids data here, but
the samples_same() validation function completely omits the COMP() checks
for these new flags.

Does this mean the parsing is never actually verified?

>  	};
>  	struct sample_read_value values[] =3D {{1, 5, 0}, {9, 3, 0}, {2, 7, 0},=
 {6, 4, 1},};
>  	struct perf_sample sample_out, sample_out_endian;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D8
