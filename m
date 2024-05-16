Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA61474BA;
	Thu, 16 May 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864892; cv=none; b=SpNk1poRTXMyiM+CoIGyQfPQ0cy5yP/gp7FPiDISKlQw5CPC20LUfnqmD+2J9R2SDU9C6WEhxq7RxqIWuELLJ8gMyUwEwPBwsTwhfOYU/XUGrgQzbUFQv/robjDBS21uVMMTj053mjvw7DdZRBJ8TPAN285efBrTaDP+Iff/LcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864892; c=relaxed/simple;
	bh=LTLX0LeM+qS03ZxB4OHmr2DRJXBFAV5FfJtbLW+rRa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOiycGDDx2Ys5RVIETP1eRdHRWm0xiLPowNG6TixC5Nuwh5PK0fxEqb7JXm4CHi/X7gCAt7Zqt/6fwCxwDLftyM/Mdx1QiuvubH+yKpd909TBRDqbgrdkAqB8eyToEkoptF9fmuq8Z9V1/cVfP+q4tfkHQLHPgyj9ddOe973CWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5ce2f0deffso103738366b.3;
        Thu, 16 May 2024 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715864889; x=1716469689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3xI3WqCXBZnh7JICdirIiSsZ2+IepKR0X49gjIcQu8=;
        b=U7nrWgiDdqIteNJF7PziMKt3yOPFzeVKebCo7ZsoA2y4ckhwFAd8Y7EI6LJVSmT4It
         m7UQ/xQeRr/PtwjGszoVhzK0hTvCdGOMbNqtvm5Kgmo0tgGQ8sdHChPcnY531ahwg0Nz
         wIdOysSOjpl2IBBvwgqyGLGFo+zH0N72cSIoUcmyqMjCobZ0V0fkTnCkULO5b87XF8Hv
         2iMtk/8sbk6R0l3oG8WQrrukhqo0ZqT8bivQ1QTSp1V/+qmRwVyYS32i1+aFuEB3gfHg
         dn01sPqviDK1u6H7xvopAm+t2J0C3R7E6PDEyDklVaVnXS629drP2s9ltH2J8n4wjyRu
         YItQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFxHr9XF2v4O0xVm45MPtLxzcCJXCSozUtmkS35RXfOrb2JXql9EKakHWisXaAE0TTH92Io58TRmaEgn4AIr6q3k9WWuMw557AJCcnuIWR4tdMPQ6hi+krEJ2BK25NbjCuqoqBl7p6f9YCuQVC/Q==
X-Gm-Message-State: AOJu0YwJcccfutVdYYGkVNIAXygGsqKsBth7idmWxcH/aZ4oJzWpWjrR
	TS86vt5a+qXvsVkz6s33YuzeLkjfEWDNSqAW+nKi4kZI+1nMxfk6
X-Google-Smtp-Source: AGHT+IHj6g17NY36UT1C5E1qzE5vQQVCSq6a5qXMzfef9hvyCrnuyZLS/XU8bjsk5rSgGfRB41Azng==
X-Received: by 2002:a17:906:3d0:b0:a59:bfab:b25a with SMTP id a640c23a62f3a-a5a2d678063mr1306501066b.63.1715864889376;
        Thu, 16 May 2024 06:08:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce5dsm969498966b.42.2024.05.16.06.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 06:08:08 -0700 (PDT)
Date: Thu, 16 May 2024 06:08:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf list: Fix the --no-desc option
Message-ID: <ZkYFNrwGtdi8XHSD@gmail.com>
References: <20240513212007.62904-1-leitao@debian.org>
 <CAP-5=fXimpTxhC0A+MDs8t9zn=hifHFxLChQm_QzJQtuHbztPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXimpTxhC0A+MDs8t9zn=hifHFxLChQm_QzJQtuHbztPg@mail.gmail.com>

On Mon, May 13, 2024 at 07:51:12PM -0700, Ian Rogers wrote:
> On Mon, May 13, 2024 at 2:20 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Currently, the --no-desc option in perf list isn't functioning as
> > intended.
> >
> > This issue arises from the overwriting of struct option->desc with the
> > opposite value of struct option->long_desc. Consequently, whatever
> > parse_options() returns at struct option->desc gets overridden later,
> > rendering the --desc or --no-desc arguments ineffective.
> >
> > To resolve this, set ->desc as true by default and allow parse_options()
> > to adjust it accordingly. This adjustment will fix the --no-desc
> > option while preserving the functionality of the other parameters.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> >
> > v2:
> >         * Do not print desc if long_desc is being printed, as identified
> >           by Ian Rogers.
> > ---
> >  tools/perf/builtin-list.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index e27a1b1288c2..16186acdd301 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
> >         } else
> >                 fputc('\n', fp);
> >
> > -       if (desc && print_state->desc) {
> > +       if (long_desc && print_state->long_desc) {
> > +               fprintf(fp, "%*s", 8, "[");
> > +               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> > +               fprintf(fp, "]\n");
> > +       } else if (desc && print_state->desc) {
> 
> I think we need the same fix also in default_print_metric, on an Intel
> Tigerlake I see the description repeated like:

Good point. We also need the same for json_print_event().

Thanks for the review.
