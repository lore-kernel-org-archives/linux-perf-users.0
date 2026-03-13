Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1863CCFDF
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426463; cv=pass; b=fg4QPCDJYB/gookzVI4ozPKzKajVfX/D2p13s8b8rHWvB4zm2zfbvQBirqoVevQhvOfkeuT4vGsbTb3LLC4JnwuQFcI22FFIxJztPS0XKiiEQTIa/cNaTPMUvBFd89pI6Y09+OxCgbHZy+WCbI/NNDoXDAZuv1iTQKVvQV1/vxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426463; c=relaxed/simple;
	bh=AAmyCvJSK20oDcJpJy5ZLQECEAFrrgbzR5wrhKjifUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoiCtKMzPev/kTvcgk/F/RuwxpwQ16NymPpKWm+AamXwaSoDQtIf1nDwTlP+E2hjgjkA1QZMP6ODSNByMrS+rdnCvL32LFQJbvPFRAnG+WbVn7ww7fosqHwvEKk1WwE7QoJJx7cvLjEYLLnGiwW36F4RZFzjDNOlKk4QSnGxG9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRpXcF+s; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRpXcF+s"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aea4ebb048so13015ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Mar 2026 11:27:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426462; cv=none;
        d=google.com; s=arc-20240605;
        b=O1Srab7yeEufohcxgv8E7zbbppAKeGCf/q8pI16tKAjJ43g3+B4oRGHq0O43i8zhA7
         3IJ9JFTJtUJk/SWS1TVJg2aqDEYTcc5HaqxWP1V74DcX5D6rU8vMgHvp8iwF2GJ/iZdO
         FUSP4GFV9vv0f2O6nDb0paRBgLp+XTSdsgdQH2M+JpIXAUz1feAQ6lzCudidXDIVbJ/h
         aKp5FFCDeNqoJNWdWshb3g75Pw9AGb1S8kTX5FWSFhEKTpqzKcQ0+sZ2XrL2Dd+fd/ix
         BQJcfqCgD0mH0GA8ilcE/szN8SyRNcyUoQm2OIqrctFVcSPPcQyCebERk17Mcp37XaIU
         1XqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ZXzaMoKERCjz1ghaSwuDUfo9+qQRwtmcdYF5ukXgVo=;
        fh=2sIRGNct6IfV18gCLACKhrVl/Z5lZVE/J6784LDvXNY=;
        b=Db+dKAHCt0IbdpDdLafZFNNZoNY4XjM/zX2M/UKP0tIFl5JBCH10rPOBDuk+yUS6yb
         YH7J2vgxfjA728oMH8Dd1+qvmIor52rhyZMJ44SjN9+rL8GVYRSm02WjdBA+IFFOpFC7
         7/+c1zOCDQ+Aqc8iVmWqHp8hGZBGROzBfZavwt0XmcDf7bcfLQ+J4UlvAiA965hDuQEh
         Mjc9DKEXPMm6YQ5b4Wfp91R+3cMtyJFisE/RDkbbG/gvKSi3oktVuFTUZUAvrQf3m+c2
         wecVvHOVf1xRWrFuIckER5xDyAxALfLKn2YhF2UxIiDws0KkfNY2oyQk81GDPLAvPUFS
         KyCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773426462; x=1774031262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZXzaMoKERCjz1ghaSwuDUfo9+qQRwtmcdYF5ukXgVo=;
        b=ZRpXcF+sZai0XaIjBRTNDC//B9/bVRfKH1L7YvCN+N/7xHYxKO+Iojps9/OpOyRabu
         HqNGkOjHRz/qHSBr7KpOtucH5OWTGDodSkAWdR/TJgIvEdaTWhzNKrlySNlhy4i9DIlR
         TVMnqcrLtDFH8KhBVoKMoqLfI5qufr0r4KuV33/n878JORWef4Uw/veEkF+0fRTgOIo/
         letw8ULpoQ7FFJf0N6iC8vxX61mKuSQcssUYKg3FK3wCqGR6e+Jp60FHp8Ps08uM1cF5
         E4iDdczq5woyHqWK5AbOUXSkcW3xaBq09fZGIa5VeLmNBa/xBIt5tB3TgqFe9lAILK10
         PcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426462; x=1774031262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ZXzaMoKERCjz1ghaSwuDUfo9+qQRwtmcdYF5ukXgVo=;
        b=b2ESQw5uKWp9/6YZKJpoRrGFCIMB9WXkKiNOIEFLvG4ze7bdQgGZ4auRMCNPETKSQ0
         XzGuNRRAsp/uZHpJecm2OzBBFprkHVlA9yWcSKW4HKuGUyY2VFvuNUBeBXtV+Qs2jKJH
         tfE3KxG1at4eOI0fPlmzdBVSRxRg5DHKwBvdx7zGoEyTbvlkUXJqVGssDAKkjXi5wtQD
         WMFLex46ibf6GgdfCYN0ClMeCynm7ESAFaMElTpuYTLU8efgSXFh4NV8MFTMuxApTQVb
         y9eNmcpwPv/JIcWEkCKAHiiblAACTcNakMBx+Wgz2PgbT7eefVx9ZrA3tHft3cprKPPV
         nXCw==
X-Forwarded-Encrypted: i=1; AJvYcCUZU04UxO4AkS9pLVA+qMayoj0tqdmOotAkekf4SvPL/Ii5krpsI3/GK9wdXGqvqXJWkm2khPctJHfkS0gSLkxs@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBtNlAQIkdD6CzsIMf5IAj1f4P2+7QJbsPyH6In5wJBCmjpSQ
	DRvU97PgxPAyYupLs12Hh25Ja7enOr1beqgVghflL0eKJFEGCrPtsdPHJFoQtos+6ajqI5EaNc3
	xeVNxSDB4OgfJkegbkXQpmxW1iAMl1c7VaVRLb+DR
X-Gm-Gg: ATEYQzyXCYk9dFvC4BtaelLjaG2OnJRgQFHA2NxbjyeBXFVJNwjV7ruAY5lgA/57i5N
	KvRFhROLTq/y16V9DFisw/Eqgt4w8GcwWKvsWoNZ4jPRJRZLJ5iH1/9DFxyFyERMZ/Xis+4xYCE
	52LaKosBCr692T70awTJbVdXMGt9hvFYwi0sfroUk9beYClHHFBwAtZEZ1uaTPjz0cvlPcAN8Rt
	EzUCzJ1UqayGSiRrqWhhGBqQUB5NxlxzuZVrARZ1D+89MTujTQePJWj2U4eURrivkbGWMU1G5fR
	RAQtcq9Ird2WD4T/bVFsytaDEZYBQNksA1/x
X-Received: by 2002:a17:903:3d0c:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2b04215d8admr336675ad.14.1773426461212; Fri, 13 Mar 2026
 11:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66d0366b-8690-4bde-aba4-1d51f278dfa1@linux.ibm.com>
 <abQq79_ajs8zFeEI@x1> <CAP-5=fWG0Q-xNGn_-_KGCopaNsWG5rUN3pYNLEh3K7+xE0OwVQ@mail.gmail.com>
 <D40D4E89-3F4E-482C-9EB8-DCFAC70095AB@gmail.com> <CAP-5=fVxRd_byM2zZ_hLoZ36vPsN02nE4FozUuuwojXcJ3eODg@mail.gmail.com>
 <957241A0-E5C8-417C-98B7-B6E1EAFE19B1@gmail.com>
In-Reply-To: <957241A0-E5C8-417C-98B7-B6E1EAFE19B1@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Mar 2026 11:27:30 -0700
X-Gm-Features: AaiRm52t_lhcSF1wX8pGPQhi32IV0ASta6Z2XzmDaoAR6hnO7Bt0c_o8mb_tD_A
Message-ID: <CAP-5=fWBDMMPv_CSE4Yv5VC_+MhXF2ddjrePeR=EajyBfQjS2g@mail.gmail.com>
Subject: Re: perf stat issue with 7.0.0rc3
To: Arnaldo Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >No worries, presumably if I'd been monitoring:
> >https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git/=
log/?h=3Dtmp.perf-tools
> >I'd have seen it was missing. Perhaps you can give a heads up to check
> >for missing patches when assembling the PRs. I rarely look at
> >perf-tools.git as perf-tools-next.git is where all the action is :-)
> >Actually, I vibe coded a script that may work to automate this:
> >```
>
>
> Well, if those patches are ok for perf-tools, i.e. are fixes for bugs int=
roduced in the current merge window or urgent fixes for longstanding bugs, =
they shouldn't be in perf-tools-next, they should be in perf-tools to be me=
rger in the current merge window.
>
> Coordination in triaging via an Acked-by/Reviewed-by pointing out it's so=
mething for the current merge window, something I do, is what we should str=
ive to do.
>
> When I notice something that's needed for the current window that's been =
processed by Namhyung for perf-tools-next, I merge it as well (as will be i=
n this case and maybe in the others that you pointed out, thanks, I'll chec=
k each one).
>
> No problem with that, better be in both branches than to get missed :-)

Thanks! In the patches tagged as "fixes," I think these 2 also need picking=
 up:

commit aa6a6a2d16c1e2e27e986936369959d70316199f ("perf parse-events:
Fix big-endian 'overwrite' by writing") to fix s390.
commit 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec ("perf kvm stat: Fix
relative paths for including headers") for non-x86 builds.

The other patches are test fixes or address malloc failures that
shouldn't really happen, so they are not a priority.

Thanks,
Ian

> >Checking for fix candidates in perf-tools-next/perf-tools-next...
> >Targeting stable release: perf-tools/perf-tools
> >-------------------------------------------------------
> >Candidate: 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b
> >  Subject: perf test type profiling: Remote typedef on struct
> >  Fixes:   335047109d7d (Found in perf-tools)
> >  Command: git cherry-pick -x 6910944bf0b92fea63d5a7aeed69e4b9c14fd01b
> >
> >Candidate: 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec
> >  Subject: perf kvm stat: Fix relative paths for including headers
> >  Fixes:   a724a8fce5e2 (Found in perf-tools)
> >  Command: git cherry-pick -x 06ec44c2aa2ef15fd56f9808b6cf7495e1fbd8ec
> >
> >Candidate: 96f202eab8133f94479b14a32902c636e9bdf6af
> >  Subject: perf trace: Fix IS_ERR() vs NULL check bug
> >  Fixes:   ef2da619b132c6f74 (Found in perf-tools)
> >  Command: git cherry-pick -x 96f202eab8133f94479b14a32902c636e9bdf6af
> >
> >Candidate: c5a244bf17caf2de22f9e100832b75f72b31d3e6
> >  Subject: perf metricgroup: Fix metricgroup__has_metric_or_groups
> >  Fixes:   cee275edcdb1 (Found in perf-tools)
> >  Command: git cherry-pick -x c5a244bf17caf2de22f9e100832b75f72b31d3e6
> >
> >Candidate: aa6a6a2d16c1e2e27e986936369959d70316199f
> >  Subject: perf parse-events: Fix big-endian 'overwrite' by writing
> >correct union member
> >  Fixes:   159ca97cd97c (Found in perf-tools)
> >  Command: git cherry-pick -x aa6a6a2d16c1e2e27e986936369959d70316199f
> >```
> >
> >Thanks,
> >Ian
> >
> >> - Arnaldo
> >>
> >>
> >> >Thanks,
> >> >Ian
> >> >
> >> >
> >> >
> >> >> - Arnaldo
> >> >>
> >> >> > bash-5.3#
> >> >> >
> >> >> > Same happens on my s390 systems (LPAR and z/VM).
> >> >> > Is this a known already?
> >> >> > I guess this is a perf tool issue, same result when you execute t=
his on a 7.0.0rc3
> >> >> > kernel.
> >> >> >
> >> >> > Any ideas where to start debugging
> >> >> > --
> >> >> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen=
, Germany
> >> >> > --
> >> >> > IBM Deutschland Research & Development GmbH
> >> >> >
> >> >> > Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> >> >> >
> >> >> > Gesch=C3=A4ftsf=C3=BChrung: David Faller
> >> >> >
> >> >> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgeri=
cht Stuttgart, HRB 243294
> >> >> >
> >>
> >> - Arnaldo
>
> - Arnaldo
