From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 15:34:51 -0300
Message-ID: <20191126183451.GC29071@kernel.org>
References: <20191126151045.GB19483@kernel.org>
 <20191126154836.GC19483@kernel.org>
 <87imn6y4n9.fsf@toke.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87imn6y4n9.fsf@toke.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke Høiland-Jørgensen escreveu:
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> 
> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Hi guys,
> >> 
> >>    While merging perf/core with mainline I found the problem below for
> >> which I'm adding this patch to my perf/core branch, that soon will go
> >> Ingo's way, etc. Please let me know if you think this should be handled
> >> some other way,
> >
> > This is still not enough, fails building in a container where all we
> > have is the tarball contents, will try to fix later.
> 
> Wouldn't the right thing to do not be to just run the script, and then
> put the generated bpf_helper_defs.h into the tarball?

I would rather continue just running tar and have the build process
in-tree or outside be the same.

- Arnaldo
