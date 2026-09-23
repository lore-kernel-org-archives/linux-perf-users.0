Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623E23264D4
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790140932; cv=pass; b=GG8tsz/kJr3wxNufqOT4tbGJl/yzgo4Wt3B60IAyzXEa2Iiy62nMX+mHUOooYsJiEtDgod40hZx23d0EsFSAFm9k7FemfMjsFhZ2HRTqTjoRoXoDqkay+oBBN7fp+XKk1kGKBy0x7/jPB+G+etuAAOTv9Xd8ERzy7yBg/JyLzTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790140932; c=relaxed/simple;
	bh=mUZzwCb+JCrAlgwo8A+ZAuwL7uSnu1ruhJ42Saued10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGIVFWYI88nElLGCAR8tfv9NhYUg2Cs/jTNVLikPBtPhsm9Mo+HG3WSudwD0bHFRhwWW/YfagQWzsRJmmKTBjzYIhQde0ARwulGSlXMAeXtQaoEuMYeYe7QDd+6kO6pfBS4MX+Q7V5WCParbHuJuHmk09RvXBGK6AtdnBT7PgRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r/rGF3iX; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r/rGF3iX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-530e8c6fb80so100761cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 22:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790140930; cv=none;
        d=google.com; s=arc-20260327;
        b=SqgxLIkYXrnUR6mGlubms60YiiGOkgDZmu177VmLvgpqNxjzadop2ZO9at80jPdLEK
         0DePu5R4wyQbBfN9yCuha953amZYMPl1lOQoazSePuAoRRjGLGJIYwEVzbEWsjA8u9VN
         ZLtoXlkjosX3I+KVVzSRPFovPeqQCTWXPnDCi/ySvQMx+LgIW2sFDATnGJW4u7zfxzx/
         yD0gw2m6JK6NMtzu8PEvj5+ApzA0WUuZe44VxEN8g9qZdzJLwb1ERC6xuA4pxkNE33m7
         M+Z1MEU9a/ne06Op/vY0lK8+3/lQKMsOWd5pGsAvFwPszgSVg32QDBa2I8r3hkghnf4M
         U8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M6himwR6bCyl5owXprR66gPCgX/tVDndxYCLaH1NDbI=;
        fh=/Jq1KS2q0q2krhe2WWf4zZSMkV0zv+11jIdid0xGzpI=;
        b=Aj6c45XKI0PWnErO1M51B3heCBT+4IVXpnaXugbkI+zwciJk4mhOtDRVI1MYDDV2XQ
         QAAaPTJismrIdnrlKcgytuv4+V3YMq+5LPAkiTlsEMk11frCdORADsphwUuv3BV0PwPP
         DKFmC4RFtzUjBZ06DGBzxVvJbFBLykNQrNIKEo4zGdKsdDus257lHNo46cIPO/Sr4UJK
         1uUibMT/nv2DyqnShkNUrksSui90AqYSmywUVgtRK3sSQs+SfHx4YeNpWJhyzskCSqv/
         CEuA54yTbVsQKHBBWRhYY8xSQyT9U/Jgnybkt3XBN10BWGlOFjcPELd17j7OTi5ZwoGC
         AYUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790140930; x=1790745730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M6himwR6bCyl5owXprR66gPCgX/tVDndxYCLaH1NDbI=;
        b=r/rGF3iXlR7tiQWEtFgPbBj9+18Y6F//oIw67rhEsrgynE+gVmNmLeeR72vXO6Pcmu
         yU3v2GgWZAdVTrJR4zQldNFo0nrPCc3pozS6R3A3aDtu/v5XVIu0GSX2QWOfIC6cAK09
         EKa+t+AsHyMHYfY4W1TeZ05wWbO/+K1QBpCAzIxOz+SwwVpfo3G1fN7I8vBQqmZPbTTK
         BENbx7mUh2rdVvjZveQsMCMJhy9PAh2VPe7MBVvhbE0SSb3NMrAO+kUbJY892zcVTo04
         WWWnHxmGR0B/1XMEOJ1H2ZuJ6f5dZaNTP9K8VB0fSpg8/k2neHS8npG43kY5Z9uZREoT
         6qVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790140930; x=1790745730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M6himwR6bCyl5owXprR66gPCgX/tVDndxYCLaH1NDbI=;
        b=tTSO4SpCe34/WEe9bXiK33gQ38esCd8hfr6cLd9itTusu0yxs0SfjHpZgXdkRWamCP
         QYNRT5wRXgeDlgGf24Wx4lDDcUuCbdEE/YEE98Q+SMrP693gcufUPlnjz/Zt6zVfXx9v
         Fpnssvh+L17/SvucOVPuoXbYGP6HDpT3S8cnJSp38coO0JN50p6P7HjuxcCFr0dHXGMp
         n7ftdSBIX3hQhBMN+QhtAkiTEBw6VVXSj+MsWXVimkxoxJlr/bzHnl1GL30lS2FBbDgf
         G8455HbatxRkgHZGxD2/m6J/bZ1YwaKm6s8cIkity62TqXqkT5GnwhYsk0G4j7prtPqg
         ARMw==
X-Forwarded-Encrypted: i=1; AKwUvBwr+/8Gfb0CPgrWMx7TefYJ9Hy2MminzEx3dJ0T9W4zSWew5ZN5t6nqgyt+IgqtFgYKEIGYJ1bi1G/EiA4tmFa3@vger.kernel.org
X-Gm-Message-State: AFuF++mRCcG71VLezsydrMHMcCht580WHOm78rOBD3xEHwJYUiIvU01R
	7fYktREn9+BWyPfsmo2FlDrI2YihaoYNezMML+UVKdJlBRTIVHgoV2kHHDa0BMHWyhp0B4vxOAs
	60SIZMWwmuQm2FmiCffm3EfX7eo7jJfdtZTW7pDha
X-Gm-Gg: AYBFou3hOsZb5FXWEefoI3cw5uvO9CwThmTJ8SRNjosUOFSo8Ow/PXT0S3Hr90HJklP
	xqzlRO9kiaceCcOoAM0yXq8BkgcYbHVOF+HN19YEnvGr0/QG9dZPQ+HoMhSusAEOaj6rmULCUgM
	GKozztszqw1iUJod/BE+srPjl7TLgyu9Cj8lm1ZCBIYpDLOI2ykzRn3CY5mwc7N0Ib7BKBF74yV
	eaPCQR3sReeWidPnKIj38DFcXwDxYHIF6RVrB5h/6alAiPNyNzfMGns97eA13jiIPKl/ko/8t9O
	xev+09izY7e122WHOPHbrUq667y8ae3zBGsKrMDFYPloou0y8H5bxV/QQCacTh1Mkbk=
X-Received: by 2002:a05:622a:1b90:b0:531:6de:6028 with SMTP id
 d75a77b69052e-532ef055b5bmr6402111cf.13.1790140929534; Tue, 22 Sep 2026
 22:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 22:21:58 -0700
X-Gm-Features: AcwNN1XVFgegAHEHKvebKKbkGZKcMNpo-6604SB4clrIe7f2Jyta2VVGpQqOfb8
Message-ID: <CAP-5=fXaB9vvDGkT05kKtHfY3K-2sa5BzpZbKK5htVVtXBeTqQ@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Rename OMR offcore_rsp attribute to offmodule_rsp
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 7:02=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> The kernel renamed the OMR data attribute from offcore_rsp to
> offmodule_rsp to avoid confusion and keep the naming consistent.
>
> So update the perf jevents msrmap accordingly.
>
> Link: https://lore.kernel.org/all/20260917015234.981153-12-dapeng1.mi@lin=
ux.intel.com/
> Link: https://lore.kernel.org/all/20260917015234.981153-13-dapeng1.mi@lin=
ux.intel.com/
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> Note: The dependent kernel patches have been queued into tip/perf/urgent
> tree.
>
>  tools/perf/pmu-events/jevents.py | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 860027bb71b2..93cf04fa8ca4 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -249,10 +249,10 @@ class JsonEvent:
>            0x3F6: 'ldlat=3D',
>            0x1A6: 'offcore_rsp=3D',
>            0x1A7: 'offcore_rsp=3D',
> -          0x3E0: 'offcore_rsp=3D',
> -          0x3E1: 'offcore_rsp=3D',
> -          0x3E2: 'offcore_rsp=3D',
> -          0x3E3: 'offcore_rsp=3D',
> +          0x3E0: 'offmodule_rsp=3D',
> +          0x3E1: 'offmodule_rsp=3D',
> +          0x3E2: 'offmodule_rsp=3D',
> +          0x3E3: 'offmodule_rsp=3D',
>            0x3F7: 'frontend=3D',
>        }
>        return msrmap[int(num.split(',', 1)[0], 0)]
>
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> --
> 2.34.1
>
