Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C93AC0E7;
	Mon, 13 Apr 2026 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082291; cv=none; b=DQftUD8U2ud6dn2jqxwN9MzRWbrI6qGwMGsLodRux8YQAZZGvjEmbCk8MRjzvxoDKmyZiwFIetUJcbE9H0OR/2TxE7OVVcv09r6R+V+nDbiQoTAAxXeCF5T0mN0uvBAm8NmKX53Ew2OZNxBEd3EXz4RC0xbe0q7TOuqpXJmft90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082291; c=relaxed/simple;
	bh=517VPRG7aw3dmA1uKR9WLJS6DEZvtohUtLUHNROLfIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbAs8VGezaPUl3u058iyqRMJ7JCoXx0fsDR0rbftqXg3BaLvvrxW7pexnQ0g0DDvLY6mIog/I8Batf7NPi7AjcvY0qDiR1zJH0gZJ2ZK/NBP8dA+g7fmHfu7DTTOUM/3SIZtgM4GpVBhB1AUprzDHYwzgzOAMhsFcmj3ALcrgsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EJ5jiQbs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EJ5jiQbs"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CMR47J3148927;
	Mon, 13 Apr 2026 12:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UTE+9K
	GQFcyPa34Yl9VtlBYC6gEZ3K4CiZBJDOmCm7I=; b=EJ5jiQbstJ5GSMMf6D/XGi
	XTzCFfxxWR7ybwIc0Fa5sdAN1OXTr43+tPkRS1gctPTEOcfA5/8nYKt1XyUhluVm
	t3MPfDIVf9h45z71wrT/ix7Fjmf0PS9NXe79vJYbb9F2MFm4GDIvWHrBJwEzYN+6
	LHdhWfGuVgUppYGJNkhszK2IAT+zVYeQyCHh6Q9a9L9f/HzJfT0Q8ChhMkl5Z+Tb
	rgEEExWXn1npfibzvtaha22Lr0tFuS0jeDPkc/T6Dyfa/3qObqz7YRtSyKg3gdj/
	zeS+g2ivhbF5VtYaIkQt0vTww2qgFA6bDP0sFW87jKHy8uUnMK7Wd1+cm6FZh2Mw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqey810-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 12:11:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D8sSkG003594;
	Mon, 13 Apr 2026 12:11:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn51ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 12:11:09 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DCB71348890310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 12:11:07 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6199320043;
	Mon, 13 Apr 2026 12:11:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F6520040;
	Mon, 13 Apr 2026 12:11:06 +0000 (GMT)
Received: from [9.111.18.90] (unknown [9.111.18.90])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 12:11:06 +0000 (GMT)
Message-ID: <8d5998ef-8535-4a5a-925a-9140b9756388@linux.ibm.com>
Date: Mon, 13 Apr 2026 14:11:06 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf test: Fix inet_pton probe failure and unroll call
 graph
To: Ian Rogers <irogers@google.com>, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        collin.funk1@gmail.com, ctshao@google.com, james.clark@linaro.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
References: <20260410002351.10856-1-irogers@google.com>
 <20260411193705.735269-1-irogers@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260411193705.735269-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDExNiBTYWx0ZWRfX5/0B1h5bjptF
 YnBitwE9eaGmJWY5iwTfcDVvS7sjGS00RO9LtIVwn+vDrYojB4WCEG90EFVjyJcySYcUyg365hq
 pDpHDRONYCuaTQHkgqptdoYu9yxP7z0DWyWCsaoXhgKSHuqmYHhMxmYRUKBG6xeJ7Tka1y1GF0Z
 Vu/OWspaR6kG4DZdFymlsOpu+6kKESVVXEX23V+pN8A251jgkptnCbgZppgxPH+N6djzsETuqip
 iYO2jb4wxANCiaxnSAslJFG9DTKdB+P/VU6UggIc0RoIeCEszAg84yCpGjwKsiZ/wgOtJFAt353
 DJen1lrpOKlCAM9Ock3wV4zxd0GPfihziC1htzzPAUXz6gXIP0cLFHotuyN4lxkTDunbKqQC4y8
 6SJltvD1hU5r5wbGCjAiIgjDbtsrr22WQJR+x768h/CUkU/OFCtyDyFJ2hx0/oRdCHjhIIvDZwE
 QBE1h9EBmXI3snHEAxg==
X-Proofpoint-GUID: 4v14CwenNrfYMcSiA3NoWJK-8axRvoCo
X-Proofpoint-ORIG-GUID: 1ab9R0WtfnHt6J_wshvly2WKt3j-r7GU
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dcdd5e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=JwUqCGEUP4hQJmkAhWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130116

On 4/11/26 21:37, Ian Rogers wrote:
> When adding a probe for libc's inet_pton, perf probe may create multiple
> probe points (e.g., due to inlining or multiple symbol resolutions),
> resulting in multiple identical event names being output (e.g.,
> `probe_libc:inet_pton_1`).
> 
> The script previously used a brittle pipeline (`tail -n +2 | head -n -5`)
> and an awk script to extract the event name. When multiple probes were
> added, awk would output the event name multiple times, which expanded
> to multiple words in bash. This broke the subsequent `perf record` and
> `perf probe -d` commands, causing the test to fail with:
> `Error: another command except --add is set.`
> 
> Fix this by removing the brittle `tail/head` commands and appending
> `| head -n 1` to the awk extraction. This ensures that only a single,
> unique event name is captured, regardless of how many probe points
> are created.
> 
> Additionally, the test artificially limited the backtrace size via
> `max-stack=4` and did not specify dwarf call graphs for non-s390x
> architectures. In newer libc versions where `inet_pton` is nested
> deeper or compiled without frame pointers, `perf script` failed to resolve
> the backtrace up to `/bin/ping`. Fix this by explicitly collecting
> dwarf call-graphs for all architectures and increasing `max-stack` to 8.
> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> index ab99bef556bf..eca629ee83f0 100755
> --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> @@ -22,9 +22,9 @@ event_pattern='probe_libc:inet_pton(_[[:digit:]]+)?'
>  
>  add_libc_inet_pton_event() {
>  
> -	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | tail -n +2 | head -n -5 | \
> +	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | \
>  			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
> -			("\\(on inet_pton in " l "\\)") {print $1}')
> +			("\\(on inet_pton in " l "\\)") {print $1}' | head -n 1)
>  
>  	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
>  		printf "FAIL: could not add event\n"
> @@ -40,12 +40,12 @@ trace_libc_inet_pton_backtrace() {
>  	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>  	case "$(uname -m)" in
>  	s390x)
> -		eventattr='call-graph=dwarf,max-stack=4'
> +		eventattr='call-graph=dwarf,max-stack=8'
>  		echo "((__GI_)?getaddrinfo|text_to_binary_address)\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
>  		echo "(gaih_inet|main)\+0x[[:xdigit:]]+[[:space:]]\(inlined|.*/bin/ping.*\)$" >> $expected
>  		;;
>  	*)
> -		eventattr='max-stack=4'
> +		eventattr='call-graph=dwarf,max-stack=8'
>  		echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" >> $expected
>  		;;
>  	esac

for s390:

Tested-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
