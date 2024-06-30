Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDAF7E572
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Jun 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756545; cv=none; b=PHAALuD24TeWvQsFb0DqHdQSvcIpgclBA/MhgfpLSnRUgmtW6IeUZr4OzgiGt2wKjhwzTQ5NmAxWQ4g6Q0sX89GRB7SXOet8DaJDjNisWEGZQ1LjEIqULOBXM5umubkxzioDXcMN9fUzOiYgAZQpn820oCdYQIv1/6Z7uL/ZB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756545; c=relaxed/simple;
	bh=sEp64HcgdKBRqhgbk+MFy88tzlPWX6Jwidw4La4fbBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fD6YJTGi3rXwR2BLSpBtpTbOH1ONmM3W81M3H4daka+R4p5NA3WobxMHJMZ2DKZQ2rxqCtzfSuEyJMmR/CKlE4l9aop0JBay7X0rOK2rT4N7D2lowlb4K30ygxzHm0+q1i9aUStJ97gs+az9/brfUKRKIfYSN7cLZ9EuFJxCXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zo3a8urd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zo3a8urd"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UDv38B025881;
	Sun, 30 Jun 2024 14:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
	rbL92RMvSy369O2B5Rq0t4ptIBVQqltQ6+6toujqzM=; b=Zo3a8urdoJLjLgDST
	t/HxADGgvtYQRrG9cvYg3y5wVct6srBnidbUAJlnKfGSvTlOBjvzKoc81ZAB484e
	yueSDy4HUZDD45btSr5eeYr0p7sD73oOLWQsEAc4InLD3iFhV0VnrIk29nGNhWgh
	zVJmPUbGdd9gHxj1TOsK/yQwCgQBNb1xphtHL4nxsiNctCh2eb0rRu7T+uATb7FB
	s/YV3yBUXjf1bOuXTg1rKM17SQRYDPjhkbPD/fZI3/tHxbjozQhMbHogUkq+68MO
	53XAWH3rWA/giMTjN5bq0uPN39scRQCKMjEDwse0YXZ/Gb8qJ69/C/A4dx/QpEvU
	Tt9IA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4037vb02s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 14:08:55 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UE8tLe010886;
	Sun, 30 Jun 2024 14:08:55 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4037vb02s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 14:08:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45UBsD64009470;
	Sun, 30 Jun 2024 14:08:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 402xtma6pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Jun 2024 14:08:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45UE8m6153739786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 14:08:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C2B2004B;
	Sun, 30 Jun 2024 14:08:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81AA620040;
	Sun, 30 Jun 2024 14:08:46 +0000 (GMT)
Received: from [9.195.34.133] (unknown [9.195.34.133])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 30 Jun 2024 14:08:46 +0000 (GMT)
Message-ID: <70a883b0-11ba-4d68-bf0d-977af60cc32e@linux.ibm.com>
Date: Sun, 30 Jun 2024 19:38:44 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, linux-perf-users@vger.kernel.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com> <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1> <Zn7GsEKwLxn5bMyN@x1> <Zn7HtaJb3NL2k5YG@x1>
 <Zn8AvuvyjXFGa90c@google.com> <Zn8OxjRgFlPduRKh@x1>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <Zn8OxjRgFlPduRKh@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DVZwXsBtT2Yf1DDgcgksokh2AXNcHnWZ
X-Proofpoint-ORIG-GUID: SZD8gZ5I0n7l6-CC3aRivpQ-nLR2hs9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=903 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300107

Hi Arnaldo,


On 29/06/24 00:58, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 28, 2024 at 11:28:14AM -0700, Namhyung Kim wrote:
>> On Fri, Jun 28, 2024 at 11:24:53AM -0300, Arnaldo Carvalho de Melo wrote:
>>
>>> And while looking at it:
>>>
>>>               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>>>
>>> This looks wrong, no? Or at least confusing, have to check the source
>>> code...
>> We have this in Makefile.config
>>
>> ifndef NO_AUXTRACE
>>    ifeq ($(SRCARCH),x86)
>>      ifeq ($(feature-get_cpuid), 0)
>>        $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
>>        NO_AUXTRACE := 1
>>      endif
>>    endif
> The complete sequence is:
>
> ifndef NO_AUXTRACE
>    ifeq ($(SRCARCH),x86)
>      ifeq ($(feature-get_cpuid), 0)
>        $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
>        NO_AUXTRACE := 1
>      endif
>    endif
>    ifndef NO_AUXTRACE
>      $(call detected,CONFIG_AUXTRACE)
>      CFLAGS += -DHAVE_AUXTRACE_SUPPORT
>      ifeq ($(feature-reallocarray), 0)
>        CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
>      endif
>    endif
> endif
>
> The most descriptive would be to HAVE_GET_CPUID_SUPPORT and have it used
> in the source code.
>
> That or have:
>
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 44ffde6f8dbe51f3..ae4a686ff4f265be 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -33,7 +33,7 @@ struct feature_status supported_features[] = {
>   	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
>   	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
>   	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
> -	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> +	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
>   	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
>   	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
>   	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),


Looks better. Went through all instances of 'HAVE_AUXTRACE_SUPPORT', 
it's mostly been used to conditionally define perf_*_auxtrace functions.

No one seems to depend on the feature 'name' 'get_cpuid'.

Any comments ?

>
> That:
>
>          FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
>
> Should also really be:
>
>          FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),

Will do it in v13.


Thanks,

Aditya Gupta

> For consistency, the get_cpuid/auxtrace also for consistency, I think.
>
> - Arnaldo
