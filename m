Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3E58203
	for <linux-perf-users@vger.kernel.org>; Sun, 28 Jul 2024 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722196710; cv=none; b=KPC8sf8qpUCl3dgKaRirKsc55EzOGN0YyuPhvJHvDIUmXCBEicuuFOQFW+Ny3gJeggqS34x3H+S32nYL5TqLyolnmj4Np/8p3pyF5IZBMC+2R4Dr92dDjnIPS6KVMpuvOnKDpJZ/qns5IWvA90EErod+BPddMsRCK+E8nH0i/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722196710; c=relaxed/simple;
	bh=hMtvA0658wBWU//7vxyt6iwXPMVt4EHvlpKOxi51C68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rCYgpDC6oJPfRrDctLFuLG+v2xfN1EZwl2CthSrINsCsIbcbmzDhICRF7RSYsSoQ6o5qAE/bkvK02yd0TYympziuXyqyoG8ho6aoxhq2QD5I0886e0vXBnPWniTx2zwE7bsU1OG0oLPUT0BSkWgZHcDlnFi4JcN1RFAdEjevUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qg5pLwx/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qg5pLwx/"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46SHkvk2017292;
	Sun, 28 Jul 2024 19:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	uJMa4a8RqrURJNqhWuGgrP2eB0h76knUr+djeRpTWgw=; b=qg5pLwx/8Pz/okyc
	tcVRYztRiBvww7LcfBBOdrXwaIlHVBKqdbLtWO/wrirh9esHFU5U2hF/sKq42cO8
	2+J8e9Y8vMK3BT2Y/ng1zVxxXgEOhLSBFgminkqoP3954mVQlRuSyQKeJ/RJTaVy
	jUUbGnSSpcfxVOp/RAVxGNfoT821ATXIy6u3x/Yg1u1HcbkW0aId6sVOyWuzejCn
	XaEAsj8DRKOBlHyStJFm05oFrsCiCSIHlEYBAS2Deb6BMdh1zhMnhBJTmSbUPJXV
	rKjAYTPUEfZR2miN0t/8PVUV2xoqBMIqsaThpvoILisNUh2UQf2+HdW/sW8nPLNQ
	dOkS5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mputb612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jul 2024 19:58:15 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46SJwFnS029293;
	Sun, 28 Jul 2024 19:58:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40mputb611-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jul 2024 19:58:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46SI0Mb1003773;
	Sun, 28 Jul 2024 19:58:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndem2yw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Jul 2024 19:58:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46SJw8eD50594208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jul 2024 19:58:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC52120043;
	Sun, 28 Jul 2024 19:58:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7354620040;
	Sun, 28 Jul 2024 19:58:06 +0000 (GMT)
Received: from [9.124.220.48] (unknown [9.124.220.48])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 28 Jul 2024 19:58:06 +0000 (GMT)
Message-ID: <b2980e78-0fde-4e99-927e-8127ac167b03@linux.ibm.com>
Date: Mon, 29 Jul 2024 01:28:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/7] tools/lib/subcmd: Don't free the usage string
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
References: <20240718085957.550858-1-adityag@linux.ibm.com>
 <20240718085957.550858-2-adityag@linux.ibm.com> <ZqOxSubGZ6O4K6Gz@x1>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <ZqOxSubGZ6O4K6Gz@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s-_hX5-IzeKZOuvUbGNEHjlRt_93JNfn
X-Proofpoint-GUID: cP4TVQoKHYbCnw2H1ew-RCND1H0oa5AP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-28_14,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407280141

Hi Arnaldo,

On 26/07/24 19:53, Arnaldo Carvalho de Melo wrote:
> On Thu, Jul 18, 2024 at 02:29:51PM +0530, Aditya Gupta wrote:
>> Currently, commands which depend on 'parse_options_subcommand()' don't
>> show the usage string, and instead show '(null)'
>>
>>      $ ./perf sched
>> 	Usage: (null)
>>
>>      -D, --dump-raw-trace  dump raw trace in ASCII
>>      -f, --force           don't complain, do it
>>      -i, --input <file>    input file name
>>      -v, --verbose         be more verbose (show symbol address, etc)
>>
>> 'parse_options_subcommand()' is generally expected to initialise the usage
>> string, with information in the passed 'subcommands[]' array
>>
>> This behaviour was changed in:
>>
>>      commit 230a7a71f9221 ("libsubcmd: Fix parse-options memory leak")
>>
>> Where the generated usage string is deallocated, and usage[0] string is
>> reassigned as NULL.
>>
>> As discussed in [1], free the allocated usage string in the main function
>> itself, and don't reset usage string to NULL in parse_options_subcommand
>>
>> With this change, the behaviour is restored.
>>
>>      $ ./perf sched
>>          Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}
>>
>>             -D, --dump-raw-trace  dump raw trace in ASCII
>>             -f, --force           don't complain, do it
>>             -i, --input <file>    input file name
>>             -v, --verbose         be more verbose (show symbol address, etc)
>>
>> [1]: https://lore.kernel.org/linux-perf-users/htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e/
>>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: Kajol Jain <kjain@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Suggested-by: Namhyung Kim <namhyung@kernel.org>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>>
>> ---
>> Note:
>> This patch is independent of the series.
>>
>> But I kept it along with the series, since the rest of the patches should
>> be applied only after this patch is applied (else the 'free' in
>> builtin-check.c will crash)
>> ---
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
> Can we instead add a parse_options_exit(const char *usagestr[]) that
> does the free?
>
> So that we don't expose these internal details of libsubcmd and if
> something else needs to be done at exit time, thenm that is the place to
> add.

Sure that would be better, but might require a flag somewhere, to know 
that `usagestr` was allocated by 'parse_options_subcommand', and not 
statically present. (so that we don't run free on a statically allocated 
string).

Currently i don't see where we can keep such thing in subcmd, will try 
to see how I can know this, or maybe some magic inside 
'parse_options_exit' to check if string is NOT NULL, AND, dynamically 
allocated, then only we free it ?


Thanks,

Aditya Gupta

> Thanks,
>
> - Arnaldo
>    
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
