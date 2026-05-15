Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D31438D3ED
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875838; cv=none; b=m2DHlDLGthsZUb14xEsTrt11i3KwZFDbP3wGlNa/xDZf3/fRHnC+pIgogfFpyvTJYwnmP1g6pUS0s3mPVxlBWRVe7cXP3ojbY83sEGRXj/mTHmTKaehXxw2bJV9qdnDoLnmgFMTaZdF5RwDKozkloH/O84JVxREz7v+7yoB1uSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875838; c=relaxed/simple;
	bh=i/DlA1tDrqLsR3aBeJqJYHh0eKmDA2zAQqYCEYgJgac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hD3XFieuKs4Ghr4H01mlbTpZSHucpndugp9FVC3Fdd5BWzfZ61rz3NO1B6zHAMhUmPvB1/d+UjsE/BkNOPTLkUlpxLFMQnBDHY9pHDSkyJCsz3PKhimRHnrPQ34x5zKK4hPtJRCbInfaTZ1vJ7chR0EAfZCCLUZopQmMfq2H5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctwSLLBq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctwSLLBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7137C2BCB3;
	Fri, 15 May 2026 20:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778875837;
	bh=i/DlA1tDrqLsR3aBeJqJYHh0eKmDA2zAQqYCEYgJgac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ctwSLLBqbmllUI9g6zqnKv9Xi43oxTMB/m57bwLwPnmFhb7hLXCR4nXYdigOvPUZ7
	 4PdTxH5hx3Gbj6XJ0JJeJtv9ZfSAXfTrBnyxpzT71F7LcG0r2zKW9VV1CBr7jkfwQK
	 V4w37aAZNR6o38eJRUNCzXMFsfwcheqYGE1bDx5CV+pNsfagUElJ9KRminX4SrwCif
	 uqDl+5oTQFlS9hzbpR7UaT16gzLenBS5uc7ZTupTGKQ5DmW5nk0sawlEORSCBvEyZo
	 s5REZ6MLReHBfmcSWSeftBqw3w0BjhTnOvBaV3ycmlpdelTwwyUVqUAMbYSWBgaRVx
	 IDwuZ3NUK38bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf evsel: don't set PERF_SAMPLE_IP for
 unprivileged tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anubhav Shelat" <ashelat@redhat.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260515194010.93725-3-ashelat@redhat.com>
References: <20260515194010.93725-3-ashelat@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 20:10:37 +0000
Message-Id: <20260515201037.B7137C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Uprobes silently lose the `PERF_SAMPLE_IP` bit when `perf` is buil=
t without `libtraceevent` support, breaking uprobe profiling for unprivileg=
ed users.
--

commit 07ebb257f5c9c09215f15379588d99009f389e9e
Author: Anubhav Shelat <ashelat@redhat.com>

perf evsel: don't set PERF_SAMPLE_IP for unprivileged tracepoints

This commit avoids exposing kernel addresses by dropping the PERF_SAMPLE_IP
bit for unprivileged tracepoints. It makes an exception for uprobes since
they expose safe userspace addresses.

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c

[ ... ]

> @@ -1509,7 +1509,19 @@ void evsel__config(struct evsel *evsel, const stru=
ct record_opts *opts,
>  	attr->write_backward =3D opts->overwrite ? 1 : 0;
>  	attr->read_format   =3D PERF_FORMAT_LOST;
> =20
> -	evsel__set_sample_bit(evsel, IP);
> +	/*
> +	 * Don't set PERF_SAMPLE_IP for unprivileged kernel tracepoints to
> +	 * avoid exposing kernel addresses. Uprobes expose only userspace
> +	 * addresses so they're safe. Detect entry and return uprobes.
> +	 */
> +	if (attr->type !=3D PERF_TYPE_TRACEPOINT || perf_event_paranoid_check(1)
> +#ifdef HAVE_LIBTRACEEVENT
> +	    || evsel__field(evsel, "__probe_ip")
> +	    || evsel__field(evsel, "__probe_ret_ip")
> +#endif
> +	    )
> +		evsel__set_sample_bit(evsel, IP);

Does this silently drop the PERF_SAMPLE_IP bit for unprivileged uprobes when
perf is built without libtraceevent support?

If HAVE_LIBTRACEEVENT is not defined, the uprobe detection logic is compiled
out, meaning the condition evaluates to false for unprivileged uprobes.

Is there a fallback detection mechanism that could be used here (such as
checking the event or PMU name) to ensure uprobe profiling continues to work
for unprivileged users on these builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515194010.9372=
5-2-ashelat@redhat.com?part=3D1
