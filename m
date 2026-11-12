Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472948;
	b=1bLu+t6PFEk0490HDZrD748QEvGapi1Iv/gFDuwlsDJNpvCGAMQvqb0xd5ya4/teczdx
	 spTxoZVYPO58WAFr19xjMpBAxoaa6srt4HUCY4vwn9iy3jbULyS3Ph6ULKhtp6gFmUIvK
	 TXye7FBo7384tyEu9lLVxGJqDNIAQS8PLEOZyeLn1kK5AhecFWUVop5pPuMoTjDsjbG7r
	 WsxQjALkl2vOKuUj3Ij7vATzqn7IbXTkBw4ckmLj+JOweTnHZKIvf/PbSUdhfNtes/Zbc
	 vqDas73kPypRzNLYGRljn1jIUJ8X4oTMgb4nbSNLaiq4O+EDw+3iVdiUEsqO0wzdaug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VBDehPp+MILCFYJkYs2rqgFfZ4uzdEhwJnd5T4YuBGQ=;
	b=e8EkH0nD1XSYy+uULt/+9L9jZ8K4i4Hiupj+vNeykrju9Yw6vTM1FViYgodOl8Ww5aww
	 4rekSTAF0l9yUO39ouFt6pjpJJku902SsfwnR+kjW0326X14jSLy7UtBEuStI51nijkw3
	 x018w3q/IBwFapQkE0tKHxfOy+ikVMt+15Ft7xyqiN4zZicBeUjkM3TRicZlN4gEyixOg
	 4Mz0jIQe7tOupWt9ef652GiH/sjbY6k/tmrtZVIvTiosJ1qc/7/JzknkbZtb2LVCj+fJ+
	 pmYkve8ldAeLuhRPEJpNpx+R93vRht6kPx8MT7tJlocN4Z3j84uHFns0M3jivN9/Miw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgjFhMBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78123607280D
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgjFhMBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360B21F00A0C;
	Thu, 12 Nov 2026 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794472948;
	bh=VBDehPp+MILCFYJkYs2rqgFfZ4uzdEhwJnd5T4YuBGQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgjFhMBMWEsiLwhPYl9ugGGqNLwpoIQHxbOTjCfCSotIFJc3tV5n0mdTVNV7GBO4V
	 ddF06DW1dYpV8SEnKR4/XVGDIVbMoSQHsxjRevZ8rX7jeztgDqBdvbHotLZg0v384p
	 glE7CBaRnfAvfikAuOtFbyXyKUhQCjSSQtT0v9u530IjIAJD7TncKSxcYVUSdpgxua
	 dmsJERsCvuvTVxtISO9iOFgcgt9061JDtQh2egBtyyQPlFuAwaNY3k/BSh5Jw0IXGR
	 fKwyQaeeDm5oTuO/lBdKoL2OI/fbGuu1F4xrDhn9A+FIh+LxcOe39q1MmKIepRTtMU
	 IKcv8xCf/v+Vg==
Message-ID: <sashiko-outbox-210765@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf trace: free intlist on filter_pids calloc failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gu Bin" <gubin@cmss.chinamobile.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261112083123.2154-1-gubin@cmss.chinamobile.com>
References: <20261112083123.2154-1-gubin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:42:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] perf trace: memory leak in trace__exit() [1]
--

commit e8d1d018ef3c0a4fdf8d8ce3c0227b4280b491f6
Author: Gu Bin <gubin@cmss.chinamobile.com>

perf trace: free intlist on filter_pids calloc failure

This commit restructures trace__set_filter_pids_from_option() so that the
temporary intlist is freed even when allocating trace->filter_pids.entries
fails.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 4094141461f91..d435b35f1351c 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -5432,17 +5432,16 @@ static int trace__set_filter_pids_from_option(con=
st struct option *opt, const ch
>  	i =3D trace->filter_pids.nr =3D intlist__nr_entries(list) + 1;
>  	trace->filter_pids.entries =3D calloc(i, sizeof(pid_t));
> =20
> -	if (trace->filter_pids.entries =3D=3D NULL)
> -		goto out;
> +	if (trace->filter_pids.entries) {
> +		trace->filter_pids.entries[0] =3D getpid();
> =20
> -	trace->filter_pids.entries[0] =3D getpid();
> +		for (i =3D 1; i < trace->filter_pids.nr; ++i)
> +			trace->filter_pids.entries[i] =3D intlist__entry(list, i - 1)->i;
> =20
> -	for (i =3D 1; i < trace->filter_pids.nr; ++i)
> -		trace->filter_pids.entries[i] =3D intlist__entry(list, i - 1)->i;
> +		ret =3D 0;
> +	}

[Severity: Medium]
This problem wasn't introduced by this patch, but does trace__exit() leak
trace->filter_pids.entries [1]?  trace__set_filter_pids_from_option()
allocates the array with calloc(), and trace__exit() never frees it on
teardown.

[1] https://sashiko.dev/#/bug/linux-ae3f475f-4084-473d-a5c5-25fd465ce61d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112083123.2154=
-1-gubin@cmss.chinamobile.com?part=3D1
