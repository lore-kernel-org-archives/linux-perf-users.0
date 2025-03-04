Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4D1F7561;
	Tue,  4 Mar 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073918; cv=none; b=YBDt7tGPgd8vV+AlwpGzPH8zBlWp6O35g7l3j2Qw3L+8frNi8E61/CokZUWQQXDm719zEEQGq2wKGcQAaNgxV5DUIMe40CQtpF7HI4iDdbItTXBunse3XipcCvxaUwpTy9Otxa87KlcQTzmR64HbszkV8S0cOP9Tk0G76xOhBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073918; c=relaxed/simple;
	bh=XFcWAfOdjfHUvZMpjXN8UBajs+n3IF62Q6GYNvZFl+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqfQcnSHMoDo19622IjtdRniXW0VeUzC6S77rmJBnIky/GPdCv5+axq7amVWoim/uQT86Pu8kUJ5+soxDj6zVtOG2kHw8ErMyc8FwY10pvWNYOIHuKnND3N34xWD+ymLYLh3BryXLFgG9ocES3d6h4TLi7cw7X2Meil28OujzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SBVcZOJw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SBVcZOJw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523Ke4cc020517;
	Tue, 4 Mar 2025 07:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vjTFF5
	8thWXv9CPpTVynWVvptQKkmV91uZV11PxveTM=; b=SBVcZOJwii5/DQXo0f+nHu
	OOuo84P6gxM/FJgAVs/R99pOBHtCPseQz4r0U7NscQND35uhhfZ1B9IpV5METI2N
	qixzELcCb14t2F/CygYQlJIowiU3+1LwRu5oTqJc1Pjph4lY7uZAmAhxOd5dnbRj
	16nBXENWIQI34KieS1OZTBVqqIn4fbL9FgSkqKl4ZaOpAYhnBlgSqVcIo9NXeKFE
	fVOedgeacXFiICdDc7Ub3GIDQCrcYTegCauL02R4num3CfsXXbw7uTN1/BXTPx/U
	gukenuyBQ35fAh4js7bDvxrCibdgfR+SuiJ75NX4uhbgqPZ6GQ9U+OT3865JOD+g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyjdnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:38:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5247RsTo003863;
	Tue, 4 Mar 2025 07:38:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyjdn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:38:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5243uJt6020871;
	Tue, 4 Mar 2025 07:38:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnc8gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 07:38:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5247cHxN49480042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 07:38:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205852004B;
	Tue,  4 Mar 2025 07:38:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B741020043;
	Tue,  4 Mar 2025 07:38:16 +0000 (GMT)
Received: from [9.152.212.236] (unknown [9.152.212.236])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 07:38:16 +0000 (GMT)
Message-ID: <aa2aad75-a8db-4cc5-a33c-f004d8f1df4a@linux.ibm.com>
Date: Tue, 4 Mar 2025 08:38:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] perf test: Simplify data symbol test
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@arm.com>
References: <20250304022837.1877845-1-namhyung@kernel.org>
 <20250304022837.1877845-7-namhyung@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250304022837.1877845-7-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: luUNLpdwlFRuykUWAoFiwHox-Lg7VStg
X-Proofpoint-GUID: suFCkDAdyhdl3vvlaKZcXkYYWEJALY6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040062

On 3/4/25 03:28, Namhyung Kim wrote:
> Now the workload will end after 1 second.  Just run it with perf instead
> of waiting for the background process.
> 
> Cc: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/test_data_symbol.sh | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
> index c86da02350596b35..1792b7ad4066f8cd 100755
> --- a/tools/perf/tests/shell/test_data_symbol.sh
> +++ b/tools/perf/tests/shell/test_data_symbol.sh
> @@ -5,8 +5,6 @@
>  # Leo Yan <leo.yan@linaro.org>, 2022
>  
>  shelldir=$(dirname "$0")
> -# shellcheck source=lib/waiting.sh
> -. "${shelldir}"/lib/waiting.sh
>  
>  # shellcheck source=lib/perf_has_symbol.sh
>  . "${shelldir}"/lib/perf_has_symbol.sh
> @@ -60,19 +58,10 @@ echo "Recording workload..."
>  # specific CPU and test in per-CPU mode.
>  is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
>  if (($is_amd >= 1)); then
> -	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}" &
> +	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}"
>  else
> -	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}" &
> +	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}"
>  fi
>  
> -PERFPID=$!
> -
> -wait_for_perf_to_start ${PERFPID} "${ERR_FILE}"
> -
> -sleep 1
> -
> -kill $PERFPID
> -wait $PERFPID
> -
>  check_result
>  exit $?

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
