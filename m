Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F435F18D
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635030; cv=none; b=EaKdrq63Dm2vORFXw6tj1X7p26ebA0pQh6dpbRkhJs539vbkuPOsM32sqqpK/lRtenbpGSZdLFBGTebCLaa8i2/mb8rJxnNKUQeEL4J8q3WKH1SvEpqpqTw4VDQAHMKI0P4CRmRSccEUToI0mCOGRzyIAHiTs/to+/QEJT5e6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635030; c=relaxed/simple;
	bh=ejSLXPKOGJTgG2k7Goo2d1lGOg1gp6nrWGH14arBPpQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IvhbvhjdqWmdONj0EPAJdue0/ZsmhyAcwcsIY72bSCNghPSAq6KR5Zn/eiE7S5/yK6W1cQmy8hcjJVYBRM3V92riNzTwcR7A5V1j9hlqbVaDwEciVwMVA1OHaZwkVkA+TpOJuOx9CAu+daPFT8SFN0Ao7QdTLKPOWsyfqYs5RG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PugIvply; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PugIvply"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E71C19424;
	Wed,  8 Apr 2026 07:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635030;
	bh=ejSLXPKOGJTgG2k7Goo2d1lGOg1gp6nrWGH14arBPpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PugIvplyEJYyGg+0kkg4Dh3El2oL2modI9ZaySWMqflsOPSn2EPy7t3O2ONFaXkF2
	 CWp1u3+Z0S2GtjgXMqywvKHWUEjevNvdbZvDO+jyruxWldbzY2oAxjPlJBz1GbQQjn
	 oMPZuEMUacr943u+WHMgzv9ZIlFFMVwpM/RfLkA4nUBqVKzpHfRAEUjxu3u60W5K/g
	 wy7F4YcLTUVuc11+uu7ijybcviP9eo3FkoXRregQc46l8YrLvolfnkmxR9NzkwcxGz
	 0eXO3M+9BJ5aEIIPQLWxzgcvMpaOKf8gCC7JFdhgp97/89kwsMFRnNnx1uzwMz9YMq
	 TpevhimI2YJXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] perf data: Clean up use_stdio and structures
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408073854.242104-1-irogers@google.com>
References: <20260408073854.242104-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 07:57:09 +0000
Message-Id: <20260408075710.13E71C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Incorrect error propagation in `perf_data__open_dir` when file o=
pen fails.
- [Medium] Incomplete hardening in `perf_data__close_dir` introduces a dete=
rministic null-pointer dereference on double-close.
--

commit 4ab46c4d5886980da2c8095f639cfaf305ff9f00
Author: Ian Rogers <irogers@google.com>

perf data: Clean up use_stdio and structures

This commit reorganizes perf_data_file to better abstract the use of
stdio. It updates tools to consistently use perf_data__ accessors,
preventing implicit file descriptor usage instead of the intended fptr.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 90df41da1a32b..df342a6977823 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -20,18 +20,32 @@

[ ... ]

>  void perf_data__close_dir(struct perf_data *data)
>  {
>  	close_dir(data->dir.files, data->dir.nr);
> +	data->dir.files =3D NULL;
>  }

Does this introduce a potential crash if the directory is closed twice?

By setting data->dir.files =3D NULL without also setting data->dir.nr =3D 0,
a second call to perf_data__close_dir() would pass a NULL array with a
positive count to close_dir().

Inside close_dir(), the loop while (--nr >=3D 0) would offset and
dereference the NULL pointer when accessing &files[nr]. Should
data->dir.nr =3D 0 also be set here?

[ ... ]

> @@ -132,16 +146,14 @@ int perf_data__open_dir(struct perf_data *data)
>  		files =3D file;
>  		file =3D &files[nr++];
> =20
> -		file->path =3D strdup(path);
> -		if (!file->path)
> +		*file =3D (struct perf_data_file){
> +			.path =3D strdup(path),
> +			.fd =3D open(path, O_RDONLY),
> +			.size =3D st.st_size,
> +			.use_stdio =3D false,
> +		};
> +		if (!file->path || file->fd < 0)
>  			goto out_err;
> -
> -		ret =3D open(file->path, O_RDONLY);
> -		if (ret < 0)
> -			goto out_err;
> -
> -		file->fd =3D ret;
> -		file->size =3D st.st_size;
>  	}

Is it intentional to return -ENOMEM when open() fails here?

Prior to this change, ret was updated with the result of open() before
checking for failure. Now, if file->fd < 0 triggers the goto out_err path,
ret still holds -ENOMEM from the realloc() step earlier in the loop. This
might provide a misleading error code to the caller.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408073854.2421=
04-1-irogers@google.com?part=3D1
