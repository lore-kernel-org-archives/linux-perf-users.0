Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0ED1FC3;
	Thu,  7 Aug 2025 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526445; cv=none; b=kjD1J4Ucz8GZvTTgEkngKtKFj7CQA3UINBcIk2sxU4q0wtULe9LQwLWf/o3eNIF45wV/MggYj0gdokn7GHUMX3l9T0Skaz8T7ygzo2wXMfyeHMypc8A/UYB/zmebYi97gfTiFThl2DLjRqPbViIH2qNyTEQwixdZ/dDVC8c9xL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526445; c=relaxed/simple;
	bh=E87G1zLOwbPcAnGSMTjOVAAtq+Pi735ZazHspvk88Rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBysJCl7PsBk2kVPKlRS80y7v4l305gcDo/uq7XP9K047VaknyJKQGNWqLsBtUTQGqiKpf1IepO6p/9Yc4uW+eTB7EI8L1NlCWNJqLns9X5eXA3AYbl6ElcZFh+fCQy2iY02tspAf7u4iXIyC3k59JqoreTW6CkIZWL1ipLe4yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/PySFgx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/PySFgx"
Message-ID: <043721e8-a38e-419d-b9b9-2dad33e267a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754526431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcp05K9GYJzNReXXgEaFxPEQD8/k4GX8YFFxozr1JYw=;
	b=O/PySFgxLk50ZVnk1G6yi0CcOpV/M7wBsBYJ3GS+mqBidZOjBvqJVjtMIrVrpvjWBuxuyy
	v797FBJYTubG8lf7tdfAlY4f8dfNxS/HmRLcZ/Jfj6KpmsdA7T6lgU3TNHNgjI3kUmNOhY
	o5yvT8R4iq1cd0I4GmbYdJcvI6wfSwI=
Date: Wed, 6 Aug 2025 17:27:02 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Content-Language: en-GB
To: Andrew Pinski <quic_apinski@quicinc.com>,
 Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 4:57 PM, Andrew Pinski wrote:
>
>> -----Original Message-----
>> From: Namhyung Kim <namhyung@kernel.org>
>> Sent: Wednesday, August 6, 2025 4:34 PM
>> To: Sam James <sam@gentoo.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>; Ingo Molnar
>> <mingo@redhat.com>; Arnaldo Carvalho de Melo
>> <acme@kernel.org>; Mark Rutland
>> <mark.rutland@arm.com>; Alexander Shishkin
>> <alexander.shishkin@linux.intel.com>; Jiri Olsa
>> <jolsa@kernel.org>; Ian Rogers <irogers@google.com>; Adrian
>> Hunter <adrian.hunter@intel.com>; Liang, Kan
>> <kan.liang@linux.intel.com>; Andrew Pinski
>> <quic_apinski@quicinc.com>; linux-perf-
>> users@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bpf@vger.kernel.org
>> Subject: Re: [PATCH] perf: use __builtin_preserve_field_info
>> for GCC compatibility
>>
>> Hello,
>>
>> On Wed, Aug 06, 2025 at 01:03:01AM +0100, Sam James
>> wrote:
>>> When exploring building bpf_skel with GCC's BPF support,
>> there was a
>>> buid failure because of bpf_core_field_exists vs the
>> mem_hops bitfield:
>>> ```
>>>   In file included from util/bpf_skel/sample_filter.bpf.c:6:
>>> util/bpf_skel/sample_filter.bpf.c: In function
>> 'perf_get_sample':
>>> tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42:
>> error: cannot take address of bit-field 'mem_hops'
>>>    169 | #define ___bpf_field_ref1(field)        (&(field))
>>>        |                                          ^
>>> tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29: note: in
>> expansion of macro '___bpf_field_ref1'
>>>    222 | #define ___bpf_concat(a, b) a ## b
>>>        |                             ^
>>> tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29: note: in
>> expansion of macro '___bpf_concat'
>>>    225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
>>>        |                             ^~~~~~~~~~~~~
>>> tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9: note:
>> in expansion of macro '___bpf_apply'
>>>    173 |         ___bpf_apply(___bpf_field_ref,
>> ___bpf_narg(args))(args)
>>>        |         ^~~~~~~~~~~~
>>> tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39: note:
>> in expansion of macro '___bpf_field_ref'
>>>    188 |
>> __builtin_preserve_field_info(___bpf_field_ref(field),
>> BPF_FIELD_EXISTS)
>>>        |                                       ^~~~~~~~~~~~~~~~
>>> util/bpf_skel/sample_filter.bpf.c:167:29: note: in expansion
>> of macro 'bpf_core_field_exists'
>>>    167 |                         if (bpf_core_field_exists(data-
>>> mem_hops))
>>>        |                             ^~~~~~~~~~~~~~~~~~~~~
>>> cc1: error: argument is not a field access ```
>>>
>>> ___bpf_field_ref1 was adapted for GCC in
>>> 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
>>> but the trick added for compatibility in
>>> 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
>>> isn't compatible with that as an address is used as an
>> argument.
>>> Workaround this by calling __builtin_preserve_field_info
>> directly as
>>> the bpf_core_field_exists macro does, but without the
>> ___bpf_field_ref use.
>>
>> IIUC GCC doesn't support bpf_core_fields_exists() for bitfield
>> members, right?  Is it gonna change in the future?
> Let's discuss how __builtin_preserve_field_info is handled in the first place for BPF. Right now it seems it is passed some expression as the first argument is never evaluated.
> The problem is GCC's implementation of __builtin_preserve_field_info is all in the backend and the front end does not understand of the special rules here.
>
> GCC implements some "special" builtins in the front-end but not by the normal function call rules but parsing them separately; this is how __builtin_offsetof and a few others are implemented in both the C and C++ front-ends (and implemented separately). Now we could have add a hook to allow a backend to something similar and maybe that is the best way forward here.
> But it won't be __builtin_preserve_field_info but rather `__builtin_preserve_field_type_info(type,field,kind)` instead.
>
> __builtin_preserve_enum_type_value would also be added with the following:
> __builtin_preserve_enum_type_value(enum_type, enum_value, kind)
>
> And change all of the rest of the builtins to accept a true type argument rather than having to cast an null pointer to that type.
>
> Will clang implement a similar builtin?

The clang only has one builtin for some related relocations:
    
    __builtin_preserve_field_info(..., BPF_FIELD_EXISTS)
    __builtin_preserve_field_info(..., BPF_FIELD_BYTE_OFFSET)
    ...
They are all used in bpf_core_read.h.

>
> Note this won't be done until at least GCC 16; maybe not until GCC 17 depending on if I or someone else gets time to implement the front-end parts which is acceptable to both the C and C++ front-ends.
>
> Thanks,
> Andrew Pinski
>
>>> Link: https://gcc.gnu.org/PR121420
>>> Co-authored-by: Andrew Pinski
>> <quic_apinski@quicinc.com>
>>> Signed-off-by: Sam James <sam@gentoo.org>
>>> ---
>>>   tools/perf/util/bpf_skel/sample_filter.bpf.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c
>>> b/tools/perf/util/bpf_skel/sample_filter.bpf.c
>>> index b195e6efeb8be..e5666d4c17228 100644
>>> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
>>> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
>>> @@ -164,7 +164,7 @@ static inline __u64
>> perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>>>                if (entry->part == 8) {
>>>                        union perf_mem_data_src___new *data = (void
>>> *)&kctx->data->data_src;
>>>
>>> -                     if (bpf_core_field_exists(data->mem_hops))
>>> +                     if
>>> + (__builtin_preserve_field_info(data->mem_hops,
>> BPF_FIELD_EXISTS))
>>
>> I believe those two are equivalent (maybe worth a
>> comment?).  But it'd be great if BPF/clang folks can review if
>> it's ok.
>>
>> Anyway, I can build it with clang.
>>
>> Tested-by: Namhyung Kim <namhyung@kernel.org>
>>
>> Thanks,
>> Namhyung
>>
>>
>>>                                return data->mem_hops;
>>>
>>>                        return 0;
>>> --
>>> 2.50.1
>>>

