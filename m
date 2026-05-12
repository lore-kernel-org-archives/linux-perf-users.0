Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792930B53E
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558921; cv=none; b=ZctUs9RwgNsbyvxJrWUj9SlsC1T8Owks95qyKoURIlWtQ57PaoLts6iVAPvvkQPRPvhLlHKpvAEuW1hZXEIR35dMqolpjFy43Pp1IHB/wixLcVl920LscCQISSvg2pgpks4nVF9wDr8r6vZcjquXiYgdL0XCwIFWvRWCNfvgvXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558921; c=relaxed/simple;
	bh=3PRpv5SmPEffUhjjrDGHYz9P9l12N8ocHFax5/sz4bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tzibhDNwxvzrDm1kaIfgIcr0e14G/JYgblVx/ba/uWe3+C+d1AP7twaOW7c8H8ItrYI6/HW/JpUmUj2zsVvAf1ekp0TVXQJ7BN4xSOIcxV9GYrVXKi3DemjMJ7DQrOvoH2LSqxPWDxVtvYTQTagsjGUQktc3Duc+qpkowj/ev6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfklP/Ww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfklP/Ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1597C2BD00;
	Tue, 12 May 2026 04:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778558921;
	bh=3PRpv5SmPEffUhjjrDGHYz9P9l12N8ocHFax5/sz4bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XfklP/Ww2Si9MGODSDAq/q56OebZgbOzodRCxl4i6JZ40GmjNnyDJzytE44zNNzim
	 sXSPhrlFXtdEhHul1KKujHjYEs3Y42ytq3agv8XZyVc6f+lz8dW3MzaTWVMONuIgzZ
	 3FDicf3Q0z76oACXgQ3t/iP7K66V1aiYXmq4qfoKjRPLM1+/vHZ0ANtaHoL3mTiDgN
	 L4e8GxrmQ5YD53WvMLKT5vfSii0npBFqTUtjqZJX4W1RnNwb9NePyu30AO29NGvaUA
	 5nEaWnCrcUNl+tREkhSkeU1Y6WlytKkCJUf32FAh4PzfRnKONDm3x80q3st28ZXKtg
	 TqhuC43gKV3wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/28] perf session: Add validated swap infrastructure
 with null-termination checks
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510033424.255812-8-acme@kernel.org>
References: <20260510033424.255812-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 04:08:40 +0000
Message-Id: <20260512040840.D1597C2BD00@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Missing bounds checking on the 'nr' array lengths during event=
 swapping in namespaces, thread_map, and cpu_map events allows malicious fi=
les to trigger massive out-of-bounds memory writes.
- [Critical] Missing size validation for `attr.size` in `perf_event__hdr_at=
tr_swap` leads to an integer underflow when calculating the remaining event=
 size, resulting in a massive out-of-bounds byte-swap.
- [High] In `perf_session__peek_events()`, the `err` variable is not cleare=
d after recovering from a malformed event, causing a spurious failure if th=
e skipped event is the last one in the processing range.
--

commit 7c3c4093f667e7200ed0e5c01305bf100df4a7ac
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf session: Add validated swap infrastructure with null-termination checks

Change swap callbacks from void to int return so handlers can propagate err=
ors.
Adds null-termination enforcement on the common event delivery path.

> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c

[ ... ]

> @@ -458,18 +506,25 @@ static void perf_event__namespaces_swap(union perf_=
event *event,
> =20
>  	if (sample_id_all)
>  		swap_sample_id_all(event, &event->namespaces.link_info[i]);
> +	return 0;
>  }

Is there a missing bounds check on the nr array lengths during event
swapping here and in thread_map/cpu_map events? It seems a large nr value
could force the loop to write out-of-bounds and corrupt adjacent memory.
I see this is addressed in the subsequent patch "perf session: Validate nr
fields against event size on both swap and common paths".

[ ... ]

> @@ -560,30 +625,34 @@ static void perf_event__hdr_attr_swap(union perf_ev=
ent *event,
>  	size =3D event->header.size;
>  	size -=3D perf_record_header_attr_id(event) - (void *)event;
>  	mem_bswap_64(perf_record_header_attr_id(event), size);
> +	return 0;
>  }

Could a maliciously large attr.size cause the size calculation to underflow,
resulting in a massive out-of-bounds byte-swap? I note this is also fixed
later in the series by the patch "perf session: Validate HEADER_ATTR
alignment and attr.size before swapping".

[ ... ]

> @@ -1968,15 +2169,34 @@ int perf_session__peek_events(struct perf_session=
 *session, u64 offset,
>  {
>  	u64 max_offset =3D offset + size;
>  	char buf[PERF_SAMPLE_MAX_SIZE];
> -	union perf_event *event;
> +	/*
> +	 * Initialized to NULL so the first-iteration error path
> +	 * doesn't dereference stack garbage.  On subsequent failures
> +	 * event may point into buf from a prior read =E2=80=94 peek_event
> +	 * sets *event_ptr on min_sz and swap failures so the header
> +	 * is from the current (failed) event, not a stale one.
> +	 */
> +	union perf_event *event =3D NULL;
>  	int err;
> =20
>  	do {
> +		event =3D NULL;
>  		err =3D perf_session__peek_event(session, offset, buf,
>  					       PERF_SAMPLE_MAX_SIZE, &event,
>  					       NULL);
> -		if (err)
> -			return err;
> +		if (err) {
> +			/*
> +			 * peek_event sets event_ptr when it read enough
> +			 * to know the event size (min_sz and swap failures).
> +			 * If event is NULL or size is 0, we can't advance
> +			 * and must abort.  Otherwise skip past this entry.
> +			 */
> +			if (event && event->header.size)
> +				offset +=3D event->header.size;
> +			else
> +				return err;
> +			continue;
> +		}

If we successfully recover from a malformed event by advancing the offset
and calling continue, but it happens to be the last event in the requested
range (offset >=3D max_offset), does the loop exit and return the stale
failure code from peek_event instead of 0?

It seems the err variable retains the -1 failure code from the last
iteration which might cause a spurious failure in the caller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510033424.2558=
12-1-acme@kernel.org?part=3D7
