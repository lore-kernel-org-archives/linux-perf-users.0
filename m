Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B81BE25B;
	Wed, 14 Aug 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723660959; cv=none; b=lSUzv05fvCQAYMZWUXfrvQca1+zuAYutIYsweo4kpOi4Wxd0Hl54FSnd6LE22Z6tVuoh1t5C1kHygXR6zUGgTyiCZ4s9LtNz00rl0xow6TrJ6A0VWKhtBMNJoBSVnCQPRkrfcS4SHRaNleHWFr+b6nc1TurkDuPyS0ps4uc7uRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723660959; c=relaxed/simple;
	bh=nb+Mq7tdOJ+Pi/Y9y221sJwv9PwfEckHWHDwQsh0Q5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=dM6pQfXZget66EHNhV9s5LlPz3wr1liYLNpoN2lHhBAOHHcJpc7ymN8Vo/KX1SW9xYmUvlg48Y5TPSXpw64WW1KixrWj0qfLfq2/XA7c84DsV6dn/xoZEtNCXHnzzKClBMI0ktQwcOJUqE0PKB4JcH7XuGaKfbbEtp3cbj1TJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qEKCIIQr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qEKCIIQr"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EI5Fxc000476;
	Wed, 14 Aug 2024 18:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:cc:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=3CPP4dO/u9ZJ7LHUmSfSPPwjcX88rXRBKYsFimnDiME=; b=qEKCIIQrF1ke
	KUL7KpCgk78ZHQU/t5NJJclg3Z/trsuS288g0n/xBalQZRef9mNU3BCGr7gcK+8H
	60sDu+N+Ca6zjr19e4ZSFyddbRmKhTGtDualWspgIviw2H0o9OQJREPhVyEWfQtj
	XVcCOHeuk3y18myzQP3l6vYUaAozuDInMNVmL1g3Uzjd4qTb8U2ShR8Xu61lbXHJ
	XJWf3j5+Xl1wulOOND8NhMwv/VaRks1wWeDKmRKXjACwsoqrTPZgLgi+mALaxF5o
	eiJoWpSuSqxfleF6+ETkS1b+AyEUKc1AUkODFCLMgrVk9o2DrXdTKP+zubolVJAR
	7tn6hydROg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5r5jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:42:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47EIgJEo010732;
	Wed, 14 Aug 2024 18:42:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5r5jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:42:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47EITvil020901;
	Wed, 14 Aug 2024 18:42:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn83agu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:42:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47EIgFc442402088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 18:42:17 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD8F858043;
	Wed, 14 Aug 2024 18:42:15 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA36D58055;
	Wed, 14 Aug 2024 18:42:08 +0000 (GMT)
Received: from [9.43.10.208] (unknown [9.43.10.208])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Aug 2024 18:42:08 +0000 (GMT)
Message-ID: <80ededea-8fb2-49a7-8f63-13bd7812d1a1@linux.ibm.com>
Date: Thu, 15 Aug 2024 00:12:06 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf sched timehist: Remove BUG_ON in
 timehist_sched_change_event()
Content-Language: en-US
To: Yang Jihong <yangjihong@bytedance.com>
References: <20240812132606.3126490-1-yangjihong@bytedance.com>
 <20240812132606.3126490-2-yangjihong@bytedance.com>
Cc: namhyung@kernel.org, acme@kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240812132606.3126490-2-yangjihong@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240812132606.3126490-2-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uuS0JKkN9PnIvRDl3OYNgTDj-Ut-HgSt
X-Proofpoint-GUID: w7FPs8JnDSMq9FagiuAgpCYP3ao_hcrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140126

On 12/08/24 18:56, Yang Jihong wrote:
> The BUG_ON(thread__tid(thread) != 0) in timehist_sched_change_event()
> is redundant, remove it.
> No functional change.
> 
> Fixes: 07235f84ece6 ("perf sched timehist: Add -I/--idle-hist option")
> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> ---
>  tools/perf/builtin-sched.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 177634df1ba5..309dcfb3796d 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2700,8 +2700,6 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>  			struct idle_thread_runtime *itr = (void *)tr;
>  			struct thread_runtime *last_tr;
>  
> -			BUG_ON(thread__tid(thread) != 0);
> -
>  			if (itr->last_thread == NULL)
>  				goto out;
>  

Yes, that indeed is redundant.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy
