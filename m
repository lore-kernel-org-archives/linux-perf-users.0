Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60674345751;
	Fri,  7 Aug 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096032; cv=none; b=Oyo7QvigEGwttyauWegjd/W37qGVgNSnKiIUmFJ9vjfDq4eEo3VY78DuSGZHGdQXcgkVAMO8pngDzwmI+kJw5wSZXKrwYYea7yoSQ+LJHfmmT+w+ttAwOigKAQESJ4FIc+U5Nr1LOe+lw8oOmsTHfneRDv6izu03wMmn3iJjvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096032; c=relaxed/simple;
	bh=r0gfbbtfnyZuEoXOLi2GQPZfWDPfOEIKOH7nglf6Ns4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oy0ZyJcdPb1ZSKnEeLVeF1ZsdxRoYuTG99gBS+VciXTUcEl2ufS8BE9/ZU57lgi/rEo/AOs3TC5wbWo9TfAlfCUe+1SqMOfK1GQCzuJkTjFfi0Sz0F8aTqo7RL8Dk2V9fgRQ3goXLc6GAS88hbo+IWO51rmBmZpzeeRBjHJqKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5aTnC2u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5aTnC2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0491F000E9;
	Fri,  7 Aug 2026 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096031;
	bh=p32wqI4JRG6kPCRm6TN/wJMnTvOEVt3jQJYsXtZ8jVM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M5aTnC2ubXB7NGkaHC6CS++PJnn7a6VTOLjNkUkjNiGaq7isrX3GhMytc0fDM4KUJ
	 K22FaTz5uC7bGegrUUKxUmUK9GTDsGujo/6VDCLOasRiEsyGGygHGhOukbuyiVnaNE
	 iFHjuM7gfbvRX+UITzB4imx5UePPed/T2VzgSv4k8lpP0j3ggIIM9qyCEkaic/O5Gn
	 dU/xBz5q95UYuHz5xsFh42H+p5aAjrn291cEJ023JUsOADtoD5zkts9I2BG5WTUx5K
	 YM1slbsUA0SeRBTvubZmfcyLgLQmmPha4vvXLM3L0wmNSbvWkkYZp8j4bPqQpkdTTO
	 v9DoEIEuecjqg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 7/8] perf record: Add --buildid-offset option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260807071818.718751-8-irogers@google.com>
References: <20260807071818.718751-1-irogers@google.com>
 <20260807071818.718751-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 09:47:10 +0000
Message-Id: <20260807094710.CA0491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] evsel__parse_sample() is vulnerable to an out-of-bounds read when =
parsing PERF_SAMPLE_BUILD_ID_OFFSET due to missing bounds checks and under-=
counted sample_size.
- [High] --buildid-offset silently produces unusable recordings if --buildi=
d-mmap is disabled or unsupported.
- [High] Integer overflow in OVERFLOW_CHECK calculation for PERF_SAMPLE_CAL=
LCHAIN_BUILD_ID_OFFSET bypasses bounds verification on 32-bit hosts.
- [Medium] perf report natively handles callchain build ID offsets but its =
front-end argument validation incorrectly rejects them.
- [Low] An empty if block with commented-out code was added to cmd_record.
--

--- Patch [7]: [RFC PATCH v1 7/8] perf record: Add --buildid-offset option =
---
commit 1f8464ef5aa5b3d651d1ae57de1909d39b5f085c
Author: Ian Rogers <irogers@google.com>
Date:   Fri Aug 7 07:18:17 2026 +0000

perf record: Add --buildid-offset option
   =20
Add the --buildid-offset flag to perf record to natively request
PERF_SAMPLE_BUILD_ID_OFFSET and PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET
from the kernel. This configures the evsel attributes by replacing
the standard IP and CALLCHAIN bits with the build ID offset equivalents.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index f58d7e3c7879e..9ff9cfc062788 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c

[ ... ]

> @@ -4166,6 +4168,11 @@ int cmd_record(int argc, const char **argv)
>  		rec->no_buildid_cache =3D true;
>  	}
> =20
> +	if (rec->opts.buildid_offset) {
> +		/* Do not drop mmap events here so we can generate build ids later */
> +		/* rec->opts.synth &=3D ~PERF_SYNTH_MMAP; */
> +	}
> +

[Severity: Low]
Is this commented-out code still needed, or can this empty block be removed?

[Severity: High]
Can sample resolution silently fail if --buildid-mmap is unsupported or
disabled?

If a user explicitly requests --buildid-offset but disables --buildid-mmap,
or the kernel does not support MMAP build IDs (which causes perf to forcefu=
lly
disable --buildid-mmap), the MMAP events will lack build IDs.

This causes thread__find_map() and maps__find_by_build_id() to silently fai=
l,
resulting in broken profiles with unknown symbols and bypassing the final
post-processing step to read build IDs from disk.

Should we enforce the dependency on rec->buildid_mmap here?

>  	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d9a07f5825e82..587f0fa41cce8 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -1744,6 +1744,17 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  	if (opts->sample_transaction)
>  		evsel__set_sample_bit(evsel, TRANSACTION);
> =20
> +	if (opts->buildid_offset) {
> +		if (evsel->core.attr.sample_type & PERF_SAMPLE_IP) {
> +			evsel__reset_sample_bit(evsel, IP);
> +			evsel__set_sample_bit(evsel, BUILD_ID_OFFSET);

[Severity: High]
Does this allow an out-of-bounds read in evsel__parse_sample()?

When evsel__set_sample_bit() is called, __evsel__set_sample_bit() blindly a=
dds
sizeof(u64) (8 bytes) to evsel->sample_size. However, the actual payload for
PERF_SAMPLE_BUILD_ID_OFFSET is 32 bytes (24 bytes for build_id + 8 for offs=
et).

Because of this under-counting, a crafted or truncated perf.data file can
pass the initial perf_event__check_size() validation. Then, in
evsel__parse_sample(), PERF_SAMPLE_BUILD_ID_OFFSET is parsed without any
explicit OVERFLOW_CHECK, allowing the pointer to read out-of-bounds.

> +		}
> +		if (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
> +			evsel__reset_sample_bit(evsel, CALLCHAIN);
> +			evsel__set_sample_bit(evsel, CALLCHAIN_BUILD_ID_OFFSET);

[Severity: High]
Does this cause an integer overflow on 32-bit hosts?

When parsing PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET in evsel__parse_sample(),
a maliciously crafted file could provide a massive size (e.g., 0x08000001).

The macro OVERFLOW_CHECK performs sz * (sizeof(struct perf_build_id) +
sizeof(u64)), which is sz * 32. This results in 0x100000020 in 64-bit
arithmetic, but on 32-bit hosts, the pointer arithmetic inside OVERFLOW_CHE=
CK
truncates the 64-bit size to 32 bits (0x20).

This trick effectively bypasses the bounds verification, while the raw
size is assigned to callchain_bids_nr, causing an out-of-bounds read during
iteration.

[Severity: Medium]
Will this replacement break perf report when users run it with -g?

If a file is natively recorded with --buildid-offset, the CALLCHAIN bit is
dynamically replaced by PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET.

However, in builtin-report.c:cmd_report():

    if (!is_pipe && !(sample_type & PERF_SAMPLE_CALLCHAIN)) {
        if (perf_hpp_list.parent) {
            ui__error("Selected --sort parent, but no "
                      "callchain data. Did you call "
                      "'perf record' without -g?\n");

This strict check seems to completely ignore that the bit was replaced by
CALLCHAIN_BUILD_ID_OFFSET, causing perf report to incorrectly reject these
files.

> +		}
> +	}
> +
>  	if (opts->running_time) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807071818.7187=
51-1-irogers@google.com?part=3D7
