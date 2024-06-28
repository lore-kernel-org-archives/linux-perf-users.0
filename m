Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A591C9EB7;
	Fri, 28 Jun 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595687; cv=none; b=M/r/z+P8+XzE6ne0c4kdwq09u7LiJtukC8id5x0EshRUrbhZBLH2btfRW774MkSAyevfVswwnIdN4Hjl0hGoFqDpo0o8rIXsMswq29BjzaYLhLsANHuytyaOq58x2v2MaQHrNkWKzbqHGZU9ZMTTxV5zw5DUKhrMf4rvuLEQLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595687; c=relaxed/simple;
	bh=MDSkmkjQeNK2pLssJRhhqoKutOF8efETS3qkABWcgHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmGjH86dkOoqdnxnGi3/0IU/bQZ6Fa0kRJMLKUVKXUtkKMXhE2R27In7GZpKT2MYJpWZU8t+6InLdDAnyEkr5vsSrk8iaqtxu33tJYs5H8Su7LwZ3D8AvcnDN9Kol3+WrZchRkt67DBpC6w0MMSVTjVoQdqZka1rC78lzaNA0mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB2vOaNJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB2vOaNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719595686; x=1751131686;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MDSkmkjQeNK2pLssJRhhqoKutOF8efETS3qkABWcgHc=;
  b=lB2vOaNJAOfwJA6lgUrxOWQBQprL2+G4J+UKWn6Jsjc8+qZckRy0Ey0F
   eoGeBkT5xMYuaQEzNNXGazX+fMJKvwxQwwsSGjAMqX0/yFN/I/P+s8IO/
   iTcQZiIprswaBVkMAeUXOtedQfYpMVxxo9Swjc904c3cU8KMtKyj0DP9J
   g26LnsHw1OEl0q7hY7CL3ZuZ24RN9TU6EffaDzIQAp2C1P3LbYdoFVecs
   RMsw+6/9ecCO0bfLRQLMNf22ikVVBfGwaI6nflRw2G8run5iG9tgZHsNb
   sO0W4MeSHK+aMNlSEa8CtSEXjcxYJcxmFjK9NASbZur8NfU5rKC6cm94u
   Q==;
X-CSE-ConnectionGUID: w8KKz1yXT3exn1MohgOfRA==
X-CSE-MsgGUID: dcacFsq7RIKTgXvxSjN4kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20605363"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="20605363"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:28:06 -0700
X-CSE-ConnectionGUID: +zYI9asqS7yGUyWK400L2Q==
X-CSE-MsgGUID: A8rPVfOUTFadIy5gYosaZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="49141102"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 10:28:01 -0700
Message-ID: <18d0ae92-d764-4151-a2d6-f017b22b4c92@intel.com>
Date: Fri, 28 Jun 2024 20:27:55 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] perf: support specify vdso path in cmdline
To: duchangbin <changbin.du@huawei.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1599b5defa46422eb66885e7430cc70f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/06/24 07:21, duchangbin wrote:
> On Thu, Jun 27, 2024 at 04:53:18PM -0700, Namhyung Kim wrote:
>> Hello guys,
>>
>> On Wed, Jun 26, 2024 at 01:32:42PM +0300, Adrian Hunter wrote:
>>> On 26/06/24 05:26, duchangbin wrote:
>>>> On Tue, Jun 25, 2024 at 04:20:49PM +0300, Adrian Hunter wrote:
>>>>> On 25/06/24 06:37, Changbin Du wrote:
>>>>>> The vdso dumped from process memory (in buildid-cache) lacks debugging
>>>>>> info. To annotate vdso symbols with source lines we need specify a
>>>>>> debugging version.
>>>>>>
>>>>>> For x86, we can find them from your local build as
>>>>>> arch/x86/entry/vdso/vdso{32,64}.so.dbg. Or they may reside in
>>>>>> /lib/modules/<version>/vdso/vdso{32,64}.so on Ubuntu. But notice that
>>>>>> the buildid has to match.
>>>>>>
>>>>>> $ sudo perf record -a
>>>>>> $ sudo perf report --objdump=llvm-objdump \
>>>>>>   --vdso arch/x86/entry/vdso/vdso64.so.dbg,arch/x86/entry/vdso/vdso32.so.dbg
>>>>>>
>>>>>> Samples: 17K of event 'cycles:P', 4000 Hz, Event count (approx.): 1760
>>>>>> __vdso_clock_gettime  /work/linux-host/arch/x86/entry/vdso/vdso64.so.d
>>>>>> Percent│       movq    -48(%rbp),%rsi
>>>>>>        │       testq   %rax,%rax
>>>>>>        │     ;               return vread_hvclock();
>>>>>>        │       movq    %rax,%rdx
>>>>>>        │     ;               if (unlikely(!vdso_cycles_ok(cycles)))
>>>>>>        │     ↑ js      eb
>>>>>>        │     ↑ jmp     74
>>>>>>        │     ;               ts->tv_sec = vdso_ts->sec;
>>>>>>   0.02 │147:   leaq    2(%rbx),%rax
>>>>>>        │       shlq    $4, %rax
>>>>>>        │       addq    %r10,%rax
>>>>>>        │     ;               while ((seq = READ_ONCE(vd->seq)) & 1) {
>>>>>>   9.38 │152:   movl    (%r10),%ecx
>>>>>>
>>>>>> When doing cross platform analysis, we also need specify the vdso path if
>>>>>> we are interested in its symbols.
>>>>>
>>>>> Would it be possible to add vdso and vdso debug to the build-id
>>>>> cache and ensure perf can find it there?
>>>>>
>>>>> Typically, getting dsos from another machine is handled via
>>>>> build-id cache e.g. what perf-archive does
>>>>>
>>>> Hmm. I agree this is better alternative approach for cross-machine analysis.
>>>> When collecting vdsos to buildid cache, I think we can use the local searched
>>>> objects (with debug symbols) instead if its build-id matches vdsos from process
>>>> dumping (the real code ran).
>>>>
>>>> Currently I just follow what perf does for vmlinux so to reuse most of existing
>>>> code. Maybe vmlinux is too big to add to buildid-cahce?
>>>>
>>>> Can we keep our current strategy for now? I'll think about above options when
>>>> I have more time.
>>>>
>>>
>>> I tried adding vdso via perf buildid-cache.  It doesn't work only
>>> because the lookup expects the basename to be "vdso" but it is
>>> "elf".
>>>
>>> Adding a link from "vdso" to "elf" made it work e.g.
>>>
>>> $ cat gettimeofday-test.c
>>> #include <stdio.h>
>>> #include <sys/time.h>
>>>
>>> int main()
>>> {
>>>         struct timeval tv;
>>>         int ret;
>>>
>>>         ret = gettimeofday(&tv, NULL);
>>>         if (ret == -1) {
>>>                 fprintf(stderr, "gettimeofday failed\n");
>>>                 return 1;
>>>         }
>>>
>>>         printf("%lu.%lu\n", (unsigned long)tv.tv_sec, (unsigned long)tv.tv_usec);
>>>
>>>         return 0;
>>> $ perf record -e intel_pt//u ./gettimeofday-test
>>> 1719397042.892837
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.026 MB perf.data ]
>>> $ perf script --itrace=e
>>> $ perf buildid-cache --remove /lib/modules/6.5.0-41-generic/vdso/vdso64.so
>>> $ perf script --itrace=e
>>> Warning:
>>> 2 instruction trace errors
>>>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>>>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
>>> $ perf buildid-cache --add /lib/modules/6.5.0-41-generic/vdso/vdso64.so
>>> $ perf script --itrace=e
>>> Warning:
>>> 2 instruction trace errors
>>>  instruction trace error type 1 time 525345.386424204 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e8e00 code 5: Failed to get instruction
>>>  instruction trace error type 1 time 525345.386424829 cpu 4 pid 198976 tid 198976 ip 0x7ffddb0e884d code 5: Failed to get instruction
>>> $ cd ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8
>>> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ln -s elf vdso
>>> ~/.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ ls -l
>>> total 36
>>> -rw-r--r-- 1 ahunter ahunter 33272 Jun 26 13:17 elf
>>> -rw-r----- 1 ahunter ahunter     0 Jun 26 13:17 probes
>>> lrwxrwxrwx 1 ahunter ahunter     3 Jun 26 13:18 vdso -> elf
>>> /.debug/.build-id/c3/530aed66e71bfd10af66039f58cc7c4d2eaba8$ cd
>>> $ perf script --itrace=e
>>> $ 
>>>
>>> So maybe a change could be made to build_id_cache__add() to add
>>> the extra link if the file name matches vdso
>>  
>> Thanks for doing this!  I noticed buildid_cache__basename() will handle
>> the name properly once it realizes the file is a vdso.  Maybe we can
>> check the filepath with some patterns, or simply add an command line
>> option to say it's a vdso.
>>
>> Thanks,
>> Namhyung
>>
> I added some tricks for vdso in build_id_cache__add(). It replace vdso object
> with debugging one if found. Is this okay?

perf has support for storing debug files in the build-id
cache using the base name "debug" instead of "elf", so really
it would be better to make that work

> 
> +static char *build_id_cache__find_debug_vdso(const char *sbuild_id)
> +{
> +       char sbuild_id_tmp[SBUILD_ID_SIZE];
> +       struct build_id bid;
> +       int i, ret = 0;
> +
> +       printf("Looking at the vdso_path (%d entries long)\n",
> +                vdso_paths.nr_entries + 1);
> +
> +       for (i = 0; i < vdso_paths.nr_entries; ++i) {
> +               ret = filename__read_build_id(vdso_paths.paths[i], &bid);
> +               if (ret < 0)
> +                       continue;
> +
> +               build_id__sprintf(&bid, sbuild_id_tmp);
> +               if (!strcmp(sbuild_id, sbuild_id_tmp)) {
> +                       printf("Found debugging vdso %s\n", vdso_paths.paths[i]);
> +                       return strdup(vdso_paths.paths[i]);
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
>  int
>  build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
>                     struct nsinfo *nsi, bool is_kallsyms, bool is_vdso,
>                     const char *proper_name, const char *root_dir)
>  {
>         const size_t size = PATH_MAX;
> -       char *filename = NULL, *dir_name = NULL, *linkname = zalloc(size), *tmp;
> +       char *filename = NULL, *dir_name = NULL, *vdso_name = NULL, *linkname = zalloc(size), *tmp;
>         char *debugfile = NULL;
>         int err = -1;
> 
> +       /* replace vdso object with debugging one if found */
> +       if (is_vdso) {
> +               vdso_name = build_id_cache__find_debug_vdso(sbuild_id);
> +               if (vdso_name)
> +                       name = realname = vdso_name;
> +       }
> +
>         if (!proper_name)
>                 proper_name = name;
> 
>>
> 

