Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8237C0FB;
	Tue, 20 Jan 2026 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891592; cv=none; b=jc2S413KSq4QWb83Egbnu+WhMOqOI8iZvkZQhgnx8l1Xq/PQ+JO3L6jgnP4NYAnkasqi09FxWpVtiMKInkuTKMhvCzngzKAlJAoZwxpdvMuh8UCgvW/HJbfp0EMu/Dc6Fk7YI0BvsKgsQTHRBO+nE0yNW1pHIwo5NAEZwefU5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891592; c=relaxed/simple;
	bh=nAEc4iLDYAvBma7oDJBG5Opm7DUkGt3ley7QP4eA4jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5NQYjo04nJ8QMz80FC8ST1+53Om0tJ/hnNSm+PS105BLK7ER5i7iluFcai2VXH2G4/kLVrVQENATV2la0lFRrkgzPoN4n7pscE7ahjsKQncI95U2tYzmNHpPLGyJd+tMEC/8P9bWXXfhbbS3iHFIq4hFbPdz69gZvxVRiQzVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXnmx6Bb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXnmx6Bb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768891587; x=1800427587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nAEc4iLDYAvBma7oDJBG5Opm7DUkGt3ley7QP4eA4jk=;
  b=RXnmx6BbHdmRqN2Y6TevsnDdaOcVHaUfdbjK6ElvXrXQ9dP4f5gOiwZ7
   hGrB3XP0w5sHxCI6PbEmZ/xaEALuCz2mopgdsyPNPoemoYmg1Y8908Dja
   ZIHxrNHmx/C9yNSJVmGZizgb7HEOkTxj62spKnPYU8Fh1TSHXcpXKoCeS
   0VU/QHLxCiDK/BVx7RrIkT4rVFXDeZvyxJphP1m8AYSnqsPdzBcyccAfd
   MIzMVgGyaxH66yAWVy7DZztlA4GyF4HCc4NV57R5eEwDKp1Yyt0D0YL5Z
   SNr2s8o3/6erEzfJbvsNE67keUCCoGH7wvjYDf/OkixP0/MW02AW55pdt
   Q==;
X-CSE-ConnectionGUID: 8DcyA4izRnOmcZgxW+E7xQ==
X-CSE-MsgGUID: Ig6g4/1WROGHcMqomsP5Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70144096"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70144096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:46:18 -0800
X-CSE-ConnectionGUID: vE4ywRtyRvW3RlR4Bf62Sw==
X-CSE-MsgGUID: PbQj8k4/Tlq+llX/Jl9M8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="243634171"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:46:12 -0800
Message-ID: <a11ddf44-e553-4a9c-a70f-824295317d4f@linux.intel.com>
Date: Tue, 20 Jan 2026 14:46:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 18/19] perf parse-regs: Support new SIMD sampling
 format
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com>
 <CAP-5=fU+JeBqCNfKVR9O2cd0zzPO1bsYORtEBzeTeTpMLg4m5Q@mail.gmail.com>
 <0a99aaac-d51c-4c65-addd-5e366408a3f0@linux.intel.com>
 <CAP-5=fV_dbFzQ8_xHsduFytEq+6H0M0iPof0Krb0dBB+Bsd42g@mail.gmail.com>
 <3d95b037-e1c1-40db-b357-889c62c70221@linux.intel.com>
 <CAP-5=fW5g-_Owf2wWtXZwpbtTy9uns_pqr=BFumohHxWGU+i0Q@mail.gmail.com>
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com>
 <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
 <8b932ae4-5f65-454e-ae9e-0d9377a92254@linux.intel.com>
 <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
 <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com>
 <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com>
 <CAP-5=fUNeJpj-rdi+552-o9xhCiT41q-Q8Zhg8U7ev0Wbiyhog@mail.gmail.com>
 <478c90df-61a8-4e19-a640-931ce791fe97@linux.intel.com>
 <CAP-5=fXNTSA4wGW+HWS_UdV-iR940A1Td9wgyHOsVbhM0QjE3g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fXNTSA4wGW+HWS_UdV-iR940A1Td9wgyHOsVbhM0QjE3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/20/2026 1:16 PM, Ian Rogers wrote:
> On Mon, Jan 19, 2026 at 7:05 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/20/2026 4:25 AM, Ian Rogers wrote:
>>> On Sun, Jan 18, 2026 at 10:55 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 1/17/2026 1:50 PM, Ian Rogers wrote:
>>>>> On Mon, Jan 5, 2026 at 11:27 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>>>> Ian,
>>>>>>
>>>>>> I looked at these perf regs __weak helpers again, like
>>>>>> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard to
>>>>>> eliminate these __weak helpers and convert them into a generic function
>>>>>> like perf_reg_name(). All these __weak helpers are arch-dependent and
>>>>>> usually need to call perf_event_open sysctrl to get the required registers
>>>>>> mask. So even we convert them into a generic function, we still have no way
>>>>>> to get the registers mask of a different arch, like get x86 registers mask
>>>>>> on arm machine. Another reason is that these __weak helpers may contain
>>>>>> some arch-specific instructions. If we want to convert them into a general
>>>>>> perf function like perf_reg_name(). It may cause building error since these
>>>>>> arch-specific instructions may not exist on the building machine.
>>>>> Hi Dapeng,
>>>>>
>>>>> There was already a patch to better support cross architecture
>>>>> libdw-unwind-ing and I've just sent out a series to clean this up so
>>>>> that this is achieved by having mapping functions between perf and
>>>>> dwarf register names. The functions use the e_machine of the binary to
>>>>> determine how to map, etc. The series is here:
>>>>> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
>>>>> and I think it can be the foundation for avoiding the weak functions.
>>>> Hi Ian,
>>>>
>>>> Thanks for the reference patch. But they are different. The reference
>>>> patches mainly parse the regs from perf.data and the __weak functions can
>>>> be eliminated in the parsing phase since the registers bitmap is fixed for
>>>> a fixed arch. While these __weak functions
>>>> arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the support
>>>> sampling registers on a specific platform.
>>>>
>>>> We know different platforms even for same arch may support different
>>>> registers, e.g., some x86 platforms may only support XMM registers, but
>>>> some others may support XMM/YMM/ZMM registers, then all these arch-specific
>>>> arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend on the
>>>> perf_event_open() syscall to retrieve the supported registers mask from kernel.
>>>>
>>>> Thus, it becomes impossible to retrieve the supported registers mask for a
>>>> x86 specific platform from running on a arm platform.
>>>>
>>>> Even we don't consider this limitation and forcibly convert the
>>>> __weak arch__intr_reg_mask() function to some kind of below function, just
>>>> like currently what perf_reg_name() does.
>>>>
>>>> uint64_t perf_intr_reg_mask(const char *arch)
>>>> {
>>>>     uint64_t mask = 0;
>>>>
>>>>     if (!strcmp(arch, "csky"))
>>>>         mask = perf_intr_reg_mask_csky(id);
>>>>     else if (!strcmp(arch, "loongarch"))
>>>>         mask = perf_intr_reg_mask_loongarch(id);
>>>>     else if (!strcmp(arch, "mips"))
>>>>         mask = perf_intr_reg_mask_mips(id);
>>>>     else if (!strcmp(arch, "powerpc"))
>>>>         mask = perf_intr_reg_mask_powerpc(id);
>>>>     else if (!strcmp(arch, "riscv"))
>>>>         mask = perf_intr_reg_mask_riscv(id);
>>>>     else if (!strcmp(arch, "s390"))
>>>>         mask = perf_intr_reg_mask_s390(id);
>>>>     else if (!strcmp(arch, "x86"))
>>>>         mask = perf_intr_reg_mask_x86(id);
>>>>     else if (!strcmp(arch, "arm"))
>>>>         mask = perf_intr_reg_mask_arm(id);
>>>>     else if (!strcmp(arch, "arm64"))
>>>>         mask = perf_intr_reg_mask_arm64(id);
>>>>
>>>>     return mask;
>>>> }
>>>>
>>>> But currently there are some arch-dependent instructions in these
>>>> arch-specific instructions, like the below code in powerpc specific
>>>> arch__intr_reg_mask().
>>>>
>>>>     version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>>>>
>>>> mfspr is a powerpc specific instruction, building this converted
>>>> perf_intr_reg_mask on non-powerpc platform would lead to building error.
>>> Hi Dapeng,
>>>
>>> So my main point is the arch directory and ifdefs, how do they differ
>>> from writing code that uses the ELF machine? For example, your code
>>> uses the arch/x86 directory and has ifdefs on
>>> HAVE_ARCH_X86_64_SUPPORT. How is that different from:
>>> ```
>>> switch(e_machine) {
>>> case EM_X86_64:
>>> ...
>>> case EM_I386:
>>> ...
>>> default:
>>> return 0;
>>> }
>>> ```
>>> If we need to determine for the current running machine then e_machine
>>> can equal EM_HOST that is set up for this purpose.
>> I think the key factor that determines if we can convert the code into
>> above e_machine switch ... case format is whether the code is
>> architecture-dependent both in building and execution phases.
>>
>> If the code is not architecture-dependent, It's good to covert the code
>> into the e_machine switch ... case and that would provide better applicability.
>>
>> Otherwise, the architecture-dependent code would lead to the building error
>> (building phase) or get incorrect execution results (execution phase).
>>
>> Even if we introduce EM_HOST case, it won't really solve the building
>> error,  instead it may introduce new building error, e.g.,
>>
>> ```
>> switch(e_machine) {
>> case EM_HOST:
>> ...
>> case EM_X86_64:
>> ...
>> case EM_I386:
>> ...
>> default:
>> return 0;
>> }
>> ```
> No, you wouldn't put EM_HOST as a case statement ever. It is the value
> of the ELF machine you are compiling upon, so either EM_X86_64 or
> EM_I386 here. You would make `e_machine = EM_HOST` were you to want
> some which is specific to the host you are compiling upon. ie `if
> (EM_HOST == EM_X86_64 || EM_HOST == EM_I386) { ... }` would be
> equivalent to `#ifdef __x86_64__` or equivalent to putting code into
> the arch/x86 directory.

The difference between  `if (EM_HOST == EM_X86_64 || EM_HOST == EM_I386) {
... }` with  `#ifdef __x86_64__` or equivalent __weak functions is on the
building phase. All the "if (EM_HOST == EM_X86_64 || EM_HOST == EM_I386) {
... }" code would be built on any architectural platforms, i.e., the x86
specific code could need to be build on ARM platform. If there are
arch-specific code, then the building would fail, e.g., there are below
code in powerpc specific arch__intr_reg_mask() function.

    version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);

mfspr is a powerpc specific instruction and it would get building error if building on the other arch platforms.

To avoid the building error, we have to introduce the #ifdef again.


I ever tried to covert the __weak arch__intr_reg_mask() functions into the below function.

```
uint64_t perf_intr_reg_mask(const char *arch)
{
    uint64_t mask = 0;

    if (!strcmp(arch, "csky"))
        mask = perf_intr_reg_mask_csky(arch);
    else if (!strcmp(arch, "loongarch"))
        mask = perf_intr_reg_mask_loongarch(arch);
    else if (!strcmp(arch, "mips"))
        mask = perf_intr_reg_mask_mips(arch);
    else if (!strcmp(arch, "powerpc"))
        mask = perf_intr_reg_mask_powerpc(arch);
    else if (!strcmp(arch, "riscv"))
        mask = perf_intr_reg_mask_riscv(arch);
    else if (!strcmp(arch, "s390"))
        mask = perf_intr_reg_mask_s390(arch);
    else if (!strcmp(arch, "x86"))
        mask = perf_intr_reg_mask_x86(arch);
    else if (!strcmp(arch, "arm"))
        mask = perf_intr_reg_mask_arm(arch);
    else if (!strcmp(arch, "arm64"))
        mask = perf_intr_reg_mask_arm64(arch);

    return mask;
}
```

But this causes the building error for the perf_intr_reg_mask_powerpc() on x86 platform since the powerpc specific mfspr instruction. A way to fix the building error is to introduce the "#ifdef __powerpc__", maybe like this,

#ifdef __powerpc__

uint64_t perf_intr_reg_mask(const char *arch)
{
	...
}

#else

uint64_t perf_intr_reg_mask(const char *arch)
{
	return 0;
}
#endif

Do you think it's a correct way to handle the issue?

>
>> Assume the code is built on a x86_64 machine, then EM_HOST equals
>> EM_X86_64, that would cause the "duplicate case value" building error.
>>
>> If we want to limit the architecture-dependent code is built only on the
>> correct architecture, then we still have to introduce the architecture
>> #ifdefs. This is actually no difference with current arch directory __weak
>> functions and make it more complex.
> If we have arch functions for  arch__user_simd_reg_mask then why would
> code go through the usual means to determine what the mask is? The
> normal means is to get a sample event, use evsel__parse_sample and
> then from the sample access struct regs_dump that has within it keeps
> a copy of the mask from perf_event_attr associated with the evsel.
>
> In your next patch you do:
> https://lore.kernel.org/lkml/20251203065500.2597594-20-dapeng1.mi@linux.intel.com/
> ```
> ...
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> ...
> +static void simd_regs_dump__printf(struct regs_dump *regs, bool intr)
> +{
> ...
> + if (intr)
> + arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
> + else
> + arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
> ...
>  ```
> The session code is generic, it may be dealing with live machine data
> or with a perf.data file from anywhere. The reason this patch is
> exposing these weak functions is for the next patch, there's not a use
> here. But why isn't the next patch using struct regs_dump? The struct
> regs_dump was set up with sample event and perf_event_attr on hand.
> The evsel__parse_sample logic should likely set up a qwords variable
> so the generic code can just do:
> ```
> qwords = regs->qwords;
> ```
> The parsing logic should be able to do "nr_vectors * vector_qwords +
> nr_pred * pred_qwords" from the perf_event_attr no?

The arch__intr_simd_reg_bitmap_qwords() are also used in this patch,  like
the below code

```

static void __print_simd_regs(bool intr, uint64_t simd_mask)
{
    const struct sample_reg *r = NULL;
    uint64_t bitmap = 0;
    u16 qwords = 0;
    int reg_idx;

    if (!simd_mask)
        return;

    for (r = arch__sample_simd_reg_masks(); r->name; r++) {
        if (!(r->mask & simd_mask))
            continue;
        reg_idx = fls64(r->mask) - 1;
        if (intr)
            bitmap = arch__intr_simd_reg_bitmap_qwords(reg_idx, &qwords);
        else
            bitmap = arch__user_simd_reg_bitmap_qwords(reg_idx, &qwords);
        if (bitmap)
            fprintf(stderr, "%s0-%d ", r->name, fls64(bitmap) - 1);
    }
}

```

But I agree this can be convert some kind of generic functions. Let me try
to do it in next version.

>
>>> I agree that determining features needs calls that may not be
>>> supported on other architectures. That should yield EOPNOTSUPP and we
>>> can use information like that to populate generic information like the
>>> PMU missing features:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n190
>>> we also probe API support with:
>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/perf_api_probe.h?h=perf-tools-next
>> In general, I agree we can return EOPNOTSUPP or some generic information
>> for some architecture independent code. But it's not applicable for these 2
>> specific arch__intr_reg_mask()/arch__user_reg_mask() functions, current
>> perf code depends on these 2 functions to return the supported registers
>> mask on a specific (running) platform.
> You can't put code into generic code like session and assume the
> perf.data is for the running machine, so the design is wrong.

Ok, let me try to convert them a generic function.


>
>>> The current code doing lots of string comparisons is unnecessary
>>> overhead and imprecise (x86 is used for both 32-bit and 64-bit x86).
>>> It is removed in the series I linked to, I think we can eventually get
>>> rid of the whole arch string for similar reasons of trying to minimize
>>> the use of the arch directory. I'm curious what happens with APX, will
>>> the e_machine change? We may need to pass in the sample regs_dump's
>>> abi field for cases like this.
>> Yes, I agree we should git rid of the arch-string comparison and minimize
>> the use of arch directory. It would improve the efficiency.
>>
>> I don't think the support of APX would change the e_machine, it should
>> still be EM_X86_64.
>>
>> Yes, we need the abi filed (exactly PERF_SAMPLE_REGS_ABI_SIMD) to determine
>> it's APX or legacy XMM.
> Right, in my (unmerged) code to map a perf register to a dwarf register:
> https://lore.kernel.org/lkml/20260117052849.2205545-13-irogers@google.com/
> we'll need the abi field.

Let me try to add the change in the next version.


>
>>> My point on the unwinding is that the sample register mask appears to
>>> be set up the same regardless, whereas for stack samples
>>> (--call-graph=dwarf) maybe just sample IP and SP suffices. So perhaps
>>> there should be additional registers to set up the sample mask.
>> Yes, that's true. It can be further optimized.
>>
>>
>>> By avoiding the arch functions we can avoid the problem of broken
>>> cross architecture support, we can also lay the groundwork for support
>>> on different architectures that may want to do similar things. I agree
>>> that doesn't matter until >1 architecture is trying to have more
>>> register masks, my concern is trying to keep the code generic and
>>> trying to make sure cross architecture is working. New weak functions
>>> is going in the opposite direction to that.
>> Yes, I agree we should git rid of these arch functions as much as possible.
>> But for these architecture dependent code (as above shows), it seems the
>> __weak functions are still the simplest and best way to handle them.
> So I don't think we should be putting functions that assume the
> running machine into generic code like session. The arch functions
> create a shortcut that avoids looking at the perf_event_attr,
> differences between EM_I386 and EM_X86_64, etc. I'm not sure simpler
> matters here, the code is just incorrect relative to how things are
> being done around it. How do I grab registers on an APX capable
> machine and then dump it on my non-APX laptop? How do the arch
> functions account for the differences between EM_I386 and EM_X86_64,
> both of which process types may be running on the machine at the same
> time and having samples show up in system-wide mode? Having the arch
> functions lets things be done wrong and the patch series shows that in
> the very next patch.
>
> Thanks,
> Ian
>
>> Thanks.
>>
>>> Thanks,
>>> Ian
>>>
>>>> -Dapeng Mi
>>>>
>>>>> I also noticed that I think we're sampling the XMM registers for dwarf
>>>>> unwinding, but it seems unlikely the XMM registers will hold stack
>>>>> frame information - so this is probably an x86 inefficiency.
>>>>>
>>>>> Thanks,
>>>>> Ian
>>>>>
