Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4681BD4EE;
	Wed, 14 Aug 2024 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660729; cv=none; b=qMxKVnBQvb5M9SObBQby3Ujyl2P8AA5JkIuNbQwBKLP0zZo+JHvfZdRu/QN03FdzTsB3VNtjSP9L4BBS3Lya2r55FLAUtXJxvdmkOi2mjoYFEfJtKEzySVhCllKQ2U40DXByve4lsmJ6fn+t2TGALmDvly5+n3CiPdl7iP8mYJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660729; c=relaxed/simple;
	bh=9VIQjITdMElJEambMlWS0EUo5gmcdfLMfeiEW59NMR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WkwqgOewd9yzf5zC46c5brAxTdFA8uL1Kje9iJyv1g7UvE22KlxECOD/NiWzH1Z7y/G2IW2cS9ELZOmt/RmnFMJqhShGXPvqZihbFQ8Uh8vCDsBwkKoo7u7SUPi2A9IosuPng/SAaIyCRUmwRMYjn9ChFdl/wvGk1GxPBSVpxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phRED2rR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phRED2rR"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHslWn025058;
	Wed, 14 Aug 2024 18:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:cc:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=TLYgqOZWGdWRFJr+qo1vXuDeJWB1UFxGLirI4LhM9+s=; b=phRED2rR8/n+
	9/ikjJ7zhETx2jMJpY+Qu84e2kAxPqQmNjm4q4FKg467aDmkBmtxCvYxCx2majfz
	UjCLaJ66fL6Fu7YB2E61fagDNFcFqD4L7Ro/Fp23ltMou8Fw3EeXJVDyi7AVnJzD
	OHL5VqgpBCFI855YuA1FflPuB+/kqC5bxSAWWke10Wbaa583q3262Od4Cz0+1+Cj
	g4l23Jo7mJZN5+pSHcEwLMKLQPjbtTGqsEUvEq6QdxoKR3SFmN0WK8jXRoQKwmX+
	dq3GonMTj4SAbJwoAzKKUxEVLYbB4bZuYNOPON7Ii8ZxsGk0PPJjECtot/2GIyFW
	jXw+w9WfVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d686tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:38:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EIcM4u017890;
	Wed, 14 Aug 2024 18:38:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d686te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:38:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EHfQvH029668;
	Wed, 14 Aug 2024 18:38:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmjnvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:38:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EIcICG36503816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 18:38:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F03B058063;
	Wed, 14 Aug 2024 18:38:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9965E5805E;
	Wed, 14 Aug 2024 18:38:11 +0000 (GMT)
Received: from [9.43.10.208] (unknown [9.43.10.208])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Aug 2024 18:38:11 +0000 (GMT)
Message-ID: <2ff74780-4649-4522-bc5b-e57f83f0ff96@linux.ibm.com>
Date: Thu, 15 Aug 2024 00:08:09 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf sched timehist: Skip print non-idle task
 samples when only show idle events
To: Yang Jihong <yangjihong@bytedance.com>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
Content-Language: en-US
Cc: namhyung@kernel.org, acme@kernel.org, kan.liang@linux.intel.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240812132606.3126490-1-yangjihong@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240812132606.3126490-1-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OJlM8tXJcmHCWG6IpBhyeVx08UZZgsjg
X-Proofpoint-GUID: Qf-X3bvWOnhtnV4Xf7mKEZZ_S5mSxwzG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140126

Hi Yang Jihong,

On 12/08/24 18:56, Yang Jihong wrote:
> when only show idle events, runtime stats of non-idle tasks is not updated,
> and the value is 0, there is no need to print non-idle samples.
> 
> Before:
> 
>   # perf sched timehist -I
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>    2090450.763235 [0000]  migration/0[15]                     0.000      0.000      0.000
>    2090450.763268 [0001]  migration/1[21]                     0.000      0.000      0.000
>    2090450.763309 [0002]  migration/2[27]                     0.000      0.000      0.000
>    2090450.763343 [0003]  migration/3[33]                     0.000      0.000      0.000
>    2090450.763469 [0004]  migration/4[39]                     0.000      0.000      0.000
>    2090450.763501 [0005]  migration/5[45]                     0.000      0.000      0.000
>    2090450.763622 [0006]  migration/6[51]                     0.000      0.000      0.000
>    2090450.763660 [0007]  migration/7[57]                     0.000      0.000      0.000
>    2090450.763741 [0009]  migration/9[69]                     0.000      0.000      0.000
>    2090450.763862 [0010]  migration/10[75]                    0.000      0.000      0.000
>    2090450.763894 [0011]  migration/11[81]                    0.000      0.000      0.000
>    2090450.764021 [0012]  migration/12[87]                    0.000      0.000      0.000
>    2090450.764056 [0013]  migration/13[93]                    0.000      0.000      0.000
>    2090450.764135 [0014]  migration/14[99]                    0.000      0.000      0.000
>    2090450.764163 [0015]  migration/15[105]                   0.000      0.000      0.000
>    2090450.764292 [0016]  migration/16[111]                   0.000      0.000      0.000
>    2090450.764371 [0017]  migration/17[117]                   0.000      0.000      0.000
>    2090450.764422 [0018]  migration/18[123]                   0.000      0.000      0.000
>    2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
>    2090450.764505 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
>    2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
>    2090450.764590 [0016]  s1-agent[7179/7162]                 0.000      0.000      0.000
>    2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
>    2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
>    2090450.764639 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764668 [0017]  s1-agent[7180/7162]                 0.000      0.000      0.000
>    2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
>    2090450.764672 [0000]  s1-perf[8235/7168]                  0.000      0.000      0.000
>    2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
> 
> After:
> 
>   # perf sched timehist -I
>   Samples of sched_switch event do not have callchains.
>              time    cpu  task name                       wait time  sch delay   run time
>                           [tid/pid]                          (msec)     (msec)     (msec)
>   --------------- ------  ------------------------------  ---------  ---------  ---------
>    2090450.764490 [0000]  <idle>                              0.000      0.000      1.255
>    2090450.764571 [0016]  <idle>                              0.000      0.000      0.278
>    2090450.764588 [0010]  <idle>                              0.000      0.000      0.725
>    2090450.764635 [0000]  <idle>                              0.015      0.015      0.129
>    2090450.764637 [0017]  <idle>                              0.000      0.000      0.266
>    2090450.764669 [0000]  <idle>                              0.003      0.003      0.029
>    2090450.764683 [0000]  <idle>                              0.003      0.003      0.010
>    2090450.764688 [0016]  <idle>                              0.019      0.019      0.097
>    2090450.764694 [0000]  <idle>                              0.001      0.001      0.009
>    2090450.764706 [0000]  <idle>                              0.001      0.001      0.010
>    2090450.764725 [0002]  <idle>                              0.000      0.000      1.415
>    2090450.764728 [0000]  <idle>                              0.002      0.002      0.019
>    2090450.764823 [0000]  <idle>                              0.003      0.003      0.091
>    2090450.764838 [0019]  <idle>                              0.000      0.000      0.154
>    2090450.764865 [0002]  <idle>                              0.109      0.109      0.029
>    2090450.764866 [0000]  <idle>                              0.012      0.012      0.030
>    2090450.764880 [0002]  <idle>                              0.013      0.013      0.001
>    2090450.764880 [0000]  <idle>                              0.002      0.002      0.011
>    2090450.764896 [0000]  <idle>                              0.001      0.001      0.013
>    2090450.764903 [0019]  <idle>                              0.063      0.063      0.002
>    2090450.764908 [0019]  <idle>                              0.003      0.003      0.001
> 

LGTM and also tested the changes.

Reviewed-and-tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

> Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/builtin-sched.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..177634df1ba5 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2727,10 +2727,10 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  
>  			itr->last_thread = NULL;
>  		}
> -	}
>  
> -	if (!sched->summary_only)
> -		timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +		if (!sched->summary_only)
> +			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +	}
>  
>  out:
>  	if (sched->hist_time.start == 0 && t >= ptime->start)

