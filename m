Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB2041443D
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789070114; cv=none; b=cY8kpbgOE1ITElx/S4sB80jc+Nez+T26zmrT6ksoycSFgNcn7lKMBA71u4u7tCFHaasBzZdfZzxzBiZAnCaDbO3gssEU2EgjW/47V6VIyNqucYZF0AkbEhETgRvyBfxYdb/7LKrdtuETL4XTTB+D/nxRMbgJtcQ3wZe+ilH0CDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789070114; c=relaxed/simple;
	bh=XRPguDF7TxQ1w0rQRY+nnbajlbYOHUzQ0BU4sljwjc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmZYP6h/ausM+ennIIsSwfDg4dhaZGuiMJNTOke1eAlMNePre/OLLHGkOOnRt8l9VfffHcUc22tE858ISCKV0tov2zig4Cg8iOwf78zRAdVQuT0GjQXeYWphHjiv0Nbwd3g8XpLv8zYmqputh+TJJxol2BjNq7A1qps48t6eAaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEALXct1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEALXct1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3883C1F000FF;
	Thu, 10 Sep 2026 19:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789070112;
	bh=MJ4TnZUOwtb/80LwH+eRHKfMisFSTRq3JNu+t1gWoPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEALXct1X1iZ2mznoLyZPMkB9deV0je59LrLVELCqYEtUsHz4c0WD69VXkvM/EUhw
	 RVuarSe7qh+k2bLc5nrs3Q08sU2eE7PQYSfupFXz9rTqU56Ajlf3hOAbokpcHE8EVQ
	 /h3obsIVK11tYBe2ocUJzae5P1sWGCGKVzxMP2a8quFTYUQCZfG52lTFrHXV0LiRT5
	 Pi9+dhfSA1woNFJetvsfpJxmqBhw93semZ/R5VesGZExhIzw8hTeouvZXSa5bH+o3/
	 a6c7T7UMb8OZsRtqQe3PPUIt2I82Nc2nU/EpzaUjLU/8/TOOSF8/5CG0uCMCaDr7FO
	 HFeod5rIxHcpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260910194324.98002-2-thomas.falcon@intel.com>
References: <20260910194324.98002-1-thomas.falcon@intel.com>
 <20260910194324.98002-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 19:55:11 +0000
Message-Id: <20260910195512.3883C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The helper functions for memory event formatting (`perf_mem__lvl_s=
cnprintf`, `perf_mem__snp_scnprintf`, `perf_mem__tlb_scnprintf`) are vulner=
able to severe stack buffer overflows and integer underflows due to unvalid=
ated size decrements, unbounded `strcat` usage, and API contract violations.
--

commit 980e511e3799aa8f7f553d523c4cd00aa00aadf1
Author: Thomas Falcon <thomas.falcon@intel.com>

perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0b49fce251fcc..4e490f9cd3488 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);

[Severity: High]
This is a pre-existing issue, but does passing sz - i here expose
severe integer underflows and stack buffer overflows inside
perf_mem__lvl_scnprintf() and related functions?

The functions perf_mem__lvl_scnprintf(), perf_mem__snp_scnprintf(), and
perf_mem__tlb_scnprintf() begin with an unconditional decrement of sz:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
    ...
	sz -=3D 1; /* -1 for null termination */
	out[0] =3D '\0';
    ...

If the remaining space passed by the caller (sz - i) is small (e.g., 0),
this underflows to SIZE_MAX. If it is 1, sz becomes 0, and subsequent
length calculations like sz - l underflow.

Furthermore, these functions use unbounded strcat() calls which ignore the
buffer capacity entirely:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
    ...
			strcat(out, "Remote ");
			l +=3D 7;
    ...
    na:
	strcat(out, "N/A");
	return 3;
    ...

Because strcat() doesn't respect sz, a maliciously crafted perf.data file
can cause this to overflow the 100-byte stack buffer used for the decode
array in builtin-script.c.

Finally, if the callee returns a length larger than the remaining size, the
caller's offset i is advanced past the buffer size.

Does this cause the caller's own sz - i calculations to underflow in the
subsequent format calls below?

>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");
>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910194324.9800=
2-1-thomas.falcon@intel.com?part=3D1
