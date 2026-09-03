Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CEE42048D
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434432; cv=none; b=BLpWVypF86fzJJaEd+K13B5mZsBG/ZUUfQayucZ4/62mJcuxKTomCgqXJqfTRrv1wDdbrR7Vk5FWEfsoJ7edCziExbrMUD/T+oSIu9mKDfjspu5ZyJxWxy6244l3Mk+gy3k/e/QTKNCzzVCLydwEsk2WncMJGCHqsl6gga5WR28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434432; c=relaxed/simple;
	bh=ZTAHRLQVZRIdhgYwC0t8P63V0/rGy9Ig/4wDS1reUJU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MGHJYqckIjhl3PokVV0nSxA21k3nt57XSB6S2o1mQzfSWZlZ9yxX9H/vR12T7oBgFCM/HKhbrfsO8u29GQxYSTv79D59nMwxdbemRHVLR6pSpy5TbuFcU3UeqpBOfHMWENaUJr/LtXylCNvQaoXCDTtn0sU0xRFMS2JMvObpQ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCljp02L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCljp02L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6A41F000E9;
	Thu,  3 Sep 2026 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788434429;
	bh=ojZ+jJk45y+Lh+1EYWcVWkGhSHKK9rLPOjOuwfr9ERQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCljp02LEfdSl3RDfSWDQdYv6zfpyxMfcZDni/GCieMicyxgkQD0ZnJFgCb5E3CMC
	 p6EOp7HY4Y86cA0EWWCGXD0XOBbBovwgLc6kWjT7dzVby1CWjW2CUNP2BnLfN73aRd
	 VXYM1nFhGNdCZ1pdO2qeoV3vHEmt4hwtkuE++kVTO6gZIQb/kfZb5xfJCjNThM3o7X
	 0upcVEq5mQOV4zXY0k6qb3Ovi4/OlC+r5xD8RFl3jvZVcGsoEU/yzMZqN416DKUNyG
	 n/mNTg4WoCy05UFNeM/MHmTD1r0rk/hvykdQtydU4aD/Ro0dFxTrRm3SgPUsFiNqI8
	 d1w1gy1lEobCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf evsel: Validate branch stack before byte
 swapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mark Amirkan" <markdamirkan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260903-sympwn-linux-002-final-v2-v2-1-0aee1fca1f95@gmail.com>
References: <20260903-sympwn-linux-002-final-v2-v2-0-0aee1fca1f95@gmail.com>
 <20260903-sympwn-linux-002-final-v2-v2-1-0aee1fca1f95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 11:20:28 +0000
Message-Id: <20260903112028.EF6A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds read in `__evsel__parse_sample` when parsing truncat=
ed `PERF_SAMPLE_CALLCHAIN` events.
- [High] Out-of-bounds read in `__set_offcpu_sample` via unvalidated `data-=
>callchain->nr`.
--

commit 49a6711ef34085909cadd51b1b19965d5f56040c
Author: Mark Amirkan <markdamirkan@gmail.com>

perf evsel: Validate branch stack before byte swapping

When perf reads an opposite-endian branch stack, __evsel__parse_sample()
swaps each entry before checking whether all entries fit in the event. A
truncated sample can therefore make the swap loop read and write past the
event boundary.

Fixes: 63c12ae2f246 ("perf evsel: Add bitfield_swap() to handle branch_stac=
k endian issue")
Cc: stable@vger.kernel.org
Assisted-by: Symbolic
Signed-off-by: Mark Amirkan <markdamirkan@gmail.com>

[ ... ]

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d4cb455f4a7d4..cc0bc08577540 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3639,6 +3639,8 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  			e =3D (struct branch_entry *)&data->branch_stack->hw_idx;
>  		}
> =20
> +		OVERFLOW_CHECK(array, sz, max_size);
> +

[Severity: High]
This isn't a bug introduced by this patch, but while we are looking at
out-of-bounds reads and OVERFLOW_CHECK() in __evsel__parse_sample(), could
we also fix a similar issue when parsing PERF_SAMPLE_CALLCHAIN events?

tools/perf/util/evsel.c:__evsel__parse_sample() {
...
		if (evsel->core.attr.defer_callchain && callchain_nr >=3D 2 &&
		    data->callchain->ips[callchain_nr - 2] =3D=3D PERF_CONTEXT_USER_DEFER=
RED) {
			data->deferred_cookie =3D data->callchain->ips[callchain_nr - 1];
			data->deferred_callchain =3D true;
		}
		OVERFLOW_CHECK(array, sz, max_size);
...
}

If a user processes a crafted perf.data file containing a
PERF_SAMPLE_CALLCHAIN event with a large callchain_nr but a truncated
payload size, doesn't this access data->callchain->ips[] before
OVERFLOW_CHECK() validates the payload length?

[Severity: High]
This is a pre-existing issue as well, but there appears to be another
out-of-bounds read in __set_offcpu_sample() via an unvalidated
data->callchain->nr:

tools/perf/util/evsel.c:__set_offcpu_sample() {
...
	OVERFLOW_CHECK(array, data->callchain->nr * sizeof(u64), max_size);
	data->ip =3D data->callchain->ips[1];
	array +=3D data->callchain->nr;
...
}

If a crafted perf.data file contains an off-cpu event where
data->callchain->nr is 0 or 1, and the payload is artificially small,
doesn't this unconditionally access data->callchain->ips[1]?

Since it doesn't verify that nr >=3D 2, wouldn't this read past the validat=
ed
nr * sizeof(u64) boundary?

>  		if (swapped) {
>  			/*
>  			 * struct branch_flag does not have endian
> @@ -3654,7 +3656,6 @@ int __evsel__parse_sample(struct evsel *evsel, unio=
n perf_event *event,
>  				e->flags.value =3D evsel__bitfield_swap_branch_flags(e->flags.value);
>  		}
> =20
> -		OVERFLOW_CHECK(array, sz, max_size);
>  		array =3D (void *)array + sz;
> =20
>  		if (evsel__has_branch_counters(evsel)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-sympwn-lin=
ux-002-final-v2-v2-0-0aee1fca1f95@gmail.com?part=3D1
