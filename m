Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317744B5A6;
	Sat, 29 Jun 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686841; cv=none; b=Aek5sYZfUpx53Obrd8VdgvhO8/VYIYulcdjwIpfRztFrQ1Y1Sm1z+bfXt/QujRqDmSj3qSgOmUkbIDqCsIlfgz2EA1ls5UUvI+nkG8TatNTbMD6FIjBupikorLUHU23kQdXCUluDzKAMZ9dXrqK7nEqPVvhjBcPUeqZFyvsP9iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686841; c=relaxed/simple;
	bh=E4zUiywCt0sKLcfWlehSQEbDnjUwj7jC0wCrkGpJNuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOaPvGyj7etkCR/f5GasozdyGFlx1/SJ+hfIVii0r2y7YZ3kpfa/tkwah0mR1eSstX/EL3q5UWqmZZiShoFOQKbSD/ZLil9GPE9d2FGBJ2h6j+75k3fd2OpRGCTnWw1TgY4f/h72rxaMTOzBSAnT0+VpoJc7TUwjdepc2qdC89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYZZxRb1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYZZxRb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719686840; x=1751222840;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4zUiywCt0sKLcfWlehSQEbDnjUwj7jC0wCrkGpJNuw=;
  b=hYZZxRb1xD6SDfpTvDpzEadDBlPWN31d3I6TrnzbEaLcAhMhjA0VMxYl
   QiyXQUv9qZe4qH5Z3gRTGUJkZlwUxzTw3nkvM18cQ9/EKbOLNfdwcoPa2
   FvuHTOddWrorThKXxaICEtPrDlH7ik8GGB5O6+9mGKYvO8gCmwSY914MX
   JM7K6CO5c609cayS5nBsKwGNXrVH04cGB3f4Hp3oZs8nGefp6PCCe0HvW
   2zRekQpttrb+UzqyviUCKfADrPPEKSIfkfOE2Xb5x9Dbc1XVOZEGs6Fbd
   FDh3bCITfiLDAG71s1n8Sss/cyeMQzbMPvCAuqIraXnY7c0kvCUX0ipoa
   A==;
X-CSE-ConnectionGUID: OSElh/ZBQISyBJTqIdynQA==
X-CSE-MsgGUID: eCtih6ARTqWEGaTFdDQuZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11118"; a="20609258"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="20609258"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 11:47:19 -0700
X-CSE-ConnectionGUID: shg5fcFPT16nUwGl5IfEgQ==
X-CSE-MsgGUID: k98idGcUR9uZHX9j9E0ahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="44968259"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 11:47:13 -0700
Message-ID: <d7b48d48-1bea-4dec-bf04-ed65602f4c4a@intel.com>
Date: Sat, 29 Jun 2024 21:47:10 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
To: duchangbin <changbin.du@huawei.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "llvm@lists.linux.dev" <llvm@lists.linux.dev>
References: <20240625033740.223009-1-changbin.du@huawei.com>
 <20240625033740.223009-2-changbin.du@huawei.com>
 <5a9e8dae-e9d9-4a97-98f5-d76be9068342@intel.com>
 <7eef4826a2f3494ea1dc92ed98d543fb@huawei.com>
 <05f95eb8-9b4c-4327-a97f-a15654278c41@intel.com>
 <Zn37bj4LER_A1bX1@google.com> <1599b5defa46422eb66885e7430cc70f@huawei.com>
 <18d0ae92-d764-4151-a2d6-f017b22b4c92@intel.com>
 <88e192fb4b82454bbb008b65be94ffae@huawei.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <88e192fb4b82454bbb008b65be94ffae@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/06/24 05:32, duchangbin wrote:
> On Fri, Jun 28, 2024 at 08:27:55PM +0300, Adrian Hunter wrote:
>> On 28/06/24 07:21, duchangbin wrote:
>>> On Thu, Jun 27, 2024 at 04:53:18PM -0700, Namhyung Kim wrote:
>>>> Hello guys,
>>>>
>>>> On Wed, Jun 26, 2024 at 01:32:42PM +0300, Adrian Hunter wrote:
>>>>> On 26/06/24 05:26, duchangbin wrote:
>>>>>> On Tue, Jun 25, 2024 at 04:20:49PM +0300, Adrian Hunter wrote:
>>>>>>> On 25/06/24 06:37, Changbin Du wrote:
>>>>>>>> The vdso dumped from process memory (in buildid-cache) lacks debugging
>>>>>>>> info. To annotate vdso symbols with source lines we need specify a
>>>>>>>> debugging version.
>>>>>>>>
>>>>>>>> For x86, we can find them from your local build as
>>>>>>>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
>>>>>>>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
>>>>>>>> the buildid has to match.
>>>>>>>>
>>>>>>>> $ sudo perf record -a
>>>>>>>> $ sudo perf report --objdump=llvm-objdump \
>>>>>>>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
>>>>>>>>
>>>>>>>> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
>>>>>>>> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
>>>>>>>> Percent│       movq    -48(%rbp),%rsi
>>>>>>>>        │       testq   %rax,%rax
>>>>>>>>        │     ;               return vread_hvclock();
>>>>>>>>        │       movq    %rax,%rdx
>>>>>>>>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>>>>>>>>        │     ↑ js      eb
>>>>>>>>        │     ↑ jmp     74
>>>>>>>>        │     ;               ts->tv_sec = vdso_ts->sec;
>>>>>>>>   0.02 │147:   leaq    2(%rbx),%rax
>>>>>>>>        │       shlq    $4, %rax
>>>>>>>>        │       addq    %r10,%rax
>>>>>>>>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>>>>>>>>   9.38 │152:   movl    (%r10),%ecx
>>>>>>>>
>>>>>>>> When doing cross platform analysis, we also need specify the vdso path if
>>>>>>>> we are interested in its symbols.
>>>>>>>
>>>>>>> Would it be possible to add vdso and vdso debug to the build-id
>>>>>>> cache and ensure perf can find it there?
>>>>>>>
>>>>>>> Typically, getting dsos from another machine is handled via
>>>>>>> build-id cache e.g. what perf-archive does
>>>>>>>
>>>>>> Hmm. I agree this is better alternative approach for cross-machine analysis.
>>>>>> When collecting vdsos to buildid cache, I think we can use the local searched
>>>>>> objects (with debug symbols) instead if its build-id matches vdsos from process
>>>>>> dumping (the real code ran).
>>>>>>
>>>>>> Currently I just follow what perf does for vmlinux so to reuse most of existing
>>>>>> code. Maybe vmlinux is too big to add to buildid-cahce?
>>>>>>
>>>>>> Can we keep our current strategy for now? I'll think about above options when
>>>>>> I have more time.
>>>>>>
>>>>>
>>>>> I tried adding vdso via perf buildid-cache.  It doesn't work only
>>>>> because the lookup expects the basename to be "vdso" but it is
>>>>> "elf".
>>>>>
>>>>> Adding a link from "vdso" to "elf" made it work e.g.
>>>>>
>>>>> $ cat gettimeofday-test.c
>>>>> #include <stdio.h>
>>>>> #include <sys/time.h>
>>>>>
>>>>> int main()
>>>>> {
>>>>>         struct timeval tv;
>>>>>         int ret;
>>>>>
>>>>>         ret = gettimeofday(&tv, NULL);
>>>>>         if (ret == -1) {
>>>>>                 fprintf(stderr, "gettimeofday failed\n");
>>>>>                 return 1;
>>>>>         }
>>>>>
>>>>>         printf("%lu.%lu\n", (unsigned long)tv.tv_sec, (unsigned long)tv.tv_usec);
>>>>>
>>>>>         return 0;
>>>>> $ perf record -e intel_pt//u ./gettimeofday-test
>>>>> 1719397042.892837
>>>>> [ perf record: Woken up 1 times to write data ]
>>>>> [ perf record: Captured and wrote 0.026 MB perf.data ]
>>>>> $ perf script --itrace=e
>>>>> $ perf buildid-cache --remove /lib/modules/6.5.0-41-generic/vdso/vdso64.so
>>>>> $ perf script --itrace=e
>>>>> Warning:
>>>>> 2 instruction trace errors
>>>>>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>>>>>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
>>>>> $ perf buildid-cache --add /lib/modules/6.5.0-41-generic/vdso/vdso64.so
>>>>> $ perf script --itrace=e
>>>>> Warning:
>>>>> 2 instruction trace errors
>>>>>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>>>>>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
>>>>> $ cd ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8
>>>>> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ln -s elf vdso
>>>>> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ls -l
>>>>> total 36
>>>>> -rw-r--r-- 1 ahunter ahunter 33272 Jun 26 13:17 elf
>>>>> -rw-r----- 1 ahunter ahunter     0 Jun 26 13:17 probes
>>>>> lrwxrwxrwx 1 ahunter ahunter     3 Jun 26 13:18 vdso -> elf
>>>>> /.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ cd
>>>>> $ perf script --itrace=e
>>>>> $ 
>>>>>
>>>>> So maybe a change could be made to build_id_cache__add() to add
>>>>> the extra link if the file name matches vdso
>>>>  
>>>> Thanks for doing this!  I noticed buildid_cache__basename() will handle
>>>> the name properly once it realizes the file is a vdso.  Maybe we can
>>>> check the filepath with some patterns, or simply add an command line
>>>> option to say it's a vdso.
>>>>
>>>> Thanks,
>>>> Namhyung
>>>>
>>> I added some tricks for vdso in build_id_cache__add(). It replace vdso object
>>> with debugging one if found. Is this okay?
>>
>> perf has support for storing debug files in the build-id
>> cache using the base name "debug" instead of "elf", so really
>> it would be better to make that work
>>
> My thoughts are:
>   1. add debugging vdso file as "debug" in buildid cache.
>   2. add a new perf config item 'annotate.prefer_debug_file' (default false) to
>      annotate with debugging object files.

Is that needed?  Isn't the debug information read from
the "debug" file?  If not, does that need fixing?

