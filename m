Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DA1AF0BE
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315817; cv=none; b=OZuhZ3uTTHXVJWXro9P8p8AJpZ7wF6pIrCHAeQaTUO5QOSs2FQzUAt5I/zqokrpV0A4hrdbFg5YotRrQjE+Y+5SxM6lnEycuqa/IQ4TkjDQ4fmyXp/nDLA3kxNszBt3an9r44/pKXaUIzayxR7ZUDaXojEwp7dB6VKQkUbj8BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315817; c=relaxed/simple;
	bh=OXBo257kgWrYsmJU2fR0f6WcXa4HcgIypS4w5tPXoOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXKP2TcK2I52R6i7pU7om0Eyh0SoqMr0Rf1XUDv9CmYdT0qcPE78lKP0TjsnE8lb/7E2nNLFnpgYVJP2pXUsZESRAIo6N1/uevw6vigcjGexfemYUXB0Qsjxpd6N9nrtsXEHqjzkVIgmx3Ms5d4VgO3bbbd390jork9xX5d1dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PfXTycwn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PfXTycwn"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4ABJ6D008245;
	Wed, 4 Dec 2024 12:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pE5P+7
	Q9Cta4GAHmwILnajt4nkW/eVb+QRox1nI4wTM=; b=PfXTycwnovk4Z4LMdByBS6
	AJxuQ5MP+nlWHuILyDa7wN0T/HysMzRKnZ60s7kKN7GbBEC0931bewJyHGUOFKuG
	sQMFYFIxUA7QUWJXZglitM7wIaRgJC9vHg2UYBSqhPCu6NGbZZb7iTkltM6cHR6y
	xUjjDlH68mY9bv6xU4LoCkXUCBNg1zoGsZp55VfiHLL2zBcS/9x4IL0hRRJIxxSi
	8V/WnQv770yIst9G0inp8mI7WRF32uh/Jm3lBPwRmTTHJ11Sgf4iWwefmTLTycQT
	tRGjg1/pIan4Wyby7DrNAuPHwAZOiftzuRJz1/biqIp+cKz0XtJpaVa3BgJ4utbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgvh2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 12:36:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B4CapQs003058;
	Wed, 4 Dec 2024 12:36:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgvh26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 12:36:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4B4v6f022960;
	Wed, 4 Dec 2024 12:36:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n3sdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 12:36:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4Caj6C63308212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 12:36:45 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEDE20049;
	Wed,  4 Dec 2024 12:36:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B8B20040;
	Wed,  4 Dec 2024 12:36:45 +0000 (GMT)
Received: from [9.152.212.95] (unknown [9.152.212.95])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 12:36:45 +0000 (GMT)
Message-ID: <3df9ea2e-dca6-4e4d-b37a-249f31e3d378@linux.ibm.com>
Date: Wed, 4 Dec 2024 13:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf test 7 fails on s390 since 6.12.0
To: James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@arm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <12338ec9-51a0-44ef-b2e6-4a95d3bf0e4d@linux.ibm.com>
 <8d6d43d1-51be-4412-829a-ef5875321f5b@linaro.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <8d6d43d1-51be-4412-829a-ef5875321f5b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eCUPrY3h_LULjYNDAmWX80iGiBBtgyIz
X-Proofpoint-GUID: KJqMqMteaYlfzn0V7U9H5fWKJVv76sue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040097

On 12/3/24 15:37, James Clark wrote:
> 
> 
> On 02/12/2024 2:53 pm, Thomas Richter wrote:
>> I just downloaded the latest kernel tree 6.13.0rc1 and observed several
>> failures of the perf test suite.
>>
>> This test case is the first one:
>> # ./perf test -F 7
>> Unrecognized literal '#system_tsc_freq'  7: Simple expression parser  : FAILED!
>> #
> 
> Hi Thomas,
> 
> Did you see this thread: https://lore.kernel.org/linux-perf-users/0F805B2F-35CC-4E0C-BD2F-84552C4C528E@linux.vnet.ibm.com/
> 
> Is that related to your issue? I looked but I couldn't find a V2 from Athira.
> 
> The same test was also mentioned on "[GIT PULL] perf-tools changes for v6.13", but I can't tell if it's the same type of failure or not.
> 
> James
> 
> 

Thanks James,

yes it is the same issue. I applied above mentioned fix and it works again:


# ./perf test -Fvv 7# ./perf test -Fv 7
--- start ---
Using CPUID IBM,3931,704,A01,3.7,002f
division by zero
syntax error
---- end ----
  7: Simple expression parser                                        : Ok
#

For s390 you have my

Tested-By: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
