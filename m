Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E7C13C9AB
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232758; cv=none; b=lfZcWFXSxfZU4ObgD/41eSkDB/yb4sqqES6T9JTCoFgXrxFTqwKOIM0W8lALpg/6f8FOEuLPevK/Dmuy2N1l1+ST8Vwnn+xv0FcvMn3Qg07xBR+JtLxWjEqk1TIUSZBZST8z2BZTpP0p6je4pMda97z/y2dXoL0GrG5RzjPllnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232758; c=relaxed/simple;
	bh=KcZG6XeUtJ75DhXoFdTyBzpZVMCrL/nG/0AHYcu8Aew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHBl0YGIIfyrNi35ddkM2r5MkS/UvRtEtdLLpQ6l5ze3orJS4tl1e2j4CbYgaMuroc1BwEEi1gPrHlBFeS9A8+g79levzp9C7Xk0nMYbOMfOBaq7PqYB/A8O9sbHFfVP22sk1gV7Zxe6AMtut65q9dV67oPGz/AtdDcMJTiQoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u0fUXpfR; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u0fUXpfR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so206081cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 22:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232756; x=1715837556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnmxyCNyaJ5gJCBe5Vw+QSGnorZnRYFPb0h8ujnL3RE=;
        b=u0fUXpfRZz16Warr2E8EpV+2uY3JJycprXwddo2Y7yOQQDNYOBVID6aJo2L6/kWYMR
         yMCcMPLByMjMw2SHcuztoRKvWpb9+6ZWr8NeY14bAk9wXin49ifTMOgmQt578ORAhSSV
         0wgt7Z13rVhi9RLFVcFBC4W/vBriKCNxEknX7Kz85CDKEtag1FD6JEs0Ad3pitd+Pt0q
         h7iubKTlkPLcJmdC5draOraqI91UwZVzlIPFIXku3MCMip5HDH947JXXDuGIz8ots2vq
         xFEudQ1rouhee9u4CMzm4Zj8feZxBrznMiqs1cSpdLFY0GI0Kp64SMpJM2JxgvM/Lcmm
         f2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232756; x=1715837556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnmxyCNyaJ5gJCBe5Vw+QSGnorZnRYFPb0h8ujnL3RE=;
        b=d1FbOdvn4rLk08Ep6EbzIJjQsTbGOvuo0+Ja82mpo6/jsVEnQLWgTfLhGyTEy0sJhR
         PQq+wPQQCkIFoacFHHeZJvSLv67JbHtxsSlsPZXWe11PdFkw1hlarRi+nvxseS0bETRT
         IiG0QLYtDwq13T5T4IvfVgR+0yltWn/u7oVoxE4GZvxW3mnTv5c7Sl1e7BMlJjLvEsSf
         xpHj2bqOPVtG7O3CniYpA4JC4xbadJsXXFbvUzeGTehrd976uBue56ITcgY5Adk9M69E
         60lIkxsSLBnB8tMgc8Gd0b2yYJA+sHn8VXAnxHTiDQxeKw+EcYWymYvwuNBAWfDT37p3
         5OMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkdLpLugnBR0UyBzxYueDzb6J4PizFWabjPVsz81tBo9d2shrSwoaoJ0pysfn/lLwOogLS5JBSbx83Ietu6YB3IZko9Al9C9dC6YWIPfedEQ==
X-Gm-Message-State: AOJu0YzAiP2IJATaxLgAqEQxDxHKonl6rcOsaT73I+rfrkpONQfVvQrU
	KJX/+uOHdWN9ytScs1OAt63Vwo6TlLNmtd1lnPBdS4WnliWhSgbR1HpQt4iaJXh9QBhV4Oo4BGg
	6Phhg2ln9n8RvB8SDZntjz+pnEQr8ATlWAoT6
X-Google-Smtp-Source: AGHT+IG5HL1fWYphq5Kr6YvO0dFE4yJT9cnAoMviM/whh8Ln3jYn3yP9/oAzo1dkWv1geG2gtv6xOVF1tRmKf4mbdH8=
X-Received: by 2002:a05:622a:5914:b0:437:b572:6d with SMTP id
 d75a77b69052e-43df48267e7mr985441cf.21.1715232755452; Wed, 08 May 2024
 22:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com> <20240508035301.1554434-2-irogers@google.com>
 <CAM9d7cgw45sv2fLm8Yea_RgrOLswSPErwMORCBaeYVb=OXjnZQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgw45sv2fLm8Yea_RgrOLswSPErwMORCBaeYVb=OXjnZQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 May 2024 22:32:24 -0700
Message-ID: <CAP-5=fVKuCb_nCmHyJ2+GZwdv8yUVFBJjpt+Wjy_GcwzrCHN+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf ui browser: Avoid segv on title
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 10:26=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, May 7, 2024 at 8:53=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > If the title is NULL then it can lead to a segv.
>
> Just out of curiosity, do you know where it sets to NULL?

Yes, the fixes patch added strdup and zfree, the NULL is coming from the zf=
ree.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Fixes: 769e6a1e15bd ("perf ui browser: Don't save pointer to stack memo=
ry")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/ui/browser.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
> > index c4cdf2ea69b7..19503e838738 100644
> > --- a/tools/perf/ui/browser.c
> > +++ b/tools/perf/ui/browser.c
> > @@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct ui_brows=
er *browser)
> >  void ui_browser__handle_resize(struct ui_browser *browser)
> >  {
> >         ui__refresh_dimensions(false);
> > -       ui_browser__show(browser, browser->title, ui_helpline__current)=
;
> > +       ui_browser__show(browser, browser->title ?: "", ui_helpline__cu=
rrent);
> >         ui_browser__refresh(browser);
> >  }
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
