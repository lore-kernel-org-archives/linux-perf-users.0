Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185A7E6
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Oct 2023 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542864490;
	Wed,  4 Oct 2023 21:44:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27734d76e1bso398184a91.2;
        Wed, 04 Oct 2023 21:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481087; x=1697085887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSXc66j6KPSxT44QaA3/43T0mBt/pQC0vRdLVYS87ZM=;
        b=JEGDMaZCoUeoSEqDgVJiEYfwWpINFse1OnRuAHKlWqqieYnFrKCYyNJnmR0NuvyhXa
         6Bx8ou6gh4AkE7F4nwBUxVyyACB5WDTRu/Kl+AvtC18V1RrEdWY6ukwQs2yXkGFBPO0a
         RRckQc5yzmsg9/TaluEh1l00E4KZtdWGo/e40IUljH8pPKrbyPya8JViUQ/1Ou52X3hb
         PsQ9LLJDryd4H1+HCPRl/9SX1ULo/HYlee9zV7/C+9aYW9CyPlfLZ7bwKe4EJirfrINl
         wLRkHokco7KlzzoLmIPuAHmv0Qt9i1xR0ZW75np81tIUlEah+nbTcI6esi4BnprmTPjp
         yrhw==
X-Gm-Message-State: AOJu0YzUrYv4HuyPE7J2rjvCFBdyVUY4et+ysJVxo9vsoMcU/Zapc0WS
	xpuUAW09RefeQhZyOjlnP0eijcGSTN/eUvj031Q=
X-Google-Smtp-Source: AGHT+IGo2QtMWpHs+yNK54aIUDzWc4jm4grLLdU6ExjvuYKDCoZf14FvBPctqJn3elwrMGkHvJHDFerV2y0FEiVshrM=
X-Received: by 2002:a17:90a:9101:b0:273:f584:40ca with SMTP id
 k1-20020a17090a910100b00273f58440camr3999328pjo.16.1696481087457; Wed, 04 Oct
 2023 21:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231001131047.15176-1-april@acab.dev> <CAM9d7cgB6GfJSQhWJwmi=FodKwsYdVy_FnRJ+jzt1DpmO-J3cg@mail.gmail.com>
In-Reply-To: <CAM9d7cgB6GfJSQhWJwmi=FodKwsYdVy_FnRJ+jzt1DpmO-J3cg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 4 Oct 2023 21:44:34 -0700
Message-ID: <CAM9d7cjRxp7zSZ0PFCW6xWvcdJhDHynu-eFkfwYXLPXWRqcthA@mail.gmail.com>
Subject: Re: [PATCH] /bin/dmesg to dmesg Path
To: April John <april@acab.dev>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 2, 2023 at 9:16=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Sun, Oct 1, 2023 at 6:10=E2=80=AFAM April John <april@acab.dev> wrote:
> >
> > Dmesg is not in every distro at /bin/dmesg, in NixOS for example, this =
fails,
> > but the path should in most cases contain dmesg.
> > This follows the example of replacing /bin/bash with bash Path in the c=
odebase.
> >
> > ---
> > tools/perf/util/evsel.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index a8a5ff87c..aa602aae6 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -3053,7 +3053,7 @@ int evsel__open_strerror(struct evsel *evsel, str=
uct target *target,
> >
> > return scnprintf(msg, size,
> > "The sys_perf_event_open() syscall returned with %d (%s) for event (%s)=
.\n"
> > - "/bin/dmesg | grep -i perf may provide additional information.\n",
> > + "dmesg | grep -i perf may provide additional information.\n",
> > err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
> > }
> >
> > --
> > 2.42.0
> >
> > Signed-off-by: April John <april@acab.dev>
>
> It is usual to put a tag after the patch, it should be at the end of the
> commit message.  With that,
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

I've tried to apply the patch but it failed.  It looks broken.
Have you generated it using git format-patch ?

Thanks,
Namhyung


  Applying: /bin/dmesg to dmesg Path
  error: corrupt patch at line 11
  Patch failed at 0001 /bin/dmesg to dmesg Path
