From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] libbpf: Use PRIu64 for sym->st_value to fix build on
 32-bit arches
Date: Wed, 27 Nov 2019 16:39:25 -0300
Message-ID: <20191127193925.GC4063@kernel.org>
References: <20191126221018.GA22719@kernel.org>
 <20191126221733.GB22719@kernel.org>
 <CAEf4BzbZLiJnUb+BdUMEwcgcKCjJBWx1895p8qS8rK2r5TYu3w@mail.gmail.com>
 <20191126231030.GE3145429@mini-arch.hsd1.ca.comcast.net>
 <20191126155228.0e6ed54c@cakuba.netronome.com>
 <20191127013901.GE29071@kernel.org>
 <20191127134553.GC22719@kernel.org>
 <CAADnVQKkEqhdTOxytVbcm1QnBcf4MQ+q4KYaHzsuqkq3r=X-VA@mail.gmail.com>
 <20191127184526.GB4063@kernel.org>
 <CAADnVQLs-=f8E8ahiW7F+_Qb1JiR4-7tXwVNbdyH1FF04RrOHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAADnVQLs-=f8E8ahiW7F+_Qb1JiR4-7tXwVNbdyH1FF04RrOHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jakub Kicinski <jakub.kicinski@netronome.com>, Stanislav Fomichev <sdf@fomichev.me>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Quentin Monnet <quentin.monnet@netronome.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Nov 27, 2019 at 10:55:31AM -0800, Alexei Starovoitov escreveu:
> On Wed, Nov 27, 2019 at 10:45 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 27, 2019 at 08:39:28AM -0800, Alexei Starovoitov escreveu:
> > > On Wed, Nov 27, 2019 at 5:45 AM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > Another fix I'm carrying in my perf/core branch,
> >
> > > Why in perf/core?
> > > I very much prefer all libbpf patches to go via normal route via bpf/net trees.
> > > We had enough conflicts in this merge window. Let's avoid them.
> >
> > Humm, if we both carry the same patch the merge process can do its magic
> > and nobody gets hurt? Besides these are really minor things, no?
> 
> I thought so too, but learned the hard lesson recently.
> We should try to avoid that as much as possible.
> Andrii's is fixing stuff in the same lines:
> https://patchwork.ozlabs.org/patch/1201344/
> these two patches will likely conflict. I'd rather have them both in bpf tree.
> What is the value for this patch in perf tree?
> To fix the build on 32-bit arches, right?
> But how urgent is it? Can you wait few days until this one and other
> libbpf fixes
> land via bpf/net trees?

Ok, I'll add a note to the pull request report about where the perf
build is clean in all containers because I added these two patches, but
that they'll go via the bpf tree, as soon as that gets merged, the
problem will go away.

And I wasn't strictly defending that I should carry this in perf/core,
just said I was, to fix something minor that I found while doing my
usual testing, patch was posted, you got notified and got the patch,
I'll remove it from perf/core now since you stated that it'll eventually
land upstream.

Thanks,

- Arnaldo
