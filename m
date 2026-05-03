Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE63590AE
	for <linux-perf-users@vger.kernel.org>; Sun,  3 May 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831768; cv=none; b=YpjVDvv5HmyDxwjwVI9EijOt3NDWaQzXtuZTgQg4Pl1H2NhNaQQFxpr7E79/QW44DsLoIlJDsIA3pNLtWhugB5011vFmPjsulkMLft4IuPD79cjynxCGSfE2TvcIhCRZxIBBs8sBmaZLAB7f4kyWUSpQipJVAxvmjs84rmaFipQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831768; c=relaxed/simple;
	bh=KVI163f8F8dhUbvlgtOud8TYVxfnNbTssTtN9+US3/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VzCBkcRfl5GJiXTW335FHXzmUhrKs3B+erRREH+bJ6rK/vGdxq69XMFPIKR1qhwHeuGw+VxIWVVkBqfWVUdPagYCJMni+Gt8glekgE83+cRZSgiVW5iWcbmT2xzQvyxg/vfyzpnWtVhGzQyvP1/HhKXfTrR4VFDW2GczK9cRmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoXrWoaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoXrWoaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71251C2BCB4;
	Sun,  3 May 2026 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777831768;
	bh=KVI163f8F8dhUbvlgtOud8TYVxfnNbTssTtN9+US3/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RoXrWoaFDPwkY9vsuHakjBS+MDFzye/nGzjAggZLDz3mSNyzkbvvfl2ZaNc0rl2t7
	 lDSnPc6a1GWfBnYyxeDVsbdGDBjcTPGBP7iKKawKuntsAWVXfG0V5SyTcY69EFXaOl
	 ck4dC6+Ob7ukpXlG8IhGzpoEBIn0kkhGV2a3217g6uvaUqYbr/VHQnJXBkYfeqDvPb
	 D46NTE7zhjpbbUniXLt23fUIUAWYT4i3o/KgB0s+xCAFSJiFfrrCSx7ud5QX+Psk/e
	 SY6siY1FczRGA7EsLHHY/sNuOOlVpDbzsoK632kn9Z4AcwdeZvtHr7WMob60xRYvJG
	 6ssB6tU+50jLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] perf libdw: Fix libdw API contract violations
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260503171032.1559338-4-irogers@google.com>
References: <20260503171032.1559338-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 18:09:27 +0000
Message-Id: <20260503180928.71251C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing O_NONBLOCK when opening dso_name in dso__libdw_dwfl()
--

commit 95f9f15ab79b0136da9eb501da82453ee78787c1
Author: Ian Rogers <irogers@google.com>

perf libdw: Fix libdw API contract violations

This commit adds error checking for dwfl_report_end and dwfl_module_addrdie.
It also introduces inline_node__clear_frames() to clean up partial allocati=
ons
and fixes potential memory leaks in libdw__addr2line().

> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index 216977884103..e69ff4cea856 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
[ ... ]
> @@ -60,7 +61,11 @@ struct Dwfl *dso__libdw_dwfl(struct dso *dso)
>  		return NULL;
>  	}
> =20
> -	dwfl_report_end(dwfl, /*removed=3D*/NULL, /*arg=3D*/NULL);
> +	if (dwfl_report_end(dwfl, NULL, NULL) !=3D 0) {
> +		dwfl_end(dwfl);
> +		return NULL;
> +	}
> +
>  	dso__set_libdw(dso, dwfl);
> =20
>  	return dwfl;

This isn't a bug introduced by this commit, but since this function is being
updated, could we also look at the open() call earlier in dso__libdw_dwfl()?

dso__libdw_dwfl() calls:
    fd =3D open(dso_name, O_RDONLY);

If dso_name originates from user-controlled mmap events, it might point to a
FIFO, character device, or a hanging network mount.

Could this open() hang indefinitely?

Would it be safer to include the O_NONBLOCK flag here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503171032.1559=
338-1-irogers@google.com?part=3D3
