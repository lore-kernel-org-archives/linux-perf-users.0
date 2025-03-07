Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52821CC4A;
	Fri,  7 Mar 2025 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378255; cv=none; b=ilNtnEGgcFdTJWrmGmkFsIhed1fPCFzI7v4bvbTRe5TllWJyf8hWYSg6eLC6AviATpTUNWPUUieWCWXJmpDm3DETEsIC2oz1u4gGkWzs9+ea4F5k3TnUhv3ETgUT0tYKi0c4uVLmKEHf8CRP67vrVohCShDV9Y5gfacBuAVQb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378255; c=relaxed/simple;
	bh=3nSZ2JbAIlV45zJPDKD7cz1iFS7azKXpOcw/9B+Wc7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNoU+1BNp6ac3yraA9FZ0AmPMkkZuFdayqBy+Tnz6c45lMTo2YhWwglwvk5lkZ35qg5BqNJFJ9hvwzaQPsPWz8TqEQTMdlGzBdWxMBRFBgicYB6X2CdfSIUCUjILq6xu0LEDIhfL7gtTvRmVpHxrf5wLBAfK3rast6mj3+w62H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJgd30qO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJgd30qO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F93DC4CED1;
	Fri,  7 Mar 2025 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378254;
	bh=3nSZ2JbAIlV45zJPDKD7cz1iFS7azKXpOcw/9B+Wc7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJgd30qOSyXEM7mIsT2K4/fd6oyvFM0crtMoGhc0OlKMUnx1gUXwqYxR/x1c0YrnQ
	 kQ4AisB7J9AzfaG3wKdKZCJtwzHLA/DcRDnKw3Q82VD9hsbqygWosSlCyjz6GlGguP
	 VMREfYj2uFOCdOgsaEcjNMS/+bvCP8WJQSBL/pI0/kh+mJmAFaTLwV8T8LeKJCeNZx
	 4dIs8o2YaqLslu23yA1kCYSZKHv9EiKmRyD/6aOf1ZQlQKoIlgtmSJHMC2rTGzSoU7
	 DAgQoWgjOdN2lCLv0XoSfkP75FtnMWyfUs2Q3qbEGDPaZuEFEQtOISGdHziTDKjyhI
	 1ze7QJ7J5QvKA==
Date: Fri, 7 Mar 2025 17:10:51 -0300
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
Message-ID: <Z8tSyzcHF2V7Lofx@x1>
References: <20250220185512.3357820-1-stephen.s.brennan@oracle.com>
 <Z7-QZKNT4Cc8lspM@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7-QZKNT4Cc8lspM@google.com>

On Wed, Feb 26, 2025 at 02:06:28PM -0800, Namhyung Kim wrote:
> On Thu, Feb 20, 2025 at 10:55:08AM -0800, Stephen Brennan wrote:
> > Hello all,
> > 
> > This series adds the ability to read symbols from the ".gnu_debugdata" section,
> > an LZMA-compressed embedded ELF file which is supposed to contain additional ELF
> > symbols. This is something that Fedora implemented (as "MiniDebuginfo" [1]).
> > There are more details in v1. I've tested it with binaries that have
> > .gnu_debugdata, and I've also ensured that the build & runtime work when LZMA is
> > disabled.
> > 
> > [1]: https://fedoraproject.org/wiki/Features/MiniDebugInfo
> > 
> > Changes since v1:
> > * Reuses the existing LZMA decompression helpers, rather than implementing a
> >   new LZMA decompression loop. This does involve creating a temporary file, but
> >   I think that actually makes things cleaner, since now the symsrc has a file
> >   descriptor to close, rather than adding a new pointer that needs freeing.
> > * I did also remove the pr_debug() for the case where there is no
> >   ".gnu_debugdata" section. That's not really an error worth logging, that's
> >   just normal operation.
> > * I added a pr_debug() for the case where we successfully load .gnu_debugdata
> >   so that it's easier to determine whether it gets used in tests.
> 
> Thanks, it'd be nice if anyone with a Fedora box could test this.

I'm trying to go thru this, testing with/without LZMA so that we can
show the difference in symbol resolution, etc, but I've now stumbled on
something that predates this, namely trying to build with NO_LZMA=1
isn't disabling it:

⬢ [acme@toolbox perf-tools-next]$ rm -rf /tmp/build/$(basename $PWD)/ ; mkdir /tmp/build/$(basename $PWD)/ ; make NO_LZMA=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j28' parallel build

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
<SNIP>


⬢ [acme@toolbox perf-tools-next]$ ldd ~/bin/perf | grep lzma
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f77ac879000)
⬢ [acme@toolbox perf-tools-next]$

my hunch is that some other feature needs lzma support and ignores the
explicit NO_LZMA=1 on the make command line when it should really be
disabling whatever features needs it, not overriding the cmd line
request.

I'm trying to investigate.

- Arnaldo
