Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264636F412
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631992; cv=none; b=CVXLLYWYGkLlGIrUusgC/ZeNNwQUoND0zYc2kNepRLuz0NFdWzLHtxrW6i9eJZNhq8C7LQ1zTVR1IiFVjAf/CAOlDa1/LuwCbt/rVG2UlTL2KpHbNwSAfhPKX2zGXKvSfo7wx5BQkNwbIQazjAk+hJYVdQ4npHczLOzezrwgIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631992; c=relaxed/simple;
	bh=ta9UVNGA8ekFABnnye7pvKOVR76OSeocnyg9pLPwoHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=haLGNuhTtUNiadmlgDkMFNQxDpmffTdn4S6sftwlYSDeFt6HqzbNPufgWH08Vrfv7iRr05L8oi4kN5X/y1I56R7cFPY7zxDNi9u9IUkrHLfnZeYQmg50sjlOsZiByzxwAoaUrOw60Af2yn88HjRCVRigLVTSVOV723iM5UFHPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF9J89rI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF9J89rI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470E7C19424;
	Wed,  8 Apr 2026 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775631992;
	bh=ta9UVNGA8ekFABnnye7pvKOVR76OSeocnyg9pLPwoHk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dF9J89rIkuaSjbSkAD8DpZg3Hr76fCeaN1oOsocakzzk/QTkSOJR4meOY58JuctiB
	 aisbmGw/gbUv248HRKS/EsQWEjIu3UkgW+mlaFtgMkLwTsMDYkRFbp/poVZQbk1puP
	 03774f7kyJJ/u5Wgtrz/6kySix3lbTfS18ij6WPiYEG3lZB+yOlc5nboyu7XOhQn+x
	 b8Xm15O3ls9WCcx5DWHl2oC8SY35YH6Pd5Uff/Z4cvcSuvzHHiPUDke680s1l2DYAG
	 uwkn9C6ozYfW3hTSWzzSIzeSUAneTZOfwkm4AJlDDtMAtwvls3xDX1OadilMIMqvjV
	 XN5rAOMw4bbZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf data: Clean up use_stdio and structures
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408064721.138338-1-irogers@google.com>
References: <20260408064721.138338-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 07:06:31 +0000
Message-Id: <20260408070632.470E7C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The newly introduced `perf_data_file__seek` API silently truncates=
 64-bit file offsets on 32-bit platforms.
- [Medium] Missed API conversion in `record__finish_output` bypasses the ne=
w stdio abstraction.
--

commit f45ea505995a4b5ea83270dc73763efa7e6f535d
Author: Ian Rogers <irogers@google.com>

perf data: Clean up use_stdio and structures

This commit reorganizes perf_data_file to better abstract use_stdio,
adding new accessors like perf_data_file__seek() to ensure stdio buffering
is respected when a file pointer is used instead of a file descriptor.

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 60d7640683024..88c2e4ea5c2d7 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
[ ... ]
> @@ -1847,8 +1847,10 @@ record__finish_output(struct record *rec)
>  	rec->session->header.data_size +=3D rec->bytes_written;
>  	data->file.size =3D lseek(perf_data__fd(data), 0, SEEK_CUR);

Should this lseek() also be converted to use perf_data__seek()?

If use_stdio is enabled here, perf_data__fd() will extract the raw file
descriptor and lseek() will bypass the stdio buffering. This seems to
miss the abstraction introduced in this patch.

>  	if (record__threads_enabled(rec)) {
> -		for (i =3D 0; i < data->dir.nr; i++)
> -			data->dir.files[i].size =3D lseek(data->dir.files[i].fd, 0, SEEK_CUR);
> +		for (i =3D 0; i < data->dir.nr; i++) {
> +			data->dir.files[i].size =3D
> +				perf_data_file__seek(&data->dir.files[i], 0, SEEK_CUR);
> +		}
>  	}

[ ... ]

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> index 90df41da1a32b..a1914d71e3331 100644
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
[ ... ]
>  ssize_t perf_data__write(struct perf_data *data,
>  			 void *buf, size_t size)
>  {
> -	if (data->use_stdio) {
> -		if (fwrite(buf, size, 1, data->file.fptr) =3D=3D 1)
> -			return size;
> -		return -1;
> -	}
>  	return perf_data_file__write(&data->file, buf, size);
>  }
> =20
> +off_t perf_data_file__seek(struct perf_data_file *file, off_t offset, in=
t whence)
> +{
> +	if (file->use_stdio) {
> +		off_t res =3D fseek(file->fptr, offset, whence);
> +
> +		return res < 0 ? -1 : ftell(file->fptr);

Does this silently truncate 64-bit file offsets on 32-bit platforms?

Both fseek() and ftell() operate on the long data type, which is 32 bits on
32-bit architectures. Since the offset parameter and return type are off_t
(which is 64-bit when _FILE_OFFSET_BITS=3D64 is used), shouldn't fseeko() a=
nd
ftello() be used here instead to correctly support large files?

> +	}
> +	return lseek(file->fd, offset, whence);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408064721.1383=
38-1-irogers@google.com?part=3D1
