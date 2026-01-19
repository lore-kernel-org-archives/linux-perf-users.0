Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1721FF3B;
	Mon, 19 Jan 2026 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768805729; cv=none; b=An+KNZetHvZfh4LVLE9qMvzXSFuNG/C2KTi3gMlg3htgoTsAlLy3upl97KHuGQpF8z6GyV8ygSbcz9/61+xSxDiyoO7FL6wA3K+k1oyZPjGeDMX2zJ6GP0fINeOhLt5S6G8TC1yXydIwF59LnXjafyHhCiZMPk2/XlvJMmrAoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768805729; c=relaxed/simple;
	bh=nDdo1iZZ5lD/kdmbRCe0+JuVKfMihaZeO3ksG2Lf6IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMmOTMH2xXi1n++V/TwvHs+Bu6Tgj5ZGeSC9f5Gr19eL5PnWhBEk1Xymyl1J9q+c8PhX3CqUqbGP/qY6BBbYDxoKYeEZ3YCRiV/ix4vEL52L8QlE/kmdBlQjA7hxvE3CkzmvIyO7J9Vj6clok7n5PT2eIysy5Emb+fgPvTbFbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1TDCwyg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1TDCwyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768805728; x=1800341728;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nDdo1iZZ5lD/kdmbRCe0+JuVKfMihaZeO3ksG2Lf6IQ=;
  b=a1TDCwyg1qYG43roubHf/vbmlz98H2DmbgoRYcjAj/LT2Lh7AHC8myDT
   arvBltcsGIk2mJz/Oh4rVp6MXyYTGaDfFt3ufxSCeT6YBGIw0BMg9SApp
   LBNmgwnNmPoQYOkLs8NyjN1yTo17l5rZ/nMFy15B6u/p45PGksSG4xNog
   wSRFELmHF3c/qnJxK6W8IO1UlSRXAETpDfSs++s4wv9GueTTh+ZJEIIFB
   B+i1dDZ1DnIe8XFcnArHfu0enQSowY/WJBeExK/HcjNwbVXlZLZycoRpu
   qBfB3pt/J8rbMNWa+C8+WYmGjG9cn/RhAX3t7nzkD40Y/zFV+sobxETUf
   g==;
X-CSE-ConnectionGUID: jaJr+nfMTsG68xN5MX2+eA==
X-CSE-MsgGUID: FtkBbmvGS7iX2z6OBBiv8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="80311420"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="80311420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 22:55:27 -0800
X-CSE-ConnectionGUID: 4OYppG4gQu6NbqpSfEP84Q==
X-CSE-MsgGUID: 6wSXoAuaQg6VAhZf2pcB9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="204937801"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 22:55:21 -0800
Message-ID: <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com>
Date: Mon, 19 Jan 2026 14:55:16 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/17/2026 1:50 PM, Ian Rogers wrote:
> On Mon, Jan 5, 2026 at 11:27 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>> Ian,
>>
>> I looked at these perf regs __weak helpers again, like
>> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard to
>> eliminate these __weak helpers and convert them into a generic function
>> like perf_reg_name(). All these __weak helpers are arch-dependent and
>> usually need to call perf_event_open sysctrl to get the required registers
>> mask. So even we convert them into a generic function, we still have no way
>> to get the registers mask of a different arch, like get x86 registers mask
>> on arm machine. Another reason is that these __weak helpers may contain
>> some arch-specific instructions. If we want to convert them into a general
>> perf function like perf_reg_name(). It may cause building error since these
>> arch-specific instructions may not exist on the building machine.
> Hi Dapeng,
>
> There was already a patch to better support cross architecture
> libdw-unwind-ing and I've just sent out a series to clean this up so
> that this is achieved by having mapping functions between perf and
> dwarf register names. The functions use the e_machine of the binary to
> determine how to map, etc. The series is here:
> https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.com/
> and I think it can be the foundation for avoiding the weak functions.

Hi Ian,

Thanks for the reference patch. But they are different. The reference
patches mainly parse the regs from perf.data and the __weak functions can
be eliminated in the parsing phase since the registers bitmap is fixed for
a fixed arch. While these __weak functions
arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the support
sampling registers on a specific platform.

We know different platforms even for same arch may support different
registers, e.g., some x86 platforms may only support XMM registers, but
some others may support XMM/YMM/ZMM registers, then all these arch-specific
arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend on the
perf_event_open() syscall to retrieve the supported registers mask from kernel.

Thus, it becomes impossible to retrieve the supported registers mask for a
x86 specific platform from running on a arm platform.

Even we don't consider this limitation and forcibly convert the
__weak arch__intr_reg_mask() function to some kind of below function, just
like currently what perf_reg_name() does.

uint64_t perf_intr_reg_mask(const char *arch)
{
    uint64_t mask = 0;

    if (!strcmp(arch, "csky"))
        mask = perf_intr_reg_mask_csky(id);
    else if (!strcmp(arch, "loongarch"))
        mask = perf_intr_reg_mask_loongarch(id);
    else if (!strcmp(arch, "mips"))
        mask = perf_intr_reg_mask_mips(id);
    else if (!strcmp(arch, "powerpc"))
        mask = perf_intr_reg_mask_powerpc(id);
    else if (!strcmp(arch, "riscv"))
        mask = perf_intr_reg_mask_riscv(id);
    else if (!strcmp(arch, "s390"))
        mask = perf_intr_reg_mask_s390(id);
    else if (!strcmp(arch, "x86"))
        mask = perf_intr_reg_mask_x86(id);
    else if (!strcmp(arch, "arm"))
        mask = perf_intr_reg_mask_arm(id);
    else if (!strcmp(arch, "arm64"))
        mask = perf_intr_reg_mask_arm64(id);

    return mask;
}

But currently there are some arch-dependent instructions in these
arch-specific instructions, like the below code in powerpc specific
arch__intr_reg_mask().

    version = (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);

mfspr is a powerpc specific instruction, building this converted
perf_intr_reg_mask on non-powerpc platform would lead to building error.

-Dapeng Mi

>
> I also noticed that I think we're sampling the XMM registers for dwarf
> unwinding, but it seems unlikely the XMM registers will hold stack
> frame information - so this is probably an x86 inefficiency.
>
> Thanks,
> Ian
>
