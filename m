Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E353E1CE3;
	Thu, 23 Apr 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937767; cv=none; b=ewa/6ugviUN4YvZUEHwMGZgJOw9FhsO3diUnMNZtoKMpf2eWJQ31DJyJ31i+Aw+prR/2PyKjNv3sXXWDoHtYe7GyBn0ypDV24VHvCAeRE/jhuFTiZ48OdO/HYgSg4r+Pd7UTQB0MlWRPKoN1ALT+RMB5STYQSvy3H1tBMeEFcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937767; c=relaxed/simple;
	bh=omlYnhoKI15TtGgZPMTNBrhT3/9GqJZ1kep5PMH9UHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+0d9HOX20VxSaMjMmX/zFvTTk74/TcfHlAXUe4ni2GWM08Dxq7JNV08sGZBA++sb1x6eiTXdCWkZJ5+vr5S6iuAJbVBcnyCtU5i6ca/nTiHr4+rF7w1+gLvmMhQ0UfPyaWVYcMkMOl/3jvMNFvoOY+iLcWnVp7P4mLXDuuL7hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B3DED34223F;
	Thu, 23 Apr 2026 09:49:21 +0000 (UTC)
Date: Thu, 23 Apr 2026 11:49:16 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, libunwind-devel@nongnu.org
Subject: Re: perf performance with libdw vs libunwind
Message-ID: <aenrHEOZDiBKG4Sy@gentoo.org>
References: <aejMem8Pt3iCxaka@gentoo.org>
 <CAP-5=fX6PT2FsvAoy+0AGq3AFEQ9XU_HBhGkZdX0fn0Ltss-JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fX6PT2FsvAoy+0AGq3AFEQ9XU_HBhGkZdX0fn0Ltss-JA@mail.gmail.com>

Hi Ian,

On Wed, Apr 22, 2026 at 09:21:52PM -0700, Ian Rogers wrote:
> Hi Guilherme,
> 
> Thanks for the feedback but I'm a little confused. Your .perfconfig is
> set to use frame-pointer-based unwinding, so neither libunwind nor
> libdw should be used for unwinding. With framepointer unwinding, a
> sample contains an array of IPs gathered by walking the linked list of
> frame pointers on the stack. With --call-graph=dwarf a region of
> memory is copied into a sample (the stack) along with some initial
> register values, libdw or libunwind is then used to process this
> memory using the dwarf information in the ELF binary.

Thanks for your reply and pardon my ignorance, I thought that the libraries
were generically used for stack unwinding, regardless of if it's fp or dwarf.
I should have looked a bit deeper before reporting this, but we are on the
right track.

> So something that changed in v7.0 is that with the dwarf libdw or
> libunwind unwinding we always had all inline functions on the stack
> but not with frame pointers. The IP in the frame pointer array can be
> of an instruction within an inlined function. In v7.0 we added a patch
> that includes inline information for both frame pointer and LBR-based
> stack traces:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/machine.c?h=perf-tools-next&id=28cb835f7645892f4559b92fcfeb25a81646f4cf

This is a nice development, I have been using --call-graph=dwarf to see
the inlined symbols, so having the ability to see inlined functions with
fp unwinding, which is much more lightweight in terms of space (i.e. the
size of the final perf.data files), is great.

> By default we try to add inline information using libdw if that fails
> we try llvm, then libbfd and finally the command line addr2line tool:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/srcline.c?h=perf-tools-next&id=28cb835f7645892f4559b92fcfeb25a81646f4cf#n145
> I suspect the slow down is for doing all this addr2line work on a
> binary that's been stripped. The good news here is that if you can add
> a config option to avoid all the fallbacks, "addr2line.style=libdw".
> You can also disable inline information by adding "--no-inline" to
> your `perf report` command line.

The binary and its direct dependent libraries, as well as most other dependencies
are not stripped, but it's possible that some dependency in the full chain might be.

When I run perf report using --no-inline I indeed recover the performance I
had before with perf-6.19.12. However, setting addr2line.style=libdw did not
help much. Here is what I observe:

$ perf config
call-graph.record-mode=fp
$ perf version
perf version 7.0
$ time perf record -g -F max -e cycles:uk -- root.exe -l -q
info: Using a maximum frequency rate of 63800 Hz
[ perf record: Woken up 18 times to write data ]
[ perf record: Captured and wrote 4.720 MB perf.data (16552 samples) ]
1.26
$ time perf report -q --stdio -g none --children --no-inline --percent-limit 75
    92.65%     0.00%  root.exe  root.exe              [.] main
    92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_main@@GLIBC_2.34
    92.64%     0.00%  root.exe  root.exe              [.] _start
    91.63%     0.00%  root.exe  libCore.so.6.38.04    [.] ROOT::GetROOT()
    89.46%     0.00%  root.exe  libRint.so.6.38.04    [.] TRint::TRint(char const*, int*, char**, void*, int, bool, bool)
    88.31%     0.00%  root.exe  libCore.so.6.38.04    [.] TApplication::TApplication(char const*, int*, char**, void*, int)
    88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] ROOT::Internal::GetROOT2()
    88.20%     0.00%  root.exe  libCore.so.6.38.04    [.] TROOT::InitInterpreter()
    76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpreter
    76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] TCling::TCling(char const*, char const*, char const* const*, void*)

1.70
Flamegraph: https://amadio.web.cern.ch/perf/perf-report-noinline.svg

Now without --no-inline, and this first command is without addr2line.style=libdw in the config:

$ time perf report -q --stdio -g none --children --percent-limit 75
    92.65%     0.00%  root.exe  root.exe              [.] main
    92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    92.64%     0.00%  root.exe  root.exe              [.] _start
    88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlined)
    76.34%     0.00%  root.exe  libCling.so.6.38.04   [.] CreateInterpreter

241.60
Flamegraph: https://amadio.web.cern.ch/perf/perf-report-addr2line.svg

$ perf config addr2line.style=libdw
$ perf config
call-graph.record-mode=fp
addr2line.style=libdw
$ time perf report -q --stdio -g none --children --percent-limit 75
    92.65%     0.00%  root.exe  root.exe              [.] main
    92.64%     0.00%  root.exe  libc.so.6             [.] __libc_start_call_main
    92.64%     0.00%  root.exe  root.exe              [.] _start
    88.22%     0.00%  root.exe  libCore.so.6.38.04    [.] GetROOT2 (inlined)

137.93
Flamegraph: https://amadio.web.cern.ch/perf/perf-report-libdw.svg

The flame graphs above are for the perf-report commands themselves.

So, the performance is fine with --no-inline, and it's better with addr2line.style=libdw.
However, the function names are not the best in the last two reports, so this problem remains.

> Your report suggests we should tweak the defaults for showing inline
> information. Could you try the options I've suggested and see if they
> remedy the issue for you?

Thank you for the suggestions. Indeed --no-inline seems to bring back the
previous performance. Please let me know if you would like me to try more
things and what other information you need for the cases without --no-inline.

Best regards,
-Guilherme
