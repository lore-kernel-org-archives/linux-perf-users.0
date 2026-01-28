Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9242857C7
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 02:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568135; cv=none; b=IrXDNwcGHKhj+11qaklEIGZnQ0uZFf+JF5fw8XC+fOuu/Wv1BiHI1igB1vMmuOPnSbNDpGRNuW8B+MnLIeFjAmf1P6ir7cwDFfVIc8D61JeABej1ZwmSRc/ADvhdZtpPf3IJ+37/4QVy/+oiUmxHZUknSd6GQXk5ZEnTh5YbHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568135; c=relaxed/simple;
	bh=Cjq8RdcGnO3/jam0fc49BXpAjOIyI2Rgw1wcMkMTdvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZD3Ti7stF3GT3cJQ6YCF5w/Bki47C6oCPOLSKFhoAwE8RGDb7s0Dpi3oLRbODdU9w7GRqZv9OTs84JwWH255NVsmGBsmoZjLpTVdCa85H6P9locxJKaokh7JH/oNJ4gKBOolbwCqvrzip0bF8Lm0qNsU21vBRxveidiEjMB8Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSg5rURw; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSg5rURw"
Message-ID: <fb745675-e25c-4dcc-be4b-4a4411056755@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769568131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xonaJmIT0yV1XBtfNVuhqYC/x9FdVSimBWSLznJyOZc=;
	b=fSg5rURwIZ8v8fMO0XcDatAwgQCwjWAve3VyUUEpjQ4tJ4zIpX1QMaebTkWwKbwkDLLNtQ
	ssTxYtqdleoLis5VwZdo376QRUsTgpB9Hiy6BvgwGtoCbTwRKKGo5FLvJdXnomgW4CLGer
	mIPxfqSQggWmYB1d9RVbtq16rmL0Bds=
Date: Wed, 28 Jan 2026 10:41:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 1/3] perf: Add rctx in perf_callchain_entry
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260126074331.815684-2-chen.dylane@linux.dev>
 <89d94076412b6fc7e05e4d4884f3830601b390d3dcbee91aff2ec214117411fb@mail.kernel.org>
 <0b02943b-4ec7-4be3-b0e2-6c77531c4cbe@linux.dev>
 <CAEf4Bzb776Sc7ByYF=AEFYw7mXoXVJTGAD-3QY49yBtuqrchuw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAEf4Bzb776Sc7ByYF=AEFYw7mXoXVJTGAD-3QY49yBtuqrchuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/28 05:01, Andrii Nakryiko 写道:
> On Mon, Jan 26, 2026 at 12:51 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> 在 2026/1/26 16:03, bot+bpf-ci@kernel.org 写道:
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index 9ded2e582c60..0330f265173d 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -57,6 +57,7 @@
>>>>    #include <asm/local.h>
>>>>
>>>>    struct perf_callchain_entry {
>>>> +    int                             rctx;
>>>>       u64                             nr;
>>>>       u64                             ip[]; /* /proc/sys/kernel/perf_event_max_stack */
>>>>    };
>>>
>>> Adding rctx before nr changes the structure layout in a way that
>>> appears to break the perf userspace ABI.
>>>
>>> In perf_output_sample() in kernel/events/core.c, when PERF_SAMPLE_CALLCHAIN
>>> is set, the code does:
>>>
>>>       int size = 1;
>>>       size += data->callchain->nr;
>>>       size *= sizeof(u64);
>>>       __output_copy(handle, data->callchain, size);
>>>
>>> This copies (1 + nr) * 8 bytes starting from the beginning of the
>>> structure. Before this patch, offset 0 contained nr (u64), followed
>>> by ip[]. After this patch, offset 0 contains rctx (int) + 4 bytes
>>> padding, then nr at offset 8, then ip[] at offset 16.
>>>
>>> With the new layout, this copy sends the following to userspace:
>>> - First 8 bytes: rctx + padding (kernel-internal data) instead of nr
>>> - Remaining bytes: nr + ip[0..nr-2] instead of ip[0..nr-1]
>>>
>>> This means the callchain data sent to userspace is shifted by 8 bytes,
>>> the last IP is truncated, and the rctx value is leaked to userspace.
>>>
>>> Is there a plan to update perf_output_sample() to output starting from
>>> &entry->nr instead of the structure start? Or am I missing something
>>> about how this structure is used for userspace output?
>>>
>>
>> As AI said, this change shifts the memory layout, which effectively
>> breaks the userspace ABI.
>>
>> Maybe we can use __output_copy(handle, &data->callchain->nr, size);
> 
> yep, very impressive for AI to notice this. I agree that
> &data->callchain->nr seems like the best way forward.
>

will fix it in v9.
>>
>>> [ ... ]
>>>
>>>
>>> ---
>>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>>
>>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21350234831
>>
>>
>> --
>> Best Regards
>> Tao Chen


-- 
Best Regards
Tao Chen
