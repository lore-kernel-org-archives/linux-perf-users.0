Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0583E331A53
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805085; cv=none; b=ByD64w72X4N6x1IX4nAgwUduXb4tmFFbsv36QGRQLmOAgeRwKuZCwFQQQTqiIOiC7qk4fwjPQQM2RpNNcd8RtfFHe7CAgw2IiQVmShOwr9OF3+Y2A+UtsKo6p4H3KbK/U8YFpmLcOwiq2lzIxUMLQRdHMmneFmEsJnCNIr2e+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805085; c=relaxed/simple;
	bh=1bZINs4C3Vj4b77JYntL/oA77QTLnW/bW9ue7I6vh7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CApbsdJzEocZ72iTa5ebzWq4Q6PEnd/Ft1fDyTOkrWX5rz7DE02jzN4YF3/mSkgGkgrLtIE+uFeaLgO9iH4GTvbJKrWsmfHfAKLgziOsoOL1bg2xzkHsKJkZ8dsVPlQilWu1vvepVONd25YLquWRFtjGS9FylHagAm8FsnfryoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rSINmQ31; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rSINmQ31"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso4766829a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 05:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765805080; x=1766409880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nZ3TNY8tVTHDDnPmgQSJz0Pzg9P4e1F60OUjaqwVxFQ=;
        b=rSINmQ31CXQnusvja2dGu2EICHvKAS4Ht75HFGeRi/O1kbK9k/w6qQUjd8SVsteOG0
         0tOCcOG/BOA7kGNc+rijiaFzmtcUl2kW1SVNxsZPqLXFQvL+zfBM+NwtZzYyxNFgdGxr
         xlFrbacLpTXPzD1oEM4z+cE834nXz08xBVHqAbSmWJyRPV7874jnG4OdW92/hIr+rYyO
         EwogtaQGURp/B0OOoGE2mjArau/BJXlnV/3XjMaFXhfZcqBDdNMLudr+1TKOxkt+KMk5
         kwLEbL6zOfN7LdYKlKrPzEQ0tqpv1vghxh7nf95UULi8L7zVWqIZnR1TqiSkvfGstI+b
         iSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765805080; x=1766409880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZ3TNY8tVTHDDnPmgQSJz0Pzg9P4e1F60OUjaqwVxFQ=;
        b=LExz4/5PeZTBhj/eglPWz+joEIjb4kvF7R4VTPU5db+QSw2cyjhFpNcAEhPJLBSl/b
         yGUmjOucrTPE6oNLlBlr+2/mip88JWJPtb4Ku/FekfQi1I8Xxb6xGbK51WavzHPPAmH4
         aK7asKvT7JDWch+E87WSv2fFJkirA3D+zosHfWx623swLfSrwuo8/dLauh25aQ6r10Jw
         QMvjxumJmPh1ikOwFDHLQN8BT9TaBVCZmLswfX0rVWcOEvcIe/jn6qJbu9r4qyD+JNE7
         6kDg5pQfq+NYVEtt6kXniWLwFTyeKrLwSJc6lljU5TPGgMHl1QUk1zSUUT82QfDTwuk7
         +dXA==
X-Forwarded-Encrypted: i=1; AJvYcCVVxYaOowmqOsgwNOx14Mefs080HXWVgnveH0VhEo5pZ/WTrKppmHAhXmVT0FvhbZCQt2HF7nCP+LkC9x2Ur7PW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Eap2HgC5/Y6rcGQdTqms/34SU8WKIhjso8th2O59+6Rpj40e
	pR+UpnHj26I3ibYQR0liy2tmqm3CYX3ZwPYtYp751BTwtZG0Sn6eOV2LtJKsiMaAmWU=
X-Gm-Gg: AY/fxX6Dsmt+zttq611T952zAq3WxTVg0S4rrxzZd3voPGfgX4XrIZVt1RxQPEbSEPx
	w3SXG+orHqimVjvbSdNUVMWgaTOV9+oQk+ICjobltEWF6Ly77WnlFNEQsPFWxPhbzYdfyCkUB3o
	JP4uIidEhpJckZl0ATp6FTy5vIEV2Zva5C42zlGjkQTr3ijU1Soq6WrKoBJx8oz3VoZtVTWzoqr
	R0y2f+sRyUnXiR2jVjzERF2K3fSIZAriE/fRgIHy3ZYdxTCwU7LqNtyDcFiF1Jn3fbDB374LX0G
	uv78gl+pLr2vJug7VYU8ZpllJ15PYSGlmH89BX7bsEqrV1ajIfvb+JLcwrRDV3awHBgRb1LVMuE
	hOoiEsukSwAFKtjMKtuWobYoRuUDLBqxQrq/hGS35kSM4MVWz+I8sBV9Aidx9wHa4tvy5iYECZ4
	w/GDYdkA9RBWXaq228yu1S
X-Google-Smtp-Source: AGHT+IH+H8kc95ZOdA84T3Odl3+9QC8aQyUc8udL+PygG6BffsfixcTAW/uPv6QUo0SuuWA4tm7s0w==
X-Received: by 2002:a05:6402:254c:b0:649:d815:d766 with SMTP id 4fb4d7f45d1cf-649d815d7c1mr3429836a12.12.1765805079764;
        Mon, 15 Dec 2025 05:24:39 -0800 (PST)
Received: from [192.168.0.108] ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498213171fsm13478742a12.30.2025.12.15.05.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 05:24:39 -0800 (PST)
Message-ID: <5acc2e4a-abac-439c-81b0-9095f660833e@linaro.org>
Date: Mon, 15 Dec 2025 15:24:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 46/48] perf jevents: Add collection of topdown like
 metrics for arm64
To: Ian Rogers <irogers@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, "Liang, Kan"
 <kan.liang@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Gray <bgray@linux.ibm.com>, Caleb Biggers
 <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Jing Zhang <renyu.zj@linux.alibaba.com>,
 Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Leo Yan <leo.yan@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Perry Taylor <perry.taylor@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Thomas Falcon
 <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
References: <20251202175043.623597-1-irogers@google.com>
 <20251202175043.623597-47-irogers@google.com>
 <c71aeb58-a87c-455b-9d5d-7bb28e34d317@linaro.org>
 <CAP-5=fXwCoOQS=E_o34oQivXMC8RAOo8we4xk9CuL_Pa=pKOVA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXwCoOQS=E_o34oQivXMC8RAOo8we4xk9CuL_Pa=pKOVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/12/2025 23:23, Ian Rogers wrote:
> On Tue, Dec 9, 2025 at 3:31 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 02/12/2025 5:50 pm, Ian Rogers wrote:
>>> Metrics are created using legacy, common and recommended events. As
>>> events may be missing a TryEvent function will give None if an event
>>> is missing. To workaround missing JSON events for cortex-a53, sysfs
>>> encodings are used.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>> An earlier review of this patch by Leo Yan is here:
>>> https://lore.kernel.org/lkml/8168c713-005c-4fd9-a928-66763dab746a@arm.com/
>>> Hopefully all corrections were made.
>>> ---
>>>    tools/perf/pmu-events/arm64_metrics.py | 145 ++++++++++++++++++++++++-
>>>    1 file changed, 142 insertions(+), 3 deletions(-)
>>>
>> [...]
>>> +        MetricGroup("lpm_topdown_be_bound", [
>>> +            MetricGroup("lpm_topdown_be_dtlb", [
>>> +                Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per instruction",
>>> +                       d_ratio(dtlb_walk, ins_ret), "walk/insn"),
>>> +                Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks per L1D TLB access",
>>> +                       d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else None, "100%"),
>>> +            ]) if dtlb_walk else None,
>>> +            MetricGroup("lpm_topdown_be_mix", [
>>> +                Metric("lpm_topdown_be_mix_ld", "Percentage of load instructions",
>>> +                       d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
>>> +                Metric("lpm_topdown_be_mix_st", "Percentage of store instructions",
>>> +                       d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
>>> +                Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD instructions",
>>> +                       d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
>>> +                Metric("lpm_topdown_be_mix_fp",
>>> +                       "Percentage of floating point instructions",
>>> +                       d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
>>> +                Metric("lpm_topdown_be_mix_dp",
>>> +                       "Percentage of data processing instructions",
>>> +                       d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
>>> +                Metric("lpm_topdown_be_mix_crypto",
>>> +                       "Percentage of data processing instructions",
>>> +                       d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
>>> +                Metric(
>>> +                    "lpm_topdown_be_mix_br", "Percentage of branch instructions",
>>> +                    d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
>>> +                            inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
>>
>> Hi Ian,
>>
>> I've been trying to engage with the team that's publishing the metrics
>> in Arm [1] to see if there was any chance in getting some unity between
>> these new metrics and their existing json ones. The feedback from them
>> was that the decision to only publish metrics for certain cores is
>> deliberate and there is no plan to change anything. The metrics there
>> are well tested, known to be working, and usually contain workarounds
>> for specific issues. They don't want to do "Arm wide" common metrics for
>> existing cores as they believe it has more potential to mislead people
>> than help.
> 
> So this is sad, but I'll drop the patch from the series so as not to
> delay things and keep carrying it in Google's tree. Just looking in
> tools/perf/pmu-events/arch/arm64/arm there are 20 ARM models of which
> only neoverse models (5 of the 20) have metrics. Could ARM's metric
> people step up to fill the void? Models like cortex-a76 are actively
> sold in the Raspberry Pi 5 and yet lack metrics.

I don't know of any plan to do so, although it's obviously possible. I 
think if some kind of official request came through some customer 
(including Google) then it could happen. But it looks like nobody is 
really asking for it so it wasn't done and that's how the decision was made.

> 
> I think there has to be a rule at some point of, "don't let perfect be
> the enemy of good." There's no implication that ARM should maintain
> these metrics and they be perfect just as there isn't an implication
> that ARM should maintain the legacy metrics like
> "stalled_cycles_per_instruction":
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=perf-tools-next#n49
> 

I kind of agree, I'm not saying to definitely not add these metrics. 
Just making sure that you're aware of the potential for some issues and 
conflicts going forwards.

As you say, the bugs can always be fixed. It's just that now we have to 
do it in two places.

> I'm guessing the cycles breakdown:
> https://lore.kernel.org/lkml/20251202175043.623597-48-irogers@google.com/
> is okay and will keep that for ARM.
> 

Yes this one looks fine.

>> I'm commenting on this "lpm_topdown_be_mix_br" as one example, that the
>> equivalent Arm metric "branch_percentage" excludes br_ret_spec because
>> br_indirect_spec also counts returns. Or on neoverse-n3 it's
>> "PC_WRITE_SPEC / INST_SPEC".
> 
> This is the value in upstreaming metrics like this, to bug fix. This
> is what has happened with the AMD and Intel metrics. I'm happy we can
> deliver more metrics to users on those CPUs.
> 
>> I see that you've prefixed all the metrics so the names won't clash from
>> Kan's feedback [2]. But it makes me wonder if at some point some kind of
>> alias list could be implemented to override the generated metrics with
>> hand written json ones. But by that point why not just use the same
>> names? The Arm metric team's feedback was that there isn't really an
>> industry standard for naming, and that differences between architectures
>> would make it almost impossible to standardise anyway in their opinion.
> 
> So naming is always a challenge. One solution here is the ilist
> application. When doing the legacy event reorganization I remember you
> arguing that legacy events should be the norm and not the exception,
> but it is because of all the model quirks precisely why that doesn't
> work. By working through the quirks with cross platform metrics,
> that's value to users and not misleading. If it does mislead then
> that's a bug, let's fix it. Presenting users with no data isn't a fix
> nor being particularly helpful.
> 
>> But here we're adding duplicate metrics with different names, where the
>> new ones are known to have issues. It's not a great user experience IMO,
>> but at the same time missing old cores from the Arm metrics isn't a
>> great user experience either. I actually don't have a solution, other
>> than to say I tried to get them to consider more unified naming.
> 
> So the lpm_ metrics are on top of whatever a vendor wants to add.
> There are often more than one way to compute a metric, such as memory
> controller counters vs l3 cache, on Intel an lpm_ metric may use
> uncore counters while a tma_ metric uses the cache. I don't know if
> sticking "ARM doesn't support this" in all the ARM lpm_ metric
> descriptions would mitigate your metric creators' concerns, it is

Probably not necessary to do that no, but maybe some kind of header or 
documentation about what "lpm_" stands for would be good. I don't know 
if we'd expect users to know about the subtle differences or what lpm 
stands for?

> something implied by Linux's licensing. We do highlight metrics that
> contain experimental events, such as on Intel, should be considered
> similarly experimental.
> 
>> I also have to say that I do still agree with Andi's old feedback [3]
>> that the existing json was good enough, and maybe this isn't the right
>> direction, although it's not very useful feedback at this point. I
>> thought I had replied to that thread long ago, but must not have pressed
>> send, sorry about that.
> 
> So having handwritten long metrics in json it's horrid, Having been
> there I wouldn't want to be doing more of it. No comments, no line
> breaks, huge potential for typos, peculiar rules on when commas are
> allowed (so removing a line breaks parsing), .. This is why we have
> make_legacy_cache.py
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/make_legacy_cache.py?h=perf-tools-next
> writing 1216 legacy cache event descriptions (7266 lines of json) vs
> 129 lines of python. I'm going to be on team python all day long. In
> terms of the Linux build, I don't think there's a reasonable
> alternative language.
> 
> Thanks,
> Ian
> 

Comments and line breaks could have been worked around by bodging the 
json parser or moving to yaml or something. But yes having a big formula 
in a one line string with conditionals wasn't that great. The biggest 
problem I think this fixes is the fact that it fills in missing metrics.

It does however make it harder to autogenerate using any formulas 
published elsewhere. Whether that's actually an issue or not I don't 
know because these are going to be changing much less frequently than 
something like the event names that are published in json (and there's 
fewer metrics than events as well).

> 
>> [1]:
>> https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/tree/main/data
>> [2]:
>> https://lore.kernel.org/lkml/43548903-b7c8-47c4-b1da-0258293ecbd4@linux.intel.com
>> [3]: https://lore.kernel.org/lkml/ZeJJyCmXO9GxpDiF@tassilo/
>>

