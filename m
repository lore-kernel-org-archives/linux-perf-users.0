Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BB71C2AA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483981; cv=none; b=BsjHYqza4NmW+n4gXpnHgpG49gW50rmUz+Po8q5v6ONVn5sprdOKyKXSYxzRLQtVAeSWa/llAqC7tJAW1sCRUXCaiackWSC32dH1hm+Dg3XDC52tZC9Ssn9wwBo0mGlsD90n4tBKn3hFIEeovkPfYoQb9J8KHT4vwOf84BtPmCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483981; c=relaxed/simple;
	bh=sPWnkeJYw4zURj6c2PdRHo0FU9m7mzmZhOOHvFDM51c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vo8gZRCWWfdXi79U/saHR3zDxvdA/SDUVT9zWL87V11c47UaAKQvXoMdW0HDLDLEoKuDAdNMzzf3tHp+8wQplsC4mnrPWfOEzFHDg6Y/6r651ghCMA5BPChsLv7RNf7mv5RTZ7zLjBZMuwRv1uJHJ2GlvqA1x1Iyje9DocOyzig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3xFJRvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3xFJRvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDF51F000E9;
	Mon, 15 Jun 2026 00:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781483980;
	bh=OhMGYM//werjHauMTjyxTQnwoZOv19WMQBVm40o/y90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y3xFJRvlcdO9NtDKEBfOjTpn31XVyJz1DK406khI6VIWIMu2Gzb1U3QFwGkEJ9l9B
	 BaaC2Sp71lntv13TI9MSSQSEv/BM5eG9ETJ5MkLpxnI6XtYjCRRzd8tP+7a4Q5KE6Q
	 BcySBm+9CKpOqUxsBSYx+/MAjH/zODKDnxDDnrV6kgyCmIeIhNvefiajnb46zSkvhZ
	 KaccrlRhvLsEELA098T2QyrXeDdAU+Rb+8HGyfvU8Ep1rmLky7oRyhjNKWqMVtUJWy
	 BpFpXZgmvk7iD8wHXzdk5tZ1ue84FuV17Fx5DZvESHRRQ7uD53PCuOzIkfC2P93RHj
	 jJKn5Cw07fH8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 12/20] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615002812.2234795-13-irogers@google.com>
References: <20260615002812.2234795-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 00:39:39 +0000
Message-Id: <20260615003940.1FDF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing explicit NUL-termination for PERF_RECORD_MMAP and PERF_REC=
ORD_COMM events allows an out-of-bounds read and heap leak when parsing mal=
iciously crafted perf.data files.
--

commit eb4ed718705e43e560f0b31c906b8c79e288206f
Author: Ian Rogers <irogers@google.com>

perf python: Add mmap2 event

This commit adds support for mmap2 events to the perf Python bindings. It
introduces a distinct Python event type for mmap2 to ensure it is handled
analogously to standard mmap events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 6a84cfcc34ea8..5f1d6fd9b0825 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
[ ... ]
> @@ -874,6 +1021,9 @@ static PyObject *pyrf_event__new(const union perf_ev=
ent *event, struct evsel *ev
>  	if (copy_size < sizeof(pevent->event))
>  		memset((char *)&pevent->event + copy_size, 0, sizeof(pevent->event) - =
copy_size);
> =20
> +	if (event->header.type =3D=3D PERF_RECORD_MMAP2)
> +		pevent->event.mmap2.filename[sizeof(pevent->event.mmap2.filename) - 1]=
 =3D '\0';
> +

[Severity: High]
This isn't a bug introduced by this patch, but since you are explicitly
NUL-terminating the mmap2 filename here, should we do the same for
PERF_RECORD_MMAP and PERF_RECORD_COMM events?

If a crafted perf.data file provides an event with a header.size exactly eq=
ual
to sizeof(union perf_event) without a NUL byte, copy_size will equal the un=
ion
size and the memset zero-padding logic above is bypassed.

When Python accesses these fields without implicit padding (e.g. via attrib=
ute
access calling strlen, or __repr__ calling asprintf), could it read past the
end of the struct pyrf_event heap allocation?

>  	perf_sample__init(&pevent->sample, /*all=3D*/true);
>  	pevent->al_resolved =3D false;
>  	addr_location__init(&pevent->al);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615002812.2234=
795-1-irogers@google.com?part=3D12
