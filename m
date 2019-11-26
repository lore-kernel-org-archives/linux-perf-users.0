From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] libbpf: Fix up generation of bpf_helper_defs.h
Date: Tue, 26 Nov 2019 16:04:50 -0300
Message-ID: <20191126190450.GD29071@kernel.org>
References: <20191126151045.GB19483@kernel.org>
 <20191126154836.GC19483@kernel.org>
 <87imn6y4n9.fsf@toke.dk>
 <20191126183451.GC29071@kernel.org>
 <87d0dexyij.fsf@toke.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87d0dexyij.fsf@toke.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Andrii Nakryiko <andriin@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>, Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-perf-users@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Nov 26, 2019 at 07:50:44PM +0100, Toke Høiland-Jørgensen escreveu:
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> 
> > Em Tue, Nov 26, 2019 at 05:38:18PM +0100, Toke Høiland-Jørgensen escreveu:
> >> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> >> 
> >> > Em Tue, Nov 26, 2019 at 12:10:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> >> Hi guys,
> >> >> 
> >> >>    While merging perf/core with mainline I found the problem below for
> >> >> which I'm adding this patch to my perf/core branch, that soon will go
> >> >> Ingo's way, etc. Please let me know if you think this should be handled
> >> >> some other way,
> >> >
> >> > This is still not enough, fails building in a container where all we
> >> > have is the tarball contents, will try to fix later.
> >> 
> >> Wouldn't the right thing to do not be to just run the script, and then
> >> put the generated bpf_helper_defs.h into the tarball?

> > I would rather continue just running tar and have the build process
> > in-tree or outside be the same.
> 
> Hmm, right. Well that Python script basically just parses
> include/uapi/linux/bpf.h; and it can be given the path of that file with
> the --filename argument. So as long as that file is present, it should
> be possible to make it work, I guess?
 
> However, isn't the point of the tarball to make a "stand-alone" source
> distribution?

Yes, it is, and as far as possible without any prep, just include the
in-source tree files needed to build it.

> I'd argue that it makes more sense to just include the
> generated header, then: The point of the Python script is specifically
> to extract the latest version of the helper definitions from the kernel
> source tree. And if you're "freezing" a version into a tarball, doesn't
> it make more sense to also freeze the list of BPF helpers?

Your suggestion may well even be the only solution, as older systems
don't have python3, and that script requires it :-\

Some containers were showing this:

/bin/sh: 1: /git/linux/scripts/bpf_helpers_doc.py: not found
Makefile:184: recipe for target 'bpf_helper_defs.h' failed
make[3]: *** [bpf_helper_defs.h] Error 127
make[3]: *** Deleting file 'bpf_helper_defs.h'
Makefile.perf:778: recipe for target '/tmp/build/perf/libbpf.a' failed

That "not found" doesn't mean what it looks from staring at the above,
its just that:

nobody@1fb841e33ba3:/tmp/perf-5.4.0$ head -1 /tmp/perf-5.4.0/scripts/bpf_helpers_doc.py
#!/usr/bin/python3
nobody@1fb841e33ba3:/tmp/perf-5.4.0$ ls -la /usr/bin/python3
ls: cannot access /usr/bin/python3: No such file or directory
nobody@1fb841e33ba3:/tmp/perf-5.4.0$

So, for now, I'll keep my fix and start modifying the containers where
this fails and disable testing libbpf/perf integration with BPF on those
containers :-\

I.e. doing:

nobody@1fb841e33ba3:/tmp/perf-5.4.0$ make NO_LIBBPF=1 -C /tmp/perf-5.4.0/tools/perf/ O=/tmp/build/perf

which ends up with a functional perf, just one without libbpf linked in:

nobody@1fb841e33ba3:/tmp/perf-5.4.0$ /tmp/build/perf/perf -vv
perf version 5.4.gf69779ce8f86
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ OFF ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                 glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                  gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ OFF ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ OFF ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
nobody@1fb841e33ba3:/tmp/perf-5.4.0$

The the build tests for libbpf and the bpf support in perf will
continue, but for a reduced set of containers, those with python3.

People wanting to build libbpf on such older systems will hopefully find
this discussion in google, run the script, get the output and have it
working.

- Arnaldo
