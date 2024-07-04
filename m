Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD7BE5E;
	Thu,  4 Jul 2024 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057531; cv=none; b=uNkZCWeJx0RKUQLPjm0VgCVOJMHyWgTlw3d1qUkzHP0RpkkrYI+K2NU3t8Do+fPRfAkWbDaJGIq8rF5VO2cxtAylY43ExC8KkDk+/+qPMsJORZKa6Nwi43w8wTiBe0U97hep1qUMpN0kTvCFSRzfgUpkSzK/BRO9bj2vmitGd+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057531; c=relaxed/simple;
	bh=SPvd8VwZD/E153NMdegZE4h/pGxOsQ6Y4bfsLGCF5kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM5WojNe+IWFKu02qSk14gvADmbmpuaJjFNkn7pWCti47xmo7FdVdRSM2vQNOQs8ukaGBgeg2/dCeYMfMEVvEu8JRSz6lgorNrR/8P695eRBudNX6jnbvnqFvHKDE7uoV76PegFhRglC2aUrGMtt1hwCWCdoM0kgchwSmdyLDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70af5c40f8aso125118b3a.1;
        Wed, 03 Jul 2024 18:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720057529; x=1720662329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YikNPi3mD5FM+s7PD6odmr1mocmGFb6M7JPjoY2/qg=;
        b=ovDolLwxPrS686Hhy4eCSeUjuUUArHLMgw374fFeYIkUxci5R7qrKHzack8FhKDQja
         k0emV2C0IvdiMTrzeOUPBtqXvOIWw0vCqjYSDZV6u9GtRQ4y/jp1XFCFLMd7Wk9UmQCD
         VfroX0RuHOayxZbVW9stgDPciyk6NoFpqO8RGJkHcN6X117k5QJiQzdCOhR0Q9BDRr0N
         hqEoT3W55Cge0gU7in+wrh/LfdoPWyJBGCeKw5MYWAbMcMZwJrPRQL6VHzsnh1ZQB7fj
         pJO86Ss57cpIppI9QY8m6EPlFHFSnc2VWTEO0+0t+WZVDsFkgncFFVaMB6PUeXDm04WC
         /ISg==
X-Forwarded-Encrypted: i=1; AJvYcCVm/h6Y+WuQk6ecWMRFAi+DMk4ooGGH9cG/LuENPXj9AoWA1WMouTEh/meTTyCMHRFmM4pCn8eNBWsO0NIKUX7jSO1vKFnUH/hdOecQ1vVvGuFYueYn7gISK4B+d0fEyvRlqK3XtOVNNk2SjZTUFx0TLHN2xAA2o79KhodN7ljxxneZ7ahrFDJn8W/KCDC4vwsHCQ==
X-Gm-Message-State: AOJu0YyzIJjqxDUw0OXLWCj6AORgvr/03FRF0O834DV3P5pj/Qq77O0I
	8rCgp3eDiEgX+PJWivrvYPkB4FQAw9yjIazCTck9IG3EYD+7vRSG82UTxxQ3b8M7x0rDttF0f81
	TDlUn/FiIkQSCrwVJDSmzaOzYhKc=
X-Google-Smtp-Source: AGHT+IGrIktkFkR+oCtQa6tf3fiVVVoeQYpsPJ8mYibF+5dXfWH9YYbLGVSBQFJHg8B/JlVl4sg1Fc3jslXvRF8wQjU=
X-Received: by 2002:a05:6a00:2d0c:b0:70a:f0f1:480f with SMTP id
 d2e1a72fcca58-70b0092ada1mr300137b3a.3.1720057529184; Wed, 03 Jul 2024
 18:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628202608.3273329-1-amadio@gentoo.org> <20240628203432.3273625-1-amadio@gentoo.org>
 <20240628203432.3273625-3-amadio@gentoo.org> <ZoSP_vFMVl83pxES@google.com>
 <20240703153617.650fcc1c@rorschach.local.home> <ZoXDoajJqDiIcgwg@google.com> <20240703190502.392be247@rorschach.local.home>
In-Reply-To: <20240703190502.392be247@rorschach.local.home>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 3 Jul 2024 18:45:18 -0700
Message-ID: <CAM9d7cgVFRO-NR+bFNxB6SgWuxyr54LeSvnwHD4r+ncFhaDutg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] tools: Make pkg-config dependency checks usable by
 other tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Guilherme Amadio <amadio@gentoo.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Thorsten Leemhuis <linux@leemhuis.info>, Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 3 Jul 2024 14:33:21 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > On Wed, Jul 03, 2024 at 03:36:17PM -0400, Steven Rostedt wrote:
> > > On Tue, 2 Jul 2024 16:40:46 -0700
> > > Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > > +CC Steve and linux-trace-kernel list.
> > >
> > > There doesn't seem to be a cover page, and it doesn't apply on
> > > v6.10-rc6 nor on tip.
> >
> > Oh, sorry.  You can find the whole series here.
> >
> > https://lore.kernel.org/linux-perf-users/20240628203432.3273625-1-amadi=
o@gentoo.org/#r
> >
> > I think this is based on the perf-tools-next tree and depends on perf
> > changes.  If you're ok with the change, I can carry it in the perf tree=
.
> >
>
> Hmm, I checked out git://git.kernel.org/pub/scm/linux/kernel/git/perf/per=
f-tools-next.git
> master branch, and it looks to contain just Linus's changes. Is there a s=
pecific branch?

Yep, it's the same as tree: 'perf-tools-next'

Thanks,
Namhyung
