Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DD1CD1E4
	for <linux-perf-users@vger.kernel.org>; Sun, 24 May 2026 04:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779597355; cv=none; b=rKK2mmjv1Oi/rQQtHz8/4x9TE7Xk+D1CDsCW78rHwP6zWG/A03/UzRZDL/yqidblzXRrF9a6w2gYNWDo7OJ1h97jVYPIh1mLG9toWz6i5v73fs7Pm3Ek/GS4h46VEuPrwqtFwNdBSOuJbjSXSdqAGMDtmaBKMOvA0YFLnhJT6c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779597355; c=relaxed/simple;
	bh=+fMj81gINfB+nP9dbyNAvTkZLJPRnVriWm7QDDMPDck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ORJqZVOYL4FvDIbrVwYCjID0Be9Go3HXPECZCnPYPG+u5LVOIB2mLRwAIHY/12pBfKv3cSYCA0lmz4fMMX5Mb/JBNtrmeaShOLL9GeKseZfKEQYxzuy4rlFLpPjE7NYI7ZTKp6r5rxrrQCz3wNYi121Z/xi/5hsANIyDJ0mYyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oawmG8f3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oawmG8f3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D4D1F000E9;
	Sun, 24 May 2026 04:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779597353;
	bh=lxEZqGdehDQCaMQ6SZgIspB2FdRFKtTtRqhapPNmgBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oawmG8f3VqJULvXgHbMf8eyVi5cXTaiOz5FBHD+74bRVQ6RCZxlK/f53QKKeP4Rs6
	 tUYIfzgWUpn5D+kU+9uvYnGKzPUdAzVZxqM8S/o0QhN5mRdfW0Gi3HvA/pPJU7AfRm
	 nmG8Dzb0RlMZr5Is+dB7xICTNxNUGQegH32Ky0D/5hSIgkVmWHlcq21iMBlQ4Pnn1j
	 o5YKaGY6g69Q/6l1Us5FCEB6rmMylHF4b9itlL856VItoPxIq3IqI7RSl5Po2MU7lf
	 afbdNTFZY8UCkz0zZwF9NH03vHdlCap/8X+vijH16Q4ymrd5uNGy8hzL4KFuXiaDKY
	 VbxZTpm1+58MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/29] perf tools: Harden compressed event processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260524032709.1080771-25-acme@kernel.org>
References: <20260524032709.1080771-25-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 04:35:53 +0000
Message-Id: <20260524043553.93D4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The validation for comp_mmap_len incorrectly rejects valid 2GB p=
ower-of-two mmap buffer sizes, breaking backward compatibility.
--

commit 7eecd6b6f6e3999d9f64b3d9ab6c2ddaff3a8a51
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Harden compressed event processing

This commit adds several hardening checks to the compressed event
decompression pipeline in perf tools. It validates decomp_last_rem
underflows, event sizes, and bounds the comp_mmap_len.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 66929c5557b21..cbc740fd29e68 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c

[ ... ]

> @@ -3861,6 +3861,23 @@ static int process_compressed(struct feat_fd *ff,
>  	if (do_read_u32(ff, &(env->comp_mmap_len)))
>  		return -1;
> =20
> +	/*
> +	 * FIXME: perf.data should record the recording system's page
> +	 * size =E2=80=94 it affects mmap buffer alignment, sample addresses,
> +	 * and data_page_size/code_page_size interpretation.  Without
> +	 * it we assume 4K (the smallest Linux page size) as a safe
> +	 * minimum alignment for comp_mmap_len validation.
> +	 *
> +	 * Cap at 2 GB to keep decomp_len + decomp_last_rem +
> +	 * sizeof(struct decomp) within size_t range on 32-bit.
> +	 */
> +	if (env->comp_mmap_len < 4096 || env->comp_mmap_len % 4096 ||
> +	    env->comp_mmap_len > (2U * 1024 * 1024 * 1024 - 4096)) {

[Severity: Medium]
Will this cap reject valid 2GB mmap buffer sizes?

When a user specifies a 2GB mmap buffer, such as by using perf record -m 2G,
perf parses this as 524288 pages. The resulting mmap length calculation adds
one control page, resulting in exactly (524288 + 1) * 4096 =3D 2147487744 b=
ytes.

Since 2147487744 is greater than the cap of 2147479552, it seems this check
will unconditionally reject these valid perf.data files and break backwards
compatibility for large perf sessions.

> +		pr_err("Invalid HEADER_COMPRESSED: comp_mmap_len (%u) must be a 4K-ali=
gned value in [4096, %u]\n",
> +		       env->comp_mmap_len, 2U * 1024 * 1024 * 1024 - 4096);
> +		return -1;
> +	}
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524032709.1080=
771-1-acme@kernel.org?part=3D24
