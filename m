Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64D3783B0;
	Thu, 23 Apr 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938614; cv=none; b=ZjUyQant3VKWEuPRChw1dSGY4VcJY6rbPxUFybdJJbBY4MuDdyNc9XYFAyoTjHFJte227dBz06CeOHwTvbJicOtw0XHR8/evG8oFID7ZLCjBsGfzXfTJpDeFVrY9jILZLHhpgOAVwm74TVAsGOeULNaDWT5bf+r1cDI0w73vmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938614; c=relaxed/simple;
	bh=Azg/igA/f/cP5AIaraXVha1Gl/boZpu99PKyfUfh8Lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBp7PswP6amet8CHPJvw4ZoVz6UFYi85Ei3AL2Z6ldOXB/ZEn+vo+6WYS37veYEUSd/YHoopsuo7ubFu0m8PXxJTgycoUjQD8rGrWBHapvIEMyeWhQY0ggsTIpuFkj87LajCTGjJhkHha28quJDrI2/fR+2pNFXMUsqFZdiTYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ljsEoqmd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ljsEoqmd"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8jTDI3291900;
	Thu, 23 Apr 2026 10:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7L1INj
	zZ0akyYYKzFCaSJcIPFCZviwywxCiLunkrXpg=; b=ljsEoqmdZ+GUpVhowSTLZs
	Qo83Otx9NE00oqLj+k4I7Uo7hZ1Xa3jL19B3TywQBaYXxlJrUeODpnoDFCqMgAEB
	tPEPdiO+Mu+cGX7RD3DHKTDvUZR/Yhz9OpM13Cu38GHwBun1edQQSiVdldgPXIRK
	dGV5A57rHPxyvPCKTzoYofbt1JbIvc9zKCvT5tgwv//Mm3x15gmpKnZXLo3TqzXL
	3h+pzzuIH3RESzFdp3EpZpxTZdyU9BL91o10m1KjKwcz0ZZFPdO0E1dksUe5hbSP
	G0BnrVt9aY5/4oerpspiUS3HDhEM3whbi3R6DY2l7/zL/hbCrj6COMRgRhXrCRSg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrfe3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:03:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63N9oMbj026952;
	Thu, 23 Apr 2026 10:03:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxx3r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:03:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NA368J13762848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 10:03:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FE4120043;
	Thu, 23 Apr 2026 10:03:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C6032005A;
	Thu, 23 Apr 2026 10:03:05 +0000 (GMT)
Received: from [9.87.134.47] (unknown [9.87.134.47])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 10:03:05 +0000 (GMT)
Message-ID: <38110c0f-f731-414f-9c5c-f30e5a3d01da@linux.ibm.com>
Date: Thu, 23 Apr 2026 12:03:04 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
To: Dan Carpenter <error27@gmail.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aenFGy9WDllTEO0S@stanley.mountain>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aenFGy9WDllTEO0S@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: sVg9ei9-2nV2zs-nfHdtl7BkrrCjRpjx
X-Proofpoint-ORIG-GUID: w2jsbNsJVEOCj-oy4cfWDXgwzTEjlw23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA5NSBTYWx0ZWRfX9FQoFmoDHAtt
 mmIrI61qF3puVKhEfeJyj32CGTZEkkZEAZ3oGQQDx7FaiVAkimtrs4gaqjzfI+lgG4r1Bx5jeO/
 9a2RMfvZl3NF9bRTc3+zDHK33SYbOydu5RtAfbgZUbWDfb8mtgp6Gct9Jik1BqRN1t/EDmpQqT9
 Qicn6VdRbm4IGVX6xNC7I+pgjHeQoJuT/ueTs6KqI/lgCNRiA7SdHQhfLbmUqPtDADt5919EjZ6
 vuN8NJdZ8BeaaVyK6OYk4bRwRwoSjiDyC+J85Frm9GZ7f0GXg6Hfunm/2dL0Vyldq0+Fz21LVfN
 kWGPld7e2zjk6VpVnxMNbCorkdUAC3R6xvCLcfdWvfIuGzOW2jttqdKqXh80gLcbJ9xRYrqVI2l
 yG0xFLUlZIF15lyRWmWhimpSBi0Fw3b1i8qc1BohlktvlxrOLoSUQbM5vovOe2/sm0AGn0itixL
 wLFY715tE7hvBtsmsoA==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e9ee5d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=x4kxwI2lhZTCVj833_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230095

On 4/23/26 09:07, Dan Carpenter wrote:
> Change the > comparison to >= to prevent an out of bounds access of
> the dwarf_s390_regnums[] array.
> 
> Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF register number mapping functions")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> index 310a37451bdc..f79216a7665a 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
> @@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum)
>  	if (perf_regnum == 0)
>  		return 0;
>  
> -	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnums) ||
> +	if (perf_regnum <  0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_s390_regnums) ||
>  	    dwarf_s390_regnums[perf_regnum] == 0)
>  		return -ENOENT;
>  

Acked-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
