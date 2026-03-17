Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318A2D9484
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 07:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732113; cv=none; b=t+tX2Sjfu7ALXjKhWQUNNFJtfh52nbm43dUflcfP5LDbdgyxeZentYFusS5hIBsdoUDxM4aToXqwA8gVTQuNtGJTGZV39d1y+dQtHOtiafzPBvQJU29SN1i+6dh3nMp3ESjzBdPoS9gHbnfDmpBJpzYsBVg3o7zpIEa1HDglmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732113; c=relaxed/simple;
	bh=IxtOz2CsJytYBKr87iuTorThohE/w7ZLhrUsPVVvNZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqe5ZYEEFcKvXAyg6t4UCRC9OKi+2ZRZuFCVA4YTqZt3iVex4wL3LG+t192UoDpJs3CJBqxbXKqjsjprStLlycRZH8tq6tFuex38U08eUrM4YfWYdOPuZk2qsivxHRH6Lh4NTH4khPJswAoDZ/qYixh9iclpMSwSjPH8PGX7Y4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gHzRIkXh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DOZtZFde; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gHzRIkXh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOZtZFde"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6tWkE1639313
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 07:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IxtOz2CsJytYBKr87iuTorThohE/w7ZLhrUsPVVvNZ0=; b=gHzRIkXhEUr9fMLr
	SyB/M5Ot98weHpB+ZuPy0nqVDwKYjAURuTPKx16t9bTyeDrcga3OXOXOPmenXgFk
	59XKyp2WJLpJlD65WFqVa7SCJK11GqzSqN0S4AQqtgE14rnxmuZtLCOQ3reYw9ar
	bHxQqQEJRdHSFUD4t6tDYRzWUR//NXxK2i+q1AQdzIbP8wcqpc9b4QIKqhMKAum8
	eXFIa52+qXQuPtphf6R/iG4NWoSBDMTiFknrpA4vrTOIKUXK79TmkZAlnoljtY++
	+WuQreqk70cIfr0i2r/7jXuywIeYwt5lPshtaJZG9fPoiYNzXP/VUFq4X6/Sqle5
	EyLjMg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke0b39p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 07:21:51 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3547c799b27so4594103a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Mar 2026 00:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773732111; x=1774336911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxtOz2CsJytYBKr87iuTorThohE/w7ZLhrUsPVVvNZ0=;
        b=DOZtZFdehJgJtWa16PDv1LsMHOFcR+QIY65Zi7yJmTok3NpBbahF1sKAsSfnEBUwf4
         23LgBZJNoSLA4VhRCcLDobVuNh4aDnTiBjLvBTcXhfwxEKpp1pvR7aS8zq0V6RFQs+DG
         8B0jkVKLw9pBTZkN3RpQSIZ1fjWUrSdou79GQNGAwzeGHb95B2UUDwI88WQPP85OwvBL
         tYwnhPJsu++UlfQdVqFIAlti46iOF2x2YYR9qU+GkX99dolT7E0sqaPKbZr0FEh7KR28
         J/92LCDs2oAq6PfrYr0IIGVRXNiYgkul3GgKsw6SUtGxbARnS1EjgeG+jsyvSoI8Avek
         9nCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773732111; x=1774336911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IxtOz2CsJytYBKr87iuTorThohE/w7ZLhrUsPVVvNZ0=;
        b=MBPGw/8guVnDXY52PZKdNS3EbhGFl7ayXzIlrP4RwZ1DYLLDa1cILJbn9pQ+XxkjU3
         cSYNsRTRJQUuVOiooV0Y+dH3IEgxBO1fy/0irHe021W+8pagAYXExlFRIENHXb66bFYs
         klBVdEZ8tHTQCOxg82tOQBlcO2mwX1E2aBXAA53rJzqqOu95lwYYqZkBFUoKZCmux/UL
         rV0X/jDsomkYQdhg0rvDHrVw0sOl08mDMEX6llvZGeFljcjXk4LMpvGNgLbz+uvlWtex
         VXYptFC9CE0cPjFHNAZNXyMo5Pu51mL2OuOHvyYdN/+4zMtCKaCjjDO1clnlo8LihGCK
         labA==
X-Forwarded-Encrypted: i=1; AJvYcCX59OioENF7CVti8G6UsgV1grigTMtbfKIoqoUKN8abfByXmUA0H65tFZEYkQsHcOziy2WoA3DImYtP7rDGvDiG@vger.kernel.org
X-Gm-Message-State: AOJu0YxyVrumR6xiCnXeNf8Q/kxsHWsd2O06aJzUSuiWAeMmAMbHli/M
	CPlhnUE+KD+wESHBzCnWjWbnhpfyaTCR4YGraheGmeui1TTvmcUfQiU+AXGXBLgRQ/pL08awrsV
	3VWi4CPCna7Ub6Pfg1ds+2S00Ar4ia9autXCdJ0b532A7K5m7H34rO3QnLo/wt4T+NsX5XY7Q
X-Gm-Gg: ATEYQzzKOPwpn3wXDufdzZNN5VJ09BgkrkOFw28+u/zithY4ws83C95DfhtgebfDosv
	yfkbNn4xh16BLmtPfYd7DlH17sHbAqaFvaFwXCpzTAYHx7ptn19Y+bbGR+286X+QZoTkPY9mccs
	gGspb/VkP6GM9SzvQ8SNsxJKjZ5GAKisFrU4LMQYbYvtylrOnzEZlzqDIOH0n0EYxfZrO+7V/js
	ID0C9ImCkx9xOhO2mZ4PemQ5zesWwHko5riE2FcHw2iPEcWBrRta20tDpRC49o6XM3AeYrlcFdE
	BZs57+0JSANh+KWlhcI/D4XgctCVrSnLWHgTWRQDs6BTatE/UWIRxEdQMXmId1/RJPWo7RpuYOr
	G52p2EyzGf7HGYZPUfiWbfN5DtUZeuTM8QIMMcs6ewmCmiw5EOA==
X-Received: by 2002:a17:90b:3d4b:b0:359:c479:fc68 with SMTP id 98e67ed59e1d1-35a220aaff9mr9161931a91.5.1773732110593;
        Tue, 17 Mar 2026 00:21:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3d4b:b0:359:c479:fc68 with SMTP id 98e67ed59e1d1-35a220aaff9mr9161903a91.5.1773732110083;
        Tue, 17 Mar 2026 00:21:50 -0700 (PDT)
Received: from [10.218.41.33] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35badbcb8b9sm2417780a91.13.2026.03.17.00.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 00:21:49 -0700 (PDT)
Message-ID: <95d2de63-5571-4fce-aa32-6e8969bb9149@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 12:51:40 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/16] Support Armv8 RAS Extensions for Kernel-first
 error handling
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
        will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
        sudeep.holla@arm.com, rafael@kernel.org, robin.murphy@arm.com,
        mark.rutland@arm.com, tony.luck@intel.com, bp@alien8.de,
        tglx@linutronix.de, peterz@infradead.org
Cc: lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-edac@vger.kernel.org,
        mchehab@kernel.org, xueshuai@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260122094656.73399-1-tianruidong@linux.alibaba.com>
 <edf7e7eb-8f02-4672-bc31-16e0a8fb9715@oss.qualcomm.com>
 <d4e4e2b1-c182-42f9-9d60-b12f0fd7f977@linux.alibaba.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <d4e4e2b1-c182-42f9-9d60-b12f0fd7f977@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vJgUFZoMTTb9YyURcEniZgh_k_8LA1Ro
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b9010f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=IrbkRpuHRcUsFRyD9lEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA2MyBTYWx0ZWRfX0LnuaNYMwDZj
 v1R8tY2m7QaXPs9tbGwYoNZDJpBQ8ba4QbI1sX6LeIUlk129wwhU1UYcyUR76Swo7bcq7tmbKNk
 o6GjJjkzX32KmJfivPHfg32rRYNcp9WU6IWVCXh9Qts8UzEzRL/xrqAzaQHBTgYWDxbrVmnav1p
 owNcF7yW/Ifue5fyODyo+XvseIAA1dZCg0Yam07ycRocj7EXGyEjRao/MsdYt45VAucnKSmhWpL
 +nX9TD8X1az72ZUclaF0/WReDGHNAFZRkI3sWht/Bp4BGttfnGNy8YrOP7J288HOtRmT8fL1K0z
 5PBfVbSRKQZ2IABE59dHBb1vLSO19ovFhqcG5+mlglsZd94uoZSq+25F690JM8EnoGuNrCiQgyb
 yqnbR3m8uJseN4mjKkw2k8k3ukDWI1ljTeYRsVnHXBe/TnVAubaOe67PaOdOjLu0JeWxsF9c+VN
 3zp7VTgCLd5qoIwXNuw==
X-Proofpoint-GUID: vJgUFZoMTTb9YyURcEniZgh_k_8LA1Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170063


On 3/11/2026 8:55 AM, Ruidong Tian wrote:
>
>
> 在 2026/3/9 21:28, Umang Chheda 写道:
>> Hello Ruidong Tain,
>>
>> On 1/22/2026 3:16 PM, Ruidong Tian wrote:
>>> Motivation: Reliability in Modern Data Centers
>>> =================================================
>>> In modern data centers, proactive maintenance is essential for achieving high
>>> service availability. The practice of using Corrected Errors (CE) to predict
>>> impending Uncorrected Errors (UE) is already widely deployed at scale across
>>> the industry, like Alibaba[2], Tencent[4], Intel[1], AMD[2]. By analyzing CE
>>> telemetry, operators can identify failing hardware and perform migrations
>>> before catastrophic failures occur.
>>>
>>> Problem: Inefficient CE Collection on ARM
>>> ==========================================
>>> Currently, ARM-based systems primarily rely on "Firmware-First" error
>>> handling (e.g., via GHES). This path is inherently heavy-weight. To avoid
>>> significant performance overhead, firmware is often configured with high
>>> thresholds—reporting to the OS only after thousands of CEs have occurred.
>>> If the threshold is set lower, the high frequency of errors leads to
>>> excessive and costly context switching between the OS and firmware.
>>> Consequently, ARM platforms currently lack an efficient mechanism to collect
>>> the granular CE data required for high-fidelity error prediction.
>>>
>>> Solution: Kernel-First Handling via AEST
>>> ===========================================
>>> Other architectures have long utilized "Kernel-First" approaches for
>>> efficient CE collection: Intel provides CMCI (Corrected Machine Check
>>> Interrupt), and AMD has recently introduced similar CE interrupt support[5].
>>>
>>> On the ARM architecture, hardware already provides the necessary RAS
>>> Extensions[6], and the ACPI AEST specification[0] defines a standardized way for
>>> the OS to discover these error source registers. This series implements
>>> AEST support, enabling the kernel to:
>>>
>>>   - Discover error sources directly via ACPI tables.
>>>   - Handle CE notifications via direct interrupts.
>>>   - Bypass firmware overhead to collect every CE or use low-latency thresholds.
>>>
>>> This implementation provides the missing link for efficient RAS telemetry
>>> on ARM, bringing it to parity with other enterprise architectures.
>>
>> Thanks for posting this series enabling kernel-first handling for the Armv8 RAS extensions.
>>
>> We noticed the current implementation targets ACPI-based server platforms. For embedded/SoC systems, Device Tree is often the primary firmware description.
>> Do you have any plans to add DT-based support for the same flow? If not, do you see any blockers to extending this series to support DT
>> (e.g., DT bindings + discovery/registration path analogous to the ACPI plumbing) ?
>> If DT support is in-scope, We would be happy to align on the expected approach and help with review/development/testing for DT-based platforms.
>
> Hi Umang,
>
> Thanks for the reply.
>
> Adding Device Tree support should be easy. We just need a patch similar to "ACPI/AEST: Parse the AEST table" to fill the DT table into struct acpi_aest_node (might need renaming) and struct aest_hnode. The driver part requires minimal changes. 
>
> However, I'm not very familiar with DT and lack DT engineering support, so I would need some guidance on these DT-related questions:
>
> - Is there a specification that outlines the reporting     requirements for RAS extension information that is similar to AEST? 

Currently there is no spec/bindings defined for DT based systems. Based on discussions on earlier posted patch [1]  - expectation from maintainers
was to have DT bindings aligned to and equivalent to the AEST spec. Based on this expectation - we plan to propose DT bindings - which are  aligned
to AEST spec.

[1] Re: [PATCH 1/2] dt-bindings: edac: Add DT bindings for Kryo EDAC - James Morse <https://lore.kernel.org/linux-edac/312fc8b8-7019-0c74-6a92-c6740cab5dad@arm.com/>

> - How should the DT be designed?
>
Same as above - plan to align DT bindings equivalent to AEST spec.

> - How can I develop QEMU and modify DT files for debugging, etc.? 

We can share the steps for this for DT based system in this thread.


>
> I would be happy to adjust the patchset to meet the needs of both parties if you are prepared to invest the necessary effort（DT-related）. In reality, I believe that just a little modification is required. 

Thanks, Yes - we are open to contribute in extending this patch series to support DT based systems as well.

[...]


Thanks,
Umang

>
>>
>>>
>>
>>
>>
>
