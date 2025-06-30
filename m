Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72619243364;
	Mon, 30 Jun 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270527; cv=none; b=dEEvLgaA3gmFf03KhmBqagDzjJWuSCk7KZGNnT6eJb4nLMcH7KQaGOy26mwUDT2frd8rmpMtiR7op2v6c2vsMlEPnke/5EDlSzB9xmUXQ8tgGRIj2LptAVU3YXtR5LFnofUitzgqLDoGnw4wh9tW49Msg9DVSeon/itwR0KdgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270527; c=relaxed/simple;
	bh=Hk4PWTSFyJ5ZH9OUolCbF/0vk1uY9caPI/PFr4sGiCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=huGfOUv0b0aXXf5Pg4agLKZopQFNHfRN6cjaEN4+0QiLvI2ZonPzwrmXuspewct7rSHXlOjHrebsyvvvzUP9jeUl5ArvqoYy43c1uTOU3EAe2uAjUh8MKLGjlLBhGWlzdhVuxjvhCIzf6xhjdjcr/APmiNaWwb0ISFpqBWcoBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DEX3d4oQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DEX3d4oQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TEOuIC016422;
	Mon, 30 Jun 2025 08:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cEmo5W
	Z9ENLCamzEsFC9RFxbGStIkBwOEpEwhYpQ33I=; b=DEX3d4oQpQEAilMMfEmIJv
	InLzDjJJHvLde3IzFtfYYdmPlp2sM9Uec9yArw6abhGgBy204jeZAkrBIcaaxdU+
	BRM2Cnx1K/HhNJVFZHlJfvl0K7fWrXekNGmJlmem0GN0ozNWkMpABSkBxhfNI7ph
	aJmE0aZ/ZNW2EXXcSzmLO3CLGi6Xo7s+JXyrPIkteoIDYuAT3mk3m1BSgxTLQRVB
	Ee+2xL5n/4BPzWf3AoKaqGOW7IWiZQjV2LHGWcGpzyMVvqpJt4ZP09gOAlui533x
	tCg20DquAkCVK69Qcl7gJ09xAhZ9fnQNyYKp7RKXuIAllBVGApUos+ZMNgazG98g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt0c02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:01:52 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U81eSK017679;
	Mon, 30 Jun 2025 08:01:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5tt0byd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:01:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4LgLo021095;
	Mon, 30 Jun 2025 08:01:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jtqu543x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:01:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U81h8p50725166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 08:01:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C0A200E4;
	Mon, 30 Jun 2025 08:01:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75425200E3;
	Mon, 30 Jun 2025 08:01:42 +0000 (GMT)
Received: from [9.87.132.218] (unknown [9.87.132.218])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 08:01:42 +0000 (GMT)
Message-ID: <898927c3-e85f-4a9a-9374-6fdb49236410@linux.ibm.com>
Date: Mon, 30 Jun 2025 10:01:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Add basic callgraph test to record testing
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250628015553.1270748-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250628015553.1270748-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E8tYNO6g_34gN2s0vfMicyge2h8fBXHu
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=68624470 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=1XWaLZrsAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=_uuWfKpNdYwReMWUY6YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 1lqPsw7z0D82yPPHre2bR6sY2ryHaFln
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2NCBTYWx0ZWRfX0CMrc+Zc4oO/ UVjarByEad7x9bfMSnGvHJzGGWrqVXRscIMRZ9DtBRakHKStShUelys8xS7FxejVH4zj5kfSarD e2PvFZ7+GRS5MZysZrUv/Bvsz7kpYDOVzG0lhpZRv38OYJYaOZ2xBaV7ZlH+p6IpxLD/vd56j04
 bXzConnOxZnnmAItsh7jf6eORtIKhoDAq1/KO8vjhT7kCmsrZ/WEHKqItB8FPEZYQG61hCq1LO9 vATDb0ehZ8Pe/uV4fDdHJ/rUoeuJ1OdMeT8YfMOj9Y+ULoAmwpg/RYQt41BHWWFEarq0lpib4b1 JJYqPde3JOForm9f8l3yrbjR2DG1QmlXDT8GIxH+Ge/usXtiBRF7o6IdYJP6mf7Aw0nyFgNsC+B
 GGDiQ2KM1416jBogCpgh4YPIxUHigTAdPokR5KA5KvsCFjoRpEvwBc8beh/OykqLoBkjfnqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300064

On 6/28/25 03:55, Ian Rogers wrote:
> Give some basic perf record callgraph coverage.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> v2: Pick up s390's needed "--call-graph dwarf" as spotted by James
>     Clark <james.clark@linaro.org>.
> ---
>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 2022a4f739be..b1ad24fb3b33 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
>  . "${shelldir}"/lib/perf_has_symbol.sh
>  
>  testsym="test_loop"
> +testsym2="brstack"
>  
>  skip_test_missing_symbol ${testsym}
> +skip_test_missing_symbol ${testsym2}
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> @@ -359,6 +361,33 @@ test_precise_max() {
>    fi
>  }
>  
> +test_callgraph() {
> +  echo "Callgraph test"
> +
> +  case $(uname -m)
> +  in s390x)
> +       cmd_flags="--call-graph dwarf -e cpu-clock";;
> +     *)
> +       cmd_flags="-g";;
> +  esac
> +
> +  if ! perf record -o "${perfdata}" $cmd_flags perf test -w brstack
> +  then
> +    echo "Callgraph test [Failed missing output]"
> +    err=1
> +    return
> +  fi
> +
> +  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
> +  then
> +    echo "Callgraph test [Failed missing symbol]"
> +    err=1
> +    return
> +  fi
> +
> +  echo "Callgraph test [Success]"
> +}
> +
>  # raise the limit of file descriptors to minimum
>  if [[ $default_fd_limit -lt $min_fd_limit ]]; then
>         ulimit -Sn $min_fd_limit
> @@ -374,6 +403,7 @@ test_uid
>  test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
> +test_callgraph
>  
>  # restore the default value
>  ulimit -Sn $default_fd_limit

Works ok for s390

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
