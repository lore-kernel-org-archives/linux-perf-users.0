Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E37611E
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Aug 2025 00:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754525759; cv=none; b=sY/lscTyS8tK8EZNm9j2DiLl3wTaJ/CIdyEUYaLvHfgS+7fQQzkDUMcr3LfxJOXwCw1nuIIjBpNIHAYKsegdVfw7LjLoVpUU6VWjffdvosK62C9UKQSaceu0ArJ0O0yQVHosdrvSbRkPgB3sGwE1PKuxXcZYD5hDmQb2iKo/V4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754525759; c=relaxed/simple;
	bh=i4LsIiz1RR4sd0mbWjIuP2fzUnEewdAdGw1p5tyqtAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4i84eKHK23x9TDb3d511xmgqISKl5tvwRAPUpr7FEhNJm6Xl87wqJsryxG704FT6fQUtY/a+6BWMDHDyokvb7I2QTZNtfSw9BbjeDjf8dqLmrMlB9nDaQ+Gddqrfddm/lnyuuJxxd7Dmfox64UpLoux0/E9g0FcUtRAyG3hc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wUgGEzCc; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wUgGEzCc"
Message-ID: <425a7914-a653-45fe-800a-1da0108bb580@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754525745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vp76ut0yAE7zduuk2f9MkduB9mOiX9R61/7Yih6G71o=;
	b=wUgGEzCcKbiwGMp0MlHKh3JobBUQK3umMr+C34AX2HPDrj51OxaDiG1U8rnvEFjDcp1Eco
	ZLB7krlTbgToQPS2Ap7nwn6Ki0MpcRTyeN6kbU69isvmFDW1lTeAQyf2kPuSlBZj5I+z6H
	KKPtZkaEqsUjJVvu311qylWMjh+Dfls=
Date: Wed, 6 Aug 2025 17:15:37 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Content-Language: en-GB
To: Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Andrew Pinski <quic_apinski@quicinc.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aJPmX8xc5x0W_r0y@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 4:33 PM, Namhyung Kim wrote:
> Hello,
>
> On Wed, Aug 06, 2025 at 01:03:01AM +0100, Sam James wrote:
>> When exploring building bpf_skel with GCC's BPF support, there was a
>> buid failure because of bpf_core_field_exists vs the mem_hops bitfield:
>> ```
>>   In file included from util/bpf_skel/sample_filter.bpf.c:6:
>> util/bpf_skel/sample_filter.bpf.c: In function 'perf_get_sample':
>> tools/perf/libbpf/include/bpf/bpf_core_read.h:169:42: error: cannot take address of bit-field 'mem_hops'
>>    169 | #define ___bpf_field_ref1(field)        (&(field))
>>        |                                          ^
>> tools/perf/libbpf/include/bpf/bpf_helpers.h:222:29: note: in expansion of macro '___bpf_field_ref1'
>>    222 | #define ___bpf_concat(a, b) a ## b
>>        |                             ^
>> tools/perf/libbpf/include/bpf/bpf_helpers.h:225:29: note: in expansion of macro '___bpf_concat'
>>    225 | #define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
>>        |                             ^~~~~~~~~~~~~
>> tools/perf/libbpf/include/bpf/bpf_core_read.h:173:9: note: in expansion of macro '___bpf_apply'
>>    173 |         ___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
>>        |         ^~~~~~~~~~~~
>> tools/perf/libbpf/include/bpf/bpf_core_read.h:188:39: note: in expansion of macro '___bpf_field_ref'
>>    188 |         __builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_EXISTS)
>>        |                                       ^~~~~~~~~~~~~~~~
>> util/bpf_skel/sample_filter.bpf.c:167:29: note: in expansion of macro 'bpf_core_field_exists'
>>    167 |                         if (bpf_core_field_exists(data->mem_hops))
>>        |                             ^~~~~~~~~~~~~~~~~~~~~
>> cc1: error: argument is not a field access
>> ```
>>
>> ___bpf_field_ref1 was adapted for GCC in 12bbcf8e840f40b82b02981e96e0a5fbb0703ea9
>> but the trick added for compatibility in 3a8b8fc3174891c4c12f5766d82184a82d4b2e3e
>> isn't compatible with that as an address is used as an argument.
>>
>> Workaround this by calling __builtin_preserve_field_info directly as the
>> bpf_core_field_exists macro does, but without the ___bpf_field_ref use.
> IIUC GCC doesn't support bpf_core_fields_exists() for bitfield members,
> right?  Is it gonna change in the future?
>
>> Link: https://gcc.gnu.org/PR121420
>> Co-authored-by: Andrew Pinski <quic_apinski@quicinc.com>
>> Signed-off-by: Sam James <sam@gentoo.org>
>> ---
>>   tools/perf/util/bpf_skel/sample_filter.bpf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
>> index b195e6efeb8be..e5666d4c17228 100644
>> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
>> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
>> @@ -164,7 +164,7 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>>   		if (entry->part == 8) {
>>   			union perf_mem_data_src___new *data = (void *)&kctx->data->data_src;
>>   
>> -			if (bpf_core_field_exists(data->mem_hops))
>> +			if (__builtin_preserve_field_info(data->mem_hops, BPF_FIELD_EXISTS))
> I believe those two are equivalent (maybe worth a comment?).  But it'd
> be great if BPF/clang folks can review if it's ok.

Yes, from clang side, they are almost equnivalent. See tools/lib/bpf/bpf_core_read.h.

#define bpf_core_field_exists(field...)                                     \
         __builtin_preserve_field_info(___bpf_field_ref(field), BPF_FIELD_EXISTS)

bpf_core_field_exists actually relies on clang builtin function
__builtin_preserve_field_info(). This builtin is handled in frontend and
also at early IR stage.

So your above code is okay to me although bpf_core_field_exists() is much
easy to understand the intent.

>
> Anyway, I can build it with clang.
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
>>   				return data->mem_hops;
>>   
>>   			return 0;
>> -- 
>> 2.50.1
>>

