Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A765824BB
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725428499; cv=none; b=BTJj2MRJFw7Stj3vP1kDW7JwB2Ywp78K4ppfjTA+8Qpil/fsQrgxmsswZK5bG09P539DmQz73l7UHbcSOGTxhfN3Abn01txVAnLdgVTkaCzxaViaSyMW9vqUrybZ7O9s8lYhkEw2ctXwcFnGN40gl7rNln5I7adBVRtTblq9sRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725428499; c=relaxed/simple;
	bh=PMxCx/hWiNazmeQ4cJ6Ha2Q8HVdFqiBR6BlEQjmjsV0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bm8AYvxoxm7Gx6xo9ftnvcZ+9wvetPuPr3BmeYBda8baeDPWbMJSVHSfvVeqJV5e0z6H578UQAPSW0f/iEJ9XYuKWMSwZ0UDRMrnNJ/24Hhn6i7+ntXk+mGg4UewqZAG+IV6APL3/fOtjhymipbJX2IwqBoTrwKPu+vyA9H+WbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trQXVkUG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="trQXVkUG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845IZTc029003;
	Wed, 4 Sep 2024 05:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	Iz+/ZFlLOcQDY+NJIhB7yWtFRUQc00yuxvc5qc3hOLM=; b=trQXVkUGB3Ks3dLW
	j2CRsOId9RA3OX5eRDl4nnhHEw4+SDteROaVTg6fBhZdZP1veBz/iGL22rqQBZqv
	cb1IIosj7LTx2VcfWlEsuI6a1BDbwwj+AVUhYDLtzG86RfcbabGn96aeSDJmUxr/
	tXDBRBh4Yux+nHHTsUn+appR1eevNZGosO+rk+TS3W7jOOSwb30Ht4VqTK2o9O48
	gtEPLqaGAe3Iu0Dpf6GeFF7AwhJ2FV2hFIW+jl2tNaUefPUNe5Cpig+t151wC4nr
	ECydW+zQ+Eq+nNHPUsVYGQX91TqrTWbIuWwXEbbcbqnoLhz9CZscPC4aS0+098Um
	Sn0veA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb1ctf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 05:41:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4845fWT1010984;
	Wed, 4 Sep 2024 05:41:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btwb1ctd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 05:41:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48440JqO018602;
	Wed, 4 Sep 2024 05:41:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw16bvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 05:41:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4845fRBP17826136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 05:41:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1910E2004B;
	Wed,  4 Sep 2024 05:41:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF61A20043;
	Wed,  4 Sep 2024 05:41:24 +0000 (GMT)
Received: from [9.109.199.38] (unknown [9.109.199.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 05:41:24 +0000 (GMT)
Message-ID: <264f7b57-514c-48fe-8dcb-8d64c293c650@linux.ibm.com>
Date: Wed, 4 Sep 2024 11:11:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/7] Introduce perf check subcommand
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240718085957.550858-1-adityag@linux.ibm.com>
 <ZtcrldaM-QfckxWL@x1>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ZtcrldaM-QfckxWL@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Epo99gW29XZBp2Rr2lXQdT4_KToF88Uo
X-Proofpoint-GUID: y4TsGGeJ_x5ssG-z6SBrZlkxGvtCX4ny
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040041

Hi Arnaldo,

On 03/09/24 21:00, Arnaldo Carvalho de Melo wrote:
> On Thu, Jul 18, 2024 at 02:29:50PM +0530, Aditya Gupta wrote:
>> The Problem
>> ===========
>>
>> Currently the presence of a feature is checked with a combination of
>> perf version --build-options and greps, such as:
>>
>>      perf version --build-options | grep " on .* HAVE_FEATURE"
>>
>> This relies on the output of perf version, and is a common pattern in tests.
>>
>> Proposed solution
>> =================
>>
>> As suggested by contributors in:
>> https://lore.kernel.org/linux-perf-users/ZMPWk5K63tadmDlU@kernel.org/
>>
>> Introduce a subcommand "perf check feature", with which
>> scripts can test for presence of a feature or multiple features, such as:
> I tried to resume reviewing/testing but:
>
> Total patches: 7
> ---
> Cover: ./v13_20240718_adityag_introduce_perf_check_subcommand.cover
>   Link: https://lore.kernel.org/r/20240718085957.550858-1-adityag@linux.ibm.com
>   Base: not specified
>         git am ./v13_20240718_adityag_introduce_perf_check_subcommand.mbx
> ⬢[acme@toolbox perf-tools-next]$        git am ./v13_20240718_adityag_introduce_perf_check_subcommand.mbx
> Applying: tools/lib/subcmd: Don't free the usage string
> Applying: perf check: Introduce 'check' subcommand
> Applying: perf version: Update --build-options to use 'supported_features' array
> error: patch failed: tools/perf/builtin-version.c:46
> error: tools/perf/builtin-version.c: patch does not apply
> Patch failed at 0003 perf version: Update --build-options to use 'supported_features' array
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> ⬢[acme@toolbox perf-tools-next]$

Maybe I need to rebase it now. I will rebase and send it again.


Thanks,

Aditya Gupta

