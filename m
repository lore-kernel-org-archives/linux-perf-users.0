Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1012FB13;
	Thu, 18 Jul 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721322149; cv=none; b=IvMDGhYOow09BXyek9bv6tAd5sh1BC+E+Gqci7cqXzYAhDulDetZJGBGzniklzoeQz4VHINi0yIiC+ZcSfLIq202LaF6n4RDTakBVxDPAf+Oym9+vNX8Zte5oOLRJhmRhVLapgW6KndjUkFd2V6u+ixFi4tbQ9RxQZjpClNLDaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721322149; c=relaxed/simple;
	bh=MYK8Iqf70n3GxpdTVH1IK5e5KAoR7Wbbpr8B36x5udk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR7L/lLj4pO1bLM64sHnnzcU0SWPuX7F8As3uCcFbgmaipXeJcSPY4YBWAjoNOkMT8YYZ6R11OBclBX362w5HD9DUD9cGfoynLC7pKoBPO94OyxMabVZFbPfb1bIO4wDR2v/PQoQ5qa1LX3/OtnFWsc//JVMyh9Gzj2iEGmXc2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvUhQcGu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvUhQcGu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721322148; x=1752858148;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MYK8Iqf70n3GxpdTVH1IK5e5KAoR7Wbbpr8B36x5udk=;
  b=BvUhQcGud+W3QTh7i4lTzDUNUd+cNaS/Qx3O5yj3Rjtc/HsOLJGbx3Dh
   StW81Cz1ZMMAWrw2nHjMGoO5Tb5jadBmQpljArC8UMi8YbeILwE04P7ic
   9BhWO3p/2MZs7ywNpCxcvAsEnR4rh3zVYb3Pf+VQag/OS2w1oNC+IRP4q
   sksX4y1/OYyvK8wnW4RMuHqe7zfywrdknO/egOsGuMZOdO41WERN7yhdE
   3Rl+AHL9/fQgRBNX00Rr6UDEFE+ZEzRfO9O8P89E3h3xIN8HqYvZ8EHOk
   sQK5pbL498y9IGLCN/OgPbaNHFozkXtCKs0Tpg1EpkHKNgTbIpkr5sdu6
   A==;
X-CSE-ConnectionGUID: Ydt4Y2nKTGaqUUHOnGM2Kg==
X-CSE-MsgGUID: IS4v3H4HRXKMnTmnepwjRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="12611788"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="12611788"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:02:27 -0700
X-CSE-ConnectionGUID: kQZGkZijTee4MhtT4mDzSw==
X-CSE-MsgGUID: QmhNHGV0QTy8TxEi0wscUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="88320990"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 10:02:22 -0700
Message-ID: <4ddbcd4a-bbf1-4773-94da-0a2ad63469dc@intel.com>
Date: Thu, 18 Jul 2024 20:02:16 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] perf: support specify vdso path in cmdline
To: Changbin Du <changbin.du@huawei.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hui Wang <hw.huiwang@huawei.com>
References: <20240702041837.5306-1-changbin.du@huawei.com>
 <20240702041837.5306-2-changbin.du@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240702041837.5306-2-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/07/24 07:18, Changbin Du wrote:
> The vdso dumped from process memory (in buildid-cache) lacks debugging
> info. To annotate vdso symbols with source lines we need specify a
> debugging version.
> 
> For x86, we can find them from your local build as
> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
> the buildid has to match.
> 
> $ sudo perf record -a
> $ sudo perf report --objdump=llvm-objdump \
>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
> 
> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
> Percent│       movq    -48(%rbp),%rsi
>        │       testq   %rax,%rax
>        │     ;               return vread_hvclock();
>        │       movq    %rax,%rdx
>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>        │     ↑ js      eb
>        │     ↑ jmp     74
>        │     ;               ts->tv_sec = vdso_ts->sec;
>   0.02 │147:   leaq    2(%rbx),%rax
>        │       shlq    $4, %rax
>        │       addq    %r10,%rax
>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>   9.38 │152:   movl    (%r10),%ecx
> 
> When doing cross platform analysis, we also need specify the vdso path if
> we are interested in its symbols.
> 

Just realized this is about objdump.  Sorry for not getting that
earlier.

Like perf tools, objdump follows the paradigm of attempting to
locate and use debug info transparently.  However, objdump looks
at the installed debug info in /usr/lib/debug/.build-id/

For example, if the debug file is copied (or linked) there, then
objdump or llvm-objdump will find it:

$ llvm-objdump-18 -dS ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso | head -20

~/.debug/[vdso]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso:      file format elf64-x86-64

Disassembly of section .text:

00000000000006d0 <.text>:
    6d0: 48 8d 3d 29 d9 ff ff          leaq    -0x26d7(%rip), %rdi     # 0xffffffffffffe000
    6d7: eb 19                         jmp     0x6f2 <.text+0x22>
    6d9: 4c 8b 0d 28 d9 ff ff          movq    -0x26d8(%rip), %r9      # 0xffffffffffffe008
    6e0: 4c 8b 05 29 d9 ff ff          movq    -0x26d7(%rip), %r8      # 0xffffffffffffe010
    6e7: 0f 01 f9                      rdtscp
    6ea: 66 90                         nop
    6ec: 8b 0f                         movl    (%rdi), %ecx
    6ee: 39 ce                         cmpl    %ecx, %esi
    6f0: 74 0e                         je      0x700 <.text+0x30>
    6f2: 8b 37                         movl    (%rdi), %esi
    6f4: 85 f6                         testl   %esi, %esi
    6f6: 75 e1                         jne     0x6d9 <.text+0x9>
    6f8: 48 c7 c0 ff ff ff ff          movq    $-0x1, %rax
    6ff: c3                            retq
$ sudo ln -s /lib/modules/6.9.2-local/build/arch/x86/entry/vdso/vdso64.so.dbg /usr/lib/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.debug
$ llvm-objdump-18 -dS ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso | head -20                                                       

~/.debug/[vdso]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso:      file format elf64-x86-64

Disassembly of section .text:

00000000000006d0 <vread_hvclock>:
; hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
    6d0: 48 8d 3d 29 d9 ff ff          leaq    -0x26d7(%rip), %rdi     # 0xffffffffffffe000 <hvclock_page>
    6d7: eb 19                         jmp     0x6f2 <vread_hvclock+0x22>
;               scale = READ_ONCE(tsc_pg->tsc_scale);
    6d9: 4c 8b 0d 28 d9 ff ff          movq    -0x26d8(%rip), %r9      # 0xffffffffffffe008 <hvclock_page+0x8>
;               offset = READ_ONCE(tsc_pg->tsc_offset);
    6e0: 4c 8b 05 29 d9 ff ff          movq    -0x26d7(%rip), %r8      # 0xffffffffffffe010 <hvclock_page+0x10>
;       asm volatile(ALTERNATIVE_2("rdtsc",
    6e7: 0f 31                         rdtsc
    6e9: 90                            nop
    6ea: 90                            nop
    6eb: 90                            nop
;       } while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
    6ec: 8b 0f                         movl    (%rdi), %ecx
$

Would that solve your problem?

Notably, later versions of llvm-objdump have an option
--debug-file-directory which makes it possible to
have the debug info in a directory owned by the user,
for example:

$ sudo rm /usr/lib/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.debug
$ llvm-objdump-18 -dS ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso | head -20

~/.debug/[vdso]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso:      file format elf64-x86-64

Disassembly of section .text:

00000000000006d0 <.text>:
    6d0: 48 8d 3d 29 d9 ff ff          leaq    -0x26d7(%rip), %rdi     # 0xffffffffffffe000
    6d7: eb 19                         jmp     0x6f2 <.text+0x22>
    6d9: 4c 8b 0d 28 d9 ff ff          movq    -0x26d8(%rip), %r9      # 0xffffffffffffe008
    6e0: 4c 8b 05 29 d9 ff ff          movq    -0x26d7(%rip), %r8      # 0xffffffffffffe010
    6e7: 0f 01 f9                      rdtscp
    6ea: 66 90                         nop
    6ec: 8b 0f                         movl    (%rdi), %ecx
    6ee: 39 ce                         cmpl    %ecx, %esi
    6f0: 74 0e                         je      0x700 <.text+0x30>
    6f2: 8b 37                         movl    (%rdi), %esi
    6f4: 85 f6                         testl   %esi, %esi
    6f6: 75 e1                         jne     0x6d9 <.text+0x9>
    6f8: 48 c7 c0 ff ff ff ff          movq    $-0x1, %rax
    6ff: c3                            retq
$ mkdir -p /tmp/debug/.build-id/cf/
$ ln -s /lib/modules/6.9.2-local/build/arch/x86/entry/vdso/vdso64.so.dbg /tmp/debug/.build-id/cf/702469f4637840fd6ba1a8d8a628ff83253d04.debug        
$ llvm-objdump-18 --debug-file-directory /tmp/debug -dS ~/.debug/\[vdso\]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso | head -20

~/.debug/[vdso]/cf702469f4637840fd6ba1a8d8a628ff83253d04/vdso:      file format elf64-x86-64

Disassembly of section .text:

00000000000006d0 <vread_hvclock>:
; hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
    6d0: 48 8d 3d 29 d9 ff ff          leaq    -0x26d7(%rip), %rdi     # 0xffffffffffffe000 <hvclock_page>
    6d7: eb 19                         jmp     0x6f2 <vread_hvclock+0x22>
;               scale = READ_ONCE(tsc_pg->tsc_scale);
    6d9: 4c 8b 0d 28 d9 ff ff          movq    -0x26d8(%rip), %r9      # 0xffffffffffffe008 <hvclock_page+0x8>
;               offset = READ_ONCE(tsc_pg->tsc_offset);
    6e0: 4c 8b 05 29 d9 ff ff          movq    -0x26d7(%rip), %r8      # 0xffffffffffffe010 <hvclock_page+0x10>
;       asm volatile(ALTERNATIVE_2("rdtsc",
    6e7: 0f 31                         rdtsc
    6e9: 90                            nop
    6ea: 90                            nop
    6eb: 90                            nop
;       } while (READ_ONCE(tsc_pg->tsc_sequence) != sequence);
    6ec: 8b 0f                         movl    (%rdi), %ecx
$


