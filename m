Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232A4D8BA
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279995; cv=none; b=PrGS1ZvLJO/bl8j6VU1MhZoay2vSh3YhnFiFNjlHcW8tguw1V84fePN9xBvYVmInNfbt+aZmf8dQVGKIEnTwvWyVrq7b1npP4pwZ2NhkXHd5W21xAzlAfo58Uz1LKUhwbQicGlTAbtpS5ZXdvIJYdfcVAMT7dNy9od3kPqig6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279995; c=relaxed/simple;
	bh=7/Rd+V/Rdzw858A6+AsFz3rC2EoHJKt2pw0ceE9trbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nwzz0R1Rx8SMbfZfhubwIbQHhJ8y2tASL8AW+AEB0q/JpCn49OpKCA2w78rb8uA332++UCMF3P4NDBGYzwlyep6bjx8l2yBFkYnY3UbJp3bIzcIVJUvCXqOKVWRMFppTQeEiaQWSDeNPJoTrzq5kxlLuXzn21j7nElw43t4U+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=np33QuTN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="np33QuTN"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I5I8tJ016083;
	Thu, 18 Jul 2024 05:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=i
	kEp9A7ANd1z/h5TGsrgALhJXSbaoHfEFuU2jmOGnvQ=; b=np33QuTNMz7lOaMXW
	z8seNjY3QT5hCRZLJl7Ljdwm4vSpeBEfx8kLixL7lRr6ZRgLYYaap4mj3wagCGl/
	GzInjSKi1BcNDFj3mecg/nCjpGur4iH7PUk0RPBFetLsfeH3qr1pV368HYN+n8ib
	nxVnGYmeWQPuxrxrr7Tb8drOb1Izf2dFnttRJuI30HV0WYx8FbLLG8a5sZ4xLT7J
	uHCnm756Oz3A2DATHSfeDR9aTYiOze1uf7EPMHzPqVpHTmiko39m7SMI61lBjRJZ
	aSDqU3fIM9qoeQ2DNm29Bfbtk1pM0QZZlZE1OLLkRWZgy0lYh1GxRatOvEqkK4wh
	sLewQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evg701cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:19:42 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I5Jgfc017410;
	Thu, 18 Jul 2024 05:19:42 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40evg701cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:19:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I5Gfvu029210;
	Thu, 18 Jul 2024 05:19:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkj7y8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:19:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I5Jbm154722884
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 05:19:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07D8A2004E;
	Thu, 18 Jul 2024 05:19:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DDB620040;
	Thu, 18 Jul 2024 05:19:35 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 05:19:35 +0000 (GMT)
Message-ID: <496820bb-5c85-4593-8daf-b8c41394c81b@linux.ibm.com>
Date: Thu, 18 Jul 2024 10:49:33 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools/lib/subcmd: Don't free the usage string
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
References: <20240717103351.268344-1-adityag@linux.ibm.com>
 <ZpiIB_1jSNvj95PL@google.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ZpiIB_1jSNvj95PL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9JOSx-ssG2rB_CR9v7siLAKOugtA-vMr
X-Proofpoint-ORIG-GUID: yNSO1-xP0Lz4ukuaY4Kk5vtmhkU72EZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_01,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 mlxlogscore=937 mlxscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180031

> <...snip...>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the Ack, Namhyung !


- Aditya Gupta


> Thanks,
> Namhyung
>
>> ---
>>   tools/lib/subcmd/parse-options.c | 8 +++-----
>>   tools/perf/builtin-kmem.c        | 2 ++
>>   tools/perf/builtin-kvm.c         | 3 +++
>>   tools/perf/builtin-kwork.c       | 3 +++
>>   tools/perf/builtin-lock.c        | 3 +++
>>   tools/perf/builtin-mem.c         | 3 +++
>>   tools/perf/builtin-sched.c       | 3 +++
>>   7 files changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
>> index 4b60ec03b0bb..eb896d30545b 100644
>> --- a/tools/lib/subcmd/parse-options.c
>> +++ b/tools/lib/subcmd/parse-options.c
>> @@ -633,10 +633,11 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>>   			const char *const subcommands[], const char *usagestr[], int flags)
>>   {
>>   	struct parse_opt_ctx_t ctx;
>> -	char *buf = NULL;
>>   
>>   	/* build usage string if it's not provided */
>>   	if (subcommands && !usagestr[0]) {
>> +		char *buf = NULL;
>> +
>>   		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
>>   
>>   		for (int i = 0; subcommands[i]; i++) {
>> @@ -678,10 +679,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>>   			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
>>   		usage_with_options(usagestr, options);
>>   	}
>> -	if (buf) {
>> -		usagestr[0] = NULL;
>> -		free(buf);
>> -	}
>> +
>>   	return parse_options_end(&ctx);
>>   }
>>   
>> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
>> index 6fd95be5032b..6b88b8b40784 100644
>> --- a/tools/perf/builtin-kmem.c
>> +++ b/tools/perf/builtin-kmem.c
>> @@ -2058,6 +2058,8 @@ int cmd_kmem(int argc, const char **argv)
>>   
>>   out_delete:
>>   	perf_session__delete(session);
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)kmem_usage[0]);
>>   
>>   	return ret;
>>   }
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index 71165036e4ca..988bef73bd09 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -2187,5 +2187,8 @@ int cmd_kvm(int argc, const char **argv)
>>   	else
>>   		usage_with_options(kvm_usage, kvm_options);
>>   
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)kvm_usage[0]);
>> +
>>   	return 0;
>>   }
>> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
>> index 56e3f3a5e03a..fd53838b5a78 100644
>> --- a/tools/perf/builtin-kwork.c
>> +++ b/tools/perf/builtin-kwork.c
>> @@ -2520,5 +2520,8 @@ int cmd_kwork(int argc, const char **argv)
>>   	} else
>>   		usage_with_options(kwork_usage, kwork_options);
>>   
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)kwork_usage[0]);
>> +
>>   	return 0;
>>   }
>> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
>> index 0253184b3b58..b25d50716e63 100644
>> --- a/tools/perf/builtin-lock.c
>> +++ b/tools/perf/builtin-lock.c
>> @@ -2713,6 +2713,9 @@ int cmd_lock(int argc, const char **argv)
>>   		usage_with_options(lock_usage, lock_options);
>>   	}
>>   
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)lock_usage[0]);
>> +
>>   	zfree(&lockhash_table);
>>   	return rc;
>>   }
>> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
>> index 863fcd735dae..b7c1cf6d0e5a 100644
>> --- a/tools/perf/builtin-mem.c
>> +++ b/tools/perf/builtin-mem.c
>> @@ -517,5 +517,8 @@ int cmd_mem(int argc, const char **argv)
>>   	else
>>   		usage_with_options(mem_usage, mem_options);
>>   
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)mem_usage[0]);
>> +
>>   	return 0;
>>   }
>> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
>> index 8750b5f2d49b..d6acc53ae89e 100644
>> --- a/tools/perf/builtin-sched.c
>> +++ b/tools/perf/builtin-sched.c
>> @@ -3805,5 +3805,8 @@ int cmd_sched(int argc, const char **argv)
>>   		usage_with_options(sched_usage, sched_options);
>>   	}
>>   
>> +	/* free usage string allocated by parse_options_subcommand */
>> +	free((void *)sched_usage[0]);
>> +
>>   	return 0;
>>   }
>> -- 
>> 2.45.2
>>
