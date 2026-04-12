Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670538C1F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775961612; cv=none; b=P7fVb8Yx9hOqajAh2WJR9dGIoc4NOQ++oBSJE5npuHDTKMn0xUXCJskhhzPSQIi9U1lRlLcfVo/Xc12E54yTk1L47BJpY5Zqf6dTwik/TG/3T1mM8RK4hDSXcsAZFwxCgau2aEWBt9jB2OqxPAXVNZG14DvFwWlqvyEsf5SccwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775961612; c=relaxed/simple;
	bh=uYs0iGNDRCwc81ld2ejRiFls3mCm8q+LGqtju5la5Ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gzhlOglEVdCtgO0nejXShphYEAkzbi5/xmXS1oDOlmjfoD1WnTC2aUATNyRI2iyl/O4dGlS/RorVUWYKS9gyf9WXG9LtL+BswvrO/1DkISuEi4/mz5Fh4J6Nz1yEbwUhwjc8iC9UaGe2vRzRZsjYWj9atyXv8qtSnbQufJJ5P48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUeZ8rts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUeZ8rts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C43C116C6;
	Sun, 12 Apr 2026 02:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775961612;
	bh=uYs0iGNDRCwc81ld2ejRiFls3mCm8q+LGqtju5la5Ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dUeZ8rtsLFBHLswN1Ncl9UzoYh+z8/Hc/Bkck3WSdGbbFUTGUKTrVE410J+xB14Ea
	 6PiVftHZyFIgC6LrCl0paCaTCsFdfD1IiLaZpAOumbku7s9pAhkfvawXUNIOfoL05H
	 J6UwXNrN5OoBYGpYHmnoQNaqzKO1KCx70Z4ig+UdzGi8k3SgD89o9tLVvQ5eSQueXO
	 mqXhSRosjE3UF5JyKCzE7u4RoR91/DhPpkJpiZs6xrOXasxzgSSW/OKIhkOmYRO3eS
	 PWrgFwtNYDAlZMVJG/vjZHByTg9TgHraEpVM8wiDC97l7H706DxlHLbzP6olU2FWoc
	 kAd6Lku7ol6ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 14/29] perf inject: Don't pass evsel with sample
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260412020833.641177-15-irogers@google.com>
References: <20260412020833.641177-15-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Apr 2026 02:40:11 +0000
Message-Id: <20260412024011.E0C43C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Typo in bounds check for `build_id_size` in `perf_event__synthesiz=
e_mmap2_build_id` causes memory corruption and out-of-bounds read/write.
- [High] The bounds check for `build_id.size` in `perf_event__synthesize_bu=
ild_id` limits the size to the destination buffer's capacity instead of the=
 source buffer's capacity, allowing an out-of-bounds read.
- [Medium] The patch alters the PID and TID used in the synthesized ID samp=
le of `mmap2` events, corrupting the event's sampling context.
--

commit 86c6e453885cee2a25c1c4a4cc9e00545f4ba854
Author: Ian Rogers <irogers@google.com>

perf inject: Don't pass evsel with sample

This commit cleans up the handling of sample and mmap_evsel when
synthesizing build id events. It also attempts to bound check the filename
length to avoid potential buffer overruns.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index 85bee747f4cd2..9a6941cfaad34 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
[ ... ]
> @@ -2252,17 +2267,22 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
[ ... ]
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))
> +		return -EINVAL;
> +
> +	len =3D sizeof(ev.build_id) + filename_len + 1;
>  	len =3D PERF_ALIGN(len, sizeof(u64));
> =20
> +	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;
> +
>  	memset(&ev, 0, len);

Since the commit message explicitly mentions fixing potential buffer overru=
ns
in this function, is this out-of-bounds read another regression that needs
addressing?

Looking at the rest of perf_event__synthesize_build_id():

    ev.build_id.size =3D bid->size;
    if (ev.build_id.size > sizeof(ev.build_id.build_id))
        ev.build_id.size =3D sizeof(ev.build_id.build_id);
    memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);

The check limits ev.build_id.size to the destination buffer's capacity
(24 bytes). However, bid->data is only 20 bytes. If a malformed file
provides a bid->size between 21 and 24, could memcpy() read out-of-bounds
from bid->data?

[ ... ]
> @@ -2308,13 +2328,24 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
[ ... ]
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))
> +		return -EINVAL;
> +
> +	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len =
+ 1;
>  	ev_len =3D PERF_ALIGN(ev_len, sizeof(u64));
> =20
> +	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;
> +
>  	memset(&ev, 0, ev_len);

Similar to the bounds check above, this function is mentioned in the commit
message as receiving bounds checks, but does this existing typo cause a
regression here?

Looking further down in perf_event__synthesize_mmap2_build_id():

    ev.mmap2.build_id_size =3D bid->size;
    if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
        ev.build_id.size =3D sizeof(ev.mmap2.build_id);
    memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);

If ev.mmap2.build_id_size exceeds the bounds, it modifies ev.build_id.size
instead of truncating ev.mmap2.build_id_size. Could this result in an
out-of-bounds read and write in the subsequent memcpy(), potentially
corrupting adjacent fields like prot, flags, and filename?

[ ... ]
> @@ -2339,7 +2370,12 @@ int perf_event__synthesize_mmap2_build_id(const st=
ruct perf_tool *tool,
> =20
>  	array =3D &ev;
>  	array +=3D ev.header.size;
> -	ret =3D perf_event__synthesize_id_sample(array, evsel->core.attr.sample=
_type, sample);
> +	ret =3D __perf_event__synthesize_id_sample(array, sample_type,
> +						pid, tid,
> +						sample->time,
> +						sample->id,
> +						sample->stream_id,
> +						sample->cpu);
>  	if (ret < 0)
>  		return ret;

Before this patch, the sample's PID and TID were extracted from the sampling
context (sample->pid and sample->tid). By switching to
__perf_event__synthesize_id_sample(), this now passes the mmap2 target
pid and tid.

If a thread maps memory for a different process, the target mmap.pid differs
from the sampling context sample->pid. Could this regression break event
correlation for tools relying on the sample ID to identify the thread that
generated the event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260412020833.6411=
77-1-irogers@google.com?part=3D14
