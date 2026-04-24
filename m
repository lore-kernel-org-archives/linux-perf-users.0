Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B38333745
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051966; cv=none; b=t6W7hW0hp4qWCgz9BD2XmhXjMOv6yp9kkJYSfiQ3PX8UdwRVRZJEwppcaVQXpQ9pHYK3R3YxJ2S+17PvgGBb+SiMvirsHdTs8ISjGbbx3fm/Fv3AdJPJpGQrY4HGOroUXoxUfkqRmca83VMBejessoisftS/gig+qD2B6ljruOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051966; c=relaxed/simple;
	bh=BtBBOrtkVL1yf8p/znzmNcbcvotwm0WoTmm7bogw+44=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EB8Er7Hoo/P5BPN3AwrDK3lm0F2MyD27+dWz2WUKvtrityb8id/uhUKi1UJ18i5GCgc4kdEUuLsvG6PWTBbaHgrCxVvkC6x+NMNRg7eKuEeQOpy2SazMAjADHhowsoifTtfxITNbbDlp6wtKlEeL+PC8F1sgk1Ec6I3sS3arEek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwNFhEXY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwNFhEXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5280C19425;
	Fri, 24 Apr 2026 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051966;
	bh=BtBBOrtkVL1yf8p/znzmNcbcvotwm0WoTmm7bogw+44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nwNFhEXYpXxoCOSE9cY94XzGxleT1wnV78lFH+ojQW1SG7alqK83mR7X0Z9AKfCyz
	 +0wvBn3/pBTF6BLC3nSp9eQVOXKVSwCZI5DOkPnp+g6gj94uNeBOpezl/GjjIS8RPN
	 gvj49sbOWH6O85YbhntTM6wUHQF9DiKwcuFWpDNiOCC3dR2ophdTDg2BRUN8yrMEdE
	 F/hSip0iVr6CAJEL3ZoeZnlaxCqeEFVbc2/NTIajm7LUScRIfYUn/QBuTtd828XwpH
	 /3MvHxUfd9iTRle24VlGkaLAkBFZqFp9mXzWLKopbqkRTizLp/KJonlx/Ax29e/U4E
	 kxXvr2xDU6N/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/58] perf inject: Fix itrace branch stack synthesis
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-2-irogers@google.com>
References: <20260424164721.2229025-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:32:45 +0000
Message-Id: <20260424173245.E5280C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Uninitialized `header.misc` field causes heap memory leak and data=
 corruption.
- [High] The `last_branch` condition bypasses `cut_auxtrace_sample`, leakin=
g AUX data and corrupting the `perf.data` format.
- [High] Hardcoded `branch_sample_type=3D0` in injection callbacks omits `h=
w_idx`, misaligning synthetic event layouts.
- [High] Integer truncation of event size at `PERF_SAMPLE_MAX_SIZE` causes =
0-size records and parser DoS.
- [High] Double-counting callchain size leaks uninitialized heap data into =
output file.
--

commit 0c5343f3bce36f601578ac2b8dba4f4ff1d2039e
Author: Ian Rogers <irogers@google.com>

perf inject: Fix itrace branch stack synthesis

When using "perf inject --itrace=3DL" to synthesize branch stacks from
AUX data, several issues caused failures:

1. The synthesized samples were delivered without the
   PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
   sample_type. Fixed by using sample_type | evsel->synth_sample_type
   in intel_pt_deliver_synth_event.

2. The record layout was misaligned because of inconsistent handling
   of PERF_SAMPLE_BRANCH_HW_INDEX. Fixed by explicitly writing nr and
   hw_idx in perf_event__synthesize_sample.

3. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
   parse failures for subsequent records in the input file. Fixed by
   moving this modification to just before writing the header.

4. perf_event__repipe_sample was narrowed to only synthesize samples
   when branch stack injection was requested, and restored the use of
   perf_inject__cut_auxtrace_sample as a fallback to preserve
   functionality.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>

> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec453..88c0ef4f5ff198 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -375,7 +375,59 @@ static int perf_event__repipe_sample(const struct pe=
rf_tool *tool,
> =20
>  	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> =20
> -	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
> +	if (inject->itrace_synth_opts.set &&
> +	    (inject->itrace_synth_opts.last_branch ||
> +	     inject->itrace_synth_opts.add_last_branch)) {

Can this bypass the perf_inject__cut_auxtrace_sample() call and corrupt
the perf.data format?

If an event has AUX data and last_branch is true but add_last_branch is
false, it skips the block that temporarily clears PERF_SAMPLE_AUX.

The event is then synthesized with its full AUX payload, bypassing the
else if block intended to cut the AUX data.

Later, __cmd_inject() unconditionally strips PERF_SAMPLE_AUX from the
file's global header. Does this leave unadvertised AUX payloads inside
sample records, causing parsers to miscalculate boundaries?

> +		union perf_event *event_copy =3D (void *)inject->event_copy;
> +		struct branch_stack dummy_bs =3D { .nr =3D 0 };
> +		int err;

[ ... ]

> +		if (sz > PERF_SAMPLE_MAX_SIZE) {
> +			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_S=
IZE);
> +			return -EFAULT;
> +		}

Does this allow integer truncation leading to zero-sized records?

If sz evaluates to exactly 65536 (PERF_SAMPLE_MAX_SIZE), the condition
passes. Since event_copy->header.size is a __u16, assigning 65536 silently
truncates it to 0.

Could this cause downstream parsers relying on event->header.size to enter
an infinite loop?

> +
> +		event_copy->header.type =3D PERF_RECORD_SAMPLE;
> +		event_copy->header.size =3D sz;

Does this leak uninitialized heap memory and corrupt metadata?

The event_copy buffer is allocated via malloc() which does not zero out
memory.

The header.type and header.size fields are set here, but the header.misc
field is omitted. perf_event__synthesize_sample() writes the payload but
does not touch the header.

Could this cause the output perf.data file to contain garbage for critical
flags like the CPU mode (PERF_RECORD_MISC_USER or KERNEL) and exact IP
flags?

> +
> +		err =3D perf_event__synthesize_sample(event_copy, evsel->core.attr.sam=
ple_type,
> +						    evsel->core.attr.read_format,
> +						    evsel->core.attr.branch_sample_type, sample);
> +
> +		evsel->core.attr.sample_type =3D orig_type;

[ ... ]

> @@ -464,7 +516,8 @@ static int perf_event__convert_sample_callchain(const=
 struct perf_tool *tool,
>  	sample_type &=3D ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
> =20
>  	perf_event__synthesize_sample(event_copy, sample_type,
> -				      evsel->core.attr.read_format, sample);
> +				      evsel->core.attr.read_format,
> +				      evsel->core.attr.branch_sample_type, sample);
>  	return perf_event__repipe_synth(tool, event_copy);
>  }

This isn't a regression from this commit, but does
perf_event__convert_sample_callchain() double-count the callchain size?

It calculates the new sample_size by taking the original event->header.size,
subtracting stack and regs sizes, and adding the new callchain size, but it
never subtracts the old callchain size.

Does this cause event_copy->header.size to be larger than the actual
synthesized payload, leaking uninitialized heap memory into the output file?

> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b824..2dce6106c038d7 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1731,8 +1731,12 @@ static void intel_pt_prep_b_sample(struct intel_pt=
 *pt,
>  static int intel_pt_inject_event(union perf_event *event,
>  				 struct perf_sample *sample, u64 type)
>  {
> -	event->header.size =3D perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.type =3D PERF_RECORD_SAMPLE;
> +	event->header.size =3D perf_event__sample_event_size(sample, type, /*re=
ad_format=3D*/0,
> +							   /*branch_sample_type=3D*/0);
> +
> +	return perf_event__synthesize_sample(event, type, /*read_format=3D*/0,
> +					     /*branch_sample_type=3D*/0, sample);
>  }

Does passing 0 for branch_sample_type misalign the synthetic event layouts?

If the corresponding synthetic evsel header natively has
PERF_SAMPLE_BRANCH_HW_INDEX set, the output file will contain an evsel
claiming hw_idx exists.

However, because the payload is synthesized here with 0, it will lack the
8-byte hw_idx field. Could this misalign the reading of branch entries and
subsequent fields?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D1
