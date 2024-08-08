Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4477E153801;
	Thu,  8 Aug 2024 18:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142595; cv=none; b=ky1282Wf0vzaCszqaN9YWuZs7snQYYwYdlUbDtj2EOy0B8aQ074/uSHL4Z6PUWihf/j6vajG22grAEYDTDiEXdYyKPky2zrsoKDO56S7g0Y61SyF/GNQYcjt2/E6IO/NyR9lP5CfOoAtJ01oqTpjlzRin/YzVedXkRPfsLPXtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142595; c=relaxed/simple;
	bh=E6Djr46GF6cVfafEHE5SLoRKFMU6caCDTSU1c4Z7bZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Cu8yoUB16e4sdiN94GJpfI8VdW7JYe3+bLUzOkPPmeLlcCFZN1bxnPm5Q/Wbd8IYxkGn3cvKqD02LAWJKn8Epz20JKNzcOc57q/8xZxSox7qe/DSs6bCtkBarDxzHf5spLpyBORfecWc9638L+CfOwVBBuIzcV4QZCVcrjwyW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tn9KEsLy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tn9KEsLy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478Calw5013384;
	Thu, 8 Aug 2024 18:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:references:cc:reply-to
	:from:in-reply-to:content-type:content-transfer-encoding; s=pp1;
	 bh=z9l3LKla3wlPReP8nb5ggl/k0yC+mQ+dFrNHuzrH9PA=; b=Tn9KEsLyY+eT
	TSvfXb2OhiTGlDDDzCH6eSNXsSFh9M1nIKfZGGIf22+I53DQYddtsQuppZpto9d9
	e/gESDXNYecTMtYH0AAl2fKhNnubqQCFqo3lCaBmUUjycr0YdcTg0wKQvQWIi/EW
	n9/ZHQqxjNantXL3h8rwE8BlXqn/niZcYybUlb2Hfonpr6kzRAcfRGajm6PvhuOU
	/bD/QcU4YiHgi0UHkNuTMm9uhiUMg8JD3nDz/Ix63IQ5O6Rxl77pt3fHcyhXhq9M
	BtHXr7KqtkXOKsEbW3p/rVovMCRUyHW8wNCz7xaijd4tdspywZTTlxnx5ePu8DpF
	ddvABAvn8w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcgxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 18:42:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 478IghiC005697;
	Thu, 8 Aug 2024 18:42:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkcgxr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 18:42:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 478IECL2024361;
	Thu, 8 Aug 2024 18:42:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40sy90yycq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Aug 2024 18:42:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 478IgeUX38077170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Aug 2024 18:42:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FF115805F;
	Thu,  8 Aug 2024 18:42:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2323E58045;
	Thu,  8 Aug 2024 18:42:32 +0000 (GMT)
Received: from [9.43.58.141] (unknown [9.43.58.141])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Aug 2024 18:42:31 +0000 (GMT)
Message-ID: <3f4a68aa-8a74-4698-bf90-d69c315d5ffd@linux.ibm.com>
Date: Fri, 9 Aug 2024 00:12:28 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf sched timehist: Add --show-prio option
To: Yang Jihong <yangjihong@bytedance.com>
References: <20240806015701.1309833-1-yangjihong@bytedance.com>
 <20240806015701.1309833-2-yangjihong@bytedance.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reply-To: 20240806015701.1309833-2-yangjihong@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240806015701.1309833-2-yangjihong@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ACXG_cngKuc1EmumUnhToJQSSCZvgll1
X-Proofpoint-GUID: BoGMd55NVsSjms1xHTEgqJ8BZ65xtK1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408080133

Hi Yang Jihong,

On 06/08/24 07:27, Yang Jihong wrote:
> The --show-prio option is used to display the priority of task.
> It is disabled by default, which is consistent with original behavior.
> 
> The display format is xxx (priority does not change during task running)
> or xxx->yyy (priority changes during task running)
> 

I had done the following steps.
1) Ran 'perf sched record stress-ng --cpu 32 -l 50 --timeout 40s'
2) Changed the nice value of stress-ng while the record was going on.
ps -C stress-ng -o pid=
64195

renice -n 10 -p 64195

3) Then ran 'perf sched timehist --show-prio'

343918.720052 [0015]  stress-ng[64195]    120  0.013      0.013   21.719
.
.
343958.797257 [0009]  stress-ng[64195]    130  40076.812  0.007   0.393

The output shows the final priority change of stress-ng from 120 to 130,
but the transition format xxx->yyy is not displayed.

Am I missing something?

Thanks and Regards
Madadi Vineeth Reddy

> Testcase:
> 
>   # perf sched record nice -n 9 true
>   [ perf record: Woken up 0 times to write data ]
>   [ perf record: Captured and wrote 0.497 MB perf.data ]

