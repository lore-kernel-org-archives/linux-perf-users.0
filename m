Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017D47F69
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546805; cv=none; b=B7l0HpE08GzQPph8v24ZO6mjbqlcCyuTitmyYYqPG6q08LrWOLMHqNP6NhPHSjlWD9BLBhYq3Xbvf/UKuFLQe+O7ybsB46HL1d4A0PtMnVZ2/HoZps9Sp7XMo+yuckX8lwnSc8CqaDodJUR3PHM4vY+dz771QUqp3efM3Iv3ltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546805; c=relaxed/simple;
	bh=ZszTKPvv5ZYJSr2FWx+dyrGg0NKkT167FFUDdtyrfc4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HPTvrhqJjNDUzF8p/qqpJDetSc/m+pUqC1cjnMCnf1Dr1HB1iqDVRAVz57BlkmWnj0Yj1P3G+K3KEBLrAKTdMLmNkCfit+KLIltmhRqNdBsBRJt2/3JdSesKo//2fm1+mOZn5Bb2P2HFIg8mssOKniR64TD2BKQ+euwLu3k77JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K/8SWyx9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K/8SWyx9"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485CGULe017262;
	Thu, 5 Sep 2024 14:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	bfbdJuIrRteYwfawh+FzEhUWVptKqRZluAyTuANwUpI=; b=K/8SWyx9qngNcLY2
	uNKDZq2GHCf1x6V1z/Zi2l3xMXNerFmYh4bmlKN0LadmnNzqiBsY/ApJZRhNNE03
	PSBktDF/S096S2gK9NbHfpF6PcQ9cOA3O1E9p1XSDhdBLC5Vn0pJNP7hxGx/i06a
	i55B0QoNe0O8yiOh/udFCjidS7DQGlhfgiWFTPsTSofhVPQDUCUfwmtrQFWy9tMg
	kx3l7CjKMK5VzaAf3gCWhEZuPMCt0MxZdCt/hGOyEy7OnOOzngT91u8Tca+l1rSs
	K8Zhkisj88hQ3n472rp8KjciUugHbZ5h0W8v8zlxjQUbF8nZlmRSrgHfg44ArhXd
	b776ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bskm9hmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 14:33:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 485EXH2P018795;
	Thu, 5 Sep 2024 14:33:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bskm9hm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 14:33:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 485EEY2G012023;
	Thu, 5 Sep 2024 14:33:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cegq55j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 14:33:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 485EXCFg36372900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 14:33:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BDF52004E;
	Thu,  5 Sep 2024 14:33:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EA020040;
	Thu,  5 Sep 2024 14:33:09 +0000 (GMT)
Received: from [9.124.218.179] (unknown [9.124.218.179])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 14:33:09 +0000 (GMT)
Message-ID: <b8d14ee1-c97e-4cac-8668-9476ab2b61d7@linux.ibm.com>
Date: Thu, 5 Sep 2024 20:03:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 7/7] perf: Add more features to supported_features
 list
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240904190132.415212-1-adityag@linux.ibm.com>
 <20240904190132.415212-8-adityag@linux.ibm.com> <Zti81yV0jRIB7oQ6@x1>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <Zti81yV0jRIB7oQ6@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QendMHZRZ5XcU0O3SJY16_bQ4H2F1MPi
X-Proofpoint-ORIG-GUID: wFq0LW2kf3qyqLquUVV3Ubi803xpvZ84
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
 definitions=2024-09-05_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=894 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050108

On 05/09/24 01:32, Arnaldo Carvalho de Melo wrote:

> On Thu, Sep 05, 2024 at 12:31:32AM +0530, Aditya Gupta wrote:
>> As suggested in [1], add more feature names and corresponding names,
>> based on the information in Makefile.config
>>
>> The entries were added after seeing the corresponding -D option which is
>> added to CFLAGS, based on the presence of a feature in Makefile.config,
>> such as:
>>
>>      ifeq ($(feature-file-handle), 1)
>>        CFLAGS += -DHAVE_FILE_HANDLE
>>      endif
>>
>> For above feature 'file-handle', corresponding entry has been added to
>> supported_features as below:
>>
>>      FEATURE_STATUS("file-handle", HAVE_FILE_HANDLE)
>>
>> [1]: https://lore.kernel.org/linux-perf-users/Zn7EvDbsnlbLXj4g@x1/
> I'll remove this now because there were some that sounds really strange,
> like:
Okay.
> acme@x1:~/git/perf-tools-next$ sudo su -
> [sudo] password for acme:
> root@x1:~# perf -vv
> perf version 6.11.rc3.g15dc9f274b8e
>                   glibc: [ OFF ]  # LIBC_SUPPORT
> libslang-include-subdir: [ OFF ]  # HAVE_SLANG_INCLUDE_SUBDIR
>
>
> The first one is the strange one, how come, no LIBC_SUPPORT? glibc?
Debugged it:


Output of `make` says glibc is there:


     Auto-detecting system features:

     ...                                   ...

     ...                                   glibc: [ on  ]

     ...                                   ...

     ...                                  libelf: [ on  ]


But, in Makefile.config, 'LIBC_SUPPORT' is only defined if libelf is NOT 
there:


     ifeq ($(feature-libelf), 0)
         ifeq ($(feature-glibc), 1)
             LIBC_SUPPORT := 1
         endif
      ifeq ($(BIONIC),1)
           LIBC_SUPPORT := 1
       endif


Hence since LIBC_SUPPORT is not defined, the check --feature command 
says glibc is OFF.

I think we can simply remove libc entry from the features array in this 
patch, as glibc is kind of obvious to be there if compilation worked.


Meanwhile I will check all feature entries added in this patch again. I 
can post this patch as an independent patch.


> The second looks irrelevant, I'll see.

Sure.


Thanks,

Aditya Gupta

>
> - Arnaldo
