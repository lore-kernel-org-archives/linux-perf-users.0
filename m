From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Wed, 27 Nov 2019 17:20:17 -0800
Message-ID: <CAADnVQLFVH000BJM4cN29kcC+KKDmVek3jaen3cZz2=12jP58g@mail.gmail.com>
References: <87imn6y4n9.fsf@toke.dk> <20191126183451.GC29071@kernel.org>
 <87d0dexyij.fsf@toke.dk> <20191126190450.GD29071@kernel.org>
 <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org> <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net> <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org> <CAADnVQJCMpke49NNzy33EKdwpW+SY1orTm+0f0b-JuW8+uA7Yw@mail.gmail.com>
 <2993CDB0-8D4D-4A0C-9DB2-8FDD1A0538AB@kernel.org> <CAADnVQJc2cBU2jWmtbe5mNjWsE67DvunhubqJWWG_gaQc3p=Aw@mail.gmail.com>
 <58CA150B-D006-48DF-A279-077BA2FFD6EC@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <58CA150B-D006-48DF-A279-077BA2FFD6EC@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Nov 27, 2019 at 5:17 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> On November 27, 2019 9:59:15 PM GMT-03:00, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >On Wed, Nov 27, 2019 at 4:50 PM Arnaldo Carvalho de Melo
> ><arnaldo.melo@gmail.com> wrote:
> >>
> >> Take it as one, I think it's what should have been in the cset it is
> >fixing, that way no breakage would have happened.
> >
> >Ok. I trimmed commit log and applied here:
> >https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=1fd450f99272791df8ea8e1b0f5657678e118e90
> >
> >What about your other fix and my suggestion there?
> >(__u64) cast instead of PRI ?
> >We do this already in two places:
> >libbpf.c:                shdr_idx, (__u64)sym->st_value);
> >libbpf.c:             (__u64)sym.st_value, GELF_ST_TYPE(sym.st_info),
>
>
> I'm using the smartphone now, but I thought you first suggested using a cast to long, if you mean using %llu + cast to __u64, then should be was ugly as using PRI, IOW, should work on both 64 bit and 32 bit. :-)

Yes. I suggested (long) first, but then found two cases in libbpf that
solve this with (__u64),
so better to stick to that for consistency.
