Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727544334C9
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581987; cv=none; b=l9SgWS6HUoq2RsqM5OjA1xpXlxaiME8W0tTWGtPD5kJ2WUw5cluL9g7bf/0f2JBR++Zt1mJhbKcwv29gz6X5Fe6T6jKsMxj91T5L3iOwbkEg/C+gay5b3OKhkmKbIOfn1ZixweHdvIyXMREP4jwRXXJS7L2xznq+2a1Yg19NAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581987; c=relaxed/simple;
	bh=PVDXdi1GKGCSwFU6W7af+RYQVaijTr+noajlf620EsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exOl4pVCDOn0bq7XGB/N0cX3FaPvoeY/NZxjPjkIvqhj51KdzOdiXtgz/KrQFukOgcDv4/fQ5fwnptc7LhLHGOH9/BsjrnQqw3wAsjgtee8eiHiCo/dAGL/dFeIsTazVZTaykLzYeuWygeUAeR0IYpvjgD8QyzArPV1PGucZq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y35+dDTB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y35+dDTB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499b2981a7bso19590685e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 07:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787581984; x=1788186784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfQu1oI+X/Avl4cDAoicLu7vQUMqyVuYyYc7hYijVqA=;
        b=y35+dDTBbSk1h9zLCD316pqLUTGMHUcuCmteifoVDU6P/Aw299ZG8RopGlO/diuLAO
         VThLP+Iad6eaMzkk3xQwNh95rVK6PNkMs0fo9coxSTrY6h5gh4jjPoAeAXWaCU4nzVJ0
         KnyIByXrb8kUByLfFUTCR/TT7FHSH0zNzmPNoWU3ZItui0IyBe6K1d8Dpyn0p5iOExXq
         o0Nd8ruyIaUgHno5ndD5amrcg3aa46UY4KI0bdLJQXK+dpp/JnmEHVxe4ksNzuiw2dNF
         stzueDu7pBCdA6fIk2Q5Fu1yXttiG1SK5qItTbPCJt2IpfCOT6ewWcRcORkpppmDUXkn
         8r5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581984; x=1788186784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfQu1oI+X/Avl4cDAoicLu7vQUMqyVuYyYc7hYijVqA=;
        b=WhBVGi8CBjwd7HzcCvsIdYjgDCZjKqkClmmdyB0U2FrP9rKEppFHD6sHB2rx+Oa+Ie
         zNqbULkDRJUKz9RUbyCr8lLO3gzO9KeIsXdZFuuW5moUy+5Nbt14eFF7Gkc+BZ5qTOUF
         EmSxpcQz6xLymZfTsMSCuCXiLutZ+yH7GUotkUdx53yb7BBAZlNDl7z7zV8h3i6ko5mx
         LVssB4n6GIKwwlbMkcHNmRXzw0gwwUgcwMx0Xfn6ZtIslhElW4MN2BWdUoBhx8F4Lq59
         RDdL6Aaonr50Ao6N36l9Gd36urEmyOrYSKY2Sgq2shbQ7U6Jz5Ba3lTywPvfx9ts14tu
         c7vA==
X-Forwarded-Encrypted: i=1; AHgh+RphKJvAAqhMbQgb+zOhRFja7t4Yw0nygWKxWzAEanQ7BxQtSZWm/ngUBBBK6AgHNwbm+j7DuGk4JGx3Iu8Vcp71@vger.kernel.org
X-Gm-Message-State: AFuF++mWnThVZaCXZzVfVLlsnTHhZP6NwJU4N19oU4jVKzeFJx41kySp
	bw50qlUdgqbaxLzc/GWHsNi4szMALoTxkjNFcF111DzEhdu4/J0roMtCguj59OHAYhs=
X-Gm-Gg: AR+sD13QXYwMFkw8mreqvT/WXqmc+8Xu8XaKFwp6+S8WxkXVh3fGrrB81f9GuNvArX0
	s4iknmadnXLP2Ya/SetSq4BxB/CNOLnJ/uEAsmxZNnHF4ag4R2Qr2fr8u8lvqL/UDLEqfn98CRf
	OmydJTevX5Ia8H3j6oydzxQ2Eawzpu/nReoZBszZCSu3RIiCpYlU/Q3o8RGP36R+bvj/ZZFLhgt
	dW9sanXbUR15tA3pF2p7LV2n8NLeYO1wvISw+HDxbTzrwd2bogtzPthwWDT66j9CTVVSziJ/N3r
	LszfA1GIQSfL2+5Xkr4xywO5hzw6Be44JevpPn5Ceo1RikwbDZa7uC100pez5CGz0GpNUM5zTw0
	N844nsxCAkzW1X6PvdaOMvW9SBs0A1OEV5tZia5dL6oEci3FqffFNPTU1DKDp7WwFNTn0RIIx6z
	knQKs+KkrDv/L7L56S2XoygH9fPWbRV6OHe1uI7doK32fFZIh2T5Yd1/ITgjchFKGNFQ==
X-Received: by 2002:a05:600c:1554:b0:496:c06b:9fb4 with SMTP id 5b1f17b1804b1-499b844b578mr320097935e9.14.1787581983590;
        Mon, 24 Aug 2026 07:33:03 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c35a1e35sm84180155e9.13.2026.08.24.07.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 07:33:02 -0700 (PDT)
Message-ID: <f1f4447e-4253-4a9c-b410-fc339b4947cc@linaro.org>
Date: Mon, 24 Aug 2026 15:32:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] perf auxtrace: cs-etm: Capture wrapped snapshots
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-doc@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-11-00c4fd0701b4@linaro.org>
 <568a14ed-161d-4f67-842a-c671e7f4c409@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <568a14ed-161d-4f67-842a-c671e7f4c409@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/08/2026 13:21, Adrian Hunter wrote:
> On 21/08/2026 12:49, James Clark wrote:
>> snapshot_has_wrapped() isn't implemented for Coresight, so when a wrap
>> occurs we only save from offset 0 to current head, modulo buffer size,
>> rather than capturing the whole buffer. Coresight drivers currently use
>> a monotonic head pointer even in snapshot mode, which gives a lot more
>> information for taking snapshots than a wrapped pointer. It means we
>> don't need to search for data at the end of the buffer to guess if a
>> wrap has occurred, and we can go back to saving partial buffers after a
>> wrap by checking if the next size to take is less than the buffer
>> size.
>>
>> The drivers will always be able to generate a monotonic head because
>> TRBE has a bytes written counter, so even if we stop generating an AUX
>> record on every overflow, we can check if the counter indicated an
>> overwrite and offset head by a whole buffer size if it wrapped. This
>> forces userspace to read the whole buffer rather than between last and
>> current head. ETR and other sinks use software double buffering, so can
>> continue as they are.
>>
>> Add a much simpler 'monotonic_snapshot_head' path for tracers to use,
>> and use it for Coresight.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/arch/arm/util/cs-etm.c                  |  1 +
>>   .../perf/tests/shell/coresight/raw_dump_stress.sh  |  5 -----
>>   tools/perf/util/auxtrace.c                         | 22 ++++++++++++++++------
>>   tools/perf/util/auxtrace.h                         |  2 ++
>>   4 files changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
>> index d36b7e41399b..dbf76dd3349e 100644
>> --- a/tools/perf/arch/arm/util/cs-etm.c
>> +++ b/tools/perf/arch/arm/util/cs-etm.c
>> @@ -918,6 +918,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>>   	ptr->itr.info_fill		= cs_etm_info_fill;
>>   	ptr->itr.snapshot_start		= cs_etm_snapshot_start;
>>   	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
>> +	ptr->itr.monotonic_snapshot_head = true;
>>   	ptr->itr.reference		= cs_etm_reference;
>>   	ptr->itr.free			= cs_etm_recording_free;
>>   	ptr->itr.read_finish		= auxtrace_record__read_finish;
>> diff --git a/tools/perf/tests/shell/coresight/raw_dump_stress.sh b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
>> index bea70d825596..c9459ded4cbe 100755
>> --- a/tools/perf/tests/shell/coresight/raw_dump_stress.sh
>> +++ b/tools/perf/tests/shell/coresight/raw_dump_stress.sh
>> @@ -48,11 +48,6 @@ read -r size offset last_idx <<< "$(awk '
>>   # everything was dumped. Allow 48 bytes difference to cover 3 frames: current
>>   # frame length, a partial frame and a final empty one, all of which aren't
>>   # dumped.
>> -#
>> -# TODO: for a single snapshot, offset should always be zero. However, we
>> -# currently output AUX records in snapshot mode when we shouldn't, which
>> -# increments the offset. Allow for that until it's fixed so we can test raw
>> -# dumping.
>>   decode_size=$((1 + last_idx - offset))
>>   if [ "$decode_size" -gt "$((size - 48))" ] && [ "$decode_size" -le "$((size))" ]; then
>>   	echo "PASS: AUXTRACE buffer length matches dumped packet index"
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index 8ca872e6d465..e3c770b46e94 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -2051,9 +2051,9 @@ static int __auxtrace_mmap__read(struct mmap *map,
>>   				 bool snapshot, size_t snapshot_size)
>>   {
>>   	struct auxtrace_mmap *mm = &map->auxtrace_mmap;
>> -	u64 head, old = mm->prev, offset, ref;
>> +	u64 head, old = mm->prev, offset, ref, size;
>>   	unsigned char *data = mm->base;
>> -	size_t size, head_off, old_off, len1, len2, padding;
>> +	size_t head_off, old_off, len1, len2, padding;
>>   	union perf_event ev;
>>   	void *data1, *data2;
>>   	int kernel_is_64_bit = perf_env__kernel_is_64_bit(env);
>> @@ -2061,10 +2061,20 @@ static int __auxtrace_mmap__read(struct mmap *map,
>>   
>>   	head = auxtrace_mmap__read_head(mm, kernel_is_64_bit);
>>   
>> -	if (snapshot && itr->snapshot_has_wrapped) {
>> -		err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
>> -		if (err)
>> -			return err;
>> +	if (snapshot) {
>> +		if (itr->snapshot_has_wrapped) {
>> +			err = auxtrace_find_snapshot(itr, mm->idx, mm, data, &head, &old);
>> +			if (err)
>> +				return err;
>> +		} else if (itr->monotonic_snapshot_head) {
>> +			size = head - old;
>> +			/* Force a full buffer read if a wrap has occurred */
>> +			if (size > mm->len) {
>> +				pr_debug3("%s: wrap detected, adjusting old from 0x%"PRIx64" to 0x%"PRIx64"\n",
>> +					  __func__, old, head - mm->len);
>> +				old = head - mm->len;
>> +			}
>> +		}
> 
> I feel like this is asking to keep the ->find_snapshot() callback.
> i.e. basically the same thing, but add a helper that BTS and SPE
> can call directly, like auxtrace_record__default_find_snapshot().
> For PT, add/use auxtrace_record__snapshot_fixup() that does the
> common old/head adjustment.
> 
> Then ->monotonic_snapshot_head is not needed.
> 

Hmm yeah I suppose that makes sense. I can give it a go.

>>   	}
>>   
>>   	if (old == head)
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index a9d0c84184c5..971b817d3396 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -385,6 +385,7 @@ struct auxtrace_mmap_params {
>>    * @evlist: selected events list
>>    * @snapshot_wrapped_len: number of bits in @snapshot_wrapped
>>    * @snapshot_wrapped: bitmap indicating if each aux buffer has wrapped
>> + * @monotonic_snapshot_head: driver doesn't wrap head pointer on overflow
>>    */
>>   struct auxtrace_record {
>>   	int (*recording_options)(struct auxtrace_record *itr,
>> @@ -412,6 +413,7 @@ struct auxtrace_record {
>>   	int snapshot_wrapped_len;
>>   	unsigned long *snapshot_wrapped;
>>   	int snapshot_search_bytes;
>> +	bool monotonic_snapshot_head;
>>   };
>>   
>>   /**
>>
> 

