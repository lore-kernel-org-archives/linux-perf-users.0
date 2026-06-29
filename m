Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606B4A32
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 04:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782705665; cv=none; b=fyQosc+M2w2RfkLeA0Dlo7P56ufp28Dpeg9jjdLBk9I7mUgCB3MpS+N1frCe8ZCbUm9VO7heCN2+50ZwWD+hSg1Ds0gyHyYafpxRO3UTbSnnpkFk/goScswLpLxFOc5lGNInyoa0MEYr5SSQIC7mNjwV1iyeJfBEFe8CyFbOz9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782705665; c=relaxed/simple;
	bh=3QkoE1jtNtq4n2U70SnB/hX4AkNxbV7a7d9DCgtjFME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc4li2t1ImoF5dQ7Evt0FumDNvzmMFmvSQ90fAJZM46f8G2CFC+dIPcs4Z8/J/9c/t+eQGThn4kyrRZUuOA2V9tZrOYAzmFX0WSoBH6QLX7Fd2PI/sfI4x+/jTh6Wi1WWWk3oxYCbPNltc17TI44Mj3IVqxp12wEwEIzrZ58veQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pyZsVxVM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIZY20Wr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pyZsVxVM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GIZY20Wr"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T2cm5n1514041
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 04:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=; b=pyZsVxVM6XSyaqW+
	VeAlx5wsghE2fas0aAgdufYZhe44kmLN+s+nhW+HibSItIlptqjGrvP4DNjQwhV+
	pUNYuTX4+TsJ6A14csUNEXJmH0EYrfOS6ulq0nwWVSQW6Ged4Qfhj6Gw7enArCa6
	e7NVGLEzSfnmgOCpmg+dXSm0kls2tDL5Fe2jvFtAxDtmQkISdLk4ZRyqMyocM6fv
	uoeERLNAU4elVXbsmdiRGSroub43gJcraSeJQNq1c1ojdoJAJDL/8OsNENWCovPx
	+7KReRTClnaQD1ugJQ8StBfbM74bCl1i2oUxNlkr3zNA/z3W+QR6ngTKyXC1p6Cn
	iQwGYQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cm93f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jun 2026 04:01:03 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137fc6f8e9fso4874902c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Jun 2026 21:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782705663; x=1783310463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=;
        b=GIZY20WrB4Zl6Bw0N1ZKMz+TOeEEMhFir7nnUJ7UnRJ0GaTOZbFofXuNaWgPV3qePB
         wJNygPRV3XVkrxqC+MXIId9XHHQK0/Cu4LDxvZ/pN5TXH/ZV7V7vjDu1HbYmK6FwgAOG
         WQP81KVAVIAhjUSXFHfbAsrxtY71OVNhMWLH+ilyJbFn83NtDzlS4DTfoO4mlHAbEexo
         zX2kMqUzH0Lqj1nuVpHyozb4QHgpocK9GZrJnWyGkjmQU81dHcQg+vpf2uzwTmABFb7g
         /Mbz/UVghmbuF7llfwI52lgvcoN9g8yQsjOdheeJ3XbFk8OwI+MAy2qWJp/vzVLO/wjq
         O2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782705663; x=1783310463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUw3sV/S3qIZv1q5k215WRUdwAcFAR4YpwI7q+yvo8w=;
        b=izGPOuWHD7IAOJ55xgfZ+yvhq9CvqfZ1AFDhCoO4RN152s7kKiMCcHTafZVHmiGzRu
         TZTIL41JMOhfqUM7esrOCrl2kYYgbsCkXxWGZe4zJJkxnGg2TVR0FfcHWMl5K2GGar2P
         4cWXzSleOf0DY1sGeSvbyyYxVlSOpfPfUMRYyV1/OceL3cG+zNgF3HNai1eidq/SvB6K
         LvwZxtB5zP+CViyVYuIqPFEdxrANG4n/h9d5c1jyT71q46174hMULma3j67tCNtXglYN
         FfeCACDbPrbJ10O6/1mZJ2eVM255ssr8HXG3z4xtWs1IuOvvytOvSjHSY1guKwPkxqPI
         pFvg==
X-Forwarded-Encrypted: i=1; AFNElJ+yXNkhc/zcHUJePWt7NqIKfVJdKdRqX2y/DB3KQAg4GDL1wtrr613x8pi5GXCqR3x9aoo/joWOsoZDZF6xXrqw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1GCi6HhSw7BeYdflK91ioU44wONdH7TrYRndQSsFQA2XGRLy
	DnckOrtgD9A/tnerp0kOoSOeQw5G651Tvly0jyO7bkZRrv6FswC2PShtm5h9fG9aux3APo/XqqV
	+0MZCU5wtuypVH70eXvJCyUomxF73xoTnnkLbA46Qjm12H1SO/nOOLa3PQOHc7+X2klegq3w6
X-Gm-Gg: AfdE7cmfn8ISds6BNnF4+XVzlo65QP1mVPvyr/2KbRP8nnebUKfcaKF8OpaqmsnGMjD
	e8Xbw5dMdmW4FmxOIKwjrXtiPelPaw4GfL42QSyIpWk/hUhaCFThUIki8sFdBBYFbbqznv4qFQ0
	HMbvs3KcPMDVHdPN6+aQxWvxn4qsztFv10XxEApgKUozzwtFddq2vpmCfJ97XEzt8RV8KaRNTRP
	LKDzZJo72PIVC6p0S9jvf4JP8f2OdxjUGxWqOghra7sGjtqwiwOlSu8jB0Alr1s+jtfFEeEQ9OS
	hhZDd9F+w27pSrZ/mGbgs5qETihvgwa4hQ0DBNa2oKikLn18uKYhU6bbuURfFRYu3zqErHwQag+
	KPdfGrdSmM3u0nE5DV93HyJSgpTdYmGcafd9RC43ZcVHn
X-Received: by 2002:a05:701b:4516:10b0:139:f62c:9587 with SMTP id a92af1059eb24-139f62c979fmr2629910c88.22.1782705662103;
        Sun, 28 Jun 2026 21:01:02 -0700 (PDT)
X-Received: by 2002:a05:701b:4516:10b0:139:f62c:9587 with SMTP id a92af1059eb24-139f62c979fmr2629884c88.22.1782705661457;
        Sun, 28 Jun 2026 21:01:01 -0700 (PDT)
Received: from [10.219.57.157] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm68401244c88.15.2026.06.28.21.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 21:00:59 -0700 (PDT)
Message-ID: <bdca57f5-fb8a-4556-b5f3-13beec0cdda1@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 09:30:52 +0530
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
Content-Language: en-US
From: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
In-Reply-To: <67f56151-3164-4922-a85b-e511b2c448e8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a41edff cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5nFhSs-KBMbq4J5pQ7cA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwi32wuql9Ean
 FkKj5lKhcxK5Rwx1rU2xz92tm00upMgLRcgxxBjPw9uTIAuwNu5j2+4eG71f5XhZM6wny7jSpah
 Pl0goLrWg4wgdvG/0oAsgmw6smMDQkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX4v9xx6zPUxnw
 3lUtfbhf+pT1utLezQKAWtt77LAxGbizuv1bWAA2XXB5jg7Imwvc230hcdUCuwJHWhxHVTkxcsP
 pqaUE1lfqrhECI1YQ8DrY8y2UaqSo+sWFmycIIK1GKy5TUbRzYsKoo7hyiY0bkB3JlYejGB6QHq
 5Cezu5yhxAgIEt+cIuer5n/EnvliSm1xDNuNsrgPwfCTaMLXUKj3869PBsM2OKA6eNh9ZRV0doh
 z19FZ4mzbrIwnOa/PYGgs7NK+pcwDv+JIOHOgFiglGsDTKsIklK59QCgj59cIUQtxVM0mXErqxU
 MGEoByZLGN+4oMmPmUhYdhU1ctKbZVmxRA0cCfMXe3VfYhsGNzeoPNZqASnnb2sdYWTBMv6fA2i
 DkXZNWwDAvgZW3MDcKm88Jr7gNZo0fciMbG/c40JfhsXsgUxW0CB6IBWG5AXi5UhlgGjKPNFhns
 l1rusy1KMS4GH1CO8Vg==
X-Proofpoint-GUID: Gm7CmN-gxa3fyxS-aP1McARFteSo3xGp
X-Proofpoint-ORIG-GUID: Gm7CmN-gxa3fyxS-aP1McARFteSo3xGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031

On 6/29/2026 8:28 AM, Mi, Dapeng wrote:
> 
> On 6/26/2026 5:54 PM, Aditya Chillara wrote:
>> perf_group_detach() handles leader and sibling detach differently. When the
>> group leader is detached, all siblings are promoted to singleton events and
>> their group_leader pointer is reset to themselves. When a sibling is
>> detached, it is removed from the leader's sibling_list, but its
>> group_leader pointer is left pointing at the old leader.
>>
>> That is harmless when the sibling is being closed and freed immediately, as
>> in the DETACH_DEAD path. It is not safe when the sibling is detached but
>> kept alive, such as during CPU hotplug with DETACH_GROUP. In that case the
>> sibling is removed from the context, while its file descriptor can still
>> keep it alive.
>>
>> A typical failing sequence is:
>>
>>   - A group contains leader L and sibling S.
>>   - CPU hot-unplug detaches S with DETACH_GROUP, removing it from
>>     L->sibling_list but leaving S->group_leader == L.
>>   - L is later closed and freed.
>>   - A PERF_IOC_FLAG_GROUP ioctl on S follows S->group_leader and
>>     dereferences the freed leader.
>>
>> This was reproduced by running the perf event fuzzer, CPU hotplug, and a
>> stress workload concurrently:
>>
>> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6cdb
>> CPU: 2 PID: 12489 Comm: perf_fuzzer 6.18.7 PREEMPT
>> pc : perf_ioctl+0x34c/0xc68
>> x20: ffffff89a3fa2c70 x8 : 6b6b6b6b6b6b6b6b
>> Code: 943c4a0e 340047a0 f9404a94 f9411e88 (f940b908)
>> Call trace:
>> perf_ioctl+0x34c/0xc68 (P)
>> __arm64_sys_ioctl+0xa0/0xf4
>> invoke_syscall+0x58/0xe4
>> el0_svc_common+0xa8/0xdc
>> do_el0_svc+0x1c/0x28
>> el0_svc+0x40/0xc0
>> el0t_64_sync_handler+0x68/0xdc
>> el0t_64_sync+0x1c4/0x1c8
>>
>> The fault happened in perf_ioctl(), where perf_event_for_each() follows
>> the stale group_leader pointer and perf_event_for_each_child() then
>> dereferences the freed leader's context.
>>
>> Fix the use-after-free by promoting the detached sibling to a singleton.
>>
>> Fixes: 8a49542c0554 ("perf_events: Fix races in group composition")
>> Assisted-by: PatchWise:gpt-5.5
>> Signed-off-by: Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>> ---
>>  kernel/events/core.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 954c36e28101..dd9892040ab2 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2605,6 +2605,26 @@ __perf_remove_from_context(struct perf_event *event,
>>  		perf_child_detach(event);
>>  	list_del_event(event, ctx);
>>  
>> +	if ((flags & DETACH_GROUP) && event->group_leader != event) {
>> +		/*
>> +		 * list_del_event() needed the old group_leader to tell a real
>> +		 * leader from a sibling. That's done now, so make the detached
>> +		 * sibling self-contained.
>> +		 */
>> +		event->group_leader = event;
>> +		event->group_caps = event->event_caps;
>> +
>> +		/*
>> +		 * PERF_EV_CAP_SIBLING event requires being part of a group, so move
>> +		 * the event to ERROR state if it is still alive.
>> +		 */
>> +		if ((event->event_caps & PERF_EV_CAP_SIBLING) &&
>> +		    event->state > PERF_EVENT_STATE_ERROR)
>> +			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
>> +
>> +		perf_event__header_size(event);
>> +	}
>> +
> 
> Why not move this part of fixing code into perf_group_detach()? It seems a
> better place to fix the issue. Thanks.

Because list_del_event() just above my change does:

	if (event->group_leader == event)
		del_event_from_groups(event, ctx);

so resetting the group leader in perf_group_detach() would attempt removing sibling
event->group_node from a group rb-tree it was never added to (only leader gets added
in list_add_event()).

Thank you,
Aditya

> 
> 
>>  	if (!pmu_ctx->nr_events) {
>>  		pmu_ctx->rotate_necessary = 0;
>>  
>>
>> ---
>> base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
>> change-id: 20260626-fix-group-leader-uaf-c46960e525e0
>>
>> Best regards,
>> --  
>> Aditya Chillara <aditya.chillara@oss.qualcomm.com>
>>
>>

