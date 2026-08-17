Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79163BA22E
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952874; cv=none; b=Jdt+dL+WmlyZayXVOPljKgtmvOzXWRG/x+oqUnY8VslIBlgIcJKfFd475HiOFd3hGAIbi9pNAqNDNFW60Xb2StEHv12H7pkQ2UYCgmsl3mzV5Xpa5MwmguIqjcBWrmVMbEHzqDOlpipCh/S4Y8kk9HlxPSxYKaDrtFGa8sjQV4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952874; c=relaxed/simple;
	bh=Yk2lyuGSBcsyd3hKrHc0gA6EMVzqjfbzgwk94kQBNPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7PDuwBRIdmB0eiKCOAZKaJ7JSObWFV7BiUqtvtX2BTCNYSkVeo3voeglnz5inR3RQAWsjnzevlPLeSvJrQypI/iZy+qu3oeOMIyFI0VWPeXyA6k0TTZh4MOwMVasr+HHyYYVg07AzfaKIAULxncjBRb7s4AVv2G3O/o3w3lh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEPan7ID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEPan7ID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7131F000E9;
	Mon, 17 Aug 2026 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952871;
	bh=W8NJK7ZYAeryEFwV9320xNaJ4ryHR6Y50UHMMx8OqT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEPan7IDrqLUU/9n7TBBuLo1rWsNoXoysH/qXJIv1A/70x9dRj8YroytMNZpc4ou6
	 +qtUSpJOVvCANIDpZDYgC/vz4c6zUMIfs6KsY0wUTe9LugkLilgLs2wXtA2gqEpQJT
	 4ZX5I5jN/Y5192R9HmMfnBEnESrHNb+ixnIu70tXVQgmYuGtraykiPl5qsVUV9ferh
	 OPQkmPhlKeFOczX5sbDzCN/HqySpUtYTUglLLWiIiHGyBz9P4Xw5UH2GVdksOb+YTn
	 xgoIZcyreQZq8+EC2yxclT4hFpPe1lsq9S3R9MJlacEvyv1k7ggcbTz6m9/HE7aqSD
	 5UnySICkTtwDA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fetch
 samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817073323.2504767-1-huangsj@hygon.cn>
References: <20260817073323.2504767-1-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:47:50 +0000
Message-Id: <20260817074751.0C7131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel stack buffer overflow when handling AMD IBS Op samples with=
 both IBS_CAPS_BRNTRGT and IBS_CAPS_OPDATA4 capabilities.
--

--- Patch [1]: [RFC PATCH] perf/amd/ibs: Report physical address for IBS fe=
tch samples ---
commit 96b9a5e865d821f72dd58d33f3f265a7de5821e5
Author: Huang Shijie <huangsj@hygon.cn>

perf/amd/ibs: Report physical address for IBS fetch samples

This commit updates AMD IBS fetch sampling to report the physical address of
fetched instructions when PERF_SAMPLE_PHYS_ADDR is requested. It implements
this by parsing the fetch data similarly to how operations data is handled.

> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 3531f9c23b8c9..e5376ad5b2ecd 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c

[ ... ]

> @@ -1555,6 +1575,8 @@ static int perf_ibs_handle_irq(struct perf_ibs *per=
f_ibs, struct pt_regs *iregs)
> =20
>  	if (perf_ibs =3D=3D &perf_ibs_op)
>  		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
> +	else
> +		perf_ibs_parse_fetch_data(event->attr.sample_type, &ibs_data, &data);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at how
ibs_data is handled in perf_ibs_handle_irq(), I noticed a potential kernel
stack buffer overflow.

Does the code overflow the ibs_data.regs[] array when a CPU supports both
IBS_CAPS_BRNTRGT and IBS_CAPS_OPDATA4 capabilities?

MSR_AMD64_IBS_REG_COUNT_MAX is defined as 8 in asm/msr-index.h. If both
capabilities are present, it appears 7 MSRs are read into indices 0 to 6,
MSR_AMD64_IBSBRTARGET is read into index 7, and then MSR_AMD64_IBSOPDATA4
would be written to index 8, writing past the end of the array.

Could this also cause uninitialized kernel stack memory to be exposed to
userspace via the perf ring buffer since ibs_data.size would evaluate to 72
bytes, making raw.frag.size 76 bytes, while the valid struct space is only
68 bytes?

> =20
>  	/*
>  	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817073323.2504=
767-1-huangsj@hygon.cn?part=3D1
