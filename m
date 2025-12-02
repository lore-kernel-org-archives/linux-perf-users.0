Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDC283FC5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692166; cv=none; b=MyGK4R1RgWmnke5+IM1/2cX4xAemz/0cedXsZV90uSaE3MDqk6nu/hr33Gh4twBYF9Kt4JJVzmEwLsJSrW79E+gqM6vH2a1Uk9xh0462IZuDp5cm4GcdK2S4/y8bEHCGP+8bHPZkV0y/HZzzTC5oTAwwxvAzFZRQD1DCk4t8GHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692166; c=relaxed/simple;
	bh=remfTrDM1aIETc0Sk88qOsVxDimHfdjE9H7wzCe/8hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4zxUzdg5VEEXyXw5HOsJO89zSePRPdVMIsjGFTApZlNdaS2EwURAWNSnN1j0nAundy22yCmBQwz+L5WTkHqKcPN2zhEoAcSGHg6mzcfnqxlm1xnShQ3H8iAxBI9yVnVB/l+RRDjgkCmIojhVYs89IWqCYFr8/n6DG36YOwf2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekAmnaN/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekAmnaN/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2980343d9d1so952265ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764692164; x=1765296964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oBF8USmDJ40ZYW4a82JBBoAjiGdK54Fzpigl/4R9dc=;
        b=ekAmnaN/EMonRrGCtAxbL3/BvL8V9olZbsyq17iXyoYphwQwtcsohZvHmX5W2kB8jt
         ZdrlB/BLPy4wYs1oKSUlWMmznpCG2IMvCHCy7hJCXi39ZEDUdzIzFLYqfhd0iReWj6eo
         BykYPYN5b1mwUs2Rn0mKXPdsPNCM8wOhpIrrf49AyF6dfn1PzkqDMbvRO5BcZpobj57+
         sV+tT1sTL8vbPfgwxm0yqcpdytjF1d544GxArcB0dj9/kFp14OV1/5ceYYi8qrNcVfZF
         T1Fmi93muUUNXc4rsRJi5AzlX91FDWHjNYmzHX//KpojcPOabRTxuueucAjxg9IoiIdk
         iSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764692164; x=1765296964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9oBF8USmDJ40ZYW4a82JBBoAjiGdK54Fzpigl/4R9dc=;
        b=wTdZiHbYASYvLpZa1jw5AYvXeZKtxC3VM+hPXchOQ8ssQxg854HxE9iR2P0+rnqfaT
         ucwgSfqJC1MpYAkKz8oCyJcubPL8mQEk6DWi9aRw/JyQRo1djLiE6sJifDcu1i3Chf1S
         7zQhrQQGfC8/nM10tOvfvSyXAQOKoZGYaxCMHRso6L+nZdxmo15HNAGv8nUoDI521YSQ
         FbrRMYX9pvmVruE2Up94XGeTvpnYC6ZLayaJvsiiyJ5E3QY84iImkecvt3lTdRdiv6Mu
         S/LKvVAoiDAAA0DAJ9qmOvSABSVgAscvewQrA64I1GRHLhqs3m+TU9PifgnUMZxoJXNK
         dK0g==
X-Gm-Message-State: AOJu0YwcYQhuhc7grqU56pcN2H3PZm9zeDlVdNBCK/lRpUoir7p/IVyY
	cJka7XTjdBoudYmMIqLj/K9+FebANay64kBKW+Vxp7P+T976hDMPlHRuu8pdgHFiuPciSzFGhOK
	YXgxvqZzJDvhDldeTIoTLdDJd25tznsu2JKnlvTPG
X-Gm-Gg: ASbGnctB6emfQDk4mlnqS80X2PpujKXBV15YaCgrdnllaxw67kEXmwHNfRCFAj6WTos
	Trmdh+Knk6Wa0YujOqiiL9cNQRUIT4mTTDHyM7h+g7GM69kEJsnHwQoSwoiVekMLP/kUnszNWXn
	TYWhP3j+YcbQ6SuVARxIuTNIfRzVuXjf9ig9Rhhdb9iX7zNonr77oPiUwaxUn+t6SqcZnsHlVZn
	Hb1U7uzGNohdP0xeIMXA22lk93yNdizKNYrPfSkvLu3opQQEheTPGq86fg2QPAZSre28v9EjboG
	WjcV4axu7PXLmumX3dm3nRWE
X-Google-Smtp-Source: AGHT+IGqm0ASgXz4YM3f2vYKEmhoMIWn3crg1qcrSB7K5HCDfa25vGUK20zvqssMxxNGyFuPVWtpKkj8hh/AVl+KdD8=
X-Received: by 2002:a05:7022:4407:b0:11a:61f0:6e6d with SMTP id
 a92af1059eb24-11de9385556mr112501c88.10.1764692163394; Tue, 02 Dec 2025
 08:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031162637.1456191-1-irogers@google.com> <CAP-5=fV1bobHM5bT8xU7sxZAFt03XNaXwTQVGj3hm9RyKsH3fw@mail.gmail.com>
In-Reply-To: <CAP-5=fV1bobHM5bT8xU7sxZAFt03XNaXwTQVGj3hm9RyKsH3fw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Dec 2025 08:15:49 -0800
X-Gm-Features: AWmQ_bkDWwvYim11tF-jrtnpeXVDyZYgIqVYIZQVhpBfbWINS9Zq8fO6MIQU8pU
Message-ID: <CAP-5=fV1TkcwGCOVXRK2gcM2KGqy9j=yNf1-bXJE1Zf5m_2Fwg@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor power9 nest metrics: Correct unit from MB
 to MiB
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:31=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Oct 31, 2025 at 9:26=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > 6.1e-5 is very close to 1/16384, where 16384 is 2^14, i.e. a power of
> > 2. When units are in powers of 2 the IEC unit is MiB (mebibytes)
> > rather than MB (megabytes) where the values are powers of 10. This
> > patch corrects the unit for uniformity and because such units may be
> > pattern matched against.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ping.

Ping.

Thanks,
Ian

> > ---
> >  .../perf/pmu-events/arch/powerpc/power9/nest_metrics.json | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.jso=
n b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > index 7a5d1bf543f8..8d028a7c2777 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> > @@ -29,25 +29,25 @@
> >         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT01@ + =
nest_mcs01_imc@PM_MCS01_128B_RD_DISP_PORT23@",
> >         "MetricName" : "mcs01-read",
> >         "MetricGroup" : "memory-bandwidth",
> > -       "ScaleUnit": "6.1e-5MB"
> > +       "ScaleUnit": "6.1e-5MiB"
> >      },
> >      {
> >         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT01@ + =
nest_mcs23_imc@PM_MCS23_128B_RD_DISP_PORT23@",
> >         "MetricName" : "mcs23-read",
> >         "MetricGroup" : "memory-bandwidth",
> > -       "ScaleUnit": "6.1e-5MB"
> > +       "ScaleUnit": "6.1e-5MiB"
> >      },
> >      {
> >         "MetricExpr" : "nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT01@ + =
nest_mcs01_imc@PM_MCS01_128B_WR_DISP_PORT23@",
> >         "MetricName" : "mcs01-write",
> >         "MetricGroup" : "memory-bandwidth",
> > -       "ScaleUnit": "6.1e-5MB"
> > +       "ScaleUnit": "6.1e-5MiB"
> >      },
> >      {
> >         "MetricExpr" : "nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT01@ + =
nest_mcs23_imc@PM_MCS23_128B_WR_DISP_PORT23@",
> >         "MetricName" : "mcs23-write",
> >         "MetricGroup" : "memory-bandwidth",
> > -       "ScaleUnit": "6.1e-5MB"
> > +       "ScaleUnit": "6.1e-5MiB"
> >      },
> >      {
> >         "MetricExpr" : "nest_powerbus0_imc@PM_PB_CYC@",
> > --
> > 2.51.1.930.gacf6e81ea2-goog
> >
