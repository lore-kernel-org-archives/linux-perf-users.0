Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5D849C;
	Mon, 30 Jun 2025 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269975; cv=none; b=MoJLFKkvzSNGWBRDxfeCbI/JrIr2VSwS6E7Qh15FKiVuckDeotNnaJM3k01/Sng5bA+HagPG3Z2QoxMJSvjroL5N1RHwP9ON5pRZcyN9hVYyaA8RgHAV+Gp4/+vpabL7roM70vmyT/YH/M0rmgHCbEnMTV9txbWTf8QeCaam/yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269975; c=relaxed/simple;
	bh=DSsJ6kjTNeq8qXIdq818j+xseGZxh3dhzRyitg5Q7dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZR2v3BV1YbD0Y6dXRb2A9fG0uZmrn6hkMjafcwc8KLWE/h+XMQakswkuKaYj7/5L6rFtPIZgnR+hMmH+cjWjBRSuIQ9+2ST1YhvZI+XretTyWCawdL5GghMYMXMzUWF9qVAnUJpHdwhyHDyJd0F7FRcwyFDi2GTJkhAPars/eV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sytREZYN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sytREZYN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TKccQs027955;
	Mon, 30 Jun 2025 07:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AbRQ9o
	Z33wngkp6Ayc/JxaLhfE3vapA+reHwN0evvAA=; b=sytREZYNe8uQAF0uUpFI+y
	7iyVsVZS9mBOGs+aUzAoyA7mt9CWu8RCf+HKX+SUDLkolMaUhDNRN77IOki8Hum+
	aBAxRHBYGIS2SOhMuEQVmZ3kkzhbHGpEnAHHYyvgHP5v5mJlxcwWsHpNLI7/Sv5o
	AFe33o2tkbpUEutVkDt4LKqsSxbDP1zgLcu9NE392vihZWZFaDc9EWdqmba+VydN
	5jTEVOwAGxYiulNrFpNTHRulciSqfGa6qxjOf0lWymjL71uK4ymvFwQlPDubbU2s
	/XeFyNOTaUQ0M3TZMzbuvy79yeCaNBSIFkLBefFJlRUwMKgrotHwdRPZUj9GWsuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84cyy8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:52:40 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55U7qes5002574;
	Mon, 30 Jun 2025 07:52:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84cyy8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:52:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4jAkO032157;
	Mon, 30 Jun 2025 07:52:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40d19h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 07:52:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U7qbWk21496106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 07:52:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F234F202DB;
	Mon, 30 Jun 2025 07:52:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63EF7202DC;
	Mon, 30 Jun 2025 07:52:21 +0000 (GMT)
Received: from [9.87.132.218] (unknown [9.87.132.218])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 07:52:21 +0000 (GMT)
Message-ID: <00441b6d-176f-4dd4-862d-08d414dfec66@linux.ibm.com>
Date: Mon, 30 Jun 2025 09:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf test annotate: Use --percent-limit rather than
 head to reduce output
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250628015832.1271229-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20250628015832.1271229-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pBUK_H8ywgp5vhGRDmEsxo0ll-TqV_zr
X-Proofpoint-GUID: 1ZrrW4K4W3pO9wyR0xsOcj8M_aSfrQR0
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=68624248 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=bj4Rs4kvGp4denB0YwQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2NCBTYWx0ZWRfXzNV5IyANDPRZ Wjc1jzRb2O8idCoJyV+grDH7+juTjNQq7Jg+QEiE6LFvchgSiqwH0K1GrRSq5TS60jiNdzCcUcK /ppwFxdQtO5x6wLvcyDHWZH/rksDYCdKDGQPLVNwLv6a5pK4LGad348fcYVFo7SbkEPMA0oiCau
 xkgLU7THf7jseGzQJfaMinjiRrDYa0fCrTKjwrMEj/jvR0Gm4hempTGY4qJDXjA5euqpflQ6Ki4 M0R0A8j+tiIhq268AEPzxmDEBMULFVyvDo7r9eF1U1tmaOrJj9FRqZCWYWsRL7ASYNw8mHym/7j /K2lANWlH6i62KDqOcWrekdxxgfMcmoqkpraTlC8YeYAMPO8p6UqwZdks9sJPWiZk/QKEUMyQTW
 pEn9JONE9ipBRS3MG1mnjUBkxWSPaXvZnnKxeavq2yhXkzHeDZdx4u1R3WZkYBSy1JRsvRGq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300064

On 6/28/25 03:58, Ian Rogers wrote:
> The annotate test was sped up by Thomas Richter
> <tmricht@linux.ibm.com> in commit
> 658a8805cb60 ("perf test: Speed up test case 70 annotate basic tests")
> by reducing the annotate output using head. This causes flakes on
> hybrid machines where the first event dumped may not have the samples
> for the test within it. Rather than reduce the output using `head`
> switch to `--percent-limit 10` which will stop annotate dumping
> functions that have an overhead of less than 10%, the noploop program
> should be using more.
> 
> Add the missing objdump option for the pipe mode version of the
> objdump with a command test.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/annotate.sh | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
> index 16a1ccd06089..689de58e9238 100755
> --- a/tools/perf/tests/shell/annotate.sh
> +++ b/tools/perf/tests/shell/annotate.sh
> @@ -53,21 +53,22 @@ test_basic() {
>    # Generate the annotated output file
>    if [ "x${mode}" == "xBasic" ]
>    then
> -    perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
> +    perf annotate --no-demangle -i "${perfdata}" --stdio --percent-limit 10 2> /dev/null > "${perfout}"
>    else
> -    perf annotate --no-demangle -i - --stdio 2> /dev/null < "${perfdata}" > "${perfout}"
> +    perf annotate --no-demangle -i - --stdio 2> /dev/null --percent-limit 10 < "${perfdata}" > "${perfout}"
>    fi
>  
>    # check if it has the target symbol
> -  if ! head -250 "${perfout}" | grep -q "${testsym}"
> +  if ! grep -q "${testsym}" "${perfout}"
>    then
>      echo "${mode} annotate [Failed: missing target symbol]"
> +    cat "${perfout}"
>      err=1
>      return
>    fi
>  
>    # check if it has the disassembly lines
> -  if ! head -250 "${perfout}" | grep -q "${disasm_regex}"
> +  if ! grep -q "${disasm_regex}" "${perfout}"
>    then
>      echo "${mode} annotate [Failed: missing disasm output from default disassembler]"
>      err=1
> @@ -92,11 +93,11 @@ test_basic() {
>    # check one more with external objdump tool (forced by --objdump option)
>    if [ "x${mode}" == "xBasic" ]
>    then
> -    perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null > "${perfout}"
> +    perf annotate --no-demangle -i "${perfdata}" --percent-limit 10 --objdump=objdump 2> /dev/null > "${perfout}"
>    else
> -    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
> +    perf annotate --no-demangle -i - "${testsym}" --percent-limit 10 --objdump=objdump 2> /dev/null < "${perfdata}" > "${perfout}"
>    fi
> -  if ! head -250 "${perfout}" | grep -q -m 3 "${disasm_regex}"
> +  if ! grep -q -m 3 "${disasm_regex}" "${perfout}"
>    then
>      echo "${mode} annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
>      err=1
Works ok on s390

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
