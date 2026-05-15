Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7BD191
	for <linux-perf-users@vger.kernel.org>; Fri, 15 May 2026 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778803399; cv=none; b=A+Rprs6V1ZZWhLLD4ijR906X9dHFJrkCym3Tat3pNKOUlrSZNIrY04QHNMfyYKZ0ZM1hkkfJs6EKECDVQFhnB0M9sDdPJT+80B3HY/lrRbauQYS5QLZ+6A5R2+/2ZuX6xW3jFmr5RIlSTZelDrItE24dh8y+m/vpf9ZqMUbSZpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778803399; c=relaxed/simple;
	bh=YWyUBaxbmzVRc4PX5tz0Kv+6kZIzGzis9nueA8YxjkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EnlW8xWPxXfOEVKupXqWyTPZPIHrGL6a/ujgK6SurClvx0fLh9G+rYT3NEjzfeHTSJhXhoQ40f78YKo+1du5YtSf+DbqR56X1dsKwBNoz9dUYHeIqS8KRd4Gbu7A2Cc3BUcQhFnlcWRNSWEW9sjsre1NEHRZsZ5knwr3ur6Oiks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhWRKirS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhWRKirS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C4AC2BCB3;
	Fri, 15 May 2026 00:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778803399;
	bh=YWyUBaxbmzVRc4PX5tz0Kv+6kZIzGzis9nueA8YxjkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=VhWRKirS8EdBsh3chZ2KDqDS3TUcfSFnIyqIiXR9jqmLUAlRCzGOCopL5Bu/oebCi
	 lkClqhKGC9GUyov1Cl4/JLSLV1wanDBYQ4N4TGUbD7qgBw2av/5VtYZMAV7u40GRDK
	 n4PBp+tnbjjmbvJeM2cb8Rbk/c6KshWDGmeKPhrjmf3Y7h3iblOtKTp5IpxW8iw4Rg
	 Od34KXOne8UCn48pwlZWR5gs5w/fhAUjjgB/kfiPIxxLcBdQJc3Lwiiyq9UMcKrIqF
	 Zm3vX9JLanQDGgqiBExlF9ddnWZMPjBIHub79AeGEh9z56HO/CQZRsLXSSKDoNLt9y
	 x0UuE35EXmOMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 26/32] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260512223001.2952848-27-irogers@google.com>
References: <20260512223001.2952848-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 00:03:18 +0000
Message-Id: <20260515000318.E9C4AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The bounds check improperly rejects valid long filenames, causin=
g event synthesis to fail.
--

commit ebc11360c993e5ddd076dd7aad06f59d0ec332b8
Author: Ian Rogers <irogers@google.com>

perf synthetic-events: Bound check when synthesizing mmap2 and build_id eve=
nts

This commit introduces bounds checking in perf_event__synthesize_build_id()
and perf_event__synthesize_mmap2_build_id() to ensure synthesized events do
not overflow the stack. It validates the filename length and total event si=
ze
before proceeding.

> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthet=
ic-events.c
> index de812a2befbc7..0816f893b9160 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct =
perf_tool *tool,
>  				    const char *filename)
>  {
>  	union perf_event ev;
[ ... ]
> -	len =3D sizeof(ev.build_id) + strlen(filename) + 1;
> +	if (filename_len >=3D PATH_MAX)
> +		return -EINVAL;
> +
> +	len =3D sizeof(ev.build_id) + filename_len + 1;
>  	len =3D PERF_ALIGN(len, sizeof(u64));
> =20
> +	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;

Will this bounds check reject valid, long filenames?

If sizeof(ev) evaluates to the fixed size of union perf_event (around 4168
bytes), and a valid filename approaches PATH_MAX (e.g., 4048 to 4095 bytes),
adding the 48 bytes for MAX_ID_HDR_ENTRIES * sizeof(__u64) exceeds sizeof(e=
v).

Does this code need to dynamically allocate a sufficiently large buffer or
safely truncate the filename, rather than returning -E2BIG and causing
callers like perf inject to abort?

[ ... ]
> @@ -2303,14 +2309,21 @@ int perf_event__synthesize_mmap2_build_id(const s=
truct perf_tool *tool,
>  					  const char *filename)
>  {
>  	union perf_event ev;
[ ... ]
> -	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filena=
me) + 1;
> +	if (filename_len >=3D sizeof(ev.mmap2.filename))
> +		return -EINVAL;
> +
> +	ev_len =3D sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len =
+ 1;
>  	ev_len =3D PERF_ALIGN(ev_len, sizeof(u64));
> =20
> +	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
> +		return -E2BIG;

Does this exhibit the same rejection of valid long filenames as the bounds
check in perf_event__synthesize_build_id() above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512223001.2952=
848-1-irogers@google.com?part=3D26
