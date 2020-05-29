From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/2] perf build: Allow explicitely disabling the
 NO_SYSCALL_TABLE variable
Date: Fri, 29 May 2020 22:33:20 +0200
Message-ID: <20200529203320.GG506785@krava>
References: <20200529155552.463-1-acme@kernel.org>
 <20200529155552.463-3-acme@kernel.org>
 <20200529180717.GF506785@krava>
 <20200529194515.GB31795@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200529194515.GB31795@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 29, 2020 at 04:45:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 29, 2020 at 08:07:17PM +0200, Jiri Olsa escreveu:
> > On Fri, May 29, 2020 at 12:55:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > This is useful to see if, on x86, the legacy libaudit still works, as it
> > > is used in architectures that don't have the SYSCALL_TABLE logic and we
> > > want to have it tested in 'make -C tools/perf/ build-test'.
> > > 
> > > E.g.:
> > > 
> > > Without having audit-libs-devel installed:
> > > 
> > >   $ make NO_SYSCALL_TABLE=1 O=/tmp/build/perf -C tools/perf install-bin
> > >   make: Entering directory '/home/acme/git/perf/tools/perf'
> > >     BUILD:   Doing 'make -j12' parallel build
> > >   <SNIP>
> > >   Auto-detecting system features:
> > >   <SNIP>
> > >   ...                      libaudit: [ OFF ]
> > >   ...                        libbfd: [ on  ]
> > >   ...                        libcap: [ on  ]
> > >   <SNIP>
> > >   Makefile.config:664: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
> > >   <SNIP>
> > > 
> > > After installing it:
> > > 
> > >   $ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf
> > >   $ time make NO_SYSCALL_TABLE=1 O=/tmp/build/perf  -C tools/perf install-bin ; perf test python
> > 
> > heya,
> > seems ok, perhaps also put it in comment to Makefile.perf
> > among other NO_* stuff and to tests/make
> 
> 
> Added this and your Acked-by (from the "seems ok") :-) Ok?

yep ;-)

jirka

> 
> - Arnaldo
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 30e41dcd4095..e3a34af38130 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -118,6 +118,9 @@ include ../scripts/utilities.mak
>  #
>  # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
>  #
> +# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
> +# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
> +# for doing the conversions to/from strings/id.
>  
>  # As per kernel Makefile, avoid funny character set dependencies
>  unexport LC_ALL
> 
