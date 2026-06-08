Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF526273803
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951860; cv=none; b=Co52r/I3r+J0sIqB5JnmOAcmi32BU8Y83m0DxsBGUrE5fAXzJyTcRhgt/N7egtHV02B6FcyPluO7mda8Irbgi1cn3pdubvkst9+b3GjjFuBZFwUD1OhLuOjsPrWWBKiZDtXnhRVT2k/YqnsucgH/ucExNKTeC7NASrq5uZSkjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951860; c=relaxed/simple;
	bh=NrnivD7HKMC7er/aVrZuTOdQxIs6bNWfoJJoq0BZ3sc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kuHlSL+1hMUBbt3vvU7T/yfs9hgJcKYEu9UgCRqhucYaJHCXzIhL4XzYjYA20NpiJDcLsJ9A5TcL2Whq4wr2WrWbEykH84LNHF3z4sGf8wuv24I9Yjmlgz1v/P6uQcQo0RySopxICybMNgMOWEYaBnYdEEHM4mBPtyHBw/vzxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol74qCLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol74qCLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD01F00898;
	Mon,  8 Jun 2026 20:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780951859;
	bh=G0vKPv+z/ZMgMQlQJTVD5BdmmuRLIf0PXkPCL/ni6+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ol74qCLpm3GcbkxXNk00oQk5bjDOx7elxB7lxcEaHKe1UkyrzmNIzT9vtrNtZOxHI
	 ELJnhyTko+vxpkud+c2t09b0MrkGLv6AIW5nv0RiwfjoAM7vVe8iUcf1grZlskUGsW
	 2/12oaS54QuMfm5ZPa8GmSOJOP2wKOTOJmPFBoa2XobMxzMBM19FyhKTKq+UvupREV
	 4FrC2/ggVXiEObV46bMs6S6LdUKYOoNJh4O6rEl4NNPS/MkoKIrSgNIEPHe54SEfdb
	 yYqG6KOpiwpv5pNvO7r/9ZvqUm9aXD7wKjRrfzhNMFFImVxqp1wwVDbLS1LvfvW5lU
	 WYFRktrbgCM9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608201753.1979464-11-acme@kernel.org>
References: <20260608201753.1979464-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:50:59 +0000
Message-Id: <20260608205059.7ECD01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The early termination condition `offs < bf_size` is rendered ineffe=
ctive by the switch to `scnprintf`.
--

commit 0dbaa7b9065f01d9d8a6117248bffa97b3021ddf
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()

This commit replaces snprintf() with scnprintf() in build_id__snprintf()
and hwmon_pmu__describe_items() to prevent accumulated lengths from exceedi=
ng
the allocated buffer size and underflowing the remaining size.

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 8c0a9ae932aa5..a3b92108f9626 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -94,7 +94,7 @@ int build_id__snprintf(const struct build_id *build_id,=
 char *bf, size_t bf_size
>  	}
> =20
>  	for (size_t i =3D 0; i < build_id->size && offs < bf_size; ++i)
> -		offs +=3D snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i=
]);
> +		offs +=3D scnprintf(bf + offs, bf_size - offs, "%02x", build_id->data[=
i]);

[Severity: Low]
Does this change neutralize the early termination condition in the loop?

Since scnprintf() returns the number of characters written excluding the nu=
ll
terminator, `offs` will reach at most `bf_size - 1` and never equals `bf_si=
ze`.

Once the buffer is full (`bf_size - offs =3D=3D 1`), scnprintf() will only =
write a
null terminator, returning 0. Because `offs` stops increasing, the condition
`offs < bf_size` remains true. This causes the loop to continue writing not=
hing
for the remaining `build_id->size` iterations instead of exiting early.

> =20
>  	return offs;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.1979=
464-1-acme@kernel.org?part=3D10
