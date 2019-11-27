From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 22:39:01 -0300
Message-ID: <20191127013901.GE29071@kernel.org>
References: <87imn6y4n9.fsf@toke.dk>
 <20191126183451.GC29071@kernel.org>
 <87d0dexyij.fsf@toke.dk>
 <20191126190450.GD29071@kernel.org>
 <CAEf4Bzbq3J9g7cP=KMqR=bMFcs=qPiNZwnkvCKz3-SAp_m0GzA@mail.gmail.com>
 <20191126221018.GA22719@kernel.org>
 <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net>
 <20191126155228.0e6ed54c@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191126155228.0e6ed54c@cakuba.netronome.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Nov 26, 2019 at 03:52:28PM -0800, Jakub Kicinski escreveu:
> On Tue, 26 Nov 2019 15:10:30 -0800, Stanislav Fomichev wrote:
> > We are using this script with python2.7, works just fine :-)
> > So maybe doing s/python3/python/ is the way to go, whatever
> > default python is installed, it should work with that.

> That increases the risk someone will make a python2-only change 
> and break Python 3.
 
> Python 2 is dead, I'm honestly surprised this needs to be said :)

It shouldn't have to be said, and probably it is old school to try and
keep things portable when there is no need to use new stuff for simple
tasks like this.

Anyway, it seems its just a matter of adding the python3 package to the
old container images and then most of them will work with what is in
that script, what doesn't work is really old and then NO_LIBBPF=1 is the
way to go.

In the end, kinda nothing to see here, go back to adding cool new stuff,
lets not hold eBPF from progressing ;-P

- Arnaldo
