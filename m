Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207241E32B9;
	Sun, 10 Aug 2025 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754842156; cv=none; b=F6jfLa11SBv5csG8KYiV0+NMsi9ZeXotoqDbuntOTia//mlc8Fdf7CtDqFF/DPc3YftkRzRWhZZfeZLuP1vbkdc6lliXzkW08Yn1KVM3vp43jfEw2FbAoxDDcCXqylZoFfM3iaT0+YnO4JCTOuvm+JUF+QaPKQgPfN3vnlerIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754842156; c=relaxed/simple;
	bh=iNEZMkRAwa9NNxtNxZOMxbo9qgjn9DPyf2np5vh35Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDyP/cae9dKWuSLC/RqY5QF68LCcjQyp3tP0uJ3/rsRsCWwr9enTy6j5Nq7oGC44cwsQJ4QlRhlJDh6DNFglW1P2acXiRUq+OhxGsSM/8XVjtB+dxrRVK/lFkvtRSgninu3Z8LXqjS2YskHwkrSf4lxebZHIKsgtxQ3O69DuM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BclEYCMG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BclEYCMG"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AFNgm8008143;
	Sun, 10 Aug 2025 16:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tgzC2y
	I/MF9coSbtIS/FuZVwgTWSWN7MU391hjnl1Ws=; b=BclEYCMG0yg9Qu/h8FqDQ2
	wPbS6GCoY4PB0KraKbq31yOh/iLedT/ORzSvhrGA9uPbrtrVBZtR21e4rA01VxjD
	+S6veD1oBh59kq5Q60HtHoFyfCWDRgbfrSSw6Uv75nsC9l0kf3xfaPaaycVnrWiA
	dTzchc+07xRH40wLLKr3Ns7/BLSKBhucouOlWukw+6fqId34DTUHVvvpWKfH2Bcv
	VhT49jozdMhPi1DPfcgvXvObHkiCfjuWFy7TYrq+9K0JU9B/XYjD9emAG1KwCchZ
	Wu0pszxUcptgLUducc5BBqEF71DGOMOyPqkHiRSWlss9QK15mf0/5jI9AYtrFBIA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9t3w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:09:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57AG91Uj022130;
	Sun, 10 Aug 2025 16:09:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9t3w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:09:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57AELopM025667;
	Sun, 10 Aug 2025 16:09:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvm25aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 16:09:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57AG8wr835914380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 16:08:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F3C32004B;
	Sun, 10 Aug 2025 16:08:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45DCB20040;
	Sun, 10 Aug 2025 16:08:56 +0000 (GMT)
Received: from [9.43.79.85] (unknown [9.43.79.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 16:08:56 +0000 (GMT)
Message-ID: <40b96722-a304-443f-966a-b155950fcbd9@linux.ibm.com>
Date: Sun, 10 Aug 2025 21:38:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf auxtrace: Avoid redundant NULL check in
 auxtrace_mmap_params__set_idx()
To: Gautam Menghani <gautam@linux.ibm.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804110602.23422-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <20250804110602.23422-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=6898c41d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=3B45m_xtiCOFTJ9Nk4UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: koHLIe8CZxvcfPJ99sol1offNMVOtdje
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDExNSBTYWx0ZWRfXy59u5RhCtzhd
 VJ+mgx7cEauc1JgWlxbLlD78nRwxuym8LP3FNuwcediPbro86XYhFELdfAFCIOk16gkXJ5b8YIF
 h7KMuSA9lnkbDjXWVKmlepeK8ahq6BtjSS3wFAxO3l87ZsGMw8F8KXq0RvMiI6Hzqc5m5cTlOpW
 2ORTHrBbcZ3QV2A/2WD7RJCHHI6mCLPoEB/ZumjmziMttvLN0B0EV7YwcuGH41tZJTKmxt+xxOb
 S2vcSgVOWcYOsx5FIAsfErNkmr4QpCGMUjeqqXJd7Lmf3+F4oNRIeAeDjcJLgwzqZoVGlei92Gb
 IoZuG0XAcllBjXa5y2+dlVqXdkhV4nzNKI2iS42eGwVyGI3BP8E3UcxNPz0jOmFxzd1WK6mMo6J
 4SNgtDQWWNlxAdkwlL4jeBhMnVRBHsghh3Dz7I4R69CHpgkOnT2XaJCcQvWLGTV+Yuwu+3Ho
X-Proofpoint-GUID: sFWV954d6K42-v_kHEDN3jaP_UOxB1cI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100115


On 04/08/25 4:36 pm, Gautam Menghani wrote:
> Since commit eead8a011477 ("libperf threadmap: Don't segv for index 0 for the
> NULL 'struct perf_thread_map' pointer"), perf_thread_map__pid() can
> check for a NULL map and return -1 if idx is 0. Cleanup
> auxtrace_mmap_params__set_idx() and remove the redundant NULL check.
>
> No functional change intended.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   tools/perf/util/auxtrace.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index ebd32f1b8f12..5e437133c753 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -185,10 +185,7 @@ void auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp,
>   
>   	if (per_cpu) {
>   		mp->cpu = perf_cpu_map__cpu(evlist->core.all_cpus, idx);
> -		if (evlist->core.threads)
> -			mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
> -		else
> -			mp->tid = -1;
> +		mp->tid = perf_thread_map__pid(evlist->core.threads, 0);
>   	} else {
>   		mp->cpu.cpu = -1;
>   		mp->tid = perf_thread_map__pid(evlist->core.threads, idx);

LGTM.

Reviewed-by: Aditya Bodkhe <adityab1@linux.ibm.com>

