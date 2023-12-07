Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6651727;
	Thu,  7 Dec 2023 12:41:26 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d048d38881so10401735ad.2;
        Thu, 07 Dec 2023 12:41:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701981686; x=1702586486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ertAQ/XyfkeiqVhWFyijagBt3DCkqglpo69jMsd5dTk=;
        b=ItEK50E1AKumUVx5BcQZMqxloiP/7Vx0fZgFc4HawyywdmN1eDf/MbPnulaRCOurQb
         8/lCRDmsT3h9x5/6+TeZTEymDJRsOiEsnwuEJ+QhueXZ4muev2q3AvVN6WABm+lSVNN4
         Rg6j6/SKWb9krRiYc4A/kYDd4dshi0YRCHOxFPFWyzja7eGEZL3LaJTBGw3JNbzY4L4s
         gipFiSbilfgDApEzoE6F+I/FJmd+0boBk87+VAVEOMU2QVV7Y/sbAap9DgA0KOmWEWEt
         9Om+OeymCd/i9Sizf6atrmKf/QIE9tBsgkdAFX58029l2+/WubwC+2poFrfNW/s/DesH
         DfjA==
X-Gm-Message-State: AOJu0Yx2hqhD0/b7oyi/HxAaZXesdsrmK6GEKOIIx25AorCS0kMkJJNP
	LDJG/GJmNhbmHKHfbMKQPrCWdIecCD6XfmR2lx2hc5RBv8U=
X-Google-Smtp-Source: AGHT+IETK/ZIBBWSnej2AHVaDXTSJyrSjWXTCLalDqzjnurbXAmTOaTyPYadjSwdrWBVBxwyYVL23HN0QA+OfUT2Av8=
X-Received: by 2002:a17:902:ea86:b0:1d0:8d57:47c with SMTP id
 x6-20020a170902ea8600b001d08d57047cmr2943727plb.25.1701981685734; Thu, 07 Dec
 2023 12:41:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
 <ZXIiBp-rvdvSI-ZY@kernel.org> <ZXIicbe9K5KYGSV4@kernel.org> <CAP-5=fWN5Jwsf5dxqw0BJxpdu89FM54A-AtQpEqxeE7XLDx3mA@mail.gmail.com>
In-Reply-To: <CAP-5=fWN5Jwsf5dxqw0BJxpdu89FM54A-AtQpEqxeE7XLDx3mA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 7 Dec 2023 12:41:14 -0800
Message-ID: <CAM9d7chXf7F9T+ToKXG+p+37-noMRtOmUr9sttBzEDOw8uJGgw@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:14=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Dec 7, 2023 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Dec 07, 2023 at 04:50:30PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> > > > On Mon, Dec 4, 2023 at 2:46=E2=80=AFPM Namhyung Kim <namhyung@kerne=
l.org> wrote:
> > > > > On Thu, Nov 30, 2023 at 10:37=E2=80=AFAM Ian Rogers <irogers@goog=
le.com> wrote:
> > > > > > Sgtm. My point wasn't to criticize, I think this is a good chan=
ge, I
> > > > > > was just trying to imagine doing things in a way that could ove=
rall
> > > > > > reduce complexity
> > >
> > > > > Yep, thanks for your review.  Can I get your ACKs? :)
> > >
> > > > For the series:
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Thanks, applied to perf-tools-next.
> >
> >
> > Now trying to fix this:
> >
> >   CC      bench/numa.o
> >   CC      tests/hists_cumulate.o
> > ui/gtk/annotate.c: In function =E2=80=98symbol__gtk_annotate=E2=80=99:
> > ui/gtk/annotate.c:179:43: error: passing argument 3 of =E2=80=98symbol_=
_annotate=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-p=
ointer-types]
> >   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
> >       |                                           ^~~~~~~
> >       |                                           |
> >       |                                           struct annotation_opt=
ions *
> > In file included from ui/gtk/annotate.c:5:
> > /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:376:36: note:=
 expected =E2=80=98struct arch **=E2=80=99 but argument is of type =E2=80=
=98struct annotation_options *=E2=80=99
> >   376 |                      struct arch **parch);
> >       |                      ~~~~~~~~~~~~~~^~~~~
> > ui/gtk/annotate.c:179:15: error: too many arguments to function =E2=80=
=98symbol__annotate=E2=80=99
> >   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
> >       |               ^~~~~~~~~~~~~~~~
> > /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:374:5: note: =
declared here
> >   374 | int symbol__annotate(struct map_symbol *ms,
> >       |     ^~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> >   CC      tests/python-use.o
> >   CC      trace/beauty/sockaddr.o
> >   CC      arch/x86/util/topdown.o
> > make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build=
:105: ui/gtk/annotate.o] Error 1
> > make[6]: *** Waiting for unfinished jobs....
> >   CC      arch/x86/util/machine.o
>
> Maybe a signal to remove the gtk support :-)

+1

Thanks,
Namhyung
