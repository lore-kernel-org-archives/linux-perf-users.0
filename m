Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9641C3161A1;
	Thu, 27 Nov 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764227428; cv=none; b=SInsdAdX8Tfkm+T98JZek8kUYrN9mrs9c37mkVthfrA71fH5dUEjFPBG56/F3PUHv8zdz4ue1Dk1l6IWstv5/2CXYayTzMgX5sNS5vyflgPQf3HsOkDdt8QnnV4qjgUl3GMc8Gxx15kON0rBbhgKo9ry8hJSBCq0PQd+9YkJUos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764227428; c=relaxed/simple;
	bh=myB5WZZTVW/H3olY1pVhc2iLXvYU/671XTeII9hXbWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpMmw0awAZEoBOwOiO3sAF7Laak8lButZuIhLyAMvCht2WESWe9XvVRqHYHjs2miwrK68P4bmj3lsln1OTPavAB0WBj2C0/BGkBCzPSYjqJ+Tseaw6o7FqA86Q4OBf6VjE3z8iLmfpZ4J53UoZO/6h0Lls/opwA81tqVnIOq8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qoE8SIrE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qoE8SIrE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR28FiX007476;
	Thu, 27 Nov 2025 07:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L448fY
	+/keW5xuSln/LzDFFa/O831sbv6wMWmnqxO+o=; b=qoE8SIrEN8sGDG5bVa2jGG
	//h8rD0JVJRZb/sJLdoEcXZC/g3w3lmJr5AFToW5SrIiA8L0/sTNy8BGtiFOllkJ
	w+HN+No126YmhCgVIjCkDSIwmQ7aa8gB7bCAoj+JOsZcEc6RuoGHrxomcVopXbFv
	6UwN9owriMDXvV7KdQOHqtnQXwbBaxoLCV9JBvrF8lXATPgWyJRS74D/XM+cELYs
	Lr+ninFaLSW8WEyw54Vqp8NW5EB56KGmgz73QkXNmtZP7mK5I4X+ekE3k3dBCuYn
	7a+hm6R7gN1MeMWfr7xVT2Buu/ENmedSb9tQ1GdWcZXk0dNP0VDqvWtAre72ODJg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq75au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 07:10:07 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AR78PsQ016688;
	Thu, 27 Nov 2025 07:10:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq75aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 07:10:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AR6VWJE016395;
	Thu, 27 Nov 2025 07:10:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aks0keq70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 07:10:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AR7A34j23527860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Nov 2025 07:10:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19B3720043;
	Thu, 27 Nov 2025 07:10:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF0E920040;
	Thu, 27 Nov 2025 07:10:02 +0000 (GMT)
Received: from [9.152.212.92] (unknown [9.152.212.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Nov 2025 07:10:02 +0000 (GMT)
Message-ID: <ea6ca6ea-13ca-4e92-a7c5-b48611f3f1e8@linux.ibm.com>
Date: Thu, 27 Nov 2025 08:10:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Skip internal syscall arguments
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Howard Chu <howardchu95@gmail.com>
References: <20251127044418.677379-1-namhyung@kernel.org>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20251127044418.677379-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX8PRbN1IuZVR/
 mCyTh+dPFoPPz6F+Ef7RCZdRCAXDxnFpwYZGZyXAcpo+UKddvHNOv0RGasPQVDMuZktokbmk7aU
 S8/gV+zlFWBSN9CzLX3N3iLUxBZrNh/yrGLd81e8Lr5WISvcFLegtTpCq0tgrlicmf9n5eRXfgX
 g2oiSKH0X9iIyVdIP1qMtXlLzARJmQbneYcdO3mZFwGymX1FzVtD/DRTOZER3wYOwTQTNQfZHuC
 YFz/Rf4iFezOjHAA+GWFmtcDq+drCmd2cPdLgB7nYWBrPilBaQLih5sosqtGIvGMlmVBF1QZJcY
 TKGtXJ+aObAs4wQzVqmjzCcdXlSBVcLG2Df3WYyFKGFfK//K0FT7uRdXn5Oi3ogXRiEeD2kC/Qi
 JdZMm8iRLoWbwZTuzP4bE4as4PrPdA==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6927f94f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=meVymXHHAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=a0IGMF8zWGYiwE1iLxEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-GUID: KRm8CHNcf-CY5cQKudPIENSOlubMvYOh
X-Proofpoint-ORIG-GUID: NWoYJlDFvi5FtD0Nzy6u_wXHsSG3Xno_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

On 11/27/25 05:44, Namhyung Kim wrote:
> Recent changes in the linux-next kernel will add new field for syscalls
> to have contents in the userspace like below.
> 
>   # cat /sys/kernel/tracing/events/syscalls/sys_enter_write/format
>   name: sys_enter_write
>   ID: 758
>   format:
>           field:unsigned short common_type;       offset:0;       size:2; signed:0;
>           field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>           field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>           field:int common_pid;   offset:4;       size:4; signed:1;
> 
>           field:int __syscall_nr; offset:8;       size:4; signed:1;
>           field:unsigned int fd;  offset:16;      size:8; signed:0;
>           field:const char * buf; offset:24;      size:8; signed:0;
>           field:size_t count;     offset:32;      size:8; signed:0;
>           field:__data_loc char[] __buf_val;      offset:40;      size:4; signed:0;
> 
>   print fmt: "fd: 0x%08lx, buf: 0x%08lx (%s), count: 0x%08lx", ((unsigned long)(REC->fd)),
>              ((unsigned long)(REC->buf)), __print_dynamic_array(__buf_val, 1),
>              ((unsigned long)(REC->count))
> 
> We have a different way to handle those arguments and this change
> confuses perf trace then make some tests failing.  Fix it by skipping
> the new fields that have "__data_loc char[]" type.
> 
> Maybe we can switch to this instead of the BPF augmentation later.
> 
> Reported-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Howard Chu <howardchu95@gmail.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index a743bda294bd3400..baee1f6956001d86 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2069,6 +2069,15 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
>         return __syscall_arg_fmt__find_by_name(syscall_arg_fmts__by_name, nmemb, name);
>  }
>  
> +/*
> + * v6.19 kernel added new fields to read userspace memory for event tracing.
> + * But it's not used by perf and confuses the syscall parameters.
> + */
> +static bool is_internal_field(struct tep_format_field *field)
> +{
> +	return !strcmp(field->type, "__data_loc char[]");
> +}
> +
>  static struct tep_format_field *
>  syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
>  			    bool *use_btf)
> @@ -2077,6 +2086,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
>  	int len;
>  
>  	for (; field; field = field->next, ++arg) {
> +		/* assume it's the last argument */
> +		if (is_internal_field(field))
> +			continue;
> +
>  		last_field = field;
>  
>  		if (arg->scnprintf)
> @@ -2145,6 +2158,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  {
>  	char tp_name[128];
>  	const char *name;
> +	struct tep_format_field *field;
>  	int err;
>  
>  	if (sc->nonexistent)
> @@ -2201,6 +2215,13 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		--sc->nr_args;
>  	}
>  
> +	field = sc->args;
> +	while (field) {
> +		if (is_internal_field(field))
> +			--sc->nr_args;
> +		field = field->next;
> +	}
> +
>  	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
>  	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
>  

With the patch it succeeds again:
❯ ./perf test -F 'perf trace BTF general tests'
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Testing perf trace's struct augmentation
110: perf trace BTF general tests                                    : Ok
>

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
