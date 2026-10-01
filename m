Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9F4A3862
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873137; cv=pass; b=pjYM4dWL3CRzPj0ynu/n4dp7CQhd8PMopekOaFnXEhwNc1b6Id8S7IG3JXMkdreRbQL2G0XXdOgqWsmKI/7Kdqyy1EJCq1uLk4netNVdxThPPUpCMzrB++nwc2Oj80VHjA4qiaUQTcgL6PCYusWBpahrxg8fGJF+JPJvzdmMA/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873137; c=relaxed/simple;
	bh=skO6HOeEOlSoI8HYXQ1xBxBxbaOcIwy1hi5C/W8lSm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsviVwJ2UBbx2FlqaEnCdis/W5p7D3wqdluBRw1Et05jr8rmj07Qb1/QodCZKY3nU9sgYvf/tArrjpUHasxALsH9/+Z0StM1kQwwdhH6njHTYR2VAVM6aovbTeFK6bnT3hzDjYn5T69uxwLBtWSO9C2JyUnvGUWdBDpbTbDaYys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dSHQvlV3; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dSHQvlV3"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5337c7b9937so1081cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Oct 2026 09:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790873133; cv=none;
        d=google.com; s=arc-20260327;
        b=Sx3LfZNhL65rc/EyjekCx5Emk7MWS9rauvZKDpBRzCHuswlauxIAcFJgt1TT42IJkg
         phyBLte9GqGrxn5rA+dJHQgvPbhKw78Up2hsgbWoyTa8jhuM/6SvK9i3pjnmIJQOYf/F
         jO3fsbgD+tarNYZ5QOtieUOdtjBbXwQMHdSuRGcxhpSiGKdBURhUHQUnFBmbKcFyLaE6
         l9+HVHDehy87Ym53I7111Eqh6ZTj1QeFYJh9/1azXP4WpKN7cLWzq2F0tl2NzKKNVk1s
         CyGC14dl53360ldTDhmBaT+DnfpkHJuqDulGTEzGm3YeP/MG2LbujKMbsupStvZva8av
         pUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        fh=3Di5/fzPKm0/tfKF28CTo/f+xp940bsm7Gj4fowbbSA=;
        b=S3jk5zu8s0NHltwf6CNOcOLOxwo52smZNPb9owB6XZpsYBWJo5OLHXrzDq3yHTu5g8
         mVdKYDZrHkFireTwEWDff2E1Baw3FWLYXu8X72f/1RkXu3+o/BIQfUbN7SUWEal+qucL
         vK/PyTi+zkl5QGAVn0aeX0CBwyAtSF2YjEea8SANft85rU4Rqz5G6sLuO6t0e8ZNm+k2
         QPUvK3UTMKb7WKj+irgUDEx42JOTe0Dwspge7SSIAEQVi7zPndEdB2McbC9aCdVy1cV7
         5hjuPO3aTVAPn+RYGxFiDU/+IKMnVlHCsR0yq7Xb5EhbzyDOgHd4JiZaSSiUkxbiQvOn
         jidw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790873133; x=1791477933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=dSHQvlV3ttXf+p0UrKNvkc+mwmTE521P+vXOYLKzyAFQ7uoAytn8r+U1gLRKQ5iyBt
         Gjretepz+PLrjFNLaNi9m/aNN2dfHPwCeNxI+sPGsbyY5xmyBUkyalmsoZzzWOQZTGi3
         vzIo96mKt+QGBeyJxX2juiUd1AJZujGhWGxro0WYQG4gmF4/lcJoed/1a5KjkY4ly8SM
         A61aUTGBspAU+wK0M/GpQRhHs4Lk4rFehX/PlJJAqgCJXUR/PuzYT0Yodf928IYWRTUv
         wbmhVrzViTLgEteqKxdBbCSg+l6yj9TrSNj0bl9F4IpsiZSwC/tFQ3LKKDNiaLcM2vd9
         73Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790873133; x=1791477933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRgW/0sJOag/ZnUMEgbSJgdYp6WyDMPTuDfsAauk39E=;
        b=E/AInoB2jWkrIGa1CEYee/u6BSyRnodXYqTTmZZvqOofriayUfo3CKjxz6isupQ3Q0
         4DzY5lYlOlWbqDMgefs0CcAKY5UhWd/XgnAUcZZryq62vZEJpejcF6rDBXitpXrZnSkB
         QC1yZC5Rlqy2X1ik9q9SJBOOeXz7KTXBbi4CLw99thVHFUqvvxq4w3Pihh5bsWTeGZso
         wbIwX+/x8OE/Q+uoO5/xqxbg2w4/skZ4Q20mNaRNUadDpku153Wynlyo2Zf85uc3gymO
         EFaNDe2q/dUY/bNUBGIA4BfWzSJeCenRvWBPcfZofgSBWRgYueZL37jn14TinNT9otGd
         XBBQ==
X-Forwarded-Encrypted: i=1; AKwUvByvEQzyd9GY7M7FPfrekEHRNxAJ0pds24ULCjB8U/hXiWOZ3wHZWkycsT+FFNWFqH0C4u/6QAtgNhdT+SsgveqA@vger.kernel.org
X-Gm-Message-State: AFuF++nNYf4gxQwnere4jnQhe6bEVGNjkY4NH6Hu/wvdO3g804FYQD+O
	BnKtczcC6qC8ay3b5+X6G2O44bR7Dsz/9PAiGU2ujyr28w1YUt/89d4c5l9dKQYcB8jFazn7c2z
	NcThx6Nhwq6rh0WjeEz6qd0bPlO+k1e1ieNVf9tEp
X-Gm-Gg: AYBFou1eetV3eaMAYFlcIx0RlaRo2sFnvaCqGjCvbRBFrtRdrFIZN09CN4k4/NCkLTP
	RyfEHlCxkgZp2gqaBMslvnHXinpLQ71MHLIs34dv9IYQ6pYvH4b/v+7xNaoUj0EH5z9U4R1Rr8F
	sfjxm4iQuRChbCc2aihD5cpQl/sa5yzng6LlyoouJtOMN25/osV6bPuOIc9zZpTfSTq9wckucvw
	H7UwtoatZbNP8DWn7ydisFbkW4g8ypk8devX+Ulqt6fas8p8EFNo9dHuCS51It5fet0m6yDg2hT
	DStYKr0jwQ9ovTslzKGT+tKVLQRmLCtgGJLjLQSTXsq+islawqRqXNcOJzennCEm
X-Received: by 2002:ac8:5cd4:0:b0:532:858d:e791 with SMTP id
 d75a77b69052e-53389203f68mr14532881cf.8.1790873132647; Thu, 01 Oct 2026
 09:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929182108.794434-1-irogers@google.com> <20260929222332.973435-1-irogers@google.com>
 <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
In-Reply-To: <20261001070755.GQ88198@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Oct 2026 09:45:21 -0700
X-Gm-Features: AclHuK_uPGIN6Z6xFRRwa7F-fBv3kGJch6oICz0HkXG7IE_sZqEVpHGVInH4o1Y
Message-ID: <CAP-5=fXCL7bd08B_i676eVwwvQ7XJua2XTvck2Nu3_ujBD=uGQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf/core: Replace perf_event_header__init_id with
 full header init
To: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ast@kernel.org, bpf@vger.kernel.org, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, song@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 12:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Sep 29, 2026 at 03:23:32PM -0700, Ian Rogers wrote:
>
> > Rather than splitting header initialization between callers and output
> > callbacks and saving/restoring mutated header fields, replace
> > perf_event_header__init_id() with
> > perf_event_header__init_header_and_id(), which initializes header->type=
,
> > header->misc, and header->size alongside the sample_id fields on each
> > invocation.
>
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 33210aff3ee6..c1b2d0c9b2af 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -8119,13 +8119,18 @@ static void __perf_event_header__init_id(struct=
 perf_sample_data *data,
> >       }
> >  }
> >
> > -void perf_event_header__init_id(struct perf_event_header *header,
> > -                             struct perf_sample_data *data,
> > -                             struct perf_event *event)
> > +void perf_event_header__init_header_and_id(struct perf_event_header *h=
eader,
> > +                                        struct perf_sample_data *data,
> > +                                        u32 type, u16 misc, u16 size,
> > +                                        struct perf_event *event)
> >  {
> > +     header->type =3D type;
> > +     header->misc =3D misc;
> >       if (event->attr.sample_id_all) {
> > -             header->size +=3D event->id_header_size;
> > +             header->size =3D size + event->id_header_size;
> >               __perf_event_header__init_id(data, event, event->attr.sam=
ple_type);
> > +     } else {
> > +             header->size =3D size;
> >       }
> >  }
>
> I've renamed the thing to perf_event_header__init(). Also, I've done:
>
>         header->size =3D size;
>
> and restored the:
>
>                 header->size +=3D event->id_header_size;
>
> and lost the else :-)
>
> But yes, this is better. Thanks!

That makes sense, thanks Peter!

Ian
