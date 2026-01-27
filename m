Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6201F2B8D;
	Tue, 27 Jan 2026 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488884; cv=none; b=KIizk56pYkRX7BDEJ9gLfFghZPABoxuCDIbfMrGZj1EPGk9JNHmhbF4pczh0MaqtiCcwGmI0gu2mEtRSVX7nchSlddLhlkGiDiBbJqXJmVQF+CYJwuETaYyr/1ywRNkhzExgY2Ji8H2hBUSrpbTzNq5c6O57BfjComjFZ+3xfqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488884; c=relaxed/simple;
	bh=yRlECGWjQL1+vdGUE5GP03TXlFsaGbCuvzDqQrDoseo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfDX2YrO3KYKN35usC4HZ6anASp5MDrWzQ2KYyP2WJumQb8XVKN15LClwKCyE9yCB7ziK/MkQnTn6TptJsdbe2hqBjNZZxqs41Pm0oF4gN/ckQVkyBwTrSfjk+zwVzPYe/XEvp6QJRvYjwNJSYMEizAGYffPla/zrdJ9kjUSJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJLewdWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJLewdWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C79AC116C6;
	Tue, 27 Jan 2026 04:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769488884;
	bh=yRlECGWjQL1+vdGUE5GP03TXlFsaGbCuvzDqQrDoseo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJLewdWCo0S/vHXQtYpYnXbmkSzdRxP/AklH9MSsHurilVNWqK4FHXg/3+M5KmaCB
	 TEMeduslDuU9N4XY4EcGbAAJXmqicZ1XUtqiF6m4oBLo41P3GiSijgVNuGVgIhUr1n
	 E7xcKTdvoqA3udrRyhsZJWtMhP9iPTGJgUCv23kPG8eOOV/QxxD8BchsnUUXYwNs8A
	 Cd17OYuTZwUcrrMHpingRiJcDRHMOmXLV/ZQLOJ13XjVgBqmYYZb70jCR1Ms8wADXF
	 e11VoE0oDSZOCthU47DJ+SUikhUnhmbIP2kBeM0fVwy02pM7FQEsPbOmNorVwf+iHw
	 2qlXY9f12QxEw==
Date: Tue, 27 Jan 2026 01:41:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v8 0/3] Capstone/llvm dlopen support
Message-ID: <aXhB8B7jdTAoZ_Qe@x1>
References: <20251007163835.3152881-1-irogers@google.com>
 <CAP-5=fW7YViusbdr9uZ_wSg5cwAPcdnysGbfuytKyYw6cbQa4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW7YViusbdr9uZ_wSg5cwAPcdnysGbfuytKyYw6cbQa4g@mail.gmail.com>

On Thu, Jan 08, 2026 at 01:32:47PM -0800, Ian Rogers wrote:
> On Tue, Oct 7, 2025 at 9:38 AM Ian Rogers <irogers@google.com> wrote:
> >
> > Linking against libcapstone and libLLVM can be a significant increase
> > in dependencies and file size if building statically. The dependencies
> > are also quite cumbersome if bringing perf into a distribution. For
> > something like `perf record` the disassembler and addr2line
> > functionality of libcapstone and libLLVM won't be used. These patches
> > support dynamically loading these libraries using dlopen and then
> > calling the appropriate functions found using dlsym. Using dlopen
> > allows libcapstone and libLLVM to be installed separately to perf and
> > when that's done the performance will improve as separate commands for
> > objdump and addr2line won't be invoked.
> >
> > The patch series adds perf_ variants of the capstone/llvm functions
> > that will either directly call the function or (NO_CAPSTONE=1 and
> > NO_LIBLLVM=1 cases) use dlopen/dlsym to discover and then call the
> > function. To support the function signatures when
> > HAVE_LIBCAPSTONE_SUPPORT and HAVE_LIBLLVM_SUPPORT aren't defined
> > prototypes generated using pahole are given. This avoids requiring
> > libcapstone or libLLVM for the sake of the header files. It also
> > avoids having a build where neither dlopen or dynamic linking against
> > libcapstone or libLLVM is supported. There are other possibilities in
> > how to organize this, but the chosen approach was done so for the
> > simplicity and cleanliness of the code.
> >
> > The addr2line LLVM functionality is written in C++. To avoid linking
> > against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> > the C++ code with the libLLVM dependency will be built into a
> > libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> > would extend their C API to avoid this.
> >
> > v8: Rebase down to 3 patches. Update commit and cover messages.
> > v7: Refactor now the first 5 patches, that largely moved code around,
> >     have landed. Move the dlopen code to the end of the series so that
> >     the first 8 patches can be picked improving capstone/LLVM support
> >     without adding the dlopen code. Rename the cover letter and
> >     disassembler cleanup patches.
> > v6: Refactor the libbfd along with capstone and LLVM, previous patch
> >     series had tried to avoid this by just removing the deprecated
> >     BUILD_NONDISTRO code. Remove the libtracefs removal into its own
> >     patch.
> > v5: Rebase and comment typo fix.
> > v4: Rebase and addition of a patch removing an unused struct variable.
> > v3: Add srcline addr2line fallback trying LLVM first then forking a
> >     process. This came up in conversation with Steinar Gunderson
> >     <sesse@google.com>.
> >     Tweak the cover letter message to try to address Andi Kleen's
> >     <ak@linux.intel.com> feedback that the series doesn't really
> >     achieve anything.
> > v2: Add mangling of the function names in libperf-llvm.so to avoid
> >     potential infinite recursion. Add BPF JIT disassembly support to
> >     LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
> >     series from:
> >     https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
> >     Some other minor additional clean up.
> >
> > Ian Rogers (3):
> >   perf capstone: Support for dlopen-ing libcapstone.so
> >   perf llvm: Support for dlopen-ing libLLVM.so
> >   perf llvm: Mangle libperf-llvm.so function names
> 
> Ping.

The first two patches apply with a bit of fuzz, the last one fails
harder, can you take a stab at refreshing it so that I can try to test
it?

Thanks,

- Arnaldo
