Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7A221275
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489079; cv=none; b=I8EyXphdD7N8HT3QYeEkMbudTVzrHvJyyIivaKUonzugjj4twjaVZpOF8Viq+JyBoXCaKA3gw40lWw2MwC3YzhL3XoTR+CkGJuNXfgKcAenDU0TFJWq1W+u22z17HtlYxoFvNSvem5QSYbHA2+yciWKYkOgJ7OeCbZxty9tSbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489079; c=relaxed/simple;
	bh=Qc5fxahfZ9Jq/TxG77JFffqiUKIs0+jf7V8xFfhyhoU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ko/rOaOuZoEC3EGh8QG+g9OnWe0UlZV/EHyG0dwcxwMJZjg9YrkD0ufsONy4nG8dYGXHWcxrCLiLimQ941EfgW6nKFf16x2MQyLd536NJJt+O1tWQK4XqChNU/lDdpWKDxZUJF9ofBlpagCfBB/FB0SRZ75qKUwt7wVJ+wKTz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZImcYA8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZImcYA8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609581F000E9;
	Fri, 22 May 2026 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779489078;
	bh=kbGMsB0Z2DrOFd2rkX0hx90hbO+RztoqYBcSDlYf3Gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZImcYA8d2a0PSKGAbkXj2eUIYZSfVDjxtZBIaZUPDPn3VZSJOUGHXEXAAj7c6ErED
	 tFq11jTrImDaoKud75CARSbWxWYLxpPDhafZfFTrUciUQgtn9ULaQbKZEQLEqq9++1
	 55lMguKQW2TvC4bEIoGxBgbyTldsbvyKcSIGAjjVdJTx1P9m0LQFwDN1mFRV5rvsoR
	 wrL14+g4qN4qeK525HwLbD5dBBA/+cfg9PbuMf1EjNtSxP5H30XnSfeBjXQ79st1Mk
	 MISFPa8EzRl8qVgp7H0tpER2SZJR+xzuyL0nQd+FrbNggn26j+14xtZFz16JTXvMpE
	 sNBMPKipwFCEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/23] perf python: Add mmap2 event
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260522220435.2378363-17-irogers@google.com>
References: <20260522220435.2378363-17-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 22:31:17 +0000
Message-Id: <20260522223118.609581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The newly added `mmap2_event` Python type omits the core fields =
that distinguish it from the `mmap` event (`maj`, `min`, `ino`, `ino_genera=
tion`, or `build_id`).
- [Medium] Incorrect type identifier 'T_UINT' used for the 16-bit 'misc' fi=
eld, causing Python to read corrupted data for the event.
--

commit 32ac3903a38f752d22cb2845337c77142842e9ac
Author: Ian Rogers <irogers@google.com>

perf python: Add mmap2 event

This commit adds support for the PERF_RECORD_MMAP2 event type to the perf
python API. It registers a new mmap2_event Python object and handlers to
process these events.

> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 029915b7a1fe9..daedd67f12d58 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -153,6 +153,54 @@ static PyTypeObject pyrf_mmap_event__type =3D {
>  	.tp_repr	=3D (reprfunc)pyrf_mmap_event__repr,
>  };
> =20
> +static const char pyrf_mmap2_event__doc[] =3D PyDoc_STR("perf mmap2 even=
t object.");
> +
> +static PyMemberDef pyrf_mmap2_event__members[] =3D {
> +	sample_members
> +	member_def(perf_event_header, type, T_UINT, "event type"),
> +	member_def(perf_event_header, misc, T_UINT, "event misc"),

[Severity: Medium]
Is T_UINT the correct type identifier for the misc field?

Looking at struct perf_event_header, misc is a 16-bit unsigned integer (__u=
16).
Using T_UINT instructs the Python C API to read a 32-bit integer, which mig=
ht
inadvertently read the adjacent 16-bit size field as well and return a
corrupted value.

Would T_USHORT be more appropriate here?

> +	member_def(perf_record_mmap2, pid, T_UINT, "event pid"),
> +	member_def(perf_record_mmap2, tid, T_UINT, "event tid"),
> +	member_def(perf_record_mmap2, start, T_ULONGLONG, "start of the map"),
> +	member_def(perf_record_mmap2, len, T_ULONGLONG, "map length"),
> +	member_def(perf_record_mmap2, pgoff, T_ULONGLONG, "page offset"),
> +	member_def(perf_record_mmap2, prot, T_UINT, "protection"),
> +	member_def(perf_record_mmap2, flags, T_UINT, "flags"),
> +	member_def(perf_record_mmap2, filename, T_STRING_INPLACE, "backing stor=
e"),

[Severity: Medium]
Does this structure omit the core fields that distinguish mmap2 from mmap?

The PERF_RECORD_MMAP2 event is designed to include additional identifying
fields, such as maj, min, ino, ino_generation, and build_id.

Since these fields are missing from pyrf_mmap2_event__members, the Python A=
PI
might not expose the essential data that differentiates an mmap2 event from=
 a
regular mmap event. Should these fields be added so scripts can access them?

> +	{ .name =3D NULL, },
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522220435.2378=
363-1-irogers@google.com?part=3D16
