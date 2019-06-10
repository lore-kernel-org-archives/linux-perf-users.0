From: =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Subject: Re: [PATCH] perf record: Add support to collect callchains from
 kernel or user space only.
Date: Mon, 10 Jun 2019 15:45:40 +0800
Message-ID: <CAHCio2ghCkRwKZ0XGTeNK90wnry-0i7arT28bsYhHx4BNZuzoA@mail.gmail.com>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
 <20190606142644.GA21245@kernel.org> <20190606144614.GC12056@krava> <20190606181504.GD21245@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190606181504.GD21245@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Wind Yu <yuzhoujian@didichuxing.com>, Adrian Hunter <adrian.hunter@intel.com>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

Hi Arnaldo,  Jirka

> perf_event_attr.exclude_callchain_kernel to 0

I don't think we should set 0 for the desired callchins,  because we
will set exclude_callchain_user to 1 if perf_evsel is function event.

void perf_evsel__config(struct perf_evsel *evsel, struct record_opts
*opts, struct callchain_param *callchain)
{
        ...
        if (perf_evsel__is_function_event(evsel))
                evsel->attr.exclude_callchain_user =3D 1;

        if (callchain && callchain->enabled && !evsel->no_aux_samples)
                perf_evsel__config_callchain(evsel, opts, callchain);
}

If we set exclude_callchain_user to 0 , it will catch user callchain
for function_event.  So, it will be best to just set the
exclude_callchain_xxx to 1.

> So that the user don't try using:

    > perf record --user-callchains --kernel-callchains

> expecting to get both user and kernel callchains and instead gets
> nothing.

I will add a note in the doc.


Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> =E4=BA=8E2019=E5=B9=B46=
=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=882:15=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Em Thu, Jun 06, 2019 at 04:46:14PM +0200, Jiri Olsa escreveu:
> > On Thu, Jun 06, 2019 at 11:26:44AM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > So that the user don't try using:
>
> > >     pref record --user-callchains --kernel-callchains
>
> > > expecting to get both user and kernel callchains and instead gets
> > > nothing.
>
> > good catch.. we should add the logic to keep both (default)
> > in this case.. so do nothing ;-)
>
> Yeah, not using both or using both should amount to the same behaviour.
>
> Can be done with a patch on top of what I have in my tree now.
>
> - Arnaldo
