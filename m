Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2u4G/Ni"
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3882D5B
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 12:26:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50aba9b8955so13167e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 12:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701116802; x=1701721602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNtbW7bb1joRBd02cZwF5zPKpcLSt2ynX6nmeWUG++o=;
        b=v2u4G/NikjoCRNKLXT7gRsYoU/kJ2LI4RxhcCkFKP6AyoYIIZHUueQToNBIinzlOmP
         lN3xbMLJRPjngBLVSAbLZrnc0S1GmL/PPxfl/7J5QVNSK4S1xd6IcYGscb5/Br/VWeC8
         encknEOx/j4fcHsxKJmiNX5D1gZA6gg/ZpAw3D7T3kMzB+0GhcAYO1+UtJ30aRV/MFWx
         iVBClxyZ3DhH2IG6y7b61MUBgRs4MGevC9eEiQcoWzwbeoIrdQsrBOKFmz4UGkVwFea4
         1D5hSBzZTBZpA4BeDu5GVaHVmqRCJPPGxuj9/yo8hoIxi/TNXfMw1PsJirm/pPvGpe66
         8tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116802; x=1701721602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNtbW7bb1joRBd02cZwF5zPKpcLSt2ynX6nmeWUG++o=;
        b=DXAMo1wTKvR1Lwzwt7F9uygPiRbaG996u30UWJ1WFYBuMm7KXrd0yA571wCvz93kbQ
         kfDjCEz0OEqW8SrSgTB4D+KFvCVn1k0Bv7m+r4A0cvM5ox4WRrZK+eAhouKji+t8uszX
         6CJlIFjtGdQ3/7rSJODrOT17vzU58ZBVpKMIW/C7GACHBFQETkPvnOipXB+XZ2pjU9lW
         zdMSqNMHss7SphVgNLqyLoq6di8QeISUinQ2UlrdY0wUJykjGp00NKI5scpxTLY/9eNb
         AXv3ndtIu6ma0iRhxkP/U5S/Ooy5zrQJddO7hXBP2Nqh1PvUg2bHUnilRAY4aEgVfPsu
         n7Ww==
X-Gm-Message-State: AOJu0Yw0ExLmHoHX6aJd0vmuwj91tj/DGWrpkPrLfppLT44hhGhnqBS2
	D0ZX56B9y5TiE7OsZr/tSvhRjLInY0mBV4vJB3Mc2g==
X-Google-Smtp-Source: AGHT+IE0vJHXXs+UpDyTFUu/c9agbsDp0hdFxUpV6rm235xacPJlBYe+WQXjBEzMzPbALedPRf2rjhzf79SOYkWJSjM=
X-Received: by 2002:a05:6512:1585:b0:50a:519d:5a8a with SMTP id
 bp5-20020a056512158500b0050a519d5a8amr327946lfb.5.1701116802002; Mon, 27 Nov
 2023 12:26:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-7-irogers@google.com>
 <CAM9d7chgQBGMmyDyi98OUzyJHWaNUfw34VD=pStkX_n-t5Vpkg@mail.gmail.com>
In-Reply-To: <CAM9d7chgQBGMmyDyi98OUzyJHWaNUfw34VD=pStkX_n-t5Vpkg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 12:26:29 -0800
Message-ID: <CAP-5=fVLOghVQjHAjLrJPN9wMTAwbCY+Fx4DU-QuJBVPq6BejA@mail.gmail.com>
Subject: Re: [PATCH v4 06/53] tools api fs: Switch filename__read_str to use io.h
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 7:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > filename__read_str has its own string reading code that allocates
> > memory before reading into it. The memory allocated is sized at BUFSIZ
> > that is 8kb. Most strings are short and so most of this 8kb is
> > wasted.
> >
> > Refactor io__getline so that the newline character can be configurable
> > and ignored in the case of filename__read_str.
> >
> > Code like build_caches_for_cpu in perf's header.c will read many
> > strings and hold them in a data structure, in this case multiple
> > strings per cache level per CPU. Using io.h's io__getline avoids the
> > wasted memory as strings are temporarily read into a buffer on the
> > stack before being copied to a buffer that grows 128 bytes at a time
> > and is never sized larger than the string.
> >
> > For a 16 hyperthread system the memory consumption of "perf record
> > true" is reduced by 180kb, primarily through saving memory when
> > reading the cache information.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
>
> [SNIP]
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index a77b74c5fb65..50d33e14fb56 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -141,7 +141,7 @@ static inline int io__get_dec(struct io *io, __u64 =
*dec)
> >  }
> >
> >  /* Read up to and including the first newline following the pattern of=
 getline. */
>
> You may want to update the comment as well.
>
> > -static inline ssize_t io__getline(struct io *io, char **line_out, size=
_t *line_len_out)
> > +static inline ssize_t io__getline_nl(struct io *io, char **line_out, s=
ize_t *line_len_out, int nl)
>
> How about io__getdelim() similar to POSIX?

Thanks done for v5.

Ian

> Thanks,
> Namhyung
>
>
> >  {
> >         char buf[128];
> >         int buf_pos =3D 0;
> > @@ -151,7 +151,7 @@ static inline ssize_t io__getline(struct io *io, ch=
ar **line_out, size_t *line_l
> >
> >         /* TODO: reuse previously allocated memory. */
> >         free(*line_out);
> > -       while (ch !=3D '\n') {
> > +       while (ch !=3D nl) {
> >                 ch =3D io__get_char(io);
> >
> >                 if (ch < 0)
> > @@ -184,4 +184,9 @@ static inline ssize_t io__getline(struct io *io, ch=
ar **line_out, size_t *line_l
> >         return -ENOMEM;
> >  }
> >
> > +static inline ssize_t io__getline(struct io *io, char **line_out, size=
_t *line_len_out)
> > +{
> > +       return io__getline_nl(io, line_out, line_len_out, /*nl=3D*/'\n'=
);
> > +}
> > +
> >  #endif /* __API_IO__ */
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
