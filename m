Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742243AB0;
	Mon,  3 Aug 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781523; cv=none; b=ZU+DlsUdVvt8qAHHpSnQ/XwX+fCWCvHZX6OFJHNIHVkNhgOCokPVJc35Zjw6R9U8vWE/DTO9NDBP7TIgV+KMRTMVR5ScRiVTeZaG+4GN2EfuMvouJhiiTmpRHa5JxjKil7xoIKWr1kxQgrSogpcKMonKT6Suu75psper/xPvQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781523; c=relaxed/simple;
	bh=pu+5wd1NXciWMjTai1p9rhCh91BD6X4X8k7viyzzK9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pciK6ckFHLSxy9h2LcaTWFQB+5xz1Y1tXuy6pc6HwC4DQycbhf5j0orlO8c1INR6tKeUh0vtddAMpbKXG8ApEw7BipRCQ/EVHNoeZTdJGW+ZWzhpqtrX9oVRjeYUyGNIJSd6EYfhDpaMkQ+RGefkUB28mOBmAn9kKbUmDNL9npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMO6jvaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMO6jvaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF1A1F000E9;
	Mon,  3 Aug 2026 18:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781521;
	bh=0sUXbnPU3ypsUVe6qUTK39ZKfehy3OvmT4Rhxz8t7H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lMO6jvaEp/dcYZ1KE1EmHXF9cs5Or5q1Pj9k0NkcoQuRN1srZ2jw9n7YSF18kWrp2
	 nvqTFIBIszbkVYiFnGmv1VAKb+JY+VLHgKDn6CuenFc0pJGREJFprgTrd2ne2tIaS8
	 kKd5/+qawekRKrp5ejw1dhMf/JO2vhRA/ofzJSNUX7QfJfDo31gyH/UooRbPclyeLE
	 muRWP7RC7IvMznAtua0VnCLGhvs2ioHRijEkMHeNLy4jsscogYYW1+/AT3S+dKW+gt
	 KwmoIxO3VPXFggm26/ih7kYGe+4guJQ3BKWVY+8VY0e21nyVgzD5DP8/BBhHZcGfZ7
	 HMQOMkGUj0zXg==
Date: Mon, 3 Aug 2026 15:25:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flaky tests
Message-ID: <anDdCoA3vFD5i9y5@x1>
References: <amaWoGWxQ4Z4iNPk@x1>
 <amadxFFSer95vdNc@x1>
 <am0wljqUaRYvsS-T@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <am0wljqUaRYvsS-T@google.com>

On Fri, Jul 31, 2026 at 04:32:38PM -0700, Namhyung Kim wrote:
> On Sun, Jul 26, 2026 at 08:52:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Jul 26, 2026 at 08:22:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1
> > > 98bc7deff4858aa8 (HEAD -> perf/hardening-machine, number/perf/hardening-machine) perf machine: Check snprintf truncation for guest kallsyms path
> > > ⬢ [acme@toolbx perf-tools-next]$ perf -v
> > > perf version 7.2.rc1.g98bc7deff485
> > > ⬢ [acme@toolbx perf-tools-next]$
> > > logout
> > > acme@x1:~/git/perf-tools-next$
> > > acme@x1:~/git/perf-tools-next$ sudo su -
> > > [sudo] password for acme:
> > > root@x1:~# perf -vv
> > > perf version 7.2.rc1.g98bc7deff485
> > >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> > >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> > >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> > >                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
> > >     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
> > >           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
> > >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
> > > babeltrace2-ctf-writer: [ on  ]  # HAVE_BABELTRACE2_CTF_WRITER_SUPPORT
> > >         libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
> > >            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> > >     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
> > >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> > >                libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
> > >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > >             libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
> > >                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT ( tip: Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it )
> > >                libpfm4: [ on  ]  # HAVE_LIBPFM
> > >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> > >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> > >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> > >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> > >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> > >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> > >                   rust: [ on  ]  # HAVE_RUST_SUPPORT
> > > root@x1:~# perf test
> [SNIP]
> > > === Test Summary ===
> > > Passed main tests : 133
> > > Passed subtests   : 152
> > > Skipped tests     : 24
> > > Failed tests      : 2
> > > List of failed tests:
> > >    23: Object code reading
> > >   110: perf record sample filtering (by BPF) tests
> > > root@x1:~# perf test 23
> > >  23: Object code reading                                                                                       : Ok
> 
> Right, I'm seeing this is flaky.  Sometimes it fails to find a map for
> some kernel address.
> 
> > > 
> > > === Test Summary ===
> > > Passed main tests : 1
> > > Passed subtests   : 0
> > > Skipped tests     : 0
> > > Failed tests      : 0
> > > root@x1:~# perf test 110
> > > 110: perf record sample filtering (by BPF) tests                                                               : Ok
> 
> I never saw this before.  Do you have error message?

So, I just ran 'perf test -vvv', i.e. everything and in parallel, when I
run it alone it works, but together with the other tests:

110: perf record sample filtering (by BPF) tests:
---- start ----
test child forked, pid 195512
Checking BPF-filter privilege
Basic bpf-filter test
Basic bpf-filter test [Success]
Failing bpf-filter test
Failing bpf-filter test [Success]
Group bpf-filter test
Group bpf-filter test [Failed forbidden CPU]
---- end(-1) ----
110: perf record sample filtering (by BPF) tests                                : FAILED!


Alone:

root@x1:~# perf test 110
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
root@x1:~# perf stat --repeat 5 --null perf test 110
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0
110: perf record sample filtering (by BPF) tests                                : Ok

=== Test Summary ===
Passed main tests : 1
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 0

 Performance counter stats for 'perf test 110' (5 runs):

      13.785992473 +- 0.048784821 seconds time elapsed  ( +-  0.35% )

root@x1:~# 


