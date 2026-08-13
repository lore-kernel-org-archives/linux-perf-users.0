Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963E40626C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634791; cv=none; b=K7MWfMcfb0oTvSqQOLD3jwJCGt1twDVTnI6hU1iFWk5Rkvh9n4KV9W0X9GMQoWxHRjUt3bZdzUrcW8kPFvHuM9Ac+KkjW4Ss42zYp70L+UynEApqyNUEz9ZR55Xu8dSyDtdmxuo+x+f00kQJFkofYWt65ndQnSSMy+VBktlOyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634791; c=relaxed/simple;
	bh=OdsSxbX2cAba7kOUF1VOGGK5DSs2iPRo55/zqw5742Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mdx/wEERfLsk9TH9B0PBCC1rBpxbZrna9k49kV54riC3bd7Cm3Gai3zEvbsR4z4ox6HzzDQRF/UQh8wXH7Yyr5iudzDQIYOgcSw0S4jgTnRVQp+Lz0ay58Vw2ssi1ZheKeMIkRj8ATd2K0EryJD10bKSkCh8u0YWmuvCyu8xzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4XercdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4XercdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E71F000E9;
	Thu, 13 Aug 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786634790;
	bh=pMAvqUMCYBZvdy6Loz9BELtp/JqSV+ZWwdpW+MWQOuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g4XercdOLjb2Rka8zYyl4dZ1SxWq7dMpHerrk1zAbc1VyClsn0WGu57DORI58Af0D
	 dfg5SyXSMwvV4gUTCxGTRt48VkTNBq0ymAQtnk8z0gXARmysBNZ/amKQ1Bm9p2+Blo
	 36J4AnOaJJQpi97JGeZqnWORYhK9Wrdi/12FV51UQZJV/NZTrl1p4rw0VCdBf83Csu
	 XRIwvRLI0ulq3u8jTgGcySECCDXaoT9MH6bPtcX+L1TXVWK5QEU5SAAr7ExBmHzykF
	 4zB0tSN57+diDkxM8H0ymXO+1aA4R8uN69gMxhHIasoY26yGv9VnTrvoPSO/aLxY3w
	 pgzJgpAWOsqzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] perf dso: Replace assert with runtime check in
 dso__read_symbol()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260813151148.23169-6-acme@kernel.org>
References: <20260813151148.23169-1-acme@kernel.org>
 <20260813151148.23169-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:26:29 +0000
Message-Id: <20260813152630.0D6E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Misleading error code used for bounds check failure.
--

--- Patch [5]: [PATCH 5/5] perf dso: Replace assert with runtime check in d=
so__read_symbol() ---
commit 99fef42823fa80b278999b8901d74d88e812bd2a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Replace assert with runtime check in dso__read_symbol()

This commit replaces an assert in dso__read_symbol() with a runtime bounds
check to prevent out-of-bounds heap reads or assertion failures when proces=
sing
untrusted perf.data files.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 4dd64069c4348..42bfe30a3b518 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -2038,7 +2038,12 @@ const u8 *dso__read_symbol(struct dso *dso, const =
char *symfs_filename,
>  			errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
>  			return NULL;
>  		}
> -		assert(len <=3D info_linear->info.jited_prog_len);
> +		if (len > info_linear->info.jited_prog_len) {
> +			pr_debug("BPF symbol length %zu exceeds jited_prog_len %u\n",
> +				 len, info_linear->info.jited_prog_len);
> +			errno =3D SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;

[Severity: Medium]
Since this is a bounds check failure in dso__read_symbol() triggered by a
corrupted perf.data file, reusing SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF mi=
ght
cause tools to incorrectly report that the BPF file is missing its BTF sect=
ion
instead of indicating a length mismatch.

Could this regression result in a confusing message for the user?

> +			return NULL;
> +		}
>  		*out_buf_len =3D len;
>  		return (const u8 *)(uintptr_t)(info_linear->info.jited_prog_insns);
>  #else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813151148.2316=
9-1-acme@kernel.org?part=3D5
