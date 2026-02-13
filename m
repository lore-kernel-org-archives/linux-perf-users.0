Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16B54723
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770986836; cv=none; b=tOyQrsIyPZt5X0Qh1j7nLRAgY8RmCHEGXCC0W5qXtRjUtcXGRF/vXy8hZrHSBH7YKvd3a/4fFTQnKM0t+K4G69tfPGc/GoRl6yzJDJp4KGglsW91WxdvfZWEkBb5A6LkbTvzzW8l4AYGnHpC1lSyE3+ES0yyT2lOuuOXb/oPEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770986836; c=relaxed/simple;
	bh=GJQKyxMKeIwUMNaqGqI3GjYYc9dshXXmMY1i8cABEEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beZ5ev/5xDf5ZlvgVTqC0YDCNbcnTVd0LP7otSpSED6S+hcAG8yhEMVWdMz6tWK7NQAbEuhTcU456HJiFTea5llFOxvEDu6pAl9hr3ZozmKPEX0/pHajPQvg3aykR1lDJXeXQJ1npqUX8Y/efLBWtv0ikLZShIiGHJhUKnPn7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=abjwA80p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTAcPqLJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="abjwA80p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTAcPqLJ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D7Mu5u2628874
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 12:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hz49KUx/6rV5fZzso3/gWIKFBBoA6xue+2R0C5UdHSQ=; b=abjwA80pMwgweWNj
	j4Sc4m/bdS0cblwumDJbefrdpg5m8TYvadaUes/oJ3XOFLDWv9B8tRVm3QEHizwd
	hbwMS9QuH+rs3sYvSPosorzcjZKUbFOmi9b9Ft2q66TbfBwXDUUFMEPTQYFHBCke
	9A7IjW9t3fRZeg6N5q5fDerOVu6F8tEhCAaSlLT9O4NBL300CBGgdLlrXAfbVRqv
	pZArbcs2appdHg1LLTqfpHNw5YUaNZDTnuRrOHCPV2v09e+rvai6Spviih5BCoOp
	NwVYG7zaGk/0SjHIA1aCWQGYZBGAEe0rMwYifaZJDDr97A8P7CQeyf7tYapNx+Ki
	k9SI0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9ygus3gs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 12:47:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a75ed2f89dso11461465ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Feb 2026 04:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770986833; x=1771591633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hz49KUx/6rV5fZzso3/gWIKFBBoA6xue+2R0C5UdHSQ=;
        b=QTAcPqLJmw0CMfGwr5srGUe7s/2Hk3lVF3hqhle5JYGccsRXeYZIoMIbSix9m9SmGa
         PL+b6ht/MTRPLfX3HvGBBuanKydD3599qAdS17XrQqyHmzo+v++cQVxqfqVFJGyJAyZM
         P2TmA2xRjjbWGAP0awOPLNak4IxcGEjIVEY5pJXJlmra/x6wQwuwGnTmOGaM7ds5+rbh
         V6smU/qHzh7zStCRHMECDR7M/Oa/QNTjic7uWVJ+526aWOmvIcId9PLTu6tIAVQ3Oxb/
         GT35AkwFVO4judfn0zCUtASOkahQxNHEsRfu2t4D0YchFfVNnDO9syMey/8R77LgqycS
         cpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770986833; x=1771591633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz49KUx/6rV5fZzso3/gWIKFBBoA6xue+2R0C5UdHSQ=;
        b=IcuMS4GAygxbbk3ERZzFTuczJerxV9ozSFs3AMeVqgFnBgmIZWaG0XBx45mwsOUY8a
         tcqhpjs/9EffY+LViidxFkDjbYcy7VdbOXwbG+QJ4s8sgMWmpWo1/3p1k1vg20vm7B5D
         NbR/GUtLxEaLou1s7c+9m9oaXykiZsN9MQu15LStvOx1Ew5ngpfyM2p0BT0DZudKTZvm
         rU2WTsxmkNReRPRA7Bqq+1Z45yQL2jU9GnjFWcl+y7CeNwBPWpEmaoNoKywDM09mt55E
         lfqpszfYsXkA/0a4QDSbe5DXHVnEMAqQnPgDCDDnst+8iX0AE+/g2b38pwqkvFqM8bDH
         eadQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3uZSyLMlnPJyX/9FINIYPUxdxIpR9Nzi32kBzYp87KjIzMZfAXqUXg/XdoliZi8SO8J0zkcAikyKKkQ798SC4@vger.kernel.org
X-Gm-Message-State: AOJu0YycTgkEYEoi8tPWp3evGD8AThf80e7XIRUI4G0Uk3CgGl5G666Z
	ZFa0MTJrcD6xr8t40P+58OoAjk/2QEVUNwyXdftufZ+uX9oOqz0W9fkqHIMZEk46/8rDWMEALL+
	snMg9XiYC3ODaa6r+EBUT95JJlaf23a8T9iopCWRNnch/WwegCot1jLKSw5AkFK8DPgpdW5Wk
X-Gm-Gg: AZuq6aJ1eC2aD2mRvvrly240Ow3Y6gQ0qn2JTywYQoegDlbp/Sser2kK/zroQkhbn4t
	zGyvEIWcbPNBfIwStERl+X6mKP7FqossrsQQbwnkKEAZoQG7w+Fw0pVDPRCizdNgkd2x+iMCz1t
	NycWyhWrRd6lramy6ByrlHI22jL83hsyKXr8aIBvBhGr3lxlI2NdwZNT9QXZAU9PgYunr+Ajk5F
	onaPwc7zngNsI+uTFRyQcHJwAAO6zKwu3VsDBKwPdzsu6BBtvrCeIra5bBRSJk5sxmP7Lq+86bJ
	7oM9mzbVAwfYujEwXzoHzYudpRCcSN5XSaY50zp2oDMX7G80qVny1WUpo1iELMwdjGANEumQWa1
	cxN02MrhtY5INuYneV4F7RkCsjHVMVgjzhimB9ve001RjnFiV
X-Received: by 2002:a17:902:d2c4:b0:2a9:484c:ff30 with SMTP id d9443c01a7336-2ab50519b94mr22192935ad.26.1770986832657;
        Fri, 13 Feb 2026 04:47:12 -0800 (PST)
X-Received: by 2002:a17:902:d2c4:b0:2a9:484c:ff30 with SMTP id d9443c01a7336-2ab50519b94mr22192625ad.26.1770986832055;
        Fri, 13 Feb 2026 04:47:12 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2997b3cdsm81299475ad.70.2026.02.13.04.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 04:47:11 -0800 (PST)
Date: Fri, 13 Feb 2026 18:17:05 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Zw Tang <shicenci@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        mingo@redhat.com, boqun.feng@gmail.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        namhyung@kernel.org, will@kernel.org, juri.lelli@redhat.com
Subject: Re: [BUG] PREEMPT_RT: sleeping function called from invalid context
 in perf_event_wakeup()
Message-ID: <20260213124705.hpxaabypmuj4pfwg@hu-mojha-hyd.qualcomm.com>
References: <CAPHJ_VK1t=pRw9zct9CNRET1=uH-efB9grAJ-kGJEN=PDk7z0w@mail.gmail.com>
 <20260205110855.GJ232055@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205110855.GJ232055@noisy.programming.kicks-ass.net>
X-Proofpoint-GUID: 7TQwwKKacxCiwvuMPqCtQurBSH7pm8eo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA5OCBTYWx0ZWRfX3vuB30wyXJJs
 p7aqVtgm5WQ4tC/95SUYFbejT+tNPdzJkboAljVj/0JU7Rcbmh6X5yO306FAcako9YL6isiPsUv
 eQdhWzXClOJ5UVbgsLCr6Cpng43I/l3VdKFlyHdGJaTKK7uEZziUynWf1Ch+VhnZ2I7cUmjXA/k
 f0uqOmVOdQKjBsNDX7r0vfbWaAygbbC/vvlCO5u2p8W8+vFJ7aAcToTOkE9d/cdFq1i3ouV1WVx
 lvu8QwiQnljcvJDoFX/bEiQf7ZcnEsPBqhNFAFskXXmEvNzzTs4UOC7czeD57DlLU+2Sh3ARH4M
 PERo+ckzNDyqInEUZP5eEYpgqXiQb+vkc8TBllyLDhG9ydADOPWms+nvxjpBGUTXJM47yBo5Qbw
 0zyTae+8grPgMAyz62DA1CELrSveNGDelkkfg2zvBcfPHLbUaY8i6fBQAXZWHD/zf2Nol65Iqjo
 uE91sOqHryJI5FHkBlg==
X-Authority-Analysis: v=2.4 cv=If+KmGqa c=1 sm=1 tr=0 ts=698f1d51 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=z8WdLUalEY_3kROG54kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 7TQwwKKacxCiwvuMPqCtQurBSH7pm8eo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_02,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130098

On Thu, Feb 05, 2026 at 12:08:55PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 05, 2026 at 06:42:05PM +0800, Zw Tang wrote:
> > Hi,
> > 
> > I am reporting a PREEMPT_RT “sleeping function called from invalid
> > context” bug triggered by a syzkaller reproducer on Linux 6.19.0-rc7.
> > 
> > The kernel reports:
> > 
> > BUG: sleeping function called from invalid context at
> > kernel/locking/spinlock_rt.c:48
> > in_atomic(): 1, irqs_disabled(): 1, preempt_count: 4
> > 
> > The splat points to perf’s wakeup path taking an RT spinlock while
> > running in an atomic/IRQs-disabled context:
> > 
> > merge_sched_in()
> > -> perf_event_wakeup()
> > -> __wake_up_common_lock()
G> > -> rt_spin_lock()
> > -> __might_resched() (complains about sleeping in invalid context)
> > 
> > This suggests a locking semantic mismatch on PREEMPT_RT:
> > perf_event_wakeup() (via __wake_up_common_lock()) ends up taking a
> > lock that maps to rt_spin_lock(), which may sleep on RT kernels, but
> > the current context is explicitly atomic with IRQs disabled.
> 
> Fixes: f4b07fd62d4d ("perf/core: Use POLLHUP for pinned events in error")
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index dad0d3d2e85f..216cf6ae1c7d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4017,7 +4017,8 @@ static int merge_sched_in(struct perf_event *event, void *data)
>  			if (*perf_event_fasync(event))
>  				event->pending_kill = POLL_ERR;
>  
> -			perf_event_wakeup(event);
> +			event->pending_wakeup = 1;
> +			irq_work_queue(&event->pending_irq);
>  		} else {
>  			struct perf_cpu_pmu_context *cpc = this_cpc(event->pmu_ctx->pmu);


Looks like this https://lore.kernel.org/lkml/20250603045105.1731451-1-namhyung@kernel.org/
got unnoticed.

-- 
-Mukesh Ojha
