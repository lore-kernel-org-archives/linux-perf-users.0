Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A443148DD;
	Tue, 20 Jan 2026 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768878305; cv=none; b=bwEaV0A3W6C2GzBtBElfTANi1uKLfNx/XkWFM+cBmzd43iraUxp30yWdIHEJ6+EFG4gFZxg6OS63IazykJ6A36Dmm9jwdvC2TNvSzMaeowmWmmiCaFU0qzRcZiG0n8kHl097i0kiygr8LAerSp0t9xqStPxigs99gVD9zD/6k24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768878305; c=relaxed/simple;
	bh=LstAeh7wJgBNgQ1/CYjE3qP3mCPh0XBZVdy+aAK0vr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdQ6JcIfNc+CqlfSaVGxhrcIclrhD6jSviMhHEXbYyX20PQLr1UWs+jtMzDNykqvhg+Vio0TYSBvEYKCznKYesX+Hkeno1L/5IU19DUK0mIMWucYSGronOKg+7LWnb9I21nTASMXZptaz8MIYXqHJcH0UZKDzIqeIGedOnSKoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh9/kYOE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh9/kYOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768878303; x=1800414303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LstAeh7wJgBNgQ1/CYjE3qP3mCPh0XBZVdy+aAK0vr8=;
  b=Yh9/kYOEDlSYQvuGf0XmAyKeBI+s0eOYhMgf16aZKI8xuWQy978SazlT
   +vkaC/cMnVAhdXp6oroCyWhfNUX0JnhjSArYOIyId58C9afSQXO9ydn5R
   WGoKfkFj++hxbLtadFHvp90sqeS2jVJbFZcN92JrPP5uknugh/27JXnNB
   IO43Z3zhzjKIqiBMNwTnTGTAjhQzl5o6WKCMVjWrqFIYYrUu602UguXnk
   OgzLRuRfcR/kzstjxQJVSjV0GjsVYgroyICKLNAXBbKe7oEWGLtM0Z8Nq
   C2m6U/U1bhBpDe53jzYwrdnm1w9tg0Pf4ff7/J0uSQcVXe/w0up+HcC5T
   Q==;
X-CSE-ConnectionGUID: J56RVftdRGOO1ljbM5ogCg==
X-CSE-MsgGUID: 9jTE4N+gR8Oezsec4wCUfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69282562"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="69282562"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 19:05:02 -0800
X-CSE-ConnectionGUID: zlkMR7hySWivDSB0UthWZw==
X-CSE-MsgGUID: +l7/Lf/XSbCapUJ2PdAm0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="205148453"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 19:04:56 -0800
Message-ID: <478c90df-61a8-4e19-a640-931ce791fe97@linux.intel.com>
Date: Tue, 20 Jan 2026 11:04:53 +0800
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
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com>
 <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fUNeJpj-rdi+552-o9xhCiT41q-Q8Zhg8U7ev0Wbiyhog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/20/2026 4:25 AM, Ian Rogers wrote:
> On Sun, Jan 18, 2026 at 10:55 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/17/2026 1:50 PM, Ian Rogers wrote:
>>> On Mon, Jan 5, 2026 at 11:27 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> Ian,
>>>>
>>>> I looked at these perf regs __weak helpers again, like
>>>> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard to
>>>> eliminate these __weak helpers and convert them into a generic function
>>>> like perf_reg_name(). All these __weak helpers are arch-dependent and
>>>> usually need to call perf_event_open sysctrl to get the required registers
>>>> mask. So even we convert them into a generic function, we still have no way
>>>> to get the registers mask of a different arch, like get x86 registers mask
>>>> on arm machine. Another reason is that these __weak helpers may contain
>>>> some arch-specific instructions. If we want to convert them into a general
>>>> perf function like perf_reg_name(). It may cause building error since these
>>>> arch-specific instructions may not exist on the building machine.
>>> Hi Dapeng,
>>>
>>> There was already a patch to better support cross architecture
>>> libdw-unwind-ing and I've just sent out a series to clean this up so
>>> that this is achieved by having mapping functions between perf and
>>> dwarf register names. The functions use the e_machine of the binary to
>>> determine how to map, etc. The series is here:
>>> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
>>> and I think it can be the foundation for avoiding the weak functions.
>> Hi Ian,
>>
>> Thanks for the reference patch. But they are different. The reference
>> patches mainly parse the regs from perf.data and the __weak functions can
>> be eliminated in the parsing phase since the registers bitmap is fixed for
>> a fixed arch. While these __weak functions
>> arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the support
>> sampling registers on a specific platform.
>>
>> We know different platforms even for same arch may support different
>> registers, e.g., some x86 platforms may only support XMM registers, but
>> some others may support XMM/YMM/ZMM registers, then all these arch-specific
>> arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend on the
>> perf_event_open() syscall to retrieve the supported registers mask from kernel.
>>
>> Thus, it becomes impossible to retrieve the supported registers mask for a
>> x86 specific platform from running on a arm platform.
>>
>> Even we don't consider this limitation and forcibly convert the
>> __weak arch__intr_reg_mask() function to some kind of below function, just
>> like currently what perf_reg_name() does.
>>
>> uint64_t perf_intr_reg_mask(const char *arch)
>> {
>>     uint64_t mask = 0;
>>
>>     if (!strcmp(arch, "csky"))
>>         mask = perf_intr_reg_mask_csky(id);
>>     else if (!strcmp(arch, "loongarch"))
>>         mask = perf_intr_reg_mask_loongarch(id);
>>     else if (!strcmp(arch, "mips"))
>>         mask = perf_intr_reg_mask_mips(id);
>>     else if (!strcmp(arch, "powerpc"))
>>         mask = perf_intr_reg_mask_powerpc(id);
>>     else if (!strcmp(arch, "riscv"))
>>         mask = perf_intr_reg_mask_riscv(id);
>>     else if (!strcmp(arch, "s390"))
>>         mask = perf_intr_reg_mask_s390(id);
>>     else if (!strcmp(arch, "x86"))
>>         mask = perf_intr_reg_mask_x86(id);
>>     else if (!strcmp(arch, "arm"))
>>         mask = perf_intr_reg_mask_arm(id);
>>     else if (!strcmp(arch, "arm64"))
>>         mask = perf_intr_reg_mask_arm64(id);
>>
>>     return mask;
>> }
>>
>> But currently there are some arch-dependent instructions in these
>> arch-specific instructions, like the below code in powerpc specific
>> arch__intr_reg_mask().
>>
>>     version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>>
>> mfspr is a powerpc specific instruction, building this converted
>> perf_intr_reg_mask on non-powerpc platform would lead to building error.
> Hi Dapeng,
>
> So my main point is the arch directory and ifdefs, how do they differ
> from writing code that uses the ELF machine? For example, your code
> uses the arch/x86 directory and has ifdefs on
> HAVE_ARCH_X86_64_SUPPORT. How is that different from:
> ```
> switch(e_machine) {
> case EM_X86_64:
> ...
> case EM_I386:
> ...
> default:
> return 0;
> }
> ```
> If we need to determine for the current running machine then e_machine
> can equal EM_HOST that is set up for this purpose.

I think the key factor that determines if we can convert the code into
above e_machine switch ... case format is whether the code is
architecture-dependent both in building and execution phases.

If the code is not architecture-dependent, It's good to covert the code
into the e_machine switch ... case and that would provide better applicability.

Otherwise, the architecture-dependent code would lead to the building error
(building phase) or get incorrect execution results (execution phase).

Even if we introduce EM_HOST case, it won't really solve the building
error,  instead it may introduce new building error, e.g.,

```
switch(e_machine) {
case EM_HOST:
...
case EM_X86_64:
...
case EM_I386:
...
default:
return 0;
}
```

Assume the code is built on a x86_64 machine, then EM_HOST equals
EM_X86_64, that would cause the "duplicate case value" building error. 

If we want to limit the architecture-dependent code is built only on the
correct architecture, then we still have to introduce the architecture
#ifdefs. This is actually no difference with current arch directory __weak
functions and make it more complex.


>
> I agree that determining features needs calls that may not be
> supported on other architectures. That should yield EOPNOTSUPP and we
> can use information like that to populate generic information like the
> PMU missing features:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n190
> we also probe API support with:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/perf_api_probe.h?h=perf-tools-next

In general, I agree we can return EOPNOTSUPP or some generic information
for some architecture independent code. But it's not applicable for these 2
specific arch__intr_reg_mask()/arch__user_reg_mask() functions, current
perf code depends on these 2 functions to return the supported registers
mask on a specific (running) platform.


>
> The current code doing lots of string comparisons is unnecessary
> overhead and imprecise (x86 is used for both 32-bit and 64-bit x86).
> It is removed in the series I linked to, I think we can eventually get
> rid of the whole arch string for similar reasons of trying to minimize
> the use of the arch directory. I'm curious what happens with APX, will
> the e_machine change? We may need to pass in the sample regs_dump's
> abi field for cases like this.

Yes, I agree we should git rid of the arch-string comparison and minimize
the use of arch directory. It would improve the efficiency.

I don't think the support of APX would change the e_machine, it should
still be EM_X86_64.

Yes, we need the abi filed (exactly PERF_SAMPLE_REGS_ABI_SIMD) to determine
it's APX or legacy XMM.


>
> My point on the unwinding is that the sample register mask appears to
> be set up the same regardless, whereas for stack samples
> (--call-graph=dwarf) maybe just sample IP and SP suffices. So perhaps
> there should be additional registers to set up the sample mask.

Yes, that's true. It can be further optimized.


>
> By avoiding the arch functions we can avoid the problem of broken
> cross architecture support, we can also lay the groundwork for support
> on different architectures that may want to do similar things. I agree
> that doesn't matter until >1 architecture is trying to have more
> register masks, my concern is trying to keep the code generic and
> trying to make sure cross architecture is working. New weak functions
> is going in the opposite direction to that.

Yes, I agree we should git rid of these arch functions as much as possible.
But for these architecture dependent code (as above shows), it seems the
__weak functions are still the simplest and best way to handle them.

Thanks.

>
> Thanks,
> Ian
>
>> -Dapeng Mi
>>
>>> I also noticed that I think we're sampling the XMM registers for dwarf
>>> unwinding, but it seems unlikely the XMM registers will hold stack
>>> frame information - so this is probably an x86 inefficiency.
>>>
>>> Thanks,
>>> Ian
>>>
