Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUFzuW2j"
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5631FDB
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 09:59:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50beed2a46eso173e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Dec 2023 09:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701799154; x=1702403954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gc6EPrb7sJMi5FLo8PEKP3q9XU/ASOLnpitI/EDUi8=;
        b=mUFzuW2j4i5cHGKoIsxLhbYUhdPktzcy0ai1owCSBP+8qPTrxPivhBwn4bmdUquMYm
         aidNDWfKUBMPlg1hX8NmQpjjiZLRlPP1OXLbFOGDr7C/Ceg3uLDuZ1EsIC6alU4LHCM8
         IVx9Hsk1VNuLByjJfbxBc/JmYqLqe45IQA2UqhsWezV6fNJcZEboRSLmkqLU+tSyf9uO
         Mhv6V/2LNhvW6zuA7/0I2tm6ZfUr0AETm4q7vspZJIaklTjk0htDJZgQibcZ9czCbWbu
         CWOGzBUd0lDl4HFmeZgc5DnHuIaRvteohM6UT9tKDEjswT8fYyvg7IW7q0e6+MNU8tDW
         XO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799154; x=1702403954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gc6EPrb7sJMi5FLo8PEKP3q9XU/ASOLnpitI/EDUi8=;
        b=n6r1ycNd/5xSt8aPYiV6W0XmfXTQKyKbMzuCGHXlh9P8haAWwTZwjbxh2EQJfXI+09
         iMtPe3SFLzrLO/mm89rddWc5q0zS1QXkU71Gu7Xxxd6ML4nyVMwEVjAHxjDp50DFmwy5
         5tA47dw7uBzI6WFk9YkyCjQDUGLdqJmhIdXL3fOM2A0nJYEbEepfDPdBXGbtVwdt5bOH
         TXtM3uUW3xJvjz9eymxPFekg/rANIAVe6VMbe+/myhv7tRND/+yz+5Lv479DPASz8G49
         QNFMnAx55iJVBxJC5lyjB9fV/rInpSpQgxHARfDaK4sPMb74OyypCzk2Vwnliv/Yn5Un
         KeZw==
X-Gm-Message-State: AOJu0Yz1mr1lk5HoRGWotaUBz+yz9w5gWnlN6oBZBoVweBxbtvnMa564
	jG4h29W8L4vMGWQltb27o6Tb8RW0TLAHDbgP+mnwQg==
X-Google-Smtp-Source: AGHT+IEreAhwBUj3VoXijNV76YGN0BLzvw/1/zLgkxdshVRnOF58QsEUVJChSnIlSNqThA+x+IZWBAr9X6ybdnnCvE4=
X-Received: by 2002:a19:7418:0:b0:50b:fa8d:f28b with SMTP id
 v24-20020a197418000000b0050bfa8df28bmr149957lfe.1.1701799153760; Tue, 05 Dec
 2023 09:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com> <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
In-Reply-To: <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Dec 2023 09:59:02 -0800
Message-ID: <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 2:46=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 30, 2023 at 10:37=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > On Wed, Nov 29, 2023 at 3:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Tue, Nov 28, 2023 at 11:14=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > On Tue, Nov 28, 2023 at 9:54=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > It used to have annotation_options for each command separately (f=
or
> > > > > example, perf report, annotate, and top), but we can make it glob=
al as
> > > > > they never used together (with different settings).  This would s=
ave
> > > > > some memory for each symbol when annotation is enabled.
> > > > >
> > > > > This code is available at 'perf/annotate-option-v1' branch in
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-pe=
rf.git
> > > > >
> > > > > Thanks,
> > > > > Namhyung
> > > >
> > > > Thanks for doing this and I think it is progress. I think there is =
a
> > > > common problem with having things be an option rather than say part=
 of
> > > > session. Having a global variable seems unfortunate but I'm not sur=
e
> > > > if in all locations we have easy access to the session.
> > >
> > > That's not the case when you deal with hist entry or TUI browser.
> > > I think that's the reason we have the option in the annotation.
> > >
> > >
> > > > The rough
> > > > structure with annotations as I understand it is:
> > > >
> > > > session has machines
> > > > a machine has dsos
> > > > a dso has symbols
> > > > a symbol has an annotation
> > >
> > > That's true.  But the annotation struct is used only if
> > > symbol__annotation_init() is called.
> >
> > Right. I find this approach likely to lead to errors, such as a symbol
> > created globally before symbol__annotation_init() was called breaking
> > the container_of assumptions.
>
> Sure, but that's a different issue.  Maybe we can add a hash table
> to map a symbol to annotation or annotated_source directly.  But
> I don't think we need annotation_option for each symbol/annotation.

Agreed.

> >
> > > >
> > > > Annotation is something of unfortunate abstraction as it covers thi=
ngs
> > > > like an IPC per symbol (why hard code to just IPC?) and things like
> > > > source files and line numbers.
> > >
> > > Right, that's why I splitted the struct annotated_branch.
> > >
> > > >
> > > > A recent success story where we got rid of a configuration variable
> > > > was by switching to lazy allocation with sorting by name for symbol=
s
> > > > within a dso. If we could have a lazy allocation model with
> > > > annotations then maybe we can do away with large hammers like globa=
l
> > > > options.
> > >
> > > Maybe I can move the pointer to option into the annotated_source
> > > which is allocated lazily.  But I don't think it needs to keep the op=
tion
> > > for each symbol or annotation.  It's usually to control some display
> > > behaviors in the disasm output globally.  So I think it's better to h=
ave
> > > a global variable.
> >
> > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > was just trying to imagine doing things in a way that could overall
> > reduce complexity
>
> Yep, thanks for your review.  Can I get your ACKs? :)

For the series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Namhyung
