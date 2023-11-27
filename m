Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX+NmCAq"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CC93
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 12:41:45 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so247545e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 12:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701117704; x=1701722504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4K6Lj4z8jII9KHfI86VtnivPUcuSuyrPVeih1ksGS0=;
        b=SX+NmCAqfhLqt6MrlqNhoZj9BkD1J7uX25aX7M9g+L1YFeO1764xAdt0gaKHTFSaqR
         EyWOBrjebu/lIT/Njk3RaTn7vWp5G45qemiCXXgnYNWHAlrG52Du77Yuklf7TbEDn2uj
         4gXGpbq1MXk3/RnV6YtxJ45kGKWYN4o7lgbON9gTZhKoVOvCGDSqnfcUNrNKrBj4S/Wt
         npPztinlDxKpENfyy5zh0pYj4oNpUghHz1n4yIEE/NwezSFYkpJHuIufsi/CwhSpdhmd
         Xuic1ZyU7p3MV+Iz0Ds8PukfJzUK9Yt2Xk6XOzQ8O8YR6+PMEb7sHtTCHyDnwuPScP8T
         sHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701117704; x=1701722504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4K6Lj4z8jII9KHfI86VtnivPUcuSuyrPVeih1ksGS0=;
        b=wfnyY7ZrjkzLEhQDguhwLAiYTn0J09X3IrZR5U/WMIinXSgEsG5ao/GS2SYHjRGGOX
         C5fvvqGnXcSLeALFwuv5GBHtYN5lG+XOStill9q4Gu8ZBF0jPZJpqeWCvRiuVMdDkKhd
         /BxxElueLt6/9AF4dPs974V0d2/dS+yTKwWLpZ37I6JygkeUWOl/zA/X2IIDClTJ8c6Q
         hUgBLyW/zCnpFGR4bylf7+Ymg9by5FFQueS6b36Nm36T5bg1f1eRkHV+66g44b1QIoKw
         yyyphnbjgElJXeEm58XAGEQYqoUVxGykjLQwNhg8qhabjhk7KcXE4KukXxUx9c9nHgXo
         e7Kg==
X-Gm-Message-State: AOJu0Yzhu0JEDFuzJVdZDc8/vktqLPIvTMvu6J3fHpWeOlZCv3TALb+o
	Rq9cKnWDrr8/xJ+CimTP6svMRoxpX+U7yHS/GfEtjQ==
X-Google-Smtp-Source: AGHT+IHKRetPWPd1P+93r7+brysZhebjHGGesRrPYg31OtmoLNt2ABSI2w8nDut3kTN2NopSvxANGWpLRHDZi+OQTDU=
X-Received: by 2002:a05:600c:206:b0:40b:443d:9b78 with SMTP id
 6-20020a05600c020600b0040b443d9b78mr202972wmi.0.1701117703673; Mon, 27 Nov
 2023 12:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-8-irogers@google.com>
 <CAM9d7chKHASNE2BbL-6G7KJ-SwKMGXW+wujLsqiB+pFUPxJ2kA@mail.gmail.com>
In-Reply-To: <CAM9d7chKHASNE2BbL-6G7KJ-SwKMGXW+wujLsqiB+pFUPxJ2kA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 12:41:32 -0800
Message-ID: <CAP-5=fWvUOiMBeDzJboihg+vPrSEBYkAju1X-JpnwTadG1XBiQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/53] tools api fs: Avoid reading whole file for a 1
 byte bool
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

On Sun, Nov 5, 2023 at 7:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > sysfs__read_bool used the first byte from a fully read file into a
> > string. It then looked at the first byte's value. Avoid doing this and
> > just read the first byte.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/fs/fs.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> > index 496812b5f1d2..4c35a689d1fc 100644
> > --- a/tools/lib/api/fs/fs.c
> > +++ b/tools/lib/api/fs/fs.c
> > @@ -447,15 +447,16 @@ int sysfs__read_str(const char *entry, char **buf=
, size_t *sizep)
> >
> >  int sysfs__read_bool(const char *entry, bool *value)
> >  {
> > -       char *buf;
> > -       size_t size;
> > -       int ret;
> > +       struct io io;
> > +       char bf[16];
> > +       int ret =3D 0;
> >
> > -       ret =3D sysfs__read_str(entry, &buf, &size);
> > -       if (ret < 0)
> > -               return ret;
> > +       io.fd =3D open(entry, O_RDONLY);
>
> The entry is a name in sysfs, so you need to get the full name.
>
> Thanks,
> Namhyung

Thanks, added in v5.

Ian

>
> > +       if (io.fd < 0)
> > +               return -errno;
> >
> > -       switch (buf[0]) {
> > +       io__init(&io, io.fd, bf, sizeof(bf));
> > +       switch (io__get_char(&io)) {
> >         case '1':
> >         case 'y':
> >         case 'Y':
> > @@ -469,8 +470,7 @@ int sysfs__read_bool(const char *entry, bool *value=
)
> >         default:
> >                 ret =3D -1;
> >         }
> > -
> > -       free(buf);
> > +       close(io.fd);
> >
> >         return ret;
> >  }
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
