Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E99EAE7
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Nov 2023 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HavltlP+"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C80CC
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Nov 2023 13:35:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so9119a12.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Nov 2023 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699220154; x=1699824954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGeltO/gzLsqyEX0SrHGG26aXCsJybxah3Ci9XWI5Ng=;
        b=HavltlP+54SpgEywcwPZwidLHCpxRUk159YMAvMYoD44B33KDht8aIUFXdIjPL8eLx
         r4ivEPxvi7HrR42Oe1bUcYV9Jz9k36mzJI4kgRHsfG/tg52WA2ZYPNTPOlo/b1Vvs3qT
         e//lc88xj2n/bWHYtHha3hdUm9nTq0reYgbzAIC67wzXL5gD2DjR0XnfhIJ/2Pva4ByT
         qox8msuG+2wCk9EGi81tjCN61auCW3mmUhf19nMUfkLq6pbpsK1Sgzw9Lpjl1urfs97u
         RGjvqRIAtlMLKK1CH2c8zrBEWqKlygaeKyLqMnYPQ3yRpY6gKAOsPsGlFU9aDK4D3gcY
         fISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699220154; x=1699824954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGeltO/gzLsqyEX0SrHGG26aXCsJybxah3Ci9XWI5Ng=;
        b=ujdN0xSslduItusxI3geCHmB/7UT0Fi4G4olkBx9ddlDO0NXyvs7xlWKyZF6brDNBi
         Un2BFxUcO1qXI2y44YK2q66CoNMJzMgnKHVDQi12Vcr/WEduRm4TTG8Mnj6bPZ50tdeo
         eBlD570h7lKResCKw91e1cN6UZ9Ydjbajn0WaEZBFAeWc77R0WC8wAwpbdcbIRh+XGac
         Gu1RizK0pnoOEEznGQZzjTZxcsZe0Ujx0SCmsjjvYthaErPO9iw9wkZuf4HEtizgPsRT
         JV/xZ001Od4RiDJg8citTftE+C6YYw9U0wuIl+bf9n0lGshgY+UdEGjcdfjTkShVn4np
         8JAg==
X-Gm-Message-State: AOJu0Yxu562gJ1PPfxuQ7XkY1rG0inqxLvUkSFdCmFPmI4qUxDWImFpo
	PvhPOm/pfwHh9lJRxv/LiuA4VIDtwfNg/p0XF+gUFg==
X-Google-Smtp-Source: AGHT+IG/7gx55TgXKRl1alJpMlzyJHWNME5/yKDyws/fLbk/LshME2U8mbHgZocMf3511MtNYEG7MYVhRhMUlN7VfO8=
X-Received: by 2002:a50:ccd5:0:b0:543:fb17:1a8 with SMTP id
 b21-20020a50ccd5000000b00543fb1701a8mr68243edj.3.1699220154063; Sun, 05 Nov
 2023 13:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
In-Reply-To: <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 5 Nov 2023 13:35:42 -0800
Message-ID: <CAP-5=fXgy95LsYLbbWN85prBs43jvGehOcwYFK-ZK2cOqCyPJA@mail.gmail.com>
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
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

On Sun, Nov 5, 2023 at 9:32=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The rwsem is only after used for writing so switch to a mutex that has
> > better error checking.
>
> Hmm.. ok.  It doesn't make sense to use rwsem without readers.
>
> >
> > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
>
> But I'm not sure this is a fix.  Other than that,

Thanks Namhyung, it fixes the case that you enable RWS_ERRORCHECK in
rwsem.h as the rwsem static initialization is wrong for a mutex.

Ian

> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
> > ---
> >  tools/perf/util/comm.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> > index afb8d4fd2644..4ae7bc2aa9a6 100644
> > --- a/tools/perf/util/comm.c
> > +++ b/tools/perf/util/comm.c
> > @@ -17,7 +17,7 @@ struct comm_str {
> >
> >  /* Should perhaps be moved to struct machine */
> >  static struct rb_root comm_str_root;
> > -static struct rw_semaphore comm_str_lock =3D {.lock =3D PTHREAD_RWLOCK=
_INITIALIZER,};
> > +static struct mutex comm_str_lock =3D {.lock =3D PTHREAD_ERRORCHECK_MU=
TEX_INITIALIZER_NP,};
> >
> >  static struct comm_str *comm_str__get(struct comm_str *cs)
> >  {
> > @@ -30,9 +30,9 @@ static struct comm_str *comm_str__get(struct comm_str=
 *cs)
> >  static void comm_str__put(struct comm_str *cs)
> >  {
> >         if (cs && refcount_dec_and_test(&cs->refcnt)) {
> > -               down_write(&comm_str_lock);
> > +               mutex_lock(&comm_str_lock);
> >                 rb_erase(&cs->rb_node, &comm_str_root);
> > -               up_write(&comm_str_lock);
> > +               mutex_unlock(&comm_str_lock);
> >                 zfree(&cs->str);
> >                 free(cs);
> >         }
> > @@ -98,9 +98,9 @@ static struct comm_str *comm_str__findnew(const char =
*str, struct rb_root *root)
> >  {
> >         struct comm_str *cs;
> >
> > -       down_write(&comm_str_lock);
> > +       mutex_lock(&comm_str_lock);
> >         cs =3D __comm_str__findnew(str, root);
> > -       up_write(&comm_str_lock);
> > +       mutex_unlock(&comm_str_lock);
> >
> >         return cs;
> >  }
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
