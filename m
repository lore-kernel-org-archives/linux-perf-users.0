Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ztgx1Am/"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854FAB
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 15:52:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so609e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702338751; x=1702943551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmlX5QGQE6gjvCh0QJ4AiLgcXStLjnVB79eHCrcfOEw=;
        b=Ztgx1Am/uCKmUJaHxZC3h1WW0RBFy3ogyj3hPJAr/aloFookgoKj4UrlyQMgc45B4s
         4F6ohAwg2LWGiUfBiM3lOl5FHTTj+axQQ8bcd2rmNxF4PGjSi/tsMtev48JX+Hw+g7mt
         /LCQ2+I2eCN05lGmDm+p4e9qbb8vCbOorxBr11/NRFIJ4zK1T49OMejokiDtiN+b6ise
         zUv7cEhwmFuciof79KBcz0KSXwNCnIShK3ZwtHBYpsrvi37r0EAwieQS86yo/zdGkEV4
         8y2dybrs7fCKCd5CyKFqOvAnBnDYfur4iRsg0hJ87tzA9KFaPjP+sj5sW+G34L+ga84c
         fNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702338751; x=1702943551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmlX5QGQE6gjvCh0QJ4AiLgcXStLjnVB79eHCrcfOEw=;
        b=Afw6eMTnaP0GQxvMev1D2rWEyrH5Q9RRxaquieJZOKsDfcPud+qsjg2mNVf2LeW0wP
         d9K3pphH7dAKh55OskYy6EYvTTdsXN7p7MsTXnxRBc1L1mr7IkhX6GJN5hRie+DXZuDS
         wzmyX0LGl51Br7XEfs1yHclF2XnBQNTWjmhhcS6iVuEYymfWrbMkEhKVEyF5b9BBw6zU
         /Ake4VIHjWTp7XYjzcSsyhOrH8DXAvMM0yq2M4Y968D6RI1xjRGh71ypAGl/Jn2zydyK
         3fENrPVjmXh4MI84QNnDF6MFoqs84g/EnjpQ2EWj4u98din6NGPoNXMVN6UJcnPEzUgo
         8iog==
X-Gm-Message-State: AOJu0Yzla7vWJOauCqvLn1TjpRTsAo3Wh/PpQgJ6ZxIEfkaJNrEiTDIv
	7hlmiXEzU10BO2N0h1Pt68Vr5Kgg7airHnp6QYVNkA==
X-Google-Smtp-Source: AGHT+IHL1LCCA0vO4jcgkFLc8WzWZILhVFZ8tBqxEvhIWFoKgTOXweEC41rWWoVJqVsAGXs4+alaLWQDy2EHlz0AU04=
X-Received: by 2002:a19:4f07:0:b0:50b:fcb7:15af with SMTP id
 d7-20020a194f07000000b0050bfcb715afmr168488lfb.3.1702338751256; Mon, 11 Dec
 2023 15:52:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207011722.1220634-1-irogers@google.com> <20231207011722.1220634-2-irogers@google.com>
 <CAM9d7cjUVCWpiy0ZsdaWQ5RtrULJSQsggZwz1wJNfeb1kXBwtw@mail.gmail.com> <CAM9d7cjjSC+_SEvc3ji4tYWqP6_Ay5VTJRVzK9mxhZhx6awyGQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjjSC+_SEvc3ji4tYWqP6_Ay5VTJRVzK9mxhZhx6awyGQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Dec 2023 15:52:19 -0800
Message-ID: <CAP-5=fX_vRHM+um7A1D+gOfnMJagzhJfQX5C3jEBj0aMCKQjjA@mail.gmail.com>
Subject: Re: [PATCH v6 01/47] perf map: Improve map/unmap parameter names
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

On Mon, Dec 11, 2023 at 3:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Dec 11, 2023 at 3:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Dec 6, 2023 at 5:17=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > The u64 values are either absolute or relative, try to hint better in
> > > the parameter names.
> > >
> > > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/map.h | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > > index 3a3b7757da5f..49756716cb13 100644
> > > --- a/tools/perf/util/map.h
> > > +++ b/tools/perf/util/map.h
> > > @@ -105,25 +105,25 @@ static inline u64 map__dso_map_ip(const struct =
map *map, u64 ip)
> > >  }
> > >
> > >  /* dso rip -> ip */
> > > -static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> > > +static inline u64 map__dso_unmap_ip(const struct map *map, u64 rip)
> > >  {
> > > -       return ip + map__start(map) - map__pgoff(map);
> > > +       return rip + map__start(map) - map__pgoff(map);
> > >  }
> > >
> > > -static inline u64 map__map_ip(const struct map *map, u64 ip)
> > > +static inline u64 map__map_ip(const struct map *map, u64 ip_or_rip)
> >
> > I'm afraid it's gonna be more confusing.  Can we say just 'rip'?
>
> Oh.. I think it should be 'ip'.

But sometimes it is an ip and sometimes it is an rip, hence the long
name. I don't think this really affects much so I'd prefer to stick
with the intention revealing name if possible.

Thanks,
Ian

> >
> > >  {
> > >         if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__D=
SO)
> > > -               return map__dso_map_ip(map, ip);
> > > +               return map__dso_map_ip(map, ip_or_rip);
> > >         else
> > > -               return ip;
> > > +               return ip_or_rip;
> > >  }
> > >
> > > -static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> > > +static inline u64 map__unmap_ip(const struct map *map, u64 ip_or_rip=
)
> >
> > Ditto.
> >
> > Thanks,
> > Namhyung
> >
> >
> > >  {
> > >         if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__D=
SO)
> > > -               return map__dso_unmap_ip(map, ip);
> > > +               return map__dso_unmap_ip(map, ip_or_rip);
> > >         else
> > > -               return ip;
> > > +               return ip_or_rip;
> > >  }
> > >
> > >  /* rip/ip <-> addr suitable for passing to `objdump --start-address=
=3D` */
> > > --
> > > 2.43.0.rc2.451.g8631bc7472-goog
> > >
