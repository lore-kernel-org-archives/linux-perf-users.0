Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027D1DF27F
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782279017; cv=none; b=EZ3xd7eXl8A9Bi9dXpDksZ1vXHP180sHh/KtYZkrQ2MjkCTigVOgH5zQRQIu9MqguFBgXIxurZadsVY++ZkdX+LO3pSFSXA6bbrn53H8Va391DJO+Huoo2eyxBMe+O0Mex0/2FPGpTmEy57E1OFbji3LFw6sbvKDThhH8lrMvvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782279017; c=relaxed/simple;
	bh=+XeMyV0H2nKSZyzrP5h/DZ8kIbfjKM7niLLkRaMnCuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bzpM5XA2Qd7a1m96vrMrpt6kKw8opwPncFQ+LCD7LdFX+5M/I+BfIdoIywZ/TQVR9DcwZJd4SN4dhQg3v0tbtVC/IzDV+B0nU0/Er9QeLMwPuHP8i7D14R5X7a2M2Zeai0ll7Kl/OdXcr7mJ1Wf/gijUffRSjM5OSXjyZsRjT2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Df9m22sr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Df9m22sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33051F000E9;
	Wed, 24 Jun 2026 05:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782279015;
	bh=+wGBNpJpCHBQO2ZQ0smI1DL++0Pi0wzeyy9SyFi2XEA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Df9m22srs8hQ4V7dehDyVnBwLV678qo8eT34C6PMWtuL+ipyNd3zeR/VvqW0deHIE
	 uJvb/eHe/deYKHIdegJK5jtRkZkKp8dgt9LR3Q4cpffhQTAUhjFH+rZUgDpMGGs3lN
	 nKe3cXe2/rV7UgaYlaLkEM5w1YgIPzKEIurKwvN9VimIeSJkC5ggkqEBGSzrsgJMrf
	 TS81hQfRH1F/e93bf2yEjo3rurevXf9FojzicKM8r7rvGwZNOSsDApWCJxonn4C38o
	 NjoxCchpFfgm2mNxTeTVXkdRXjAD+ABP0XaLYUV900wrrSu/mnC6Ui70Eqxh026272
	 kA1Umz09IEbhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/16] perf data: Fix directory file descriptor leak
 in perf_data__switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260624051535.3584977-8-irogers@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 05:30:15 +0000
Message-Id: <20260624053015.A33051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The patch introduces a Use-After-Free during file rotation in =
directory mode. By changing `perf_data__switch()` to call `perf_data__close=
()`, the `data->dir.files` array is freed. However, thread mmaps (`map->fil=
e`) still retain pointers to this freed array and are never updated. Subseq=
uent writes dereference the freed memory.
--

commit d39defbf0b046135d95bd01181c56fe40f6a6430
Author: Ian Rogers <irogers@google.com>

perf data: Fix directory file descriptor leak in perf_data__switch

This commit fixes a file descriptor leak in perf_data__switch() when running
in directory mode. It replaces perf_data_file__close() with perf_data__clos=
e()
to properly close thread-local directory files during file rotation.

> diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> --- a/tools/perf/util/data.c
> +++ b/tools/perf/util/data.c
> @@ -472,8 +472,7 @@ int perf_data__switch(struct perf_data *data,
>  		pr_warning("Failed to rename %s to %s\n", data->path, *new_filepath);
> =20
>  	if (!at_exit) {
> -		perf_data_file__close(&data->file);
> -		data->open =3D false;
> +		perf_data__close(data);

[Severity: Critical]
Could this cause a use-after-free regression during file rotation?

Calling perf_data__close(data) here frees the data->dir.files array.
However, thread mmaps (like map->file) appear to still retain pointers to t=
his
freed memory and are not updated.

For example, in tools/perf/builtin-record.c:record__write():

    if (perf_data_file__write(file, bf, size) < 0) {

The file pointer here is aliased from map->file, which now points to the
freed memory. If someone runs perf record --switch-output with threads
enabled, the subsequent writes dereference these dangling pointers.

>  		ret =3D perf_data__open(data);
>  		if (ret < 0)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624051535.3584=
977-1-irogers@google.com?part=3D6
