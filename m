Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C03B2BA;
	Tue, 27 Jan 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475255; cv=none; b=u1ytUVNtjUEE0xHBVL8nXIzvjzyqcBn/ygjDKGoi5vGD71FAQwXM/HIrQR+rpdmDA98zynUYJemH+H9uDR9htIr+AUbQTBiWnuTsLjidlh1cXmAhCcGZiMOhjWly+uRegX7bGzyJVOSWVZb3xPrvokPxeKN6tjmmLZyd7LToqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475255; c=relaxed/simple;
	bh=UG670THUM6Hd5seCbw9urgOHuUyuGqKILAFzgCZJTEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc35PnLU90jouGzLxkjJ3DEE8t+GV5j2syLODFqqKwwt+dyq67WZwkeFah14ufeH9tyzsyN/A7NfHaTR1yu1uo/ST8Bs0NbzQXjcu5Wzsft7g37PZHfxDSjROInwasR4UO+KhI221a+Lfw+7F6vcudj/RpgpenHPJ0Z/8O9+7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gg99OoGW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gg99OoGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769475254; x=1801011254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UG670THUM6Hd5seCbw9urgOHuUyuGqKILAFzgCZJTEQ=;
  b=gg99OoGWCvl/FZ8deEkOGgnFfK2J9zUCdO+K85N/ezGSBNNkavCpzmwu
   04Lq5/NidcZb3yPYBbgAb8F02d0myFLN57vxXsUrz+yf4HHJg8RAvYxZu
   byWb0WjtEO+E7qDBuQX1gczDcR5oh2tEKEeJejmdn0J09uTDD+f2COwFK
   RuOhKozaoROO5b70sA79Qd9kFIDrpjTxOhX+u8F/oJBc4mFEmtB0KO+qJ
   ds8BhXeog70wnrqh+psEl0B/HKnC9wTgu6mos4eezMWEEoD2eXUHOjV/l
   3CGvK33CfMoGAQLnIc319WmpAtYoxds22pwsdxK8zgL6uzKbw/1pDWG5v
   Q==;
X-CSE-ConnectionGUID: oVxma5TTSn2Sclqk975/BA==
X-CSE-MsgGUID: Sm9YjQYfQ8ul5KojDhAr3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81380279"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="81380279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:54:13 -0800
X-CSE-ConnectionGUID: dwna1jZ3SqSwIBw1BsTLRA==
X-CSE-MsgGUID: BuSNRU5KSbiyUDxhs4dp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="206949406"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 16:54:10 -0800
Message-ID: <ab3db115-65b4-485d-ad78-0d14f40b2f8a@linux.intel.com>
Date: Tue, 27 Jan 2026 08:54:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC Patch] perf regs: Remove __weak attribute from perf-regs
 functions
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260123090938.2222960-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fWMvuMXU405nu8hsysnq3id_3A1Uj4H5mTCDY3Chsfe-w@mail.gmail.com>
 <4fa47f77-fa1c-43d2-992e-de166613dda8@linux.intel.com>
 <CAP-5=fVmVnFQOp82rdrnq=cLiQq+jq0fLJXUWGwV+Q+U+yHwTQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVmVnFQOp82rdrnq=cLiQq+jq0fLJXUWGwV+Q+U+yHwTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/27/2026 1:17 AM, Ian Rogers wrote:
> On Sun, Jan 25, 2026 at 9:20 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>
>> On 1/24/2026 8:39 AM, Ian Rogers wrote:
>>> On Fri, Jan 23, 2026 at 1:13 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
> [snip]
>>>> diff --git a/tools/arch/arm64/include/uapi/asm/perf_regs.h b/tools/arch/arm64/include/uapi/asm/perf_regs.h
>>>> index 86e556429e0e..43e8e08f52ed 100644
>>>> --- a/tools/arch/arm64/include/uapi/asm/perf_regs.h
>>>> +++ b/tools/arch/arm64/include/uapi/asm/perf_regs.h
>>>> @@ -43,6 +43,6 @@ enum perf_event_arm_regs {
>>>>         PERF_REG_ARM64_EXTENDED_MAX
>>>>  };
>>>>
>>>> -#define PERF_REG_EXTENDED_MASK (1ULL << PERF_REG_ARM64_VG)
>>>> +#define PERF_ARM64_REG_EXTENDED_MASK   (1ULL << PERF_REG_ARM64_VG)
>>> I think avoiding the conflicts by adding the architecture name is correct.
>> Yes, but the side effect is that there would be mismatch with the
>> corresponding kernel header file. Not sure if someone dislike it ...
> It should be possible to update the kernel headers too rather than
> have them out-of-sync with the perf ones. Someone might object but it
> doesn't seem unreasonable to make the changes to me :-)

Ok, let me do this and look at if someone doesn't like it. Thanks.


>
>>>> Additionally, there could be architecture-specific instructions called,
>>>> such as the "mfspr" instruction on PowerPC, which causes build errors on
>>>> other platforms like x86.
>>> Right, the mfspr is used to add additional registers into the mask and
>>> if we're not on a powerpc and can't run it we should assume something
>>> conservative which your change will achieve. Fwiw, I tried to see if
>>> similar information was available from say the ELF header, but I
>>> couldn't see it.
>>>
>>> With your SIMD changes and common functions you can refactor the
>>> function signature to take the e_machine and also the perf ABI enum
>>> value, then the mapping of either an XMM register string or SSP should
>>> be possible by varying the ABI enum value. You'll also know to fix up
>>> all the callers on the reading perf.data side to pass the enum value
>>> as the code won't compile with the missing parameter.
>> Yes, if we decide to use this way, the SIMD/eGPRs support would follow same
>> way.
> Great, thanks.
>
> [snip]
>
>>> I think it would be nice for the SDT clean up to be a distinct patch
>>> from the arch__user_reg_mask/arch__intr_reg_mask clean up. If there
>>> are regressions it will be easier to bisect.
>> Sure. Would split them in V2.
> Thanks!
> Ian
