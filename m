Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03E3E171C
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636115; cv=none; b=V06pK8vWTY3K+MwE1/pRCVX3I340dqPqPAJ55gvYljY/rmi11+pOjRFhmGghrzR0OQCvJsAfvX/CYWFIGx5mZ5nIlSV5Hhbvn5ZP7gIlsOzNlSbE6Qpx89UzYZdsgB+rUFd8K2Q87ZGveUFg6D65M7XD1kaeXlgnC77+Uz/uRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636115; c=relaxed/simple;
	bh=gsFQxXniWrj8pERhsLdFgW9XATW1MlhmAmdYNi3Xx+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jex2SMPQORZy/WwHohlS68xgf+MxoOaeITDiUvTp6m1WU2Un3c2VdP1q2Sl3WCtVGtmtb1t5J0V3WXEtWwerKw8uG3DnXX7bGcO1MZq97rI2pzxtX7pO5/0wgzxDKJHDDytYdn6aK8LIx9OjV7ITCo/W883lOwQnftvmbmQ/K4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRdR0XBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRdR0XBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004131F00A3D;
	Thu,  9 Jul 2026 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636114;
	bh=pc85UbmOgUV8YljNrSc2ON0qwKdjvrvCOUoBRzOUG3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRdR0XBS+YRjfg+YuqJSiT2FM0EyMw0JJsnzeVxt5RnCaq7R/JwRfiA4j/Oi0yADs
	 apx1h3gaVDmc13iRwa5yPfgQhkJOvRvxxTgrzA65qfxLRFia0msOBgiDcD22xG7xY+
	 VBChJ1FUE3SlMb/3d7jQQCg5/TRzFoy/CR1oIdsW5+GgpqPu3BbBKSWu6VzG4OeMYD
	 P1OB7cmwHewH1MYyDCZhW8MNEbw9MWyU33BJFdXGKvxquQJes8cevXRGLB1EGHe5hv
	 lvc9uvAbA1y0/y0D3gUDx1B8kklTwk52feTA/EXm/ec7hQVG/ZnkrRV3mArG3y/FMi
	 dnbb5faH/4TIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260709221736.33446-2-thomas.falcon@intel.com>
References: <20260709221736.33446-1-thomas.falcon@intel.com>
 <20260709221736.33446-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 22:28:33 +0000
Message-Id: <20260709222834.004131F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Cascading integer underflows and stack buffer overflows in `pe=
rf_script__meminfo_scnprintf` and its helper functions due to unbounded `st=
rcat` and unchecked size arithmetic.
--

--- Patch [1]: [PATCH 1/6] perf mem: Fix size tracking for mem_lvl's in per=
f_script__meminfo_scnprintf() ---
commit e57d4daab871fa57aef1ac0569d81f8d93753398
Author: Thomas Falcon <thomas.falcon@intel.com>

perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf=
()

When printing memory info in perf script, the entire size of the
buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
size. Pass the remaining buffer size instead.

> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -610,7 +610,7 @@ int perf_script__meminfo_scnprintf(char *out, size_t =
sz, const struct mem_info *
>  	i +=3D scnprintf(out, sz, "|OP ");
>  	i +=3D perf_mem__op_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|LVL ");
> -	i +=3D perf_mem__lvl_scnprintf(out + i, sz, mem_info);
> +	i +=3D perf_mem__lvl_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|SNP ");

[Severity: Critical]
This is a pre-existing issue, but does sz - i risk underflowing here if i
exceeds sz?

Looking at the helper functions called here, they use strcat() without boun=
ds
checking and advance the length manually:

tools/perf/util/mem-events.c:perf_mem__lvl_scnprintf() {
    ...
    if (printed++) {
        strcat(out, " or ");
        l +=3D 4;
    }
    l +=3D scnprintf(out + l, sz - l, mem_lvl[i]);
    ...
}

If multiple bits are set and l exceeds sz due to the manual l +=3D 4 increm=
ents,
could sz - l underflow to SIZE_MAX? This would cause subsequent scnprintf()
calls to write past the buffer boundaries. The same pattern appears to exist
in perf_mem__snp_scnprintf() and perf_mem__tlb_scnprintf().

Since these helpers can return a length greater than sz, the accumulated si=
ze i
in perf_script__meminfo_scnprintf() could also grow larger than sz. This wo=
uld
cause cascading underflows when subtracting i from sz in subsequent calls.
Should we ensure the accumulated length is checked against sz before
subtraction, and consider replacing strcat() with a bounded string operation
in the helper functions?

>  	i +=3D perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
>  	i +=3D scnprintf(out + i, sz - i, "|TLB ");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709221736.3344=
6-1-thomas.falcon@intel.com?part=3D1
