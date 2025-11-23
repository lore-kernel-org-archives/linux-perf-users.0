Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BC686347
	for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763857848; cv=none; b=B02H8r5P+tflzCp3qzu4nMibRtuu1sDDjpjMsbCryjht4grG2hJ2gQ18axu3zurBRG91qwpJ8gvXSiN82trcxL2FKjA35PU8SEJDEfdb8b5pUrWpKkK9Q4hD9sG51SBYIKEqmBzVnkFI7X7U7Fo1YVWnxDctDJbdR5Y2SHXtyeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763857848; c=relaxed/simple;
	bh=6xhfXXlpqcCqejVCDCYVo3oAu9yx0YwKcR0PFbIIDFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1efij4ToxkIhlhWSF2LZkimgQtdw/gAoxj/gOI8yfKh+TQaRjS58RBvuAH1xvGmj3q4NmuCXgbAnokTQdBlgej/cL2nDBIi9f0YNBIPgTZpYqdTItFKJ7Q6rPXvHKYBw8sEwVqhJ+fr0qhTkL93g8EBKWYJW65Tjxy9/ZjQ4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4Hf+pTz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4Hf+pTz"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so130435ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 16:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763857846; x=1764462646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26FtagD37u9GK5Wekr3iLHsRu7ImiEfyzh6Sww0KaxY=;
        b=M4Hf+pTz2Rpcl83gbjT78V1+bOdvAa9SV3dQ5VJ7+Oy7bgK3lAgNL03YzsKxWj1LLW
         nR+i8c5YxGlG9UzmZbkkh1j4rcIj74pfoF7gxblq0OdWeIfVzi24CSqM+bDp8en3A0rQ
         d5sKChbXX1mqHxxbduHFzeBb6lMYh2RtC9AciuL1OuMsrHFGCDqnbl4Z/wYI+d4nAFpH
         iOC7ThvElSKKBXI/WLRKbQZmJ+oefwQsSH/BNLyxsP2VRMqU9GfejCQ+wNQUGoXUcov9
         eWEu66D0D6ZUQP4m+5jh22g0SmjRBFXtkSZQ+Rv7T3Irbe7o1Lpm51Gc5CXAjLU7vNSK
         LCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763857846; x=1764462646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=26FtagD37u9GK5Wekr3iLHsRu7ImiEfyzh6Sww0KaxY=;
        b=MnUMZV7s+v4pRRZhXzKaVVnyjqLELF152QNppwjQsH+/VR++ZBYNt6uW0n31leXWc4
         ujFB4o8HofRCudus34nw+PT4hcA1WpHV1YlPUf7YZg+c2sR+43O8wkbjL+P+EI8NQfke
         ji6NozXVPZS8bJhUzwgBe9TG4neIX/QHeLGFVqw63iLz/HughXsuLPbND/v9j+GTmxzx
         7ArzJ0WtSlWNsgvKxT6JRyEznjMpXzTv3iPbPe2lWykz0PfcXo7eBFNthBhKapLUAl49
         4+LakL4wcVFbquOo157m1tt4zV0zgHzThSvKHZygCE4zk6RjzMM7TmsxokAZoWWCYFgp
         Wwdg==
X-Forwarded-Encrypted: i=1; AJvYcCV3KyFbFghqLoLSXcV4hixwxbOFUoMXPC0N4MReLbQyl0gGmHMXt8W0MI3/g9HjTVO2A6QQiCA8yHvtl3Wm4i4Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vpTuBijcjmR+V2fH4071lWofHzIgHvKBJrA1xQMclsv/78lk
	sqTiWSSA8B4RtYtHPwu7yHks4Ig8Tkfgjtka6GRVoJPqcexP1cDlCBeMI0wvNHy5F96W4wb05eC
	mTNw61XC5kVvRfevipQpyKhvfhPGCOtkk7KEEk46+
X-Gm-Gg: ASbGncuFcP3/sqBg+mToowpWFGNdf1urB/s2FuOhn8WsBlC/B2wmB3i2uva8VEr2YE/
	XeFacQvickOEzFpzU/rTGTk3WVdtbhfWJNGrkUYvZ3qpBygyAQle0L4qwukzSD8lz1a6zFrDgxv
	2NYX3Jc0GJWw1634iwR2rngoshyCFKQdmn+TnGxAiAnvp+YW1cpXA3FGtiMMR5Z9e2Y3q90kIzv
	S/yGfu1p3+vh7kGqWzv89cEpeAE/h6b4sPGVDIPVt7UjfcbrHZED+gTvPu8+bZnO4EuxDQP
X-Google-Smtp-Source: AGHT+IGxZugTBeTINYeI9mdAvYCHsBzpYel/BLJyZnES4BIkRliCez1EVoui4mKjHpvIj63YSLHiTDlfNoawTTs0VNM=
X-Received: by 2002:a17:903:41cc:b0:299:c368:6b20 with SMTP id
 d9443c01a7336-29b7b2db473mr2583055ad.19.1763857845403; Sat, 22 Nov 2025
 16:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119091538.825307-1-jirislaby@kernel.org> <796c2f61-b74f-44e4-a633-eb447a79c9f6@linux.intel.com>
In-Reply-To: <796c2f61-b74f-44e4-a633-eb447a79c9f6@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 22 Nov 2025 16:30:33 -0800
X-Gm-Features: AWmQ_bkCk5-a7wRNbNYgo7JW0xj6eHanA6zrrXGBweukWX05VbY3t4xY0tTZrtM
Message-ID: <CAP-5=fWBME6Di_=uPqytjPEM9a=S+qm-fDcUXJczwNtH5jjVdA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: remove dead check
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, peterz@infradead.org, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:25=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 11/19/2025 5:15 PM, Jiri Slaby (SUSE) wrote:
> > pmu cannot be NULL as is taken as a pointer to an array. Remove the
> > superfluous NULL check.
> >
> > Found by Coverity: CID#1497507.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > ---
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: "Liang, Kan" <kan.liang@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: linux-perf-users@vger.kernel.org
> > ---
> >  arch/x86/events/intel/uncore.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/unc=
ore.c
> > index d6c945cc5d07..e228e564b15e 100644
> > --- a/arch/x86/events/intel/uncore.c
> > +++ b/arch/x86/events/intel/uncore.c
> > @@ -1325,8 +1325,6 @@ static void uncore_pci_sub_driver_init(void)
> >                               continue;
> >
> >                       pmu =3D &type->pmus[UNCORE_PCI_DEV_IDX(ids->drive=
r_data)];
> > -                     if (!pmu)
> > -                             continue;
> >
> >                       if (uncore_pci_get_dev_die_info(pci_sub_dev, &die=
))
> >                               continue;
>
> LGTM.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
