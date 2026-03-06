Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D1A33E358
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783597; cv=none; b=rEfvQFljGChNAKuspKNCo5os/Fq/BTkr1HBrZWSnpiUaazPwXyOmSg8Eba8xLo0sPwlvFAJESsIawbZ9uoVjy9y5Hi81qCS4A3iuiIAEG07W5DPTz+yNsjsOoHXk6HMVB45uIEsB+POlDzXqR+1KHP6hxgh7LK2fhaC5/nC5Ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783597; c=relaxed/simple;
	bh=PgSHDVI+rpF0XEl034rHoRrMtsjWIP8893ffDws7MO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsR7yvPg9MUI29XKPiQ84U+5p68mY8NqkT/3XM6XZip7C/lWx7C4t9uEU+oEvwCuGmiKJDVQOX6K05pmeRFt+kWEZoRvvG3OLNEQEWQ/G+HRK3Zl0Z5xiQ7jgz9aqZgGcndZU1gQr/SkXzNpLj581wYnsnqw1W2+s5H6JK2iNxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCWUHyGt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MoT6RrW/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCWUHyGt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoT6RrW/"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aV9M1087386
	for <linux-perf-users@vger.kernel.org>; Fri, 6 Mar 2026 07:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VDqdJFAg0KU1it5TveUhRei5AuIxuL6SLpcPwfpjiuU=; b=YCWUHyGtze9XQ1qo
	uPXQKTuMI4EZVqRP2bblBhiPoxJO/wEW77aZUXVhoTp+61n9vx7datVG951vCK+l
	P7nxmuE472VA6uVe4vgYNumJvjmbdYi1aLRkleSFuLk78irrKjhSeVh/g9xRLqvR
	ETueAAN6C2fGPnwt/tFB1HSg9CBq4TD/WCpAafKLimUgaIPFm8zy/j8t8BLgx0nP
	zANq60yhMQweU++fb+HQJfpZy3RKJ4LoHUDS3ZbF79FgS8/3EReYedWdb6g46CO3
	TQUgNNzrdbSJRICwCjV084hup5Ot9jme4oEMSIP1FOCHfTprBq4tB9AzY6QhvrVD
	XBlxfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqfg6a5h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 07:53:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cbb8040f48so5611350685a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 23:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772783593; x=1773388393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDqdJFAg0KU1it5TveUhRei5AuIxuL6SLpcPwfpjiuU=;
        b=MoT6RrW/9TF+7NGZAoXPDJfDZ+bmd79ucCrzVgONXC2CSU/RdWd5a66q4yhvzqhDiB
         JmeoC8ROrlUvHoD0Oyxe9d08Z1Rdka56tSRdnS1GUpOsJJyAeXlkYEO3xlr7tFdGv087
         gK/25tOlYIwqmpYndzs0tzzHXWhixtnCI7XRS+XuYsiWGAIFKtJnRtWOztCUyhVnc9yn
         9Hg1mN58v+6PpUiLEVAa/RQ1PNGIB9oVN5w031rwpdqNb3Ir0ywUcs08M1/XadsiZuyQ
         M6mSX0CdwpPYIh2oJCsEzFQWpweYRDbbfKMkm4hcUZ5GfOym0PldOAHgZ8DVWVAkB/bJ
         0hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772783593; x=1773388393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDqdJFAg0KU1it5TveUhRei5AuIxuL6SLpcPwfpjiuU=;
        b=HoJrZsxVsiePv5uMzrzHBb2mSJXmmdwHKDxaHBWW5OOuKp3usMYWZRnNe7unbR83Jg
         JXi7NiqTioAU3Hpjd/DPA3rhgELsJCgQT/Qd9NY9YbVhwssL3O1kA0ki/5z8h9Hp3/2B
         FWwLkanEmNjsewihlBL716fDEER59P9s/CY96BBM5/Z4QqKxZhoj/0bdcwa/AkIwNnOl
         dKZ/7zW1WgNNAapAKSA8mbjdK/9aItoFL2vPWxJMHbFNmMlwBioFUfGjJ1YPAZUpI5OR
         IojnaPRVKCI+ETcvtojfxO0X6mIOz3cmCM1rDPw4CcQZRmDxKVqMGuszjwX3xBa3inTg
         2Zwg==
X-Forwarded-Encrypted: i=1; AJvYcCUO9EEbuvVhLv09nIN+95o/bSP/j6ti1qoJAXjPwv1+d8x75QRNimsyxzapGDvT2Qu9+jR3rV2RPjTloF0rtM9g@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXqYqJ804P2J03hLNpMcwZgF5Rts5xh4BHHRwCwrwSim9b0z0
	rMgXYhNbnwb1xRVYK6V+gKgYMDoypK9M31m00Pp6gFcsAazkUk3kdNOE1ypOgdDzZ2WupmsFVRC
	HGyRUpYOtGSgap4avWoSo7qjFeEQQLtbY+DippVjd4NvGcHffmBt7qAEBv1aiGwCO/9ra/F0C
X-Gm-Gg: ATEYQzwiIYmG6F7kolh8tNeRF/ONZolIwRXUfSYQdYcANoxOGHGVxccAbCQvssqhyoj
	/Ty63c5M7+hBzuXywMe0lp9ST+6ahZ9SUh7PL2V6il3NxyPEk/Ce+pKD3rXQZnhI6Yu2vIk/siC
	y80gjRLf1Dwvrbn0xDta9V3az4NZiQpMzAMaiVSJo6T4dGiL7NsLwAaswiE9UhA/Vux8FgbFWbP
	9Npo6IBoob7XCjQK/C09KDPODMipaTKLvAyZ24zv0jtMIy7vj0EG1E67+ofUpGiXpgf/YHYHQqi
	NwWSvlMdb1kzu0SMSr9E0vkygCL+8ekoGhg5UZskU1K1kG3vhgPaLs8NC4gcnUEzRCKeVca9a0k
	XHgSKJmgNW6CPJ9JWIJA/aZQ4jeyirvmPT3OzNOGm78H7E5azUuv20/0U1iMF1fcTSRQwPw==
X-Received: by 2002:a05:620a:44cc:b0:8ca:123e:819b with SMTP id af79cd13be357-8cd6d336d89mr169110785a.13.1772783593233;
        Thu, 05 Mar 2026 23:53:13 -0800 (PST)
X-Received: by 2002:a05:620a:44cc:b0:8ca:123e:819b with SMTP id af79cd13be357-8cd6d336d89mr169107685a.13.1772783592833;
        Thu, 05 Mar 2026 23:53:12 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1265:158c:17d1:c76e? ([2a05:6e02:1041:c10:1265:158c:17d1:c76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae483desm1793314f8f.34.2026.03.05.23.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 23:53:12 -0800 (PST)
Message-ID: <86ea19c5-306c-4ebd-a9a2-ced274977ec8@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 08:53:11 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add references to tip tree handbook
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
        x86@kernel.org
References: <20260305212215.3188399-1-dave.hansen@linux.intel.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260305212215.3188399-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 12X_dHusZMEvFFEWV0_Rg5bYY454KmXM
X-Proofpoint-ORIG-GUID: 12X_dHusZMEvFFEWV0_Rg5bYY454KmXM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3MyBTYWx0ZWRfX8kAb6BRmf24m
 vAfe96sBEgjmLebw8sDX8XeLf+i7fn8n1ao1bJKVnPEz3s8zya0vvND/Ei2yY0WjE82K2YCtLkK
 91IvUUrScKMgrHcgVQxOB0qBM0i7+vLI0UAEutHsZXC90nkNWXQw4ROGAt+gYcUITINSb4m1pUn
 VAmz4X3xDwLc3IUC4gbixtEY4V9BWZNaJa5+15+sJUGTFOQtfsCZMShteFSTPZfcoQjPUVzrPwO
 CAgaD2KlzfXRSdZc6QnwmC0TTeS7Fkrl+KFXhUhsU9sFDX4aCqKz9kD7imGhdGkAJ5R4b0vUKnw
 6IB2y9e6rHmfdBqon+F/pH1uRvcW4tkyGPrlRDr6UEnDjS2SteVsRBCjg9hZL7LWX6Fy8TMdRSc
 WFovdnSbWAJNzhm/4Yh80KdMWlvu2tpbjP+0RpY5LfloGyWZhZMk3zJVrC/XGvK65ozNiK6ZsIP
 JRhr12AqgJA3NTl3KSg==
X-Authority-Analysis: v=2.4 cv=XKg9iAhE c=1 sm=1 tr=0 ts=69aa87ea cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=oGMlB6cnAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8
 a=KKAkSRfTAAAA:8 a=DE3I5U_dAa-LTm6LnEgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=NdAtdrkLVvyUPsUoGJp4:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060073

On 3/5/26 22:22, Dave Hansen wrote:
> The tip tree handbook is a pretty handy reference for keeping the
> various tip maintainers happy. But there are no references to it
> in the MAINTAINERS file.
> 
> Add a references to the handbook for a number of subsystems. I've
> added these for all of the obvious subsystems that list T:.../tip.git
> and are likely to follow the tip rules.
> 
> This will be useful both for humans digging in the MAINTAINERS file
> and our new AI bot overlords.
> 
> I'm cc'ing all the M:'s and L:'s listed for the subsystems but leaving
> off the R:'s because the cc list is already out of control. I'll
> commit this to *some* tip branch if there's general consensus that
> this is a good idea.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Boqun Feng <boqun@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: x86@kernel.org
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@kernel.org>
