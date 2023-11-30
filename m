Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmwuZucq"
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7ED7F
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:28:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso13595e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 10:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701368888; x=1701973688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQnDDplBo/xl6TSnDTzhQLPLA7PVAh8kIH3hmpt4VIo=;
        b=KmwuZucqW16iZcPXuZ9CKNpoJ7tTag643kqrHwLMuQbBh6GvfT/Do1AycmiQ/HMhWY
         DmSBNC9EVe7S4An/XcSR1HYsld1t0p2N2XvhE1y9gAy7E8AUdKwTUvuo4D5GiV+8LbIa
         BUgq374jE6Oaaw7JHPz7XNPIB0aLe5HbdWCXUHuFfA4o8ajeu/a2/ncL60ju06ejIdrf
         EScd+gKMz9YnlBSCxX4D8mDssafAjS+cYdnqSNXP7p80UvO6MkiycuX3L7Xlb+w6RVHD
         a/gwzIxLBh5yNO5ZDg8NcnH/dTwGiAw+rvelIgOSmtNg1BaPhxo7++GZZZNy8bNMluS3
         dtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368888; x=1701973688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQnDDplBo/xl6TSnDTzhQLPLA7PVAh8kIH3hmpt4VIo=;
        b=kq1cZ55Qi6GKx3taQxLSavcVLwX+gfrpBY7J4XEwIOkye5aLcqMpQ8SLMkFDq3Ru/4
         881Dq4hlf504WtRcAiNz9NcLkDUXk1huQuv8fMZU+6E4WJcnUav/Fqqxmlg1mwxgQHVE
         ZooIk34oHGK7FKkMKGwnAKzujiJ6FlKwJJ6EiAaydKHhcVYQLouNVFX5WvzZMTbyp692
         VQtMzsXTju7/txx0yvfO1BkirkyKM8ToIzcLi4z1HFMrwQfO0VHZzi/GGSnLHvUUD4z2
         qhU2vMbbvHw+3qrbwHTbuKOMmWUr/knH37Ss8nShWULxEiSWMHd0lRyplOPisCZ3R0x6
         z2Eg==
X-Gm-Message-State: AOJu0YzdnZuXMUyBQDTaUqoMR8/C4c3QDmKZKrZ/hLeNWqTxEHamcXSk
	CWaH2Lbks9xkedNMB9jFp6MurDYSqIa7I9fvtNqdLg==
X-Google-Smtp-Source: AGHT+IH0qly/6N+PSKn52LeY7Db2raJh+S9M05YJg7N3XXfn1ABYr8yEwAJWvPy/CS8/VZRIHxvhhPQpFR/o8ze+5CA=
X-Received: by 2002:a05:600c:a686:b0:40b:4355:a04b with SMTP id
 ip6-20020a05600ca68600b0040b4355a04bmr214963wmb.6.1701368888211; Thu, 30 Nov
 2023 10:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-2-irogers@google.com>
 <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
In-Reply-To: <CAM9d7cjCO8e7nbrtrcy4rsbexemQ94=XK+b5byMFFTDDgoJ2eg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Nov 2023 10:27:56 -0800
Message-ID: <CAP-5=fUBr60o22P4Op-J=TPkdfnby9vLetHQZ4UqjuX+nvbG9w@mail.gmail.com>
Subject: Re: [PATCH v5 01/50] perf comm: Use regular mutex
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 4:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > The rwsem is only after used for writing so switch to a mutex that has
> > better error checking.
> >
> > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex")
>
> I think we talked about fixing this separately, no?

Sorry, I'm unclear on an action to do. Currently changing the
RWS_ERRORCHECK in tools/perf/util/rwsem.h will break the build without
this change.

> > Signed-off-by: Ian Rogers <irogers@google.com>
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
>
> IIUC it has a problem with musl libc.  Actually I think it's better to
> hide the field and the pthread initializer under some macro like
> MUTEX_INITIALIZER or DEFINE_MUTEX() like in the kernel.

Will there be enough use to justify this? I think ideally we'd not be
having global locks needing global initializers as we run into
problems like we see in metrics needing to mix counting and sampling.

Thanks,
Ian

> Thanks,
> Namhyung
>
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
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
