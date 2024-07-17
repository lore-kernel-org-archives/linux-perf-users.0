Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F109818EAB
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721198563; cv=none; b=bMWAecBLpJqrfzcE4N2OPCDigKldBCgaN4AEGyAfAN8NgKCRk6lE0c3OxBKW4nHRA1pfRxfqUIDaxeEyFnEcYksAqpjXOifjmvWZKXpJQwQqxzl8q2r1HN8XWexpj1SHeXzn0K/0g6p8qEADkogVwruP9OPDsO8HWOxewz8J8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721198563; c=relaxed/simple;
	bh=EMWTHkPUWl6+LpbIBVgZRT6qmObHOm/ohrnT97ezO8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khQsGyVcKGF/D36gi7XTf3h5UJyWnX4ORuKl0DDcCmDjVoIZ3cCqBzhYFjvEmJVySM38U+33JJoBI7TY+J5S6eBg6ClZUvLrffLuC8ur6uoROMwFbMhnwJ+UI3QYSy7Et8gxVLA+MvsFppLu+n5M0o3g5fB8ojjnVSojzBsByiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KX6LEY3G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KX6LEY3G"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H5vB21029826;
	Wed, 17 Jul 2024 06:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=E
	MWTHkPUWl6+LpbIBVgZRT6qmObHOm/ohrnT97ezO8M=; b=KX6LEY3Grnump34c1
	9Nh3dUlu4/G550GoLlVZeSs8jEAMuEXCnZtK/yUX8iuUp0VC21YQIrB4gBPO4xSu
	UxpFU8PxbK5RXR/GX+6XrelZzhD/Esgnc7/yg22Y8EfTIG8e3iXzb6lA8qKbJqxB
	EXRf/bU36WkgFnDztKpNWscm2XLUHOSJoWTcvt1JTOYc8/ho/afCT5l5lGOU9g1e
	0fgoJgRG2tw0CI1OpYFhhSiMz2gHvza/PRz00VPkEgA22Oz4sb5cgRuGand6g2DS
	W4kY2wd2L+TZ1LkcmNuCr9uFc45rwZGwLjihgCgUaMKMJo2/C4guu1FqfE8Rr9h5
	T3+lw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e6h3g8vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 06:42:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46H6gUAR032108;
	Wed, 17 Jul 2024 06:42:30 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e6h3g8vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 06:42:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H5g86U028853;
	Wed, 17 Jul 2024 06:42:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkmtvht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 06:42:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46H6gNvu46137848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 06:42:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9301B2005A;
	Wed, 17 Jul 2024 06:42:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4DF320063;
	Wed, 17 Jul 2024 06:42:21 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jul 2024 06:42:21 +0000 (GMT)
Message-ID: <2bd363dd-8467-4caa-ab87-bf488b73752b@linux.ibm.com>
Date: Wed, 17 Jul 2024 12:12:21 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/4] perf check: introduce check subcommand
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240628064236.1123851-1-adityag@linux.ibm.com>
 <20240628064236.1123851-2-adityag@linux.ibm.com>
 <Zn8C-XpC1beIRN8t@google.com>
 <tylbo22m2koyrcypdykidcuzcwrtfqrzehcwwwmqkcqnbnhz2y@rnsy3gyfmzj4>
 <ZoSRiW1aVsV-xrur@google.com>
 <htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e>
 <ZpGQcN8RBHs6peFL@google.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ZpGQcN8RBHs6peFL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JCjYXGTvLqRHXrGrP4vkYfNxLsBwmGvo
X-Proofpoint-ORIG-GUID: 8Or1gu-CzzGwOuBTgzBFxe-niIrSZEu5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_03,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=669 bulkscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170047

Hi Namhyung,

On 13/07/24 01:52, Namhyung Kim wrote:
>
> <...snip...>
>> Maybe `free(command_usage[0])` or something like
>> `parse_options_free_subcommand()` ?
> It seems we don't have a place to mark whether it needs to free or not.
> Let's go with free(command_usage[0]) for now.


Sure, I will post a separate fix patch for this.


Thanks,

Aditya Gupta

>
> Thanks,
> Namhyung
>
