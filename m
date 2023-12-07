Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSHFfBI5"
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5F170F
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 12:14:36 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54f4a933ddcso211a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701980075; x=1702584875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O59CADGEUW6I15GmJQjsmBYRut0M70PjtjxoPXjvnZo=;
        b=RSHFfBI5cnyPBAa/SOFWl4kamY+bc+MhBa6SZT5PD+BtArkyu8GzGQfm0TsFkhQrgg
         xo1TpZC0ehPnIuR4wHjzVmuj8IaMXOgGvpTR/Hmqyeum5ZB0gCrXtFL/bFn6/bBB84VF
         Kd7C/oK08blnT7GB+/hooPA5XLlaKe6vwGjxAYpNd8YR+caYXYevmO27/9BOvpQglLQG
         1Vb1TImUlmCKiVKnt510ZvjY9iPIZmAMq3+UkOYg1Ag+/YjAMnpl/9TnH84XnYJrJdxz
         4zVZmte6QjiKgDqCUF1FIgTMSLGiMHuwhtI5MvbySHSe8NXDcvZoeSWu7wrNUsdKBDZS
         JjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701980075; x=1702584875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O59CADGEUW6I15GmJQjsmBYRut0M70PjtjxoPXjvnZo=;
        b=H/wjQaXTCyzlgXIPKRzm9vJy+f6WvTFgI+j+cXZ2Q7TUbFo2idWOrF3FE06/U6dIf7
         fs2O6fLDP2sajHPM1CvOdxrY/cuCXUAqPPfw3FURb271yLplhkC/IqpkX8fCNi9yoPp+
         7uFcdBDufA+HeAyI/53ITAYhmNOmoPjVCehRP5Q/sWA/vZzi8CC6ULUczAtVdcX5MO2u
         Ww0nlewHu2akbiecdOcN1eBePflHSMHARzAoE3MOAqdVaOolFlrGnNmBCNlZdzyfd39d
         fhL9ApEARi3J0xDpuMrV/zajMxhImDjTBcIR2dlnO3QueiEZqLyOtUgQXI795ZPXS9y0
         XZ5Q==
X-Gm-Message-State: AOJu0YxITJS9eQceDonRhw2K2fG0Kbf5+HMzjdMZbRnaiXmX716g6x7R
	s93khofZP4B7URCr8CSVO/qWSXVlcgdN6xp0ghsRng==
X-Google-Smtp-Source: AGHT+IHKHtr5xE3RkGK0fJwUK612HPcHHmi9TzXyZbEI0xzrbY30jcQXq3kwA1TkT9ayLJiDTy7rskFOTZTnNxoE6f4=
X-Received: by 2002:a50:ccc6:0:b0:54a:ee8b:7a99 with SMTP id
 b6-20020a50ccc6000000b0054aee8b7a99mr17972edj.0.1701980074584; Thu, 07 Dec
 2023 12:14:34 -0800 (PST)
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
 <ZXIiBp-rvdvSI-ZY@kernel.org> <ZXIicbe9K5KYGSV4@kernel.org>
In-Reply-To: <ZXIicbe9K5KYGSV4@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Dec 2023 12:14:23 -0800
Message-ID: <CAP-5=fWN5Jwsf5dxqw0BJxpdu89FM54A-AtQpEqxeE7XLDx3mA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 11:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Dec 07, 2023 at 04:50:30PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> > > On Mon, Dec 4, 2023 at 2:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > > On Thu, Nov 30, 2023 at 10:37=E2=80=AFAM Ian Rogers <irogers@google=
.com> wrote:
> > > > > Sgtm. My point wasn't to criticize, I think this is a good change=
, I
> > > > > was just trying to imagine doing things in a way that could overa=
ll
> > > > > reduce complexity
> >
> > > > Yep, thanks for your review.  Can I get your ACKs? :)
> >
> > > For the series:
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Thanks, applied to perf-tools-next.
>
>
> Now trying to fix this:
>
>   CC      bench/numa.o
>   CC      tests/hists_cumulate.o
> ui/gtk/annotate.c: In function =E2=80=98symbol__gtk_annotate=E2=80=99:
> ui/gtk/annotate.c:179:43: error: passing argument 3 of =E2=80=98symbol__a=
nnotate=E2=80=99 from incompatible pointer type [-Werror=3Dincompatible-poi=
nter-types]
>   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
>       |                                           ^~~~~~~
>       |                                           |
>       |                                           struct annotation_optio=
ns *
> In file included from ui/gtk/annotate.c:5:
> /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:376:36: note: e=
xpected =E2=80=98struct arch **=E2=80=99 but argument is of type =E2=80=98s=
truct annotation_options *=E2=80=99
>   376 |                      struct arch **parch);
>       |                      ~~~~~~~~~~~~~~^~~~~
> ui/gtk/annotate.c:179:15: error: too many arguments to function =E2=80=98=
symbol__annotate=E2=80=99
>   179 |         err =3D symbol__annotate(ms, evsel, options, NULL);
>       |               ^~~~~~~~~~~~~~~~
> /home/acme/git/perf-tools-next/tools/perf/util/annotate.h:374:5: note: de=
clared here
>   374 | int symbol__annotate(struct map_symbol *ms,
>       |     ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>   CC      tests/python-use.o
>   CC      trace/beauty/sockaddr.o
>   CC      arch/x86/util/topdown.o
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:1=
05: ui/gtk/annotate.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   CC      arch/x86/util/machine.o

Maybe a signal to remove the gtk support :-)

Ian
