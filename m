Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066B1E47C5
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760547; cv=none; b=G8W48So2E5ptKosPhSS2NlIq1DPAYqrte82kyfGui6G1EDmPXvUg75lpgF1HbOXNqpOIB83TyRtv3L+v3jT1sgDXQoikJCp82EC5j9VXAGK0de/CVbKsnaASV3bacJVAy2RssOUxO9MfCaF6oZIcMhJJ057DwJjYG7ugQCdr1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760547; c=relaxed/simple;
	bh=lJ5zKooiKzbg8+escUbbnQhwFlA5qAdIRzAYA7f4WWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9orD1Ot5KHQtPjsZ/gVKTo8pRhvvrkzgdq74pbLVTKpQmUYVpWGubnLBdBP6qk+8WXEssAerYp2TzohiumdOXOJklmZgVVyyFCTFyfA6fDAy/4450jkGiyhWXUNeagaL73+Lw6+hpfKzz3Ojv8EQi3AMbdX3yNJKb5cd0cyiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSPzG7M2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dnLHoONW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSPzG7M2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dnLHoONW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TGJnYV3448105
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 19:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8I++PrbSy0ZEcGYwTL0DodAEWjo7ZIRg4CczMtI/2/0=; b=nSPzG7M2goE4mc00
	nfGAz8JZuftvoOCPPTGON8zmNL8i2OJXrQd6+7DSaOuEWTTKi0admbMXwxnECo1q
	YovPb2Q0DmzK5jXRdvf8vHuET8aNfeQeWUCvTAMrCW3r1buQteUevfYpYAtOUI54
	WDt5HOi/h/kTgxRy4J8IqiQLHu/VNzXDEoZ35mkgtV4WwE/BBjlivbn4/UtEwcHa
	hmuBGzqqNiG2CV5UWxwMqGftOOxyhphkVdXiJAeVx5P8Qp86/bZemMHE2hdEdKy9
	2nKPZkCv3mTs4ZmBk1VGSreVIFaJHwx0z/cb6RdKphpnLoGvKry2MJyb3wlxQWHl
	7bRmeA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qhaa5b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 19:15:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30ec59471a3so1203596eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782760544; x=1783365344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I++PrbSy0ZEcGYwTL0DodAEWjo7ZIRg4CczMtI/2/0=;
        b=dnLHoONWx3HnOmJSihnBYyOwSr8Ni6wuP9gWVqJKWMAOegVUAQqCCILEo4Yrjg/j14
         9unwSF5GpJtWmYsMPvKCrzC1zADz5z6vzZ0BuDeyND7YHcuUBcf4/KxkXVA4K9vzZUgR
         pXCwzCRGogJT6keZIDCySRQXVEZ4aJaoxYblWoQL3g9hyPRblLnQ06rGh0gevqoNlVuU
         tZ/tajj5DOAzqvprfsArKaChuCc+12TS554I0aAu7TeoA3PN1eavL0efI/2niViLr5vo
         H8+Rz39rNQji+hydtFDqYyldC1Zy+dunWFIowL5gG4dEKAc3WWTo99WHUiS15HvfmC5S
         7M3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760544; x=1783365344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8I++PrbSy0ZEcGYwTL0DodAEWjo7ZIRg4CczMtI/2/0=;
        b=PD67jaLnJ839EoW5w34lrrsh/yX3/kdWmSSWKsUmzi9GdvyJ/vZ6X79Qxdf5T28cW5
         2UjawzpcKTrAXAABsuYOKd/KOs4ENDQEY79lj/7zYR4KVyV40UG0+C28QUnjA6kxwPbJ
         aI5SZCxaDZiDpGFamTlm5gNCXfRQJlc3kI4b1gCxyvYbPE6Gx32BSAgRkBWLsWBQh8ED
         S9zar+CSNvzA7VhoUFJtC6uNxMbVEns4/5PSwxEZmYWUx9yNWGSAXqVYUQXPV62C5XjI
         d6vGgyCF5CsU0GUSXIUI5kx3wEy6HDPlDoJn9hRgonsHuK6qcKuFeUHRRumJ6j1SIro6
         xHFw==
X-Forwarded-Encrypted: i=1; AHgh+RoTp/2y0l9VeApDJ/diece22bjSNV2eXURFa2NRR02Kt9edMrDSNj7FU+CUdFfzfcTvqJe9FmbDWayUu4YAM9zK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5adTO+HpLdhvfO/GKdx7N/67WZVcRjC4StXtrb3mmedV7+KhC
	qwhj83djBhZCAYPvnCWAHsIcIkN/QIsut7toQ1X27MTXMIG55g4yZmCTo2LELhi9qUnztPYj8/4
	0HAM/CjKp/bxtsBSkSxpTS5jNXH3+dgpOT/+93PBWgUsIN4IsLND14GvRuYQKkap9l6BMMOL8
X-Gm-Gg: AfdE7cmmjCb2ADIQQohynDVz6IxuMLYXMgolZwAJSOSHEC46IcG5+46Z7txhm0o67x8
	Mw0xhPatRyenSwb4KSzRzlpALQyxy6ZVsiGZnqfVKsESIjBdNbtuJejiBAIPzwXtgCX06dwqmH3
	HQApy1Bag9McZ+DKyn/KNwcVWmcWbxPmD3WAilTmHozoATBepomHZ7vpnpd3DEAQrXxwbH8zgqQ
	ZOoULZU1bfCA7AH2E7Wolf4jEKl8apkeTVH8DkoBb8ccbnretIXWuaeYC5/1xLw95AExSSWcvt2
	re3gk4qXfoUVm7x3vjA28aKiIX3ICY2EsoBeJSmMMZgosZylkiiqF557iOpBtS/pO1Fx4HC1Aw3
	47kZnUKIOpFQFSy/o7vTDDsr0btJ8Ek/lwXlWyWEoBwMpBw==
X-Received: by 2002:a05:7300:214f:b0:30c:ab96:7302 with SMTP id 5a478bee46e88-30ee1c8869bmr348310eec.18.1782760543857;
        Mon, 29 Jun 2026 12:15:43 -0700 (PDT)
X-Received: by 2002:a05:7300:214f:b0:30c:ab96:7302 with SMTP id 5a478bee46e88-30ee1c8869bmr348277eec.18.1782760543193;
        Mon, 29 Jun 2026 12:15:43 -0700 (PDT)
Received: from [192.168.1.7] ([122.177.244.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5ed29sm418697eec.1.2026.06.29.12.15.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 12:15:42 -0700 (PDT)
Message-ID: <608f1601-cef4-4c66-9d82-8d3827e8ac50@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 00:45:34 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/core: Fix group leader use-after-free after sibling
 detach
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260626-fix-group-leader-uaf-v1-1-ac54652ca944@oss.qualcomm.com>
 <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
 <bdca57f5-fb8a-4556-b5f3-13beec0cdda1@oss.qualcomm.com>
 <cbd90339-f6c1-4986-8727-50a6c1b24d76@linux.intel.com>
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <cbd90339-f6c1-4986-8727-50a6c1b24d76@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: civB6sY-LwzKViGouTqH6DkkfUmwah5s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE2MSBTYWx0ZWRfX7aJ0xsmDI/8B
 mgglW4hC5lQHUM9ZG/loIPf8AG2obHPWXKYW4gKx7xatKx8LYsM8c8qV834MKo1J3OtVlJgG1YZ
 lHvpHOxMdN6k4N3ManBdm+5A7vtVoqIwaSdbsvxLRzpjfJdfS49AJq6/aE0afpVUfnHVOBwoAGE
 TxPTUbML2MPgAQNMJOxfhyzEiiPLoVa4wjw/AGICWIHEHxKWWJjRTyUDQjz3M3NQgIwXLnLufi4
 KLN3bk3dJCP2ss+IkmtZzlsw2XRZ5Qg95jSuv8o3mGZmpz9mHxb+XmbKJROYo2kaT6OnCOBEQkA
 N5RKz6NdS9lv0qgeLVCFvOYh1rjvEYOqvy3LSXQTl9ASEmRmegF4BREkuNQnmbx16cUEe3icK1P
 ZqVuvdTOfiyz2awZjLtqR/5zmamKbBeP3Zz8+sPteT+I/NVifxhIWEseqou2CYpu4YyCF+jjZyJ
 iZ1CpWr8VIREmDRW/+g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE2MSBTYWx0ZWRfX9n8x+TygT9aV
 jP9uE5+qCNR8Cb2bvpv/LjPeFuy/DMaRf+XBYpvlPyRz80DO0u5LiPJEph4l3VUw+dGFFJyjMrz
 rJwtiFC3v9dN2alO6bRRPBdxgWcPiQc=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a42c461 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=cBpEFP3VsKMDvY265z5wtw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mKdH2X2G3I8vq56XIfkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: civB6sY-LwzKViGouTqH6DkkfUmwah5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290161

On 6/29/2026 12:36 PM, Mi, Dapeng wrote:
> 
> On 6/29/2026 12:00 PM, Aditya Chillara wrote:
>> On 6/29/2026 8:28 AM, Mi, Dapeng wrote:
>>> On 6/26/2026 5:54 PM, Aditya Chillara wrote:
>>>> perf_group_detach() handles leader and sibling detach differently. When the
>>>> group leader is detached, all siblings are promoted to singleton events and
>>>> their group_leader pointer is reset to themselves. When a sibling is
>>>> detached, it is removed from the leader's sibling_list, but its
>>>> group_leader pointer is left pointing at the old leader.
>>>>
>>>> That is harmless when the sibling is being closed and freed immediately, as
>>>> in the DETACH_DEAD path. It is not safe when the sibling is detached but
>>>> kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
>>>> sibling is removed from the context, while its file descriptor can still
>>>> keep it alive.
>>>>
>>>> A typical failing sequence is:
>>>>
>>>>   - A group contains leader L and sibling S.
>>>>   - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
>>>>     L->sibling_list but leaving S->group_leader == L.
>>>>   - L is later closed and freed.
>>>>   - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
>>>>     dereferences the freed leader.
>>>>
>>>> This was reproduced by running the perf event fuzzer, CPU hotplug, and a
>>>> stress workload concurrently:
>>>>
>>>> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
>>>> CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
>>>> pc : perf_ioctl+0x34c/0xc68
>>>> x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
>>>> Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
>>>> Call trace:
>>>> perf_ioctl+0x34c/0xc68 (P)
>>>> __arm64_sys_ioctl+0xa0/0xf4
>>>> invoke_syscall+0x58/0xe4
>>>> el0_svc_common+0xa8/0xdc
>>>> do_el0_svc+0x1c/0x28
>>>> el0_svc+0x40/0xc0
>>>> el0t_64_sync_handler+0x68/0xdc
>>>> el0t_64_sync+0x1c4/0x1c8
>>>>
>>>> The fault happened in perf_ioctl(), where perf_event_for_each() follows
>>>> the stale group_leader pointer and perf_event_for_each_child() then
>>>> dereferences the freed leader's context.
>>>>
>>>> Fix the use-after-free by promoting the detached sibling to a singleton.
>>>>
>>>> Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
>>>> Assisted-by: PatchWise:gpt-5.5
>>>> Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>>> ---
>>>>  kernel/events/core.c | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index 954c36e28101..dd9892040ab2 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>> @@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
>>>>  		perf_child_detach(event);
>>>>  	list_del_event(event, ctx);
>>>>  
>>>> +	if ((flags & DETACH_GROUP) && event->group_leader != event) {
>>>> +		/*
>>>> +		 * list_del_event() needed the old group_leader to tell a real
>>>> +		 * leader from a sibling. That's done now, so make the detached
>>>> +		 * sibling self-contained.
>>>> +		 */
>>>> +		event->group_leader = event;
>>>> +		event->group_caps = event->event_caps;
>>>> +
>>>> +		/*
>>>> +		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
>>>> +		 * the event to ERROR state if it is still alive.
>>>> +		 */
>>>> +		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
>>>> +		    event->state > PERF_EVENT_STATE_ERROR)
>>>> +			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>>>> +
>>>> +		perf_event__header_size(event);
>>>> +	}
>>>> +
>>> Why not move this part of fixing code into perf_group_detach()? It seems a
>>> better place to fix the issue. Thanks.
>> Because list_del_event() just above my change does:
>>
>> 	if (event->group_leader == event)
>> 		del_event_from_groups(event, ctx);
>>
>> so resetting the group leader in perf_group_detach() would attempt removing sibling
>> event->group_node from a group rb-tree it was never added to (only leader gets added
>> in list_add_event()).
> 
> Yeah, but I don't see why we can't do same thing for the sibling event
> detaching in perf_group_detach(). Just like the group leader detaching,
> each sibling event would be re-added into ctx groups by calling
> add_event_to_groups(). Suppose we can do same thing for the sibling event
> detaching, call add_event_to_groups() to add the standalone event into ctx
> groups, right?

Yup, that's a cleaner fix, sent v2!

Thank you,
Aditya

> 
> 
>         if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
>             add_event_to_groups(sibling, event->ctx);
> 
>             if (sibling->state == PERF_EVENT_STATE_ACTIVE)
>                 list_add_tail(&sibling->active_list, get_event_list(sibling));
>         }
> 
> 
>>>
>>>>  	if (!pmu_ctx->nr_events) {
>>>>  		pmu_ctx->rotate_necessary = 0;
>>>>  
>>>>
>>>> ---
>>>> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
>>>> change-id: 20260626-fix-group-leader-uaf-c46960e525e0
>>>>
>>>> Best regards,
>>>> --  
>>>> Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>>>
>>>>
>>

