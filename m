Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B988BE5
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358841; cv=none; b=EDFALJPn8pQF4TUvEVMGQzR/e/38nIGqZC15gxFe4LuwjfEWtOzdNYTcb4sm0OiKyNpBQ2cslXlAz+ib+TS+XoKxd9NZ5wswOITG9UibBO1rItvwC4lsu7GfbxLxEogzYQ95D3ur3sL0QmEOBYSkFE4BFMwkAkztX74bqjvuGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358841; c=relaxed/simple;
	bh=kC6U9+KG6uDSrqO+JpXpC+eujcy5pIeZ8EBzlvRXtKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueHzpQl1E2LUqnNZyc08o6N0ctikIFix7O6SQJLwGLRYWEgg3DfYQ3PpFZxQ0oSNUkhtEXNWglYcph3RW2wNdrcPNmnf9EhW3g5VS0MU8jcXyOA6Y9ozOem951ya2O8ZbpZI+F1jMpZvuAd5fNyw7Xrt/Olumg0GxkdodJroSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZLewmn7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZLewmn7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bc6a6aaf7so15105785e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741358838; x=1741963638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbfnpKzUT2MsLd5Bwk73doiDIkga+RD0L+zIs0tw74s=;
        b=AZLewmn7mi06PJRiaBeCiIQNzOz1Dx0KEQpuTKsfleCLIiu7x+UDv5j/fFNhIo7a9k
         O6DpR8umV51JZTtQJ0fnWBmNRdzpj1auNBsArlk6+a9lFZwMlumzzWz1O6ckqx/mSr+r
         +q5UNDC6uXi/YSnemKY/HNjUUcYvp5j9+lrAfuQg5mX/w5a7CW79BVcHK2UxY98xfrbq
         4/afY9ExqmY4GiY6/tPgw8SUlYIjNyklyfXU/7I4x5VgW9RQYyw5Lt1ya38HR2GxCu8b
         hRNFEgR3iLsejix19LZK5XwerklT92Xuw4SwET0n30C2fqJpFxU2wRUjGZMJdXzAK6V5
         ez4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358838; x=1741963638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbfnpKzUT2MsLd5Bwk73doiDIkga+RD0L+zIs0tw74s=;
        b=KUYtUjJ6Ch/AD3MNjWAP1R/mLwdb7od/jvaCYw7eKozS4BKOu5DLKZ1eI5Nt1nIYgQ
         USMqY/ITjZAoVRPmUO1BLkRljn/FwxpYGtpppNXKnlL+ZTzZUfI+lUc8q9Mtl9uSz97K
         cSh+L8pM2V7qpYlSawrRShSiAY83arjtsmSVrz1fhxl8TAfYa9oaJdgZ075a7q6kHrI4
         G+Dq0QmJR0Ruad8mI90fu5XNWaRTe7ChDUefCVg/MOVR8uliKTsb0WZ3UVQ4pE85E7TB
         2pfb0f4lUqpNEVdbq5yuw8NfHpz4mKQTMa76EilGI7FZC0CXHXoiFfxSv5xahOAKCQWJ
         j6UA==
X-Forwarded-Encrypted: i=1; AJvYcCXWeoZ1G0AqPrnFIcLO2Xm2bVVjTH8tM5SmO396+gHMB1OhuvgoksB32P9ElcsgoTboHMKxWF6dQJ1rdtzO2210@vger.kernel.org
X-Gm-Message-State: AOJu0Yyij6P0PVLGqiSETNcpGpU0shEsetblzkFzYdtoIisB+8fNx55Y
	oBdjSjJ4eMJnlvWA0a/1ALb3Ie6D4Deue1/WrxpaTcDO+Anr8mYacRezKIHTyqQ=
X-Gm-Gg: ASbGncsGFfygLEV3J7RvV/ChKjYPo7HpFTTes5f5QbNLGDMf5dQX3ahBLkkhqAniqq2
	7d4duzMXUilcJQ7mGvjuGWlIKs/gPMBSRKaTmzEbVsXRvdM1JLDHCF7SYbfZ/89blLYRyabEO9f
	hx63I/zLDjhv7ngIC4mCbrvBLv4vU8TQYrVAyiBaJoD5aa3SAfJ6t6YYQulheVkX0xuZKpwwjbI
	baI8tTlw4no2Qf25qrlyPYThiyKu4NXiD0Wdfrc4sOOoL241D6ve5BT8B8kQLrcHfRNKYwPepvR
	H+IIZ2p03qc0YAKd1QS8nDDlhDjRzW71fI/CHnIcPHsBo6p4lJTk7Q==
X-Google-Smtp-Source: AGHT+IFSBbFNXfMlM1Wzf7wWoWonIVcYjk8lO0nR3i7vr2DP0Ev9WBlkWA4L/wfhtgAV7Vn7GQ+9/A==
X-Received: by 2002:a05:600c:198f:b0:439:6101:5440 with SMTP id 5b1f17b1804b1-43c5a5f7050mr26119285e9.8.1741358837651;
        Fri, 07 Mar 2025 06:47:17 -0800 (PST)
Received: from [192.168.1.247] ([145.224.67.152])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4293250sm82424835e9.16.2025.03.07.06.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:47:17 -0800 (PST)
Message-ID: <c401c3c7-b593-4d72-af62-bcf3f419af76@linaro.org>
Date: Fri, 7 Mar 2025 14:47:15 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf list: Collapse similar events across PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <CAP-5=fUtS5-vHj+GWDsyWG-2CUYy6e0qhjuUtD9x7FudPsRpOQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUtS5-vHj+GWDsyWG-2CUYy6e0qhjuUtD9x7FudPsRpOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/03/2025 8:38 pm, Ian Rogers wrote:
> On Tue, Mar 4, 2025 at 5:50 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Some changes related to the discussion here [1] about deduplication of
>> PMUs. This change stands on its own right now, but it may not go far
>> enough. This can either be dropped for now or applied and improved
>> later. Extra ideas are as follows.
>>
>> Treating alphanumeric suffixes as duplicate has been slightly
>> problematic due to marketing strings having looks-like-but-not-actually
>> alphanumeric suffixes. For example 'cpum_cf' and now the one digit
>> longer than before 'cortex-a720'. The easy fix is to increase the
>> minimum length considered for deduplication as suggested [1], but as
>> also mentioned, the current mrvl_ddr_pmu PMU names don't zero pad the
>> address, meaning that > 2 alphanumeric suffixes are already technically
>> not enough to deduplicate the same PMUs. They could have only a 2 digit
>> alphanumeric address suffix. Increasing the minimum digits feels a bit
>> like kicking the can down the road and it places awkward limitations on
>> marketing names which we have no control over. Also I'm not sure helps
>> the following much:
> 
> The hex suffix thing was very unfortunate, can we reverse that
> decision and move the physical address.. it captures into a caps file?
> 

Do you mean changing the PMU's name in the driver? I can't imagine that 
would go down too well given how long it's been there. Seems to me 
there's too much risk of it breaking some other tool or script. It would 
be a bit unfair to do that to fix an assumption that only really exists 
in Perf, and especially if there could be other ways to achieve the same 
behaviour in Perf.

> Fwiw, we have a similar hex mess with raw events. A raw event can be
> r0xead or read, but read also makes a pretty nice event name. This is
> solved by first checking if read is an event and if not assuming it is
> a raw encoding. Would anyone really care if raw events always had to
> start with r0x? We seem to get tangled up in corner cases like this
> too often, for example legacy event priorities and topdown event
> sorting. Keeping things simple would be nice from a correctness pov
> but also so that it's easy for other tools to emulate.
> 

I think tools like this are always going to be full of various 
heuristics and magic to make the experience as user friendly as 
possible. If using the bare kernel interface was already fully featured 
enough then there wouldn't be a need for Perf to exist.

In an ideal world we'd have some capability file like you mentioned 
above. Or a folder with symlink to other instances of the same PMU then 
a tool can follow the links to other PMUs to deduplicate them. In theory 
we could add that right now. At least it wouldn't depend on any name 
restrictions, but it does push complexity that should probably exist in 
a tool into the kernel. In practice I think it would be a bit of a 
nightmare because it has to be re-implemented for everyone's PMU driver. 
That's got to be more code than tools doing it on the list of events 
produced.

>> The problem is that arm_cmn_[n] PMUs have a numeric suffix, but they can
>> have different events. Even if we were adding this PMU today, keeping
>> the suffix rule in mind, it would be difficult to come up with a suffix
>> that differentiates the different ones. Flavour words might work, but
>> that complicates the kernel which would have to group them and come up
>> with flavours rather than just doing an i++. Deduplicating too
>> aggressively on only PMU name suffix means only arm_cmn_1's events get
>> listed, missing other events, and it's hard to see which events relate
>> to which PMU.
>>
>> Therefore in addition to the changes in this patchset I'd like to look
>> into:
>>
>>   * Collapsing duplicate PMU names into ranges, for example
>>     arm_pmu_v3_[0-4], rather than simply concatenating names as done in
>>     this patchset
> 
> The current suffix rule is weird as Intel's GPU i915 PMU appears to be
> a PMU called 'i' with a 915 numeric suffix.
> I think capturing the rules in the ABI doc and some kind of legacy
> compatibility is do-able.
> I like regular expressions over globs/fnmatch, for example, we could
> use flex to turn the CPUID matches in mapfile.csv into something that
> is parsed and matched with less interpretation/compilation at runtime.
> I suspect we can bike-shed for a long time on what these new rules
> will be, which has been why I've generally just tried to match
> existing and inelegant behaviors.
> 

I think at this point we could even consider a whitelist of known PMU 
names and how each one behaves. It's probably less than a handful long.

>>   * Deduplicate uncore based on the contents of events/ rather than just
>>     the suffix
>>
>> As some background, the original commit for deduplication, commit
>> 3241d46f5f54 ("perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu")
>> mentions reducing the number of duplicate PMUs, and is presumably
>> motivated by usability. But there are also other commits mentioning
>> reducing openat()s, for example lazily loading formats 504026412162
>> ("perf pmu: Make the loading of formats lazy"). Deduplicating based on
>> the contents of the events/ folder is somewhat in contention with this
>> reduction, but could be done along side some more lazy loading (like of
>> the terms) and hashing the result of readdir() without opening any of
>> the contents. JSON tables can have event name hashes calculated at build
>> time if we want to consider them for deduplication too.
> 
> I worry about the run time cost of this when there are 100s of uncore

I'm interested in quantifying this time if we do any of these changes.

Is this particular example of 100s of PMUs with mrvl_ddr_pmu? How many 
events does it have? And which particular uses cases are most important, 
is it just listing or opening events? From what I can see these 
proposals shouldn't actually effect opening events, and you'd think 
listing could take a small time hit as it's done less frequently than 
opening. And there's already a lot of output.

> PMUs. I wonder if the case of an empty events directory would also be
> common.

Is this an issue in this case? If we're talking about listing events, 
then we show the single deduplicated instance as it is now. With an 
empty events folder nothing is lost.

> Wrt the x86 conventions I think Kan is best placed to say what the
> preferred convention should be.
> The json will routinely say this event is on a PMU name without a
> suffix, and the number of PMUs will only be known at runtime. Hashing
> without the suffix would be fine but I think the controversy is over
> what should be considered a suffix.

Well, I was considering what would happen if we always apply this 
deduplication without taking suffixes into account. The suffix rule just 
becomes a bit of a premature optimization to avoid reading the events 
folder in some cases, but if we make it acceptably fast all PMUs 
regardless of name could be considered for deduplication.

> 
> Thanks for doing the series, I'll dig into/test each one in turn.
> Ian
> 
>> Then with the events hash, PMU's can be sorted based on this and the
>> 'Unit:' string can be constructed with a set of values that collapses
>> adjacent suffixes to display as ranges. I believe that could remove the
>> need for any further changes to duplication based on suffix, but still
>> avoids over deduplication.
>>
>> [1]: https://lore.kernel.org/linux-perf-users/CAP-5=fW_Sq4iFxoWPWuixz9fMLBPyPUO0RG0KPbYa-5T0DZbTA@mail.gmail.com/
>>
>> ---
>> James Clark (3):
>>        perf list: Order events by event name before PMU name
>>        perf list: Collapse similar events across PMUs
>>        perf list: Don't deduplicate core PMUs when listing events
>>
>>   tools/perf/builtin-list.c      |  2 +
>>   tools/perf/util/pmu.c          |  5 ++-
>>   tools/perf/util/pmu.h          |  2 +
>>   tools/perf/util/pmus.c         | 95 ++++++++++++++++++++++++++++++++++--------
>>   tools/perf/util/print-events.h |  1 +
>>   5 files changed, 86 insertions(+), 19 deletions(-)
>> ---
>> base-commit: 7788ad59d1d9617792037a83513be5b1dd14150f
>> change-id: 20250304-james-perf-hybrid-list-11b888cf435a
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

