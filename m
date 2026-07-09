Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CE3AA504;
	Thu,  9 Jul 2026 05:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575781; cv=none; b=rmk1lyLZEMSL7kKUcVDCpZOavKn0/UalCX3ikkpgLdluWqwgov2g8TYT0gEFjjIR6dsb3Gz75VHee3/rsSYsRmx5qdcGd1XWOMnzLBuh10rQWldmv4ZHoQP5c9VG/CILnFee0S5nh1+VDFggmUlF8rvK4uZU8eFSBNoB12uzikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575781; c=relaxed/simple;
	bh=3Uopv+tVCeATd6/BKuuE5qebJJGmEfIDToYSDMLInVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vz+XoBE0+MHpdBgL7QOCghgFzHARIR25drNEkMbYQXhorqyNxp8LK5uDg7GXlfE/LCkC/YJWSULWUoQuKoPkmJScdfBHGpOy5OkbNnunkGTnqjG1l9C7FZJHcxnpe8zqF55rwPIN1YOVM3mEKsw2yX39q51OZImCMqgNreKQ6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bYEJazC6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bYEJazC6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668NITok280245;
	Thu, 9 Jul 2026 05:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cSLhvu
	bCqnGpsYuPPunrvlMPR4jeX3vHMs2feKu4i/0=; b=bYEJazC6ESP2EYsEQn8AyS
	Q1iMK4MCMi+tB2r2ujO3AYm+5A9TR8BsIR0nowWF1toOvw9uqyS3V+GRXJT23dza
	FBQyrze94bJrxiG/PF+/N3InaM10JBHvjKcBcijUEzGp7cmF+TMjn+5aJqy0Fv7S
	6Aztz5JobBV0+RY8X/2qGgSmc4zuv0G/zsfoFms8ru6M+jjiwDnCChvdRBNhk4Uh
	Vo3pPWI3Qlc0B9G/44IbFQwovM9aTISOSEtkFTBfQQjO7PfzFPXeLrysNJ/Pl8eq
	mXKvwWU+b5VabhzQwvaJBzV2vtwKdQP7G3yd8bCp0ySlF4O+q12uCBWCC0ggtkWQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw5070a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:42:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6695YhTk009558;
	Thu, 9 Jul 2026 05:42:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwbwrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 05:42:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6695gXr248628062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 05:42:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B54B2004B;
	Thu,  9 Jul 2026 05:42:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 608A720040;
	Thu,  9 Jul 2026 05:42:33 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 05:42:33 +0000 (GMT)
Message-ID: <5be22030-53df-4ed6-ae87-f2ad8dc1daab@linux.ibm.com>
Date: Thu, 9 Jul 2026 07:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf tests: Restore -p flag to lock contention test
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark
 <james.clark@linaro.org>,
        Jan Polensky <japo@linux.ibm.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260708175311.858850-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260708175311.858850-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: iUsUI5aPqLRZjLBQO8nuHLx2-ckYdOc9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA0NyBTYWx0ZWRfX0AvpfTbJwEsM
 Ym/KCreAyfmZQKzcJKQOlP13I4wY0QG3XpRnzn0Efh0jaT0eOQRZRwyZ1bts2cfGNuH8LTcnwDJ
 w4X0GBivw+U3e0f147REDNvIIfES3NA5W4y8vs4Nm5Jgus69fi7TpIMNJjhKMVlpx+8eu7kQ5QR
 64wK2zlGEfo+NGRwEvWzUTPff9xFSA5GtdDMRAR1KyCQ7RHn6L2CB970fDhIltzazcLal0sYz+L
 e5OwpVOYRo9iIhAAZpWjT0BhrUuadtXag1RwiCqmYxwZHNABfiLwOWtTMYFRpU4nIEXVM2TmrX8
 AzqYal9D2/PzRn7TmYNx558NMq2NsdtMWwxgw4w6z1sLoy9qweYVfdyNSfzxpeLqJxsxWlpcxlE
 BWYZsK2DT0zzPaz3DvmfZhBFFuTk/oQQXWScjs825+2lyv8HPWAY3Yvp4ncTNaLAcqTAc+V5d2J
 PAwMawaarmSpsrICn7Q==
X-Proofpoint-ORIG-GUID: wsGDMsyYZrCHo4ect3PsypKtHK3HzDcg
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4f34cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=zpbS0Xk1SXV1LcOI_EoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA0NyBTYWx0ZWRfXxsgXNtd5FY8J
 wUjRljKfqqbJxTGmJkJ1+rgL466yHmpTGAvUyzJ25Hga47YwKfDIXLqk/NBEsfEJIXpbrc3h1Ny
 KFpqy392i3MQXdiU5OByom5yzP9NKsU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090047

On 7/8/26 19:53, Ian Rogers wrote:
> Commit ae42a2a2a3ae ("perf tests: Speed up lock contention analysis shell test")
> in linux-next heavily optimized the test runtimes by switching the workload from
> the default of 10 process groups down to 1 (`perf bench sched messaging -g 1`).
> 
> However, this change inadvertently dropped the original `-p` flag, causing the
> benchmark to default to `socketpair()` instead of `pipe()`. While `socketpair()`
> still generates some lock events on x86, it fails to trigger enough samples on
> architectures like s390, causing the test suite to fail due to lack of captured
> data.
> 
> Restore the omitted `-p` pipe flag. The test retains the massive speedups
> achieved through the `-g 1` scaling, while producing a massive density of lock
> events across all architectures to fully satisfy the BPF trace filtering logic.
> 
> Fixes: ae42a2a2a3ae ("perf tests: Speed up lock contention analysis shell test")
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3.1-pro
> ---
>  tools/perf/tests/shell/lock_contention.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index ba598370be73..5df9a0cd48a3 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -11,7 +11,8 @@ errout=$(mktemp /tmp/__perf_test.errout.XXXXX)
>  
>  # Workload to generate lock contention.
>  # Using 1 group (-g 1) keeps runtime low while generating sufficient lock events.
> -msg_workload="perf bench sched messaging -g 1"
> +# We include -p (pipes) because socketpairs don't generate enough lock events on s390.
> +msg_workload="perf bench sched messaging -g 1 -p"
>  
>  cleanup() {
>  	rm -f ${perfdata}

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

Thanks a lot

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
