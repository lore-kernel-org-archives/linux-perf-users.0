Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC63299929
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379163; cv=none; b=p6N/WB5uNRXR5gyF9JpoQqWWqtDsSKXOPEcKwsKenyCR7fX3cO6Tw6/BSNE5jAqt0MhjZ4GIwXHeROHNCrh6APMUNbCopLcdlSpMW+Z4DmYYH5H+R5OaS2be0f7VvUea4NiE4k8CgkB/iAHsoCpeEoNZhbHERvMwlgqFtmpZzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379163; c=relaxed/simple;
	bh=FHx8m+An1dIlVxJtiZQMLiCikXU+S6uSyHSBB19KgRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHB6O5f8MUbZuSRj5NNaYNaYTe2MaeLNMYlaEODWXOuhInXyQeMbu6kW4PQfuMp5CeraaifHkGUSBrLvpw3DL8S/Tg6QV4jatBywHfGY8Js6F+CfPtEXl4DBz7q/ZXgyX1pZG30Zfn1Ae1NZHGm9gbsGv+GwXVNoroq74aoll64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRW8bTPP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRW8bTPP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780379162; x=1811915162;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FHx8m+An1dIlVxJtiZQMLiCikXU+S6uSyHSBB19KgRA=;
  b=ZRW8bTPPnXNha5vA9/fWS6UUlvGxBWxAy5Tl0tLjkB+JnQCUsX8SL9sz
   OuoNIWKccVUTEGW/Ei1N7B13jkA94ctjyyw8d77ScEx3NKjkgR9jMZEue
   d9Z0HDZRIW9piYnF0cPjsJ/zUOdYu96Ssne1lPEHfotffNKbnhEzDuW4Z
   ZohwB4I0m00nbAVN5Q39YTri0MNfrTcpHG/nQaqws1W3u9ylz8JYd4+fz
   b1v+fpiFx5jr7Y57APZWzMhtXb1OTFrMmCuFh31FRdUUTuxGM5fjLZlce
   yzxkGwjOhNNqNW4mXeqY1MpX7lgIsPKWu7hTIPTih/Ui1bCoskcs2FrAI
   A==;
X-CSE-ConnectionGUID: 5I/q6ghSRlKvhE1vl3xerQ==
X-CSE-MsgGUID: Utxhfh+OQ+efgbbqNozSWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80186702"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="80186702"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:46:01 -0700
X-CSE-ConnectionGUID: 5Yae4jmxRW2eH+rCbjxvjQ==
X-CSE-MsgGUID: UFkqO4qKSVWzi6C586LH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239638190"
Received: from unknown (HELO [10.238.1.64]) ([10.238.1.64])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 22:46:00 -0700
Message-ID: <43217aa4-3613-4906-8e3c-f0d24893c70c@linux.intel.com>
Date: Tue, 2 Jun 2026 13:45:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 4/5] perf regs: Enable dumping of SIMD registers
To: Ian Rogers <irogers@google.com>, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529082451.591783-5-dapeng1.mi@linux.intel.com>
 <20260529112332.140E61F00893@smtp.kernel.org>
 <CAP-5=fXrjHohqOkq+gnxT2DwKMZ=aiEh0rT4FH6bnXFP5hrnhw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fXrjHohqOkq+gnxT2DwKMZ=aiEh0rT4FH6bnXFP5hrnhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/30/2026 1:45 AM, Ian Rogers wrote:
> On Fri, May 29, 2026 at 4:23 AM <sashiko-bot@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>
>> New issues:
>> - [Low] Misleading post-increment of `idx` in `simd_regs_dump__printf` inner loop.
>>
>> Pre-existing issues:
>> - [High] Integer underflow in manual `sample_size` calculation in `perf_event__convert_sample_callchain` corrupts the event stream if registers are missing.
>> --
>>
>> commit 7e4b22be95dca28326d1271ce91f25c99e231f74
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf regs: Enable dumping of SIMD registers
>>
>> This patch adds support for dumping SIMD registers using the new
>> PERF_SAMPLE_REGS_ABI_SIMD ABI.
>>
>>> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
>>> --- a/tools/perf/builtin-inject.c
>>> +++ b/tools/perf/builtin-inject.c
>>> @@ -457,8 +457,13 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>>>       /* adjust sample size for stack and regs */
>>>       sample_size -= sample->user_stack.size;
>>>       sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
>> [Severity: High]
>> This is a pre-existing issue, but does unconditionally subtracting the full
>> expected size of the register mask cause an integer underflow if the perf
>> sample didn't capture user registers?
>>
>> If the sample didn't capture user registers (e.g., when sampling a kernel
>> thread), the ABI is PERF_SAMPLE_REGS_ABI_NONE (0). It seems subtracting the
>> full mask size would underflow sample_size (a u32), resulting in a massive
>> size being written to event_copy->header.size.
>>
>> Could this corrupt the event stream or cause out-of-bounds reads when
>> perf_event__repipe_synth writes to the pipe?
> So this should never happen, because if we don't sample the stack
> pointer how are we going to unwind through memory? It may be worth
> adding an assert with a comment to capture this though.
>
>>> -     if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>> -             sample_size -= 4 * sizeof(u64); /* Reduce SIMD regs header size */
>>> +     if (sample->user_regs && sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>>> +             sample_size -= 4 * sizeof(u64);
>>> +             sample_size -= (sample->user_regs->nr_vectors *
>>> +                             sample->user_regs->vector_qwords +
>>> +                             sample->user_regs->nr_pred *
>>> +                             sample->user_regs->pred_qwords) * sizeof(u64);
>>> +     }
>>>       sample_size += (sample->callchain->nr + 1) * sizeof(u64);
>> [ ... ]
>>
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>> [ ... ]
>>
>>> +     for (i = 0; i < regs->nr_vectors; i++) {
>>> +             for (j = 0; j < regs->vector_qwords; j++) {
>>> +                     idx = i * regs->vector_qwords + j;
>>> +                     if (regs->vector_qwords > 1) {
>>> +                             printf(".... %3s[%d][%d] 0x%016" PRIx64 "\n",
>>> +                                    name, i, j, regs->simd_data[idx++]);
>> [Severity: Low]
>> Is the post-increment of idx necessary here?
>>
>> Since idx is re-initialized at the start of each inner loop iteration
>> (idx = i * regs->vector_qwords + j), the incremented value seems to be
>> discarded on the next iteration.
> Yeah, we can drop the dead "++" I think.

Yes, it's a typo, the dumping code is rewritten, but the "++" is forgotten
to delete.

Thanks.


>
> Thanks,
> Ian
>
>>> +                     } else {
>>> +                             printf(".... %3s[%d] 0x%016" PRIx64 "\n",
>>> +                                    name, i, regs->simd_data[idx++]);
>>> +                     }
>>> +             }
>>> +     }
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260529082451.591783-1-dapeng1.mi@linux.intel.com?part=4
>>
