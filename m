Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3113E04F;
	Thu, 27 Jun 2024 23:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532401; cv=none; b=oF+dTE0uBlIZEMvOZwqg/XIzDp73dETjMs4wSErMSN8ZVRAFP4eoRWWIGAIUL8N6OOliKpUF2foMy0F05cCF1FkCjET7+w93NRvmJQlA8pnNkdQYQsIQAE3cGaZ67ZNc8PsalpZIW/2lYGN/s6tbyoJ0Rd7OI3QkNcrCX3WhY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532401; c=relaxed/simple;
	bh=2Jc74u8zqMtpyZa6rfWUbAVGrZ5Inv4IOZxhPgIBgnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE+9HHL/ZRkb3yDaHKwp4G9DZ4rxook8vAP0fj0ReUrVWvbtedYtCq9g6JJ0S7kH+M1iYvYpLhjqdX3rN6oRwk0X1/1urGZmuS+JyMklRvKeF6oLelMoFnawJqFBtAXIOzzAGvzDu6HxBJDk5joB7q9v1x4HvM//DnAk+kLSZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjVsghK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjVsghK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06BCC2BBFC;
	Thu, 27 Jun 2024 23:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719532400;
	bh=2Jc74u8zqMtpyZa6rfWUbAVGrZ5Inv4IOZxhPgIBgnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjVsghK1G8sKmUjRTt8AewGite3J7sFm9+zlIBLfOT0bCRojIzfuclmz21voco4Xw
	 0DdS43K5tjYwfL2FIYD6b96x+6id8OEgYDqVb1joUzYRVi9b3uw7vW/rLMvhkhD/ZY
	 JYEMGYzRKFBH/8emZuaWc9P0UaxEN0vh4pHXPIjrzJ9ivfkKtbevcVonKiRSDhXuFt
	 ndX8hFLtHB8O/Z3fo5cpFqb1+N9j+7ouMcS020up8qBBW51eRx/AlUOtmbpP+YJTEM
	 gJiphFZfZYxNKVlNMsQj7BGs7OT2FAgYHKqMlsNzCTa5H1/AIyxAt4NUdfcGNs7zDc
	 JPTN1JUsApXiQ==
Date: Thu, 27 Jun 2024 16:53:18 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: duchangbin <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
Message-ID: <Zn37bj4LER_A1bX1@google.com>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
 <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
 <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>

Hello guys,

On Wed, Jun 26, 2024 at 01:32:42PM +0300, Adrian Hunter wrote:
> On 26/06/24 05:26, duchangbin wrote:
> > On Tue, Jun 25, 2024 at 04:20:49PM +0300, Adrian Hunter wrote:
> >> On 25/06/24 06:37, Changbin Du wrote:
> >>> The vdso dumped from process memory (in buildid-cache) lacks debugging
> >>> info. To annotate vdso symbols with source lines we need specify a
> >>> debugging version.
> >>>
> >>> For x86, we can find them from your local build as
> >>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
> >>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
> >>> the buildid has to match.
> >>>
> >>> $ sudo perf record -a
> >>> $ sudo perf report --objdump=llvm-objdump \
> >>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
> >>>
> >>> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
> >>> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
> >>> Percent│       movq    -48(%rbp),%rsi
> >>>        │       testq   %rax,%rax
> >>>        │     ;               return vread_hvclock();
> >>>        │       movq    %rax,%rdx
> >>>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
> >>>        │     ↑ js      eb
> >>>        │     ↑ jmp     74
> >>>        │     ;               ts->tv_sec = vdso_ts->sec;
> >>>   0.02 │147:   leaq    2(%rbx),%rax
> >>>        │       shlq    $4, %rax
> >>>        │       addq    %r10,%rax
> >>>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
> >>>   9.38 │152:   movl    (%r10),%ecx
> >>>
> >>> When doing cross platform analysis, we also need specify the vdso path if
> >>> we are interested in its symbols.
> >>
> >> Would it be possible to add vdso and vdso debug to the build-id
> >> cache and ensure perf can find it there?
> >>
> >> Typically, getting dsos from another machine is handled via
> >> build-id cache e.g. what perf-archive does
> >>
> > Hmm. I agree this is better alternative approach for cross-machine analysis.
> > When collecting vdsos to buildid cache, I think we can use the local searched
> > objects (with debug symbols) instead if its build-id matches vdsos from process
> > dumping (the real code ran).
> > 
> > Currently I just follow what perf does for vmlinux so to reuse most of existing
> > code. Maybe vmlinux is too big to add to buildid-cahce?
> > 
> > Can we keep our current strategy for now? I'll think about above options when
> > I have more time.
> > 
> 
> I tried adding vdso via perf buildid-cache.  It doesn't work only
> because the lookup expects the basename to be "vdso" but it is
> "elf".
> 
> Adding a link from "vdso" to "elf" made it work e.g.
> 
> $ cat gettimeofday-test.c
> #include <stdio.h>
> #include <sys/time.h>
> 
> int main()
> {
>         struct timeval tv;
>         int ret;
> 
>         ret = gettimeofday(&tv, NULL);
>         if (ret == -1) {
>                 fprintf(stderr, "gettimeofday failed\n");
>                 return 1;
>         }
> 
>         printf("%lu.%lu\n", (unsigned long)tv.tv_sec, (unsigned long)tv.tv_usec);
> 
>         return 0;
> $ perf record -e intel_pt//u ./gettimeofday-test
> 1719397042.892837
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.026 MB perf.data ]
> $ perf script --itrace=e
> $ perf buildid-cache --remove /lib/modules/6.5.0-41-generic/vdso/vdso64.so
> $ perf script --itrace=e
> Warning:
> 2 instruction trace errors
>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
> $ perf buildid-cache --add /lib/modules/6.5.0-41-generic/vdso/vdso64.so
> $ perf script --itrace=e
> Warning:
> 2 instruction trace errors
>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
> $ cd ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8
> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ln -s elf vdso
> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ls -l
> total 36
> -rw-r--r-- 1 ahunter ahunter 33272 Jun 26 13:17 elf
> -rw-r----- 1 ahunter ahunter     0 Jun 26 13:17 probes
> lrwxrwxrwx 1 ahunter ahunter     3 Jun 26 13:18 vdso -> elf
> /.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ cd
> $ perf script --itrace=e
> $ 
> 
> So maybe a change could be made to build_id_cache__add() to add
> the extra link if the file name matches vdso
 
Thanks for doing this!  I noticed buildid_cache__basename() will handle
the name properly once it realizes the file is a vdso.  Maybe we can
check the filepath with some patterns, or simply add an command line
option to say it's a vdso.

Thanks,
Namhyung

