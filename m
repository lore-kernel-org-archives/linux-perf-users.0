Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BF2405E1
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967838; cv=none; b=lWnwDUsc/zKVH4miPpaFIUNW+MEc7ogOlQVF4HX5N+UF+F+Oa2X8xLq7tqg7O8vFw8PG6/d5aWJRXerfmcefnaikfQ9E5wi74R9MiKHHUJYDNtp/7lwLPPgDzf9HOwFTQQvv/LmiG7Kbsk4+7zT01izwbTvyGsAn4XjpBzgcocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967838; c=relaxed/simple;
	bh=UULsYYKbmtLhRO6zQ26vkpBtpirWokZEp/MKdhzla4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cL5f62Xfb1necWclr8oS29apdBDJwNKke/Pyl8fdeiAlN1VcOhVAAIa91izp4yUsct6vpu4wA9IOTF8NIM1QATtgEgt0fGZXnk19nsp+6YJsuXxKyMZ6Z0KIH7Cpuc6vKLZbgo5JYFM2uAtvoDWpv3G5c82Wj4/pPlCnlJ2jqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWTl203w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWTl203w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A371F00893;
	Tue,  9 Jun 2026 01:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967837;
	bh=ZOlv5T13yTWy82PemwUpU2FsZAI/OILiuZ6YdMSXSrk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWTl203wM0zeBg8z7pkyRZNq2yjep7cXX7it+ZPvYgOzCP2wvCGNGSMVafMTscqez
	 O92pfYnUzuwYmk2LAIbwDqCILOEpdwQ9olO/vunJMF2u7carL+mYxbz5aC6IjLIegW
	 /Qquyg9zHBhutmaBD0XCUnMTzNIrd6LC3XMRFJMB7KruR33GbWYyeuiTuPiNHgCSxe
	 m/JT5Dxbvo3W/EkHJZfs7SKzmfNSFgO9BCJfrxxs0rtDcxX2BCOMVgO/yLbdgtVMor
	 vniBJMJTb9erJ0r2MoX0mnUXHfTXGpCf80mOu3HuA5YvnTkgIzwv0J9VusqvkB/xcG
	 j7662bZfTPTNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in
 build_id__snprintf() and hwmon read_events()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-11-acme@kernel.org>
References: <20260609010526.1998472-11-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:17:17 +0000
Message-Id: <20260609011717.79A371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] build_id__snprintf() fails to null-terminate the output buffer w=
hen bf_size is 1.
- [Low] hwmon_pmu__describe_items() spins doing useless sysfs operations on=
ce the output buffer fills.
--

commit 0f670823c7b8e81b469db29dc89cf4b4de7e4cad
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()

This commit switches build_id__snprintf() and hwmon_pmu__describe_items()
to use scnprintf() instead of snprintf() to prevent out-of-bounds length
tracking. It also modifies the loop guard in build_id__snprintf() to
prevent useless zero-byte writes once the buffer is full.

> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index 8c0a9ae932aa5..82af3dca7e2fb 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -93,8 +93,8 @@ int build_id__snprintf(const struct build_id *build_id,=
 char *bf, size_t bf_size
>  		return 0;
>  	}
> =20
> -	for (size_t i =3D 0; i < build_id->size && offs < bf_size; ++i)
> -		offs +=3D snprintf(bf + offs, bf_size - offs, "%02x", build_id->data[i=
]);
> +	for (size_t i =3D 0; i < build_id->size && offs + 1 < bf_size; ++i)
> +		offs +=3D scnprintf(bf + offs, bf_size - offs, "%02x", build_id->data[=
i]);

[Severity: Medium]
If bf_size is 1, does this new loop condition skip execution entirely?

If build_id->size > 0 and bf_size =3D=3D 1, the offs + 1 < bf_size condition
is false on the first iteration. Because scnprintf is never called, would
bf[0] be left un-null-terminated?

>  	return offs;
>  }

[ ... ]

> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index fb3ffa8d32ad2..dbf6a71af47f9 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
[ ... ]
> @@ -442,12 +442,12 @@ static size_t hwmon_pmu__describe_items(struct hwmo=
n_pmu *hwm, char *out_buf, si
> =20
>  				buf[read_len] =3D '\0';
>  				val =3D strtoll(buf, /*endptr=3D*/NULL, 10);
> -				len +=3D snprintf(out_buf + len, out_buf_len - len, "%s%s%s=3D%g%s",
> -						len =3D=3D 0 ? " " : ", ",
> -						hwmon_item_strs[bit],
> -						is_alarm ? "_alarm" : "",
> -						(double)val / 1000.0,
> -						hwmon_units[key.type]);
> +				len +=3D scnprintf(out_buf + len, out_buf_len - len, "%s%s%s=3D%g%s",
> +						 len =3D=3D 0 ? " " : ", ",
> +						 hwmon_item_strs[bit],
> +						 is_alarm ? "_alarm" : "",
> +						 (double)val / 1000.0,
> +						 hwmon_units[key.type]);
>  			}
>  			close(fd);
>  		}

[Severity: Low]
Does this loop also need an early break condition once the buffer fills?

The commit message notes that build_id__snprintf() was updated to avoid
spinning doing zero-byte writes once the buffer fills.=20

In hwmon_pmu__describe_items(), once len reaches out_buf_len - 1, scnprintf
will return 0. Does this mean the loop continues for all remaining hardware
monitor items, performing unnecessary sysfs file open, read, and close
operations only to do a 0-byte scnprintf write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D10
