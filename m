Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DE2E419
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293659; cv=none; b=tPrnY3aVmMrhwT+5Yz0703rTmvC71eIKwPSFLD7eH7fKvwsKnKt8aiHi5lBYeR/N3InZES9iiPfIDeWEz41B9e7dWFZiONyRCPnZn23jeoH0SqeK33qjgsgdjif2FBe9znkxUGIK+lzs89m1KIBJ7VrpSh5iu5O7uTU1mwxpNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293659; c=relaxed/simple;
	bh=+c7h/+iquMWCxm58a7X+jSR1ycCqSkjdwrcBhdtYEr8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fDZfTtThICtUOQlfya/LM6g/VcUxaPdc0HnzBIkURY+NIoLavT1TLny9cQE0/yPXFbdvnOMMKZbuMjKHyRBZicalEknTZxcs6Wfjxv1C4scamLXi41F5izxXJWAoN+vbBAE9/Fkvh9fGYis1VfCmyxurx+WR96pLDpJ62gSVG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hL9/Cvl3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hL9/Cvl3"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8RCY7016912;
	Thu, 18 Jul 2024 09:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:from:to:cc:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	6cnorPFh70GggGUMZm4oWHSiH3E2S1dPmKQ58ng464U=; b=hL9/Cvl3x42Q/4jM
	IQUtIbX3Lcau7xzuBjKX0GDocdU1ppMzk/LZ6o5P9hjcqQ5wXMrjAUJjEmDCPcL0
	gIww5U/A6UeeNDF2VC9j7Bp51j3tQFJEdmEau8YnV4FGeR/WDRnI8ij7dL+ig2tl
	8XLAqHQigDhoyXS+6Zxyu8NQhu20+nSy+DKjp5rWFD5BHLBLOdiqsFYurDmrTRkL
	eBXU2aBAQKqQtXGxQ0JKeZiDOZ1189SRjGEOZmndv1bkFRE0kcy40gr5p9BDAvSo
	ROFvLkjEnZI7Mv7vVI1EQ/GcAUGBj6xnl/6rZKiZ2PUesOj726qC3xDyUtDtXJHy
	jKTOyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40esutrwv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:07:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I94UR9006109;
	Thu, 18 Jul 2024 09:07:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmgufd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:07:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I97U8s55116124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:07:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D2BD2005A;
	Thu, 18 Jul 2024 09:07:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 845CB20043;
	Thu, 18 Jul 2024 09:07:29 +0000 (GMT)
Received: from [9.109.199.72] (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:07:29 +0000 (GMT)
Message-ID: <5557e311-92b2-48c5-b5c3-cf89980a5973@linux.ibm.com>
Date: Thu, 18 Jul 2024 14:37:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/7] tools/lib/subcmd: Don't free the usage string
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org
References: <20240718085957.550858-1-adityag@linux.ibm.com>
 <20240718085957.550858-2-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240718085957.550858-2-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yzsnNTHlDY8yX_VcCx9Btm9sz756cRyK
X-Proofpoint-GUID: yzsnNTHlDY8yX_VcCx9Btm9sz756cRyK
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
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180056

Hello,

This patch is independent of the series. I had also sent this patch as a standalone single patch yesterday.

But I kept it along with the series only since, the rest of the patches should
be applied only after this patch is applied (else the 'free' in
builtin-check.c will crash)


Thanks,
Aditya Gupta

On 18/07/24 14:29, Aditya Gupta wrote:
> Currently, commands which depend on 'parse_options_subcommand()' don't
> show the usage string, and instead show '(null)'
>
>      $ ./perf sched
> 	Usage: (null)
>
>      -D, --dump-raw-trace  dump raw trace in ASCII
>      -f, --force           don't complain, do it
>      -i, --input <file>    input file name
>      -v, --verbose         be more verbose (show symbol address, etc)
>
> 'parse_options_subcommand()' is generally expected to initialise the usage
> string, with information in the passed 'subcommands[]' array
>
> This behaviour was changed in:
>
>      commit 230a7a71f9221 ("libsubcmd: Fix parse-options memory leak")
>
> Where the generated usage string is deallocated, and usage[0] string is
> reassigned as NULL.
>
> As discussed in [1], free the allocated usage string in the main function
> itself, and don't reset usage string to NULL in parse_options_subcommand
>
> With this change, the behaviour is restored.
>
>      $ ./perf sched
>          Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}
>
>             -D, --dump-raw-trace  dump raw trace in ASCII
>             -f, --force           don't complain, do it
>             -i, --input <file>    input file name
>             -v, --verbose         be more verbose (show symbol address, etc)
>
> [1]: https://lore.kernel.org/linux-perf-users/htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e/
>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>
> ---
> Note:
> This patch is independent of the series.
>
> But I kept it along with the series, since the rest of the patches should
> be applied only after this patch is applied (else the 'free' in
> builtin-check.c will crash)
> ---
> ---
>   tools/lib/subcmd/parse-options.c | 8 +++-----
>   tools/perf/builtin-kmem.c        | 2 ++
>   tools/perf/builtin-kvm.c         | 3 +++
>   tools/perf/builtin-kwork.c       | 3 +++
>   tools/perf/builtin-lock.c        | 3 +++
>   tools/perf/builtin-mem.c         | 3 +++
>   tools/perf/builtin-sched.c       | 3 +++
>   7 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
> index 4b60ec03b0bb..eb896d30545b 100644
> --- a/tools/lib/subcmd/parse-options.c
> +++ b/tools/lib/subcmd/parse-options.c
> @@ -633,10 +633,11 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>   			const char *const subcommands[], const char *usagestr[], int flags)
>   {
>   	struct parse_opt_ctx_t ctx;
> -	char *buf = NULL;
>   
>   	/* build usage string if it's not provided */
>   	if (subcommands && !usagestr[0]) {
> +		char *buf = NULL;
> +
>   		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
>   
>   		for (int i = 0; subcommands[i]; i++) {
> @@ -678,10 +679,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
>   			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
>   		usage_with_options(usagestr, options);
>   	}
> -	if (buf) {
> -		usagestr[0] = NULL;
> -		free(buf);
> -	}
> +
>   	return parse_options_end(&ctx);
>   }
>   
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 6fd95be5032b..6b88b8b40784 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -2058,6 +2058,8 @@ int cmd_kmem(int argc, const char **argv)
>   
>   out_delete:
>   	perf_session__delete(session);
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kmem_usage[0]);
>   
>   	return ret;
>   }
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 71165036e4ca..988bef73bd09 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2187,5 +2187,8 @@ int cmd_kvm(int argc, const char **argv)
>   	else
>   		usage_with_options(kvm_usage, kvm_options);
>   
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kvm_usage[0]);
> +
>   	return 0;
>   }
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 56e3f3a5e03a..fd53838b5a78 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -2520,5 +2520,8 @@ int cmd_kwork(int argc, const char **argv)
>   	} else
>   		usage_with_options(kwork_usage, kwork_options);
>   
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)kwork_usage[0]);
> +
>   	return 0;
>   }
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 0253184b3b58..b25d50716e63 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -2713,6 +2713,9 @@ int cmd_lock(int argc, const char **argv)
>   		usage_with_options(lock_usage, lock_options);
>   	}
>   
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)lock_usage[0]);
> +
>   	zfree(&lockhash_table);
>   	return rc;
>   }
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 863fcd735dae..b7c1cf6d0e5a 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -517,5 +517,8 @@ int cmd_mem(int argc, const char **argv)
>   	else
>   		usage_with_options(mem_usage, mem_options);
>   
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)mem_usage[0]);
> +
>   	return 0;
>   }
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 8750b5f2d49b..d6acc53ae89e 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -3805,5 +3805,8 @@ int cmd_sched(int argc, const char **argv)
>   		usage_with_options(sched_usage, sched_options);
>   	}
>   
> +	/* free usage string allocated by parse_options_subcommand */
> +	free((void *)sched_usage[0]);
> +
>   	return 0;
>   }
