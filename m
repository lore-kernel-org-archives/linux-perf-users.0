Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D681AC8B7;
	Thu, 15 Aug 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733206; cv=none; b=BnkOxVbr9kKRiTF/AMnSES4Aug4bu2m0vpgqPI1WanHmxp9XzA4QpNEl/BZQq8N4V+cg6fWSqX2J1n9HSCfeOsAmNa6JXBaAAr6zoIKcLpCNYHbIfLf+Aw6zb606soJ4qLk6dQgZYeBJEDjv4TPBCvHlXoGtCLkhtbw2vU4Ly88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733206; c=relaxed/simple;
	bh=0cb2ozE3pSmk2tc/Whcdb9nUWYpE3P/0sgVBTFvVb4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c61ftyWct8n2pzVTLgYw42wA4SxJ3K0H+dDeyFOmEoWjIkcXp5oL19vCyABXoShOUfSY7oXNqRfTBFg5zBkNwxSsu/TRBsDDznMYYNjRu2Xj68FWWz5zXWg8ruOP1fMKzujcHEx3tJN+jDG2irneKyLxqlXsJu4KYtyky3SKDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ3rfHNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ3rfHNV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AAAC32786;
	Thu, 15 Aug 2024 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723733205;
	bh=0cb2ozE3pSmk2tc/Whcdb9nUWYpE3P/0sgVBTFvVb4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQ3rfHNVNgMESSJwOPybUrwGPx4xX9FbFCBH5Fb2Gwamyj61eNyEngoBwaa1a2H60
	 +drdg1E9icTjK9TJx+d9rF+Ezn1UqRT+uKhsNxUkgdjFkWoZONlKI28VdfEpTSLcfZ
	 4tTL2XgBjv22AVGBcilzDFtOhpY8uio/B85ZGt9PQ4eZtT1rOWeuNvT4zKxQVJUQ/E
	 8yKhZDf/uSEsC3fD3CW7lZE1N5YI+KbpxNwgImlNQKCTniqt9eGgaoQe0AMfGoD/IQ
	 Qx+Hva0TFqFc4zL5i0KpqKCSshrWT490/X+OZfrvyqwwoUzJXGSaxH0QJIKCMOzbya
	 m/efBjpRsO0Sw==
Date: Thu, 15 Aug 2024 11:46:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: duchangbin <changbin.du@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Andi Kleen <andi@firstfloor.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf build: Fix up broken capstone feature detection
 fast path
Message-ID: <Zr4U0ud8zAtFyqPR@x1>
References: <Zry0sepD5Ppa5YKP@x1>
 <76c92af3b3544f8a9fed412fc287947d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76c92af3b3544f8a9fed412fc287947d@huawei.com>

On Thu, Aug 15, 2024 at 03:26:22AM +0000, duchangbin wrote:
> Hi, Arnaldo,
> 
> How about workaround it by rename the 'bpf_insn' in capstione?

Right, that could help overcome that clash, but then we would also have
to call main_test_libcapstone() from test-all.c's main() to get it fully
supported.

The thing is, do we think capstone is crucial for building perf these
days and is most of the time installed on developer's machines? The idea
of test-all.c is to save time by doing just one build test for the
things that are almost certain to be installed, so we don't have to do N
compilations/links.

The way it is now makes it achieve that, after a while, if capstone
support becomes integral to the perf tooling experience, we can change
that and add its feature query test to the test-all.c suite.

Since we're seeing also some support for llvm libraries that "compete"
with capstone, this may end up not being the case, so I think we should
wait a bit there.

- Arnaldo
 
> Change test-libcapstone.c as:
> 
> #define bpf_insn capstone_bpf_insn
> #include <capstone/capstone.h>
> #undef bpf_insn
> 
> I haven't tried it but seems feasible.
> 
> On Wed, Aug 14, 2024 at 10:44:17AM -0300, Arnaldo Carvalho de Melo wrote:
> > The capstone devel headers define 'struct bpf_insn' in a way that clashes with
> > what is in the libbpf devel headers, so we so far need to avoid including both.
> > 
> > This is happening on the tools/build/feature/test-all.c file, where we try
> > building all the expected set of libraries to be normally available on a
> > system:
> > 
> >   ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   In file included from test-bpf.c:3,
> >                    from test-all.c:150:
> >   /home/acme/git/perf-tools-next/tools/include/uapi/linux/bpf.h:77:8: error: ‘bpf_insn’ defined as wrong kind of tag
> >      77 | struct bpf_insn {
> >         |        ^~~~~~~~
> >   ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> > 
> > When doing so there is a trick where we define main to be
> > main_test_libcapstone, then include the individual
> > tools/build/feture/test-libcapstone.c capability query test, and then we undef
> > 'main' because we'll do it all over again with the next expected library to
> > be tested (at this time 'lzma').
> > 
> > To complete this mechanism we need to, in test-all.c 'main' routine, to
> > call main_test_libcapstone(), which isn't being done, so the effect of
> > adding references to capstone in test-all.c are not achieved.
> > 
> > The only thing that is happening is that test-all.c is failing to build and thus
> > all the tests will have to be done individually, which nullifies the test-all.c
> > single build speedup.
> > 
> > So lets remove references to capstone from test-all.c to see if this makes it
> > build again so that we get faster builds or go on fixing up whatever is
> > preventing us to get that benefit.
> > 
> > Nothing: after this fix we get a clean test-all.c build and get the build speedup back:
> > 
> >   ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.
> >   test-all.bin          test-all.d            test-all.make.output
> >   ⬢[acme@toolbox perf-tools-next]$ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   ⬢[acme@toolbox perf-tools-next]$ ldd /tmp/build/perf-tools-next/feature/test-all.bin
> >   	linux-vdso.so.1 (0x00007f13277a1000)
> >   	libpython3.12.so.1.0 => /lib64/libpython3.12.so.1.0 (0x00007f1326e00000)
> >   	libm.so.6 => /lib64/libm.so.6 (0x00007f13274be000)
> >   	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f1327496000)
> >   	libtracefs.so.1 => /lib64/libtracefs.so.1 (0x00007f132746f000)
> >   	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f1326800000)
> >   	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f1327452000)
> >   	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f1327436000)
> >   	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f1327403000)
> >   	libdw.so.1 => /lib64/libdw.so.1 (0x00007f1326d6f000)
> >   	libz.so.1 => /lib64/libz.so.1 (0x00007f13273e2000)
> >   	libelf.so.1 => /lib64/libelf.so.1 (0x00007f1326d53000)
> >   	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f13273d4000)
> >   	libslang.so.2 => /lib64/libslang.so.2 (0x00007f1326400000)
> >   	libperl.so.5.38 => /lib64/libperl.so.5.38 (0x00007f1326000000)
> >   	libc.so.6 => /lib64/libc.so.6 (0x00007f1325e0f000)
> >   	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f1326741000)
> >   	/lib64/ld-linux-x86-64.so.2 (0x00007f13277a3000)
> >   	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f1326d3f000)
> >   	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f1326d07000)
> >   ⬢[acme@toolbox perf-tools-next]$
> > 
> > And when having capstone-devel installed we get it detected and linked with
> > perf, allowing us to benefit from the features that it enables:
> > 
> >   ⬢[acme@toolbox perf-tools-next]$ rpm -q capstone-devel
> >   capstone-devel-5.0.1-3.fc40.x86_64
> >   ⬢[acme@toolbox perf-tools-next]$ ldd /tmp/build/perf-tools-next/perf | grep capstone
> >   	libcapstone.so.5 => /lib64/libcapstone.so.5 (0x00007fe6a5c00000)
> >   ⬢[acme@toolbox perf-tools-next]$ /tmp/build/perf-tools-next/perf -vv | grep cap
> >              libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> >   ⬢[acme@toolbox perf-tools-next]$
> > 
> > Fixes: 8b767db3309595a2 ("perf: build: introduce the libcapstone")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Andi Kleen <andi@firstfloor.org>
> > Cc: Changbin Du <changbin.du@huawei.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/build/feature/test-all.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > index dd0a18c2ef8fc080..6f4bf386a3b5c4b0 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -134,10 +134,6 @@
> >  #undef main
> >  #endif
> >  
> > -#define main main_test_libcapstone
> > -# include "test-libcapstone.c"
> > -#undef main
> > -
> >  #define main main_test_lzma
> >  # include "test-lzma.c"
> >  #undef main
> > -- 
> > 2.45.2
> > 
> > 
> 
> -- 
> Cheers,
> Changbin Du
