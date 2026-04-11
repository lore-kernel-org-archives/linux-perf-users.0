Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C76284881
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869710; cv=none; b=jR1kujE3csuKO/bOKlv2qm3xDAhsYW2JvHx/E0NM8KgmQ2lX7eaLg8WVv59OIIltmwD1iMkltMnx9E5SyXibSuPaRQyu4m7KUML6OAHlvVXsuHSg7mi4Qsh4sIInBPEEL5whLDtxyprG7nuQt7g52nrVI/B1kgmp4HujxKDErD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869710; c=relaxed/simple;
	bh=yLDq8tWCjxJYxpfLwb2jAo/P1JbpY7hP95lxVbdXlb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AW1ZX3vOG8NkuNVWUeXrL33hNZAr4A/SDaWSECQNWck+MZdj2jq7DK6NCOqmFVb3e7Hov15XYKZaNph0WbyJSccCQEClLgxkskY9/R3w1XMEfZvFoGLGpB3QZiYJPu32cBDfvN9LoyDAcBfhnUYv3IxSkbcysdKnVBjKU9LmAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OP2U7+48; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kVvT/hHo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OP2U7+48";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kVvT/hHo"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AFJASw3118232
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 01:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0bDVBAejqWe0kV9GB2+d2A1NsYQoo7EwftQT72y1HGo=; b=OP2U7+48Ji/6zZ+4
	8xdPsryT+m45d9nGPJOyxVw5oo683kd730eRv/Imu4xeulIlEJLL9R1gnFwKsRQ2
	XZq/aiJmIQ7NYp4pY8ILpj6j22uDxjelTDJkj0QYNjl/D22G63fUuj/yaCvQxzVq
	YU4o7/meA7TIO7LFR3FKBCfTIodm0Q5iONIAKRqanGwHhYwi8pcMFi/uLaYA7ylR
	iElJLwA+ek7qPOmcE2Gr7SB2IHcO4Pojfvy7lFxzLAFbw0H/9KhLYIS58t8hu9uB
	SXnqtO2sDDR5Zad+E4hb4jHfdrpzNe1zNLuyCCREve53QLmGKuORRWsaQfrrArkr
	KKrFHw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4df3rasdk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 01:08:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b24308165dso55561345ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 18:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775869706; x=1776474506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bDVBAejqWe0kV9GB2+d2A1NsYQoo7EwftQT72y1HGo=;
        b=kVvT/hHomJFVwz296YesHL6Xpi1On8fjgdo71CFuwg+6+YCUCoSye5bvgwKr6eVWOb
         zHtBC8YY7ajHgLfu69axDuN54CZlFghTXxFovwyH1LJtk5Pr/nZa+m9w4uCchKZOxG6j
         ZJvHMG5UJcFkdOgA0KgrsxxEj6ZktQjZ66NqjXxRlgbnxuE7ymghF1U9WCta+av6f43z
         KxfFIXZ8FaY8ztBJRxVP/QpDiZqLbDLaJgJX7UlARDS1UlD0h/oNoeZ7lLbmMMFzTAOS
         BjAKXJecTrbllbWKqkr7B4fYW1KnJEXKIAT6EyVNzEdGDqIqZuowUFx2sHHC/xRq+Oxo
         LxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775869706; x=1776474506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bDVBAejqWe0kV9GB2+d2A1NsYQoo7EwftQT72y1HGo=;
        b=o8MTKquBjZqRUVRiye853xhXuEOsZCcX7VoBPHR7YHUh0Jw/mbMS+ur1vthmnKjWR6
         2gzkJkfrkY6MbHwpYG3dhC5edggaPiebt+LkgXGBI/N/HtssVtKAELKndOTcAnZo2Vc4
         XkCpLmr10a7mBU8wW+wdUTMzFeysxIm9ZFCbi7CmN+K5udCLITy/+JYyqsZEdW35cDmu
         ELiJs6VdeAf1ifi8hV1a2E4+FWDrQAAlviQFDdqmAFV23ep9kpCy9i3Abe1bxwxnP/ZH
         TRoxYr0YGIJ5lu2liUDx+5slh6TTOuMazraoho53k/K4Eer9Pg+oRpOBZChAQcHZE1r6
         BwDw==
X-Forwarded-Encrypted: i=1; AJvYcCW3DqskLpER1JULDuszQS2mor1DRvVbhaFKIT7btF/pPhbGMKgbDVSIKi45101HSD/167s0WozsrwvvBvapU25J@vger.kernel.org
X-Gm-Message-State: AOJu0YxQEZTOqXR0blNOn4xQInrFv/uKMC4+C7EcmvWBap6Zlj1CcQBT
	gv4aRMl+S8yUxopUhgRoz1TzjO8oYAEl6vxf8Qa/hnGRKPQ2CZwvfYX54qG4VCf8tHFog0QFila
	0ahdb47Uzv0np6reP15LPJ/jnI/WxiqYaZWp7JptW6qgVL6wLesHrjvV9cUTVUuy68OQ0rzIa
X-Gm-Gg: AeBDiesh0BEYK8MoXbZvoOB6oyJACfRiKbflkqqbSMTBkF2seq0ASTknF7tZl88QkqS
	aSliYAj4tHviUQ3v9yZXW+2d0Df8W1YXSmDAXXqjvdYzbEO/SKDRSVBalIYZrSzuUxsDqq7auDr
	Ifmp4/GN1bAioWg9RtBrM5copg+zc+EVz3C016JtGW4FCWc97EiDiGVVcTTYCDHFKV5uR1Glh6O
	3UBQNOQOusKpYvpojceU1cUc/EkIGg0z0deDc/9mCukpTAjKHx8EYnmwa4NPYM4xLebrRE4o6Nb
	4s3mVYhGSaUX4E3rg0jkoRVlzdDOc+6h5Lcbqd8RQ4wtCWe03VEm9g0XG1elYAm35hl5AQvORFw
	Zir0OgZfynYIiKP/dD9iteZu1ehBFuZ11HhuaNN4gv5Sl/usl1MAgHNLhKA959E3IZmd0lCSL1F
	8p/2QwNxoVoQ==
X-Received: by 2002:a17:902:6bc3:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b2d599adedmr38660715ad.17.1775869705914;
        Fri, 10 Apr 2026 18:08:25 -0700 (PDT)
X-Received: by 2002:a17:902:6bc3:b0:2b0:6e60:9586 with SMTP id d9443c01a7336-2b2d599adedmr38660375ad.17.1775869705411;
        Fri, 10 Apr 2026 18:08:25 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm39322235ad.79.2026.04.10.18.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 18:08:24 -0700 (PDT)
Message-ID: <3e7645cf-28cb-4021-89e6-e467e9555ff4@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 09:08:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf arm_spe: Print remaining IMPDEF event numbers
To: James Clark <james.clark@linaro.org>,
        John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-6-55d3ef997c48@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vs4Txe2n c=1 sm=1 tr=0 ts=69d99f0b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=7CQSdrXTAAAA:8 a=KKAkSRfTAAAA:8 a=-8vgJeR-9WfCzkiTBPAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDAwNyBTYWx0ZWRfX+grhMpe6krUR
 73ADWfWFD9XXUhiF9Eggq0dEQSMb1QuJLapuoirHznK8nr3FaC+dDZduLTtqEEeX/BCydURvqE2
 Qtjpw9OxLTTO49ziF1sbGUED3k17DCkQqYQ7FhGWhrtj3okr4nbSx3xDlNcOK6FnG3gmwPGXsOs
 iK6KeEnUDsidgySRqEu2HDdTcnX6A2kDVm/qntDpkWvGGP5+iPlp+qR2WuP6kuB3vqB0rtw9SYT
 4375WFB+BT+o19ItSoWelPlpZmvpSNY/Dv5SCNmLt+SrYyzuXV268EFkHl/LgW6nqrqPaA9m3/f
 MmXmx8dWqD0MAhBLLgbcDasUpVYUvBlZkcIIowoUXQPCGxtUaJgg8aakYhnKQI9hqHhO2YHAB9/
 ia+/u2eFVT/Ks1aNIpdSl4ZDw8yrQiht/SRAPCCv02fcH4wWERsGVQDARIh2ZBlV5VLRFNPm6AO
 4665VnZSYJa6/iK1/0w==
X-Proofpoint-ORIG-GUID: 13mThSU1Xeksn3sxI6iS2n67dKhyVXtU
X-Proofpoint-GUID: 13mThSU1Xeksn3sxI6iS2n67dKhyVXtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_07,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110007

Hi James,

On 4/7/2026 10:05 PM, James Clark wrote:
> Any IMPDEF events not printed out from a known core's IMPDEF list or for
> a completely unknown core will still not be shown to the user. Fix this
> by printing the remaining bits as comma separated raw numbers, e.g.
> "IMPDEF:1,2,3,4".
> 
> Suggested-by: Al Grant <al.grant@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index b74f887a48f2..c65b22a2179c 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -8,6 +8,7 @@
>   #include <string.h>
>   #include <endian.h>
>   #include <byteswap.h>
> +#include <linux/bitmap.h>
>   #include <linux/bitops.h>
>   #include <stdarg.h>
>   #include <linux/kernel.h>
> @@ -365,6 +366,23 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
>   						   payload);
>   	}
>   
> +	/*
> +	 * Print remaining IMPDEF bits that weren't printed above as raw
> +	 * "IMPDEF:1,2,3,4" etc.
> +	 */
> +	if (payload) {
> +		int i;
> +
> +		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:");
> +		for_each_set_bit(i, &payload, 64) {

for_each_set_bit(i, &payload, 64) passes &payload where payload is u64. 
The macro expands to find_next_bit(const unsigned long *addr, ...). On a 
32-bit host unsigned long is 32 bits wide, so only the low 32 bits of 
payload would be scanned; bits 32–63 would be silently ignored. While 
perf is almost always built on a 64-bit host today, the tools/ tree is 
explicitly portable and the compiler will emit a -Wpointer-arith / 
-Wincompatible-pointer-types warning on a 32-bit build.

Thanks,
Jie

> +			const char *sep = payload & (payload - 1) ? "," : "";
> +
> +			arm_spe_pkt_out_string(&err, &buf, &buf_len, "%d%s", i,
> +					       sep);
> +			payload &= ~BIT_ULL(i);
> +		}
> +	}
> +
>   	return err;
>   }
>   
> 

