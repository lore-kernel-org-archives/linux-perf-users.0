Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB444781A;
	Fri, 31 Jul 2026 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540761; cv=none; b=rmWKBCzv6xKiMLz3on4jKkfl+4i4tEVLy84AqOyX8HWsUP91R/J+qA2fEg29oDj3Q+yer+tVmxejMhScV7Vd4JuuUSU285FgweYstvK3FSeYJkiXJTFSzUmPuu/DfXEV2ZGF62hM2xzQM2X8iBPsNHHMcyfr6D2J9fxFcaleaTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540761; c=relaxed/simple;
	bh=NX+qMY7Z+Tz4La2FhpK7ALZnDA8LaIeePy2CJi2hCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuGEz5IlKTMB0JShLOJTMIRMwa1C5e95K2+//jBcKMkxii4vlD8Zyk/mMbNnG0zdU+B1IA+UUMoh+XDubJhZj+bPbJ1QOxz9og+iKMLVe9WKvZhM8o7MYd0jPc5NW87f2mP54m408URZlHsrgLtRMQD8BBNFje9Js8VDDEpxKYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ5oAPr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ5oAPr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA771F00AC4;
	Fri, 31 Jul 2026 23:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785540760;
	bh=czqlfcEAMjWrlTHx1B9wJwhXcruEO6Ku+5ixIxaRqU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DJ5oAPr1pz6M1zU275NSFKL7OI6KYRYEVw9vuZDb4YdwWHtK/QhOmL4tp07fToy4k
	 F+nQq5E8IiJ7HQupShpelGACJvbRKwsnfkEHTCtZxG6FI87+cR5Oqaa7fcII/2GxEm
	 z31ZXktr6iy2bdQEUptiocLcDjUBdYCRpBNd1oABpsbwcUO91nCTldC4QLmH9KlGPJ
	 t0x1cXfsS/xgnUuwSlcQ+o8D/cdjNBZR+xVyuaeHRQg56RZ/LKcQM7lSqHLfj8Z/qe
	 uhYv6EStFkbrJJXQlRpUTieferLaUKyvgXvSn+Ak4CZECUeHy/OwdGIsVCbaQ7W7BV
	 ep5EkBfnrFFaQ==
Date: Fri, 31 Jul 2026 16:32:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flaky tests
Message-ID: <am0wljqUaRYvsS-T@google.com>
References: <amaWoGWxQ4Z4iNPk@x1>
 <amadxFFSer95vdNc@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amadxFFSer95vdNc@x1>

On Sun, Jul 26, 2026 at 08:52:36PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Jul 26, 2026 at 08:22:08PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> > 
> > 	Getting back on track with perf I noticed these two flaky tests,
> > not investigated yet:
> 
> Sry, sent to another Ian, from another life :-)

:)

>  
> > ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1
> > 98bc7deff4858aa8 (HEAD -> perf/hardening-machine, number/perf/hardening-machine) perf machine: Check snprintf truncation for guest kallsyms path
> > ⬢ [acme@toolbx perf-tools-next]$ perf -v
> > perf version 7.2.rc1.g98bc7deff485
> > ⬢ [acme@toolbx perf-tools-next]$
> > logout
> > acme@x1:~/git/perf-tools-next$
> > acme@x1:~/git/perf-tools-next$ sudo su -
> > [sudo] password for acme:
> > root@x1:~# perf -vv
> > perf version 7.2.rc1.g98bc7deff485
> >                    aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> >             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >                  dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
> >     dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
> >           dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
> >                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip: Deprecated, license incompatibility, use BUILD_NONDISTRO=1 and install binutils-dev[el] )
> > babeltrace2-ctf-writer: [ on  ]  # HAVE_BABELTRACE2_CTF_WRITER_SUPPORT
> >         libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
> >            libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> >     libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
> >                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >                libLLVM: [ on  ]  # HAVE_LIBLLVM_SUPPORT
> >                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >             libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
> >                libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT ( tip: Deprecated, use LIBPERL=1 and install perl-ExtUtils-Embed/libperl-dev to build with it )
> >                libpfm4: [ on  ]  # HAVE_LIBPFM
> >              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> >                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >                   rust: [ on  ]  # HAVE_RUST_SUPPORT
> > root@x1:~# perf test
[SNIP]
> > === Test Summary ===
> > Passed main tests : 133
> > Passed subtests   : 152
> > Skipped tests     : 24
> > Failed tests      : 2
> > List of failed tests:
> >    23: Object code reading
> >   110: perf record sample filtering (by BPF) tests
> > root@x1:~# perf test 23
> >  23: Object code reading                                                                                       : Ok

Right, I'm seeing this is flaky.  Sometimes it fails to find a map for
some kernel address.

> > 
> > === Test Summary ===
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x1:~# perf test 110
> > 110: perf record sample filtering (by BPF) tests                                                               : Ok

I never saw this before.  Do you have error message?

Thanks,
Namhyung

> > 
> > === Test Summary ===
> > Passed main tests : 1
> > Passed subtests   : 0
> > Skipped tests     : 0
> > Failed tests      : 0
> > root@x1:~#
