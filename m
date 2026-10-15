Received: from mta0.migadu.com (out-151.mta0.migadu.com [91.218.175.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585C52FE49
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073591; cv=none; b=cEcHuRyc+IZo+5QTDnLffJalj+/+47NJrtLLZqmjC/9yCMdq28QckBq2ZbjDraNYYmBxKEYxHABmEo7RM2+3FNkkSA5UhsgG7t2skGGLZ1Uj0z0MRFQReE8AvgHQ+lAAKiNsCbrHZcG+TLHRal2dTG6Tp8hHYitgJN4/kdtI6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073591; c=relaxed/simple;
	bh=AehSZEUXyYI5DnsWcNl+PxgJ375j0fwJ+dcWs3+ntuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGcOUkOI/ihv53jXh5G9Vno//Y3hQUu+U47DX6eU2u6MxoXwmE36n5sV4kiGEj9yQ8uV7n9MxEh22Vp5UyO7gajXNnQqhgokO26cGjwQcMIDjw29ypMfcM6VcWhJywGAz6Eytw79fAlPzcypJjhRS4wuPwJszgsZBg5OxtUKAhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w+VCKMOf; arc=none smtp.client-ip=91.218.175.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w+VCKMOf"
X-Envelope-To: linux-perf-users@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AehSZEUXyYI5DnsWcNl+PxgJ375j0fwJ+dcWs3+ntuo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792073587; v=1; x=1792678387;
 b=w+VCKMOfUhZ4tnUVXgY67Kd3FFG/XrjyC9yoHz4uB+KWiaFE5rxOJDgzUvdyypas+jqMRDSV
 x8s6NQAJ/+KafzKv7/7FzR20ERkP5qAZInNHVEFgCT8ClMqjtuypi6A3ndnMrfiFbuMZwNMFC2L
 FC6rGijnFaBeLnx5Utonxda0=
X-Envelope-To: linux-perf-users@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f14b6a49a99b4775;
	Thu, 15 Oct 2026 14:13:07 +0000
X-Mizu-Trace-ID: f14b6a49a99b4775
X-Migadu-Flow: FLOW_OUT
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so8387a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 07:13:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByFAIYtgwDvW2wxHt96rO2KC0U26/qzVCHoTYGXIH0XI7bQJOGi0p6GRkD6ocL5jgILnX4diPoZanlrsaoeIgu7@vger.kernel.org
X-Gm-Message-State: AFq9FYIQW0KsTb/q2Cr6ZBABlAVBfoRlJHJJrF4LxSFyj6CipkTGuEpY
	TSgMmB2RsynUeJWdwrz47F1CCU4ExWEHUC25Wpy7COeuBIDojaLhoPqAWXUWFjLDYqJPD34Lio1
	AnltO4w51tApfod4t+qG0RkC4obOGuFKaxp5/c5Yt
X-Received: by 2002:a05:6402:208e:10b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b375fddc3fmr33779a12.14.1792073582345; Thu, 15 Oct 2026
 07:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013130247.4135515-4-fuad.tabba@linux.dev> <20261015140909.1310928-B-seiden@linux.ibm.com>
In-Reply-To: <20261015140909.1310928-B-seiden@linux.ibm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Thu, 15 Oct 2026 15:12:25 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwqhB8_L0E5X5SgCcpK4rGceRgq1mtOwcPaMG-szycvew@mail.gmail.com>
X-Gm-Features: AclHuK8s26iwmj4UvOequv8LIG1kS_-fIOvoCkMvREIBgursWs09-hjQUBgRlhc
Message-ID: <CA+EHjTwqhB8_L0E5X5SgCcpK4rGceRgq1mtOwcPaMG-szycvew@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: sysreg: Mark fields the architecture dropped
 as RES0
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 15:09, Steffen Eiden <seiden@linux.ibm.com> wrote:
[...]
> Verified values with DDI0601 2026-09.
>
> While checking I noticed that Bit 58 of PMICFILTR_EL0 is also defined as
> RES0 in DDI0601 2026-09 but is defined as SYNC in tools/sysreg. Not sure
> if this demands a separate patch or can be folded into this one as you
> already are touching this reg. This field is unused as well.

Thanks Steffen. Catalin has already merged this series, so it would
have to go into a separate patch.

Like I said in the cover, I plan to fix this once and for all though later on.

Cheers,
/fuad

>
> Anyways,
>
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
>
> Steffen
>
> > ---
> >  arch/arm64/tools/sysreg | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> > index 341db8e9b6c37..99af1c39478be 100644
> > --- a/arch/arm64/tools/sysreg
> > +++ b/arch/arm64/tools/sysreg
> > @@ -1420,8 +1420,7 @@ Field   17      DIRECT
> >  Field        16      EnI
> >  Res0 15:8
> >  Field        7       PAUSED
> > -Field        6       LASTFAILED
> > -Res0 5:0
> > +Res0 6:0
> >  EndSysreg
> >
> >  Sysreg       BRBTS_EL1       2       1       9       0       2
> > @@ -2663,11 +2662,7 @@ Field  57      EPAN
> >  Field        56      EnALS
> >  Field        55      EnAS0
> >  Field        54      EnASR
> > -Field        53      TME
> > -Field        52      TME0
> > -Field        51      TMT
> > -Field        50      TMT0
> > -Res0 49:47
> > +Res0 53:47
> >  Field        46      TWEDEL
> >  Field        45      TWEDEn
> >  Field        44      DSSBS
> > @@ -2985,7 +2980,7 @@ Field   27      NSH
> >  Field        26      M
> >  Res0 25
> >  Field        24      SH
> > -Field        23      T
> > +Res0 23
> >  Field        22      RLK
> >  Field        21      RLU
> >  Field        20      RLH
> > --
> > 2.39.5
> >
