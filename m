Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F58126E71E
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768000624; cv=pass; b=rk9gwKFRYowWrCeiK1J40JjoFEINHVxcE78TDzlvoEUK11+gFTHbXYo09iQuWxQIPdIjcEoP4AVvytg30kiUMNqbK5ZsMoRbd1P1cpNcxaTxRHJQaufeaX2UhPrKRVnkrFHDrIiV1CQ2RHd+rLoZnH3FRs9/exrT/K2pS/f2Yew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768000624; c=relaxed/simple;
	bh=6v64bvjneaXLcQkB6m6l4SZFx/jxod3u34U6TRG8W4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nlfs6I0zpV6KeA/ilWuvKCU4Emd3jG4peK+EVZrgh2LZuH/eKVKvNjlrxPQCPGAcmO9Pm1UnurrDF/J4duQiVuY9IP7zMzyGW/U8J52/fV6sVQsyv0wkv6xyvB+Vi8SoblGROkCPFbl+Ptrara2xxkGtLkwiRkaO/K8wr2OonA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EyWCl6qs; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EyWCl6qs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d06cfa93so15855ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jan 2026 15:17:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768000622; cv=none;
        d=google.com; s=arc-20240605;
        b=G5T6I+mc/M29yqBCviDN4oAoWxTgS7NSyNjOtF+vYG/AHvdtDHIdeJcfPHnIC6vbpR
         EFTlS96J2OUXO1AzQEoxLKQm+/Y6i+XSz+3fGT9+Nqjy4CLuVGCEPIK3tu3mW9vzNFOz
         D5WY4VilOJQvC/WA8jMXiAhpVAvTCPDSpY58f0dVaatLuDf5o8/7FTKfbxHXDlLu+Co/
         OVPD36XvEePjRSHXqD/mUo2SyCDDHM4Z+XKdj14wt9ITJHWoIvbe3/QUOx4pGiOwQR4j
         Uq4VSQHgKi/uSjN/rLyKrQuxTV2XVMBAZ+L6l+LvyvsXTMVdQnUkj3VMFGTAd/3xbp2M
         4v+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pHt++g8r70KtlevT07gexjhVIWehNRMbh+jTUzABYfY=;
        fh=/G62m0Zaa6flqoCFyHqIwRoJY7F3Yk3iCTKP8ZeVF1I=;
        b=JV+KS3+Wrz7+lZUKwTMRom19qlf8ffXLhKHV3Xm21/j9xO23IsHrVvWxs0F3kw1Q0p
         mXJVJEFV2s4GrLvUeXCfRd2z3+hOsL52sXKFldxQk+gQc5YK/bZIc+VbJKq9GpPKJOej
         Z/p/m7XoWUnjHWwWVrtQGOlogN9LIMGuu1GnV24totUvlXRpSoiNgFS+BawoPxHG30vG
         Fd7ck0XKt/+p28MvmzktPE56o9D6ueH6ybOTW9lUjGD/lrpov+/pX5ETnDv3mGs6WV+G
         e4Zc24x5kDXlNDMDP4JlvZ9qJEDspBMz/qthlghqmyv4HIgsCjT4HRGnkG3yBZce2+mc
         AvNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768000622; x=1768605422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHt++g8r70KtlevT07gexjhVIWehNRMbh+jTUzABYfY=;
        b=EyWCl6qsWBKqaPdXAyqfFhd7CWTKfoZpERTh37lTDr72cvIJX2rM0g+buXJYAzPkoQ
         /B4iRi5EWhHqKLPdSPrbaiA99XiG9didawiy8cSFAi5RVQWQWhJ+IP3MTxbRQNF96rci
         uA1lN/s/N5zdiYOTyNusDeHLWzBjkgSlDrnZWLhHBPhOm3YRNqoH+Qcy5anOzSntERuP
         9ExrPeuTcDVWTgewQLBpswA/1aZFZkm5nv1hu324BJ6qRp1LyzyI7NuB2F3CMu1q8+eN
         VHp534hGdUxghU4EorTgBX6XxJHrmAscj2gEptgze6wHLdjraCsoYoaswAu/0QOZh9bC
         sE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768000622; x=1768605422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHt++g8r70KtlevT07gexjhVIWehNRMbh+jTUzABYfY=;
        b=lad5ih2MCrcdRxjknN85IKAgBvTBO/Zu8nSUFrywXKac/XUgxATu5oxhgsc4V1FKzi
         XSjbnALzRomd53UajETI2Ev0og2N+mLKvoFRYrNEmRAHY1vX0v+RWgHihL/FqAWe9WpP
         vlqxl2+6NYkjHRqJMfr5mJss+5kO5cGgcJ4FnfT3Fzru34FVAbULiRlmWGJNCvrLsgQC
         c3N2bTfNO22bE3GHgcDEbQ6JncqmCnwCa6H7hEGuZXM94OsJTh/f7RTLyGaOjsby8Pu1
         ZIvyTxuu6yG3mYfRcLWAreHdBxTBIk7QItTA3szQUR8sMfshCj7E0qZeR7X83e95ReC4
         iOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVWOz9KN/Oai+dYKjf4rr4FDUAjG99SHIWV8//grMyhBuSUe8LhAQZdHq7xxqDn56srKZbCAJIsY+XzS4/gSak@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MsBySeMZqqygahmDTOMxCr4UvWiH4/my8HjCT5aSTm+mcUq7
	CP26MC0md7TiYlp91vaJ5BfsPO72K1+gipGi5PDVfBS2hgqoTyiEwVcru6GSoFdAi3Kcqotat2Q
	ETalAjVYAyuHcM07xfn+XTOH+9Od0ZMRDiDki4u1u
X-Gm-Gg: AY/fxX65ivddz8wP+3Pr4oXDYE9CNkVDHDRwuu9KA+BOXudeE41ryMc08Xo+1Mw8Iyz
	ExUzoCjSmWvhpZNg2V0p/7U3SsLfXQjYVw1rdbvKXhdNevLHbMwavGaiQKBqpKfFDBNvT8MSHAe
	Zd11iAbNB4soHWzH/X3SZ5to2GmSO/k8zv61KCt9LJPUvWd9drvIH1sYJYA3u1NJg3JIJqcc0cm
	pLG+rUtZnTFo4+vJaBxNsNMilAm4iXRCXbidtwm24ZmMKKaAF8tt+1N5/X3urmvz+5CUb0SZNYN
	Vog3tCN4MVjp9QESiup2pwHQjw==
X-Received: by 2002:a17:903:1670:b0:2a1:3cdc:7720 with SMTP id
 d9443c01a7336-2a415608f55mr550315ad.21.1768000621939; Fri, 09 Jan 2026
 15:17:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219011820.2505506-1-namhyung@kernel.org> <aWBEr-PCJS4UEvtI@google.com>
In-Reply-To: <aWBEr-PCJS4UEvtI@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Jan 2026 15:16:50 -0800
X-Gm-Features: AQt7F2rXGhP1VDpYaQUa9BfJwImugGkRssgVkvXZvAHYAkkDJ1EIwMzeM6pesww
Message-ID: <CAP-5=fXp+jQFykEenXo4u9S6TstZ-xZ4ZHGOmn3HRBWHzc5agA@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf test: Skip dlfilter test for build failures
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Ping (for the whole series)!
>
> Thanks,
> Namhyung
>
>
> On Thu, Dec 18, 2025 at 05:18:17PM -0800, Namhyung Kim wrote:
> > For some reason, it may fail to build the dlfilter.  Let's skip the tes=
t
> > as it's not an error in the perf.  This can happen when you run the per=
f
> > test without source code or in a different directory.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/tests/shell/script_dlfilter.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tes=
ts/shell/script_dlfilter.sh
> > index 45c97d4a7d5f90e8..7895ab0309b29dd5 100755
> > --- a/tools/perf/tests/shell/script_dlfilter.sh
> > +++ b/tools/perf/tests/shell/script_dlfilter.sh
> > @@ -70,15 +70,15 @@ test_dlfilter() {
> >       # Build the dlfilter
> >       if ! cc -c -I tools/perf/include -fpic -x c "${dlfilter_c}" -o "$=
{dlfilter_so}.o"
> >       then
> > -             echo "Basic --dlfilter test [Failed to build dlfilter obj=
ect]"
> > -             err=3D1
> > +             echo "Basic --dlfilter test [Skip - failed to build dlfil=
ter object]"
> > +             err=3D2
> >               return
> >       fi
> >
> >       if ! cc -shared -o "${dlfilter_so}" "${dlfilter_so}.o"
> >       then
> > -             echo "Basic --dlfilter test [Failed to link dlfilter shar=
ed object]"
> > -             err=3D1
> > +             echo "Basic --dlfilter test [Skip - failed to link dlfilt=
er shared object]"
> > +             err=3D2
> >               return
> >       fi
> >
> > --
> > 2.52.0.322.g1dd061c0dc-goog
> >
