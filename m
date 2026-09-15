Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5224CC27A
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498481; cv=pass; b=W48rWHbrWAvNviDV179D72FKRGjFwywzy5bNfcffS81uBn1HGpT8Glndmz07lx3yGV7TMTgQtEaSiw1/PI2oqSZcHhMNOSRonAQAlmvwswHXp29udAknIHQLeJomfedqXdbnQ8PDSYEUnD9Ef/7WeIPZylEpn3jVDyV9MNMgQSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498481; c=relaxed/simple;
	bh=GFVmruL3cPBEfvtAGaHzMJQ7fSP1HiCWYM4XCZnhV+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmPvkGZlH+K68AQuG+nfxUvh+SNXHFqpL5Ck+QkNPPkAAxeIYtqgNl3caFb3AIkAn990+6QDl38hFLY/TfnT2E5IbOClYddo6frB8Seye517ZdiAi6Rq7RMyLSNLNaEqTVbgDn65ALLFrxLY8QQaUvkmtAJoE3NjDVNZ891ujcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMLpY6ez; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMLpY6ez"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b917769so16865ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 11:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789498477; cv=none;
        d=google.com; s=arc-20260327;
        b=D8D768vEACM9pUWGEM459YtOypyCxB/Izi58BVOnpS5o5uk6N6z2E8tQ9Be3YoyuGY
         Sg1CTc1ah+JSNuCmqW0Xf/XupSkyWnPCU/dkdc17E9UrY02B4c0VHJ8Y0uet2zp35ALb
         evlHWm5HX/nXF6d58hd+rGGTE5V+i1Wwk/QRfMQ2Eh/OrkDIopEGrpXSX6C4UD0OYiv3
         HeoX8SR9LZq+ApB7Jl5Px222wcMTv3a5HudCMHAJ75dVVp0WJM2rvzUZMLEyW2Bl/J6F
         YDmuWaRKdYrvbLhn1Xc7sDUhOVtBD5LRcAff5RbsYQhTMAtHlbfrH5kpUIYEjHtvq/hW
         onXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=arRFlThrQDHJouWNW7pmtVkTmqxo0HW/M/+9WZYjCjk=;
        fh=4zd2YZ125J36P8gJu6szCagdUdruxx2ittokc/qqOFg=;
        b=iQ2MaS+lywEKDT+c7o4vhK6FFEoE1fSIziynt/WBztIFix2iuen2DFjPbueffwNyac
         VlIq2UBJNVz77ZBGzmGNf3u0Jmth7T85oDcRZUlNuyHc9fpTUQWs2rNCmoJz69WJcfC3
         BunKcfs6UK6WKhoYVVL/JrltaaQ8ke5VWF/5zE07Eg8Dq2Y3aI9T8BeIXvWoRDf5uD2l
         Y5UYNOs82ZbRM6MhXy0sAmzxLisx5msEGi9rUxj8cZzbnwEtSCKx82cC5ofz3qe2H/OV
         30ENWq05PB/k85E4JUGuBfwfZBk84j+bGAIvScvj/CVORCkM3usWRTkyuq+qiO3HDPJ9
         EeBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789498477; x=1790103277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=arRFlThrQDHJouWNW7pmtVkTmqxo0HW/M/+9WZYjCjk=;
        b=GMLpY6ezDXJkFcIPPWzCfgfdUr0zSkfoX6WUzI++JytBz5Rp0gpXyWl+j/0Z2X6sHz
         p9TQJAjRCbURbHoLL632skc0ZqOkgP11nP2HIuZzuOghQGgRy6lbONgBeL9DTdd0TO2O
         cUAFn0r36aeD5dvEJz7+tAyUFFhNgnz0G4vG4WmoSH+mDrRXU4hiqBly07YjPvCT+H4M
         WGCgRHMboB9LAONt8PBc20Rsv+BVJ3yB9nb+KrisPrpI6dn1zWZqh/2UwwgN1NcyBINB
         qjLuR4CebQtTWL38Ke992gNcRUVJOYv0hIJ5IPR5fXUYrYl5p0eMuymzGEB0il7s92Q7
         8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789498477; x=1790103277;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=arRFlThrQDHJouWNW7pmtVkTmqxo0HW/M/+9WZYjCjk=;
        b=pTBtd0HI388Leiex18WihjiBCd3mi5G5Qpwx91gcFJuYCm3+sUGmXgDMiNg4Woli6M
         qzhNkGRs41+5yyydtJN2z16CntFxJfZV3h5jGVfhZW86I5kS3q2iMc/751XctQymsRz3
         8+/YdbkHa7W74vN6ivGsBqbreMox+8Fu5D9eR/z/H6oIAkJK66QObGIZSlt1m2sDNtmx
         /s2o82ZxzkUN86d6LNtsWAepoYJL6qsiPnrdap+ty/Dc+6tZNlZsZZ0NxWDy/6xz3xBL
         eVP69iKrutfQT4lNuWht6RK7PMWGuB4PfCtZNc+2DTy+mkp/axGxz9DJjja5B1eAL3t2
         pxrw==
X-Forwarded-Encrypted: i=1; AKwUvBzSuGxFD6QAD0ZYJUCA/mD6VgbmuvB0IjqlyFAPZP2lwE72uBx2KMZpW7pnAi7T7f5DBPf/4nmU+7JK1OWUZ11A@vger.kernel.org
X-Gm-Message-State: AFuF++nkATlQSIJyyRB3zQ6PHzzDV9RgnkXTczBdvcmTj9Rq4AXQNC5H
	HszsYi2/B/Cs5Bmd36Y5qrwdxwecTiBlHDvBXZpJ0af+ief+6JP5HcezdZiAih8Pi7aCnsuLWHa
	L0U96rXCSIROlpwFTbsd3R9SOHeXfvqBgmCS1HJwY
X-Gm-Gg: AYBFou2HZLjvTD1+FK+03RYKRMO9kdRPnizeithaixkgB4So/KsyFQZoXIQmKvRUhZM
	MAIMFlv9polUEMfTIaQ7nXgrz5YhIr+Ws6lsX22CizyvLGmkdHeJHAamRNanznyMnfw0/AKpr+v
	Tf4sZjHdlNg8djrdY7lyac40HYJTlIOfXMiuK5ifLlfSJH0VM82aR6/rDOLr2DAAU+OPbQ0gh6W
	GhJggpdH84OnJJZnTRqcbfi6Zvg8jb5BXBl6N1d+tX8NeKfxkMGmGpqDZoRZfV5VaVZbJQi3sKZ
	zEu2fNU2tWzEROmFflE8fHcLsY/TE34rgPxY3bZAG2zijrR+voHMrJLG3qrqnlG0ilJwTETAC/T
	0U5nI/1qvOQ==
X-Received: by 2002:a17:903:1965:b0:2d5:db3d:1a45 with SMTP id
 d9443c01a7336-2dd89c53b5fmr918555ad.18.1789498476071; Tue, 15 Sep 2026
 11:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181349.3969429-1-ctshao@google.com> <20260602181349.3969429-2-ctshao@google.com>
 <CAP-5=fVwLO29i5SoLjOBhPqqUMTiy-z52Wm1mbeBF_941Jbx9Q@mail.gmail.com>
 <aihLa9ezNXXZm9mC@x1> <aqdRi7v_A03mY1tU@x2> <CAJpZYjXT5rrqQuUTePV6WS5XafgtW1Z4FxMoT93uKjYdKU1VWw@mail.gmail.com>
In-Reply-To: <CAJpZYjXT5rrqQuUTePV6WS5XafgtW1Z4FxMoT93uKjYdKU1VWw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 11:54:21 -0700
X-Gm-Features: AcwNN1VVwoWvz_e9gxbcbMEzwLeLB1HYP1av5G-CVgrJRZd7px1Xy6Hu_Vz2LQM
Message-ID: <CAP-5=fWKaSgVF5M-m7fObPdt5=MFZpK0RcmAS_G5thTYSzLXPw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] perf evsel: Find process with busy PMUs for EBUSY
To: Chun-Tse Shao <ctshao@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> On Sun, Sep 13, 2026 at 6:44=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Jun 09, 2026 at 02:20:43PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Tue, Jun 09, 2026 at 08:58:03AM -0700, Ian Rogers wrote:
> > > > On Tue, Jun 2, 2026 at 11:13=E2=80=AFAM Chun-Tse Shao <ctshao@googl=
e.com> wrote:
> > > > >
> > > > > It parses fdinfo with PMU type, comparing with the event which fa=
iled to
> > > > > open, and report the processes causing EBUSY error.
> > > > >
> > > > > Testing cycles and intel_pt//
> > > > >
> > > > >   $ ./perf stat -e cycles &
> > > > >   [1] 55569
> > > > >   $ ./perf stat -e intel_pt// &
> > > > >   [2] 55683
> > > > >   $ ./perf stat -e intel_pt//
> > > > >   Error:
> > > > >   The PMU intel_pt counters are busy and in use by another proces=
s.
> > > > >   Possible processes:
> > > > >   55683 ./perf stat -e intel_pt//
> > > > >
> > > > > Only perf with intel_pt was reported.
> > > > >
> > > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > >
> > > > Arnaldo, as the kernel piece of this landed (thanks Peter!) could w=
e
> > > > land the tool part too?
> > >
> > > Thanks for pointing this out to me, I'll do some housekeeping and
> > > process this.
> >
> > I think this hasn't landed, I tried to find the userland part of v8 but
> > didn't manage to, can you please point it to me?
> >
> > - Arnaldo
>
> Hi Arnaldo,
>
> Thanks for taking care this. The link to lkml for this userland part
> is: https://lore.kernel.org/all/20260602181349.3969429-2-ctshao@google.co=
m/

Hi CT,

Would it be possible to rebase and resend the tool part as a v9? This
will also trigger the Sashiko review, which would be nice to have.

Thanks,
Ian

> The kernel part
> (https://lore.kernel.org/all/20260602181349.3969429-1-ctshao@google.com/)
> was merged by Peter Zijlstra and I can see a tip-bot replied on it.
>
> -CT
