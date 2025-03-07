Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF2254B09;
	Fri,  7 Mar 2025 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378717; cv=none; b=P/77Xu0NYwFS10Ksg1ZBwuKwYn/6ycWHyd+MbMa9ahQhKvIFsdyhEICBv+/FjAljsdD82UqFQezm3jneKbOkFR2/M0SBbYr5B9vZjeIXOvV1XYDAUu/DksbaHRWcDogmNCyxaj/K7MKDCDKwtQZPw9aV7VeZ+jk81BRpOAyTnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378717; c=relaxed/simple;
	bh=1yhe14MDWVvkAjpJEVQtvx76CjTg7n7GNwPyuNGclTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgofmA2eUjztdSvvDqpAMJr2uUcvP/VW0spLGmeize3TpVY/P1FhMoE1MvkaMISrAJyPF30WhBOFfUqmZ0TvGTGvnaA4N46T5LtuvoLrpeVs98wtSVx3XLDDR9UWwtITFqnVRWUPX/Pt4+A3sCIo36vXaZXOKv9VQ//lX8crsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biTtwzjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biTtwzjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EE3C4CEE8;
	Fri,  7 Mar 2025 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378716;
	bh=1yhe14MDWVvkAjpJEVQtvx76CjTg7n7GNwPyuNGclTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biTtwzjrL/9nN3K5IeUREraEEGMQw42j0ySREqs6Yyc/9qt3/+3MHF4U4XLlI1bl7
	 dEodPrdu96HHt+ULD5+D5/hYWWIwwsBIEFVBlkXa4PqRUsdFAGkOj9pIam83YVPs2Y
	 tpINUPdaa5ed255UciQjC8OuWudzfr5z4fEl7GQ+9Pp2CoFI9hd6RZ5Z2RFyZV3Mkx
	 YAHX2oqRIVKfs6rLn96JCrM/Rw07Ki8bYrN2L6TuRQ+YTnRsuqq/2SH0crSJvBp4Xu
	 aXraGiNnFYVUy2ayXqaUnPEMDS0OxsdhVKQlmA0Antq0I12RX0SCu7Ff8XTuWkiHH8
	 Uz4DORQkgr6hw==
Date: Fri, 7 Mar 2025 17:18:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Support .gnu_debugdata for symbols in perf
Message-ID: <Z8tUmcIH1qTF6YTn@x1>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
 <Z7-QZKNT4Cc8lspM@google.com>
 <Z8tSyzcHF2V7Lofx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8tSyzcHF2V7Lofx@x1>

On Fri, Mar 07, 2025 at 05:10:55PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 26, 2025 at 02:06:28PM -0800, Namhyung Kim wrote:
> > On Thu, Feb 20, 2025 at 10:55:08AM -0800, Stephen Brennan wrote:
> > > This series adds the ability to read symbols from the ".gnu_debugdata" section,
> > > an LZMA-compressed embedded ELF file which is supposed to contain additional ELF
> > > symbols. This is something that Fedora implemented (as "MiniDebuginfo" [1]).
> > > There are more details in v1. I've tested it with binaries that have
> > > .gnu_debugdata, and I've also ensured that the build & runtime work when LZMA is
> > > disabled.

> > > [1]: https://fedoraproject.org/wiki/Features/MiniDebugInfo

> > > Changes since v1:
> > > * Reuses the existing LZMA decompression helpers, rather than implementing a
> > >   new LZMA decompression loop. This does involve creating a temporary file, but
> > >   I think that actually makes things cleaner, since now the symsrc has a file
> > >   descriptor to close, rather than adding a new pointer that needs freeing.
> > > * I did also remove the pr_debug() for the case where there is no
> > >   ".gnu_debugdata" section. That's not really an error worth logging, that's
> > >   just normal operation.
> > > * I added a pr_debug() for the case where we successfully load .gnu_debugdata
> > >   so that it's easier to determine whether it gets used in tests.
> > 
> > Thanks, it'd be nice if anyone with a Fedora box could test this.
> 
> I'm trying to go thru this, testing with/without LZMA so that we can
> show the difference in symbol resolution, etc, but I've now stumbled on
> something that predates this, namely trying to build with NO_LZMA=1
> isn't disabling it:
 
> ⬢ [acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir /tmp/build/$(basename $PWD)/ ; make NO_LZMA=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> <SNIP>
> 
> 
> ⬢ [acme@toolbox perf-tools-next]$ ldd ~/bin/perf | grep lzma
> 	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f77ac879000)
> ⬢ [acme@toolbox perf-tools-next]$
> 
> my hunch is that some other feature needs lzma support and ignores the
> explicit NO_LZMA=1 on the make command line when it should really be
> disabling whatever features needs it, not overriding the cmd line
> request.
> 
> I'm trying to investigate.

Its an interesting case, as this patch says, elfutils now depends on
liblzma, so:

⬢ [acme@toolbox perf-tools-next]$ rpm -qa | grep xz
xz-libs-5.4.6-3.fc40.x86_64
xz-5.4.6-3.fc40.x86_64
xz-devel-5.4.6-3.fc40.x86_64
⬢ [acme@toolbox perf-tools-next]$ rpm -e xz-devel
error: Failed dependencies:
	pkgconfig(liblzma) is needed by (installed) elfutils-devel-0.192-9.fc40.x86_64
	pkgconfig(liblzma) is needed by (installed) libxml2-devel-2.12.9-1.fc40.x86_64
	xz-devel(x86-64) is needed by (installed) libxml2-devel-2.12.9-1.fc40.x86_64
⬢ [acme@toolbox perf-tools-next]$

The NO_LZMA code in the perf build system should at this point either be
deleted, as elfutils is so critical for perf, or mean that outside of
elfutils, perf should make no use of lzma, which seems odd even with
some potentially marginal value.

So for testing this series I'll have to collect data before these
patches get applied, making sure we collect samples from symbols in
binaries with a MiniDebuginfo section, do a perf report, see them as
being not resolved after making sure we don't have its debuginfo files
installed and zapping whatever local debuginfo cache we have
(debuginfod, perfs, etc), apply the patches and then see if it gets more
symbols resolved by looking at the .gnu_debugdata section.

Ok, doing that now.

- Arnaldo
