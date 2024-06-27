Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8222EF2
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482765; cv=none; b=PMWfFA/sGhhRbzzGs2pMG6te9qHjE2tgRWB+pb8mXV0QxoWIOLWbItaK8cfC5QsP9EGq/Oh0RYamxa/XWPN15+pLY43lG0F+eZcIyoWhEfMNZbOXOS64/TEwq0pSUurIS6RQ1tKsD9uug2KNj5z7EqC2g9DNpgV3jWygLSRvhdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482765; c=relaxed/simple;
	bh=ey+we+KRohYCwDgZg/go+1QdUYk7Qbc4Dcn+x9CIdFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAlr+zI/j1FdecsB20H4AD+rxBcqLdObSYJ868pnSkk3c9rfVRo+JTWLyMuGLJg1v2bokqn8OgllXmmOYqPQOqrNH0qVoCnPNhSuyQw6TBU0Mx2CAt9CFhKjYLpmaWcjH6g8RPxlCZM+4/OPIvuGmI366jSinWYAYl7kwLPi+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GpqrdgLB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GpqrdgLB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R8utNj025551;
	Thu, 27 Jun 2024 10:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=pp1; bh=/
	Vkit/6GVESIVqHl3+0ia13WmUpK+U29btNzXJbHBBw=; b=GpqrdgLB0bl0X5LGa
	v2yexKSN+ZgPckSKJyC6+QoyBIxrzvy1OBXxf8C/Q278YWd9/5NiCfoL90JrGZ9V
	NxxrZhf3WtNSvj4INarNjaNrU4wpE39lchSxE621U7Y7adEtp7qByIoTIO77a+G8
	2jk0rqCzz85WjO/BL/Dfql+Pe5S1BQ6Mi4/P6L1pr5B/sU0uarsx4GykfK4VtEsa
	188EIMPGN2qI0rtGnLH2xBdh5/6URwMFo5no4Xytip39L/E7y01W1mZb93BkAmc3
	Ouq4tRSJexHbQX4MznfzK/JoDETF+/ckTvtL3V2seeRHWKC6nqwSgxFlH4eXcv8j
	qI4Pg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg8cax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:05:56 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RA5tpj023180;
	Thu, 27 Jun 2024 10:05:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg8cav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:05:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45R7jfp9019591;
	Thu, 27 Jun 2024 10:05:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xqa504-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:05:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RA5m0j52822368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 10:05:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0A92004B;
	Thu, 27 Jun 2024 10:05:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE6762004E;
	Thu, 27 Jun 2024 10:05:45 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.72])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Jun 2024 10:05:45 +0000 (GMT)
Date: Thu, 27 Jun 2024 15:35:41 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v10 0/4] Introduce perf check subcommand
Message-ID: <n2fau4cqfklctsgovn6tvmpxleglgan3l64xumv5wgch4yatby@p7e4na6xzush>
References: <20240626131638.597544-1-adityag@linux.ibm.com>
 <cfe80846-69de-4d19-a4be-10fa27ee057d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe80846-69de-4d19-a4be-10fa27ee057d@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x2WOb3-mHH7QRrbYSqQCwg7GKQKCBqzu
X-Proofpoint-ORIG-GUID: pnIv8UQ8O_TCkERapjcUxotAy8EOjh8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=569 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270074

Hi Thomas,

> <...snip...>
>
> I have a running linux-next kernel on fedora 40.
> I applied your patches onto linux-next head and got these results:
> 
>  # git am ~/gupta1.patch
>  Applying: perf check: introduce check subcommand
>  .git/rebase-apply/patch:110: new blank line at EOF.
>  +
>  warning: 1 line adds whitespace errors.
>  # git am ~/gupta2.patch

Thanks for reporting this, I removed the blank line at EOF.

> 
> The other patches apply cleanly.
> The compile of perf fails with this error:
>  # make
>  ...
>  builtin-check.c: In function ‘cmd_check’:
>  builtin-check.c:167:44: error: passing argument 5 of
>        ‘parse_options_subcommand’ discards ‘const’ qualifier
>        from pointer target type [-Werror=discarded-qualifiers]
>   167 |                         check_subcommands, check_usage, 0);
>       |                                            ^~~~~~~~~~~
>  In file included from builtin-check.c:10:
>  /root/mirror-linux-next/tools/perf/libsubcmd/include/subcmd/
>        parse-options.h:180:45: note: expected ‘const char **’
>        but argument is of type ‘const char * const*’
>   180 |                                 const char *usagestr[], int flags);
>       |                                 ~~~~~~~~~~~~^~~~~~~~~~
>   CC      builtin-timechart.o
>   CC      builtin-sched.o
>  cc1: all warnings being treated as errors
>  make[3]: *** [/root/mirror-linux-next/tools/build/Makefile.build:106: builtin-check.o] Error 1
>  make[3]: *** Waiting for unfinished jobs....
>  make[2]: *** [Makefile.perf:728: perf-in.o] Error 2
>  make[1]: *** [Makefile.perf:265: sub-make] Error 2
>  make: *** [Makefile:70: all] Error 2
>  #
> 
> Hope this helps...

Thanks, fixed in v11. It occured due to me making last minute changes
suggested by checkpatch to prefer 'const * const' instead of 'const *'.
Should have tested it again, will take care in future.

- Aditya Gupta

> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
