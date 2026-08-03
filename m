Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5924DCF6
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Aug 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753729; cv=none; b=Qaj5fVPwVirOe+SVFsJHuL4V5QgVOUT1nQrAgKeUc6i3C+uiu0+HQ9KnTqv3OaHHr9l/20Iwv7Vg0LK5hqIbXHytUqQfXdBTKazkTsh5LfBte+eLa8GiAJQUZ5wQmUuLKH5et6VicBHbmEFuxTH4GIKUGPP7GY1B32RuQMpZxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753729; c=relaxed/simple;
	bh=mz/KtsA+BbVkTXGts5XZDgjHA1IeHb3zjYUyh5DnaFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=khfI4EOZa3igCLvqxhh1RhaJWOTyF+qdaKJpo/J3/MDa0SdzZufVC7M6qvSEdZxd6csmXnUZ2gYWWPMxGNKagsf5McHhz6DllgbOzZAf+REYq+HE08OwbrqT7ogu+K/T8GDe+dc81wQNWr4ZWgyBenDOnz8hyZiNJ4JH25t2oTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN5R6ZKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN5R6ZKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A0E1F000E9;
	Mon,  3 Aug 2026 10:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753727;
	bh=VLbFgeMBX8HvEH3jpLz7e5JFmJP6G/OCtriQD5p797c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LN5R6ZKCUvtlLZNHsk8mYbBm8OLdifWRThU+7409t2Lf4VMSHz/8cuQdXiLiY3Tyi
	 HXL45YcNX7CoaUskL6cmQmT59PFiddj+r9K1yQl3mvaMIGgs87KhqNiAmVzBT5aGJJ
	 mgqlKQ05MZDhC1JXjFrno4Ge8v4F/K4BgnfGTyqq8eJNfo1WNMpQn56XUlj1jxj1Ps
	 y1Y5bJPP35+4T7i0wXS0Y/azOsw6DdbSPobDzQ1/8wADNYmYzXNZLcYSOQ8H2xtFb7
	 ipdKBnp+zJKUUjAd1QQKPOmX0ftPnmuy0yAZQfeVDOIDaBomIrc8KaDZakeoyClnYQ
	 M/RM57AOW4KUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] perf tools: Fix memory leak in cmd_kvm()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michalis Niarchos" <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260803-perf-kvm-fixes-v1-1-a5db849ac973@gmail.com>
References: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
 <20260803-perf-kvm-fixes-v1-1-a5db849ac973@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:42:06 +0000
Message-Id: <20260803104207.90A0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The error check evaluating `if (!file_name)` immediately following =
`get_filename_for_perf_kvm()` is functionally dead code and prints an obsol=
ete error message.
--

--- Patch [1]: [PATCH 1/4] perf tools: Fix memory leak in cmd_kvm() ---
commit 85aa78ecdd5ada6c616d04d112b0f46542981162
Author: Michalis Niarchos <michael.niarchos@gmail.com>

perf tools: Fix memory leak in cmd_kvm()

filename may get allocated by get_filename_for_perf_kvm(), but is
never freed. Use string literals to remove the need for freeing.

> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 394302ebdb161..44c6998f2ee5d 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -606,11 +606,11 @@ static const char *get_filename_for_perf_kvm(void)
>  	const char *filename;
> =20
>  	if (perf_host && !perf_guest)
> -		filename =3D strdup("perf.data.host");
> +		filename =3D "perf.data.host";
>  	else if (!perf_host && perf_guest)
> -		filename =3D strdup("perf.data.guest");
> +		filename =3D "perf.data.guest";
>  	else
> -		filename =3D strdup("perf.data.kvm");
> +		filename =3D "perf.data.kvm";
> =20
>  	return filename;
>  }

[Severity: Low]
Since get_filename_for_perf_kvm() now exclusively returns static string
literals, it can never return NULL.

Is it worth cleaning up the now-dead error handling block in cmd_kvm() that
still checks for allocation failures?

tools/perf/builtin-kvm.c:cmd_kvm() {
    ...
	if (!file_name) {
		file_name =3D get_filename_for_perf_kvm();

		if (!file_name) {
			pr_err("Failed to allocate memory for filename\n");
			return -ENOMEM;
		}
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-perf-kvm-f=
ixes-v1-0-a5db849ac973@gmail.com?part=3D1
