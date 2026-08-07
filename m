Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2D45516A
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085671; cv=none; b=BR5QWNb8NduvnYXx/pkv5JpZyGBV0x8pa75ep0HjiSNpvme4fBQK1Yj2MMoS/3PaP7LuoFVGMk8/Y9MKe/DHDsKnnuHOA327YcvJKBzlLZZ68OGsmaH2pVTOLtLRfm6Th1YT0QgszkSp6zOHVyzyfFGoiMTuzt6UReIIqPJbDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085671; c=relaxed/simple;
	bh=tug7sQswO90srQ+3Q3AllW5rofm8ksyrqn6GVbehczM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSNtcI1sicgd/Xb7LSKtMApABDLIFd/+xoKmB7/TODVtEI22liOXrDHIoYyU9ruaf0tFeRhlFJnklyEffvg1a5b0eu9dj6XxMg+M7+uhlVO8z9lP0WEgBTBo9xrT2Vn1szTL2+5wt5zGZxa7MXMAifN/yVCOssug4GEjvnTmx4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=leP7pXFk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IPiNG1bB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="leP7pXFk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPiNG1bB"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Gl033564366
	for <linux-perf-users@vger.kernel.org>; Fri, 7 Aug 2026 06:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=; b=leP7pXFkWUrClpiK
	Ickn3XtAgxSfXj1RcXk19Fme9576WrJTTDMaZSJU07Mgj2wZsNes11qS68wbdh2H
	P47d9fu8iq0YdAf9e4qVW6vKLxHu6g+ifk2a2KzRAQR0vcveEum2mcTMF96zr3RS
	0JAa3Z8nram284q7ytcuHKTc3uPJv+lKSDqijUfwc0Mt1SH9RSA1R12J9xNFP5Us
	M56gzuo0/BA1UQEezcoezE0mTRMD7MslN1ldkO9ARVqN67vO+9UVWBQLshNkWpTV
	L9YB6ScdVgJWNHhK9Y0o8NHaQoaR4WcAabzRW+Fp60feDrNW3qEEwX1qZucKels+
	E/pwog==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6jtjcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 07 Aug 2026 06:54:27 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso3575245b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 23:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786085667; x=1786690467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=;
        b=IPiNG1bBH/7U+qQ2DRKrxq0ygk8MWpSybGa35jIyN/ViERdJW3bx0q7Zl7JvoQAPQU
         mIpxirltTIOnPLNeIf5rXdZMtG33C3Vh7DesUjdk3SRRVcRi5fsefMpi+KCG2PpVdmOC
         5n6pcK9+Fg47kMaRZYy1cKAq3j576MhWLQCsNJkuPzfE0+9Bb15jm77q7hgcyZOC9Tsz
         7s+g73xi5cd7PI9CrVQCEM135mjNxTnb1El3GItyW8nDIdp0j1LRBMUfkcp4QNNTjRwx
         SlVTg5R7UizLXDoiolOZFuinopGOSHv25LSotzec5hISazaoZ3lWEwOXP5j+JDmGUnGm
         ++rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085667; x=1786690467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZeOBTbYHrkUTwW5imyA1ZIjKriCPkAvo/0a6LVyIW64=;
        b=sGhIflfEk94CRyfj3CEk0VpGBJLEA3Qr+C5h93TFPnkVZ4nqydMZXKj4RBLGgmGMcM
         CndHr8+E2pSOUn7NcLiAbKWYsfAMWTo0HnWrkUfaxcJY0biHyUF2ykOxq/f+LQ0T/b6h
         mmXlSj5EZKPY2CSo10JVjZX9mukF5WrykPGZUHNCYTM/d4oXymbsb0ylyirWkRJ+8pkb
         l5AQ0VNYFW/YD/OU9PBWrev+ACl8sOjwxnF6U454y/ir36e7UQQY7PKkehY33qzVxTSm
         JPCn/JGglMDDvjWyLzidIk7X07AapAf1ypBOAPGraKai3WIaUoVBTINg4XfANt+PnACG
         O5BA==
X-Forwarded-Encrypted: i=1; AHgh+RrZcgvwHf7+2lLuCTGJWcxKiEIEKExgqWMcFJdYQTFdVTzuQmj2ezeO8NhIDVGAS1dbL2I28htGPf1bvNv46TA1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywugy8Gf1+PZ2A00QHf/PNV2lhL2lENArnbWEurThg430XW70zz
	XzpV1YBrFhKShy08zAQ9ZoYYoqRy7jjnNJum/hwPa3wEDHzlunX3dEnY2A/hYfj27xW5heANuUK
	U3Ml7yZkeRIVgnN/ZB/uCulIZhdy00qQ+7FBP5hHoyr8AgvRBB5/FK1gkcxYGLzpfm7ewk0ff
X-Gm-Gg: AR+sD10YATzqbQ/g7clvBM5THGU/qyOOG0vQMvABFWxoV10GdEzkEcKZdKrG1ZsbxC7
	p2/8E5YfqEIfPIzrs4HXz1BsgwXIIVr4kOtVcxMcBVROsLGku52QnG0W0kffTYd7lLcJVjj40lE
	oSuAIz1W2BLVs3lmWqoANpgscJ9Ziecpz3TiUsVbP5REGz7DCy1Xv29FPb7yaVp04r+rphZmAcK
	zhyqKYJLl2kdz00LcBiqGhXUHfhXSp3yEkacQ/muusWxuzl6ki7E+aXz7EXRqtVG3cVqs4t9TYp
	UwGmmAevs9/9ozeFSE+uNZpPcz1SgeB+GA0q7fvtfDGU5Ih/fzUIguSZdubOzi5YH0Mdkow0E/l
	d9wH7XwtL8XUrAQN8bNpoDJbWVnIlbRDqjg==
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr25217926b3a.5.1786085666432;
        Thu, 06 Aug 2026 23:54:26 -0700 (PDT)
X-Received: by 2002:aa7:9303:0:b0:848:6b76:592f with SMTP id d2e1a72fcca58-84f2e021ecfmr25217866b3a.5.1786085665952;
        Thu, 06 Aug 2026 23:54:25 -0700 (PDT)
Received: from [10.218.24.187] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a188esm510948b3a.5.2026.08.06.23.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:54:25 -0700 (PDT)
Message-ID: <9a965b40-c15d-4802-8d55-aacb9ad33987@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 12:24:20 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/core: Fix group leader use-after-free after
 sibling detach
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo
 <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>, Ingo Molnar <mingo@elte.hu>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260630-fix-group-leader-uaf-v2-1-9349121835ee@oss.qualcomm.com>
 <20260806195020.GR48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <20260806195020.GR48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Rt/16imK c=1 sm=1 tr=0 ts=6a758123 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6HyQyo9fOVBPkGHd9gEA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1MCBTYWx0ZWRfX4GZysSSdruKg
 WVrf7bn/yPFQ2io8SK+zxGsmBhlLlxdoGJQr2EJKxBKdpmQefaiLvsvzqFzOsAeHmkbU7TWFT1l
 E2TgXPT/RjzMl9ChtJrrwg4aAezpg2bLksjd0+Toh2VfVb5z5W2sI61HSBe4ttuV0el5aMmCmvi
 DHPl+el1XQHWieP7xL9NjT5Bhw5dMpeByri4gwgIm0BcD7evwG/6dZGGjl+/p4hFeOEut7uJbwk
 MsoNFVINO05jkR/4iEREtsPOPNdmQRmIxj6FwhIOeMtEdKsKgrVCnYEhlJN+BqxQlsI1e/E8khY
 45I3bD/GLb0bzLsQuuCd5aeFvjvzddkswx+TBOGag82oIwSQxMsgUZi5xtlySkBLRZ+LLIXouT9
 WO4+6OFLmVAOGmvPTEvuBvqXvz0GjyGxEsDWi3vCaGmb9URYY5qG/ENcdcbF28HVv9QExANd2NN
 UYD8eVASnDDk8oQV15g==
X-Proofpoint-GUID: eCintydCipRCj67txAVcEvf-V1mVUlzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1MCBTYWx0ZWRfX6ZfMLvm+d77a
 CuZsfGnoaAdkVD2brgmVm0HFlJrW/k3nw1tXSaw1Nj8kLb9N43Dy5+K7qgJuGRBYtc33ug+8ELu
 bO/oEkbodwu2HNww3XpfdsPEXffpKtE=
X-Proofpoint-ORIG-GUID: eCintydCipRCj67txAVcEvf-V1mVUlzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070050

On 8/7/2026 1:20 AM, Peter Zijlstra wrote:
> 
> Finally got to look at this. In principle this seems okay, but while
> staring at it, I had a few questions, see below.
> 
> On Tue, Jun 30, 2026 at 12:42:12AM +0530, Aditya Chillara wrote:
>> ---
>>  kernel/events/core.c | 62 +++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 42 insertions(+), 20 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 954c36e28101..744643ada948 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2253,6 +2253,8 @@ static void put_event(struct perf_event *event);
>>  static void __event_disable(struct perf_event *event,
>>  			    struct perf_event_context *ctx,
>>  			    enum perf_event_state state);
>> +static void event_sched_out(struct perf_event *event,
>> +			    struct perf_event_context *ctx);
>>  
>>  static void perf_put_aux_event(struct perf_event *event)
>>  {
>> @@ -2343,6 +2345,44 @@ static inline struct list_head *get_event_list(struct perf_event *event)
>>  				    &event->pmu_ctx->flexible_active;
>>  }
>>  
>> +/* @sibling must already be unlinked from its old leader's sibling_list. */
>> +static void perf_promote_sibling_to_leader(struct perf_event *sibling,
>> +					   struct perf_event_context *ctx,
>> +					   int group_caps)
>> +{
>> +	/*
>> +	 * Events that have PERF_EV_CAP_SIBLING require being part of
>> +	 * a group and cannot exist on their own, schedule them out
>> +	 * and move them into the ERROR state. Also see
>> +	 * _perf_event_enable(), it will not be able to recover this
>> +	 * ERROR state.
>> +	 */
>> +	if (sibling->event_caps & PERF_EV_CAP_SIBLING) {
>> +		event_sched_out(sibling, ctx);
>> +
>> +		/*
>> +		 * The guards keep this correct even when @sibling is already
>> +		 * disabled (see __perf_remove_from_context()).
>> +		 */
>> +		if (sibling->state > PERF_EVENT_STATE_OFF)
>> +			perf_cgroup_event_disable(sibling, ctx);
>> +		if (sibling->state > PERF_EVENT_STATE_ERROR)
>> +			perf_event_set_state(sibling, PERF_EVENT_STATE_ERROR);
>> +	}
> 
> The below code used __event_disable(); and this change is not
> mentioned in the Changelog. Why was this changed?

I should've mentioned this in the Changelog, I'll update it.

In case of __perf_remove_from_context(event, ...) where the event is part of a group
but is not the leader; by the time we get to perf_group_detach():

1. perf_cgroup_event_disable(event, ctx) would have been called
2. The sibling's state may have been set to EXIT/REVOKED/DEAD if not OFF

So we cannot use __event_disable() because it would unconditionally call
1. perf_cgroup_event_disable() that would decrement nr_cgroups twice
2. perf_event_set_state(event, PERF_EVENT_STATE_ERROR) that could bring back
   the state from EXIT/REVOKED/DEAD/OFF to ERROR.

In previous code, in case of __perf_remove_from_context(event, ...) where the event
is a leader; __event_disable() was called for siblings unconditionally but I do not
see a reason why the added guards don't hold.

Should we move the guards to __event_disable() instead? That would simplify the code:

static void __event_disable(struct perf_event *event,
			    struct perf_event_context *ctx,
			    enum perf_event_state state)
{
	event_sched_out(event, ctx);
	if (event->state > PERF_EVENT_STATE_OFF)
		perf_cgroup_event_disable(event, ctx);
	perf_event_set_state(event, min(event->state, state));
}

Also, event_sched_out() in case of pending_disable calls perf_cgroup_event_disable()
and sets the state to OFF, but __event_disable() immediately calls
perf_cgroup_event_disable() again.

> 
>> +
>> +	sibling->group_leader = sibling;
>> +	sibling->group_caps = group_caps;
>> +
>> +	if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
>> +		add_event_to_groups(sibling, ctx);
>> +
>> +		if (sibling->state == PERF_EVENT_STATE_ACTIVE)
>> +			list_add_tail(&sibling->active_list, get_event_list(sibling));
>> +	}
>> +
>> +	perf_event__header_size(sibling);
>> +}
>> +
>>  static void perf_group_detach(struct perf_event *event)
>>  {
>>  	struct perf_event *leader = event->group_leader;
>> @@ -2368,6 +2408,7 @@ static void perf_group_detach(struct perf_event *event)
>>  		list_del_init(&event->sibling_list);
>>  		event->group_leader->nr_siblings--;
>>  		event->group_leader->group_generation++;
> 
> Here we can do 's/event->group_//'

I'll update this.

> 
> Also, this case 'leader != event' we remove one sibling from a group and
> decrement leader->nr_siblings...
> 
>> +		perf_promote_sibling_to_leader(event, ctx, event->event_caps);
>>  		goto out;
>>  	}
>>  
>> @@ -2377,29 +2418,10 @@ static void perf_group_detach(struct perf_event *event)
>>  	 * to whatever list we are on.
>>  	 */
>>  	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
>> -
>> -		/*
>> -		 * Events that have PERF_EV_CAP_SIBLING require being part of
>> -		 * a group and cannot exist on their own, schedule them out
>> -		 * and move them into the ERROR state. Also see
>> -		 * _perf_event_enable(), it will not be able to recover this
>> -		 * ERROR state.
>> -		 */
>> -		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
>> -			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
>> -
>> -		sibling->group_leader = sibling;
>>  		list_del_init(&sibling->sibling_list);
>>  
>>  		/* Inherit group flags from the previous leader */
>> -		sibling->group_caps = event->group_caps;
>> -
>> -		if (sibling->attach_state & PERF_ATTACH_CONTEXT) {
>> -			add_event_to_groups(sibling, event->ctx);
>> -
>> -			if (sibling->state == PERF_EVENT_STATE_ACTIVE)
>> -				list_add_tail(&sibling->active_list, get_event_list(sibling));
>> -		}
>> +		perf_promote_sibling_to_leader(sibling, ctx, event->group_caps);
>>  
>>  		WARN_ON_ONCE(sibling->ctx != event->ctx);
>>  	}
> 
> This is the case 'leader == event' (per not being the other case), and
> this we remove all siblings, but then do not set leader->nr_siblings =
> 0, should we ?

Yes, I'll add this.

Thank you,
Aditya

