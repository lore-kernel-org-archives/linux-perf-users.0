Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBA83211;
	Wed,  6 Nov 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886365; cv=none; b=W4UeBIElAiFqinrC/AwyzUFduzTT6T7pCz0XduXHxpzlnznAH+XEzToDg73UjUB3At6DCLMgVYa+YGD4qkHUJhy8ZcB7xl6yG/QeNmPjds/Zi1wCLJHu+KKFZy79nEJmlZvSKvdRw1hjS8Fh/bvEzHqFGh8zCRq9eq4KasBonyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886365; c=relaxed/simple;
	bh=7MghTJQkR44qaMgyLxvcz4iaHBncGIlDk0onWf/Qlhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=djvgpfXvIaPMsOv7LGjfo90F6TYlBsC1Sgc46yN3jEWcRGnYH7B8yUwM1DPk4IpKOxE233JKgUvVMobHTKlYYKx2uAqfK5MwU8SdiYjQBIS3m1gq+/jU1oQzYmTa1zLKwpzF4izOdgWX7wFwq+CQ6NXm8whmgCAKqTjBDxb68W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fTDmSyUX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fTDmSyUX"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68jNV6030512;
	Wed, 6 Nov 2024 09:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nK6e8P
	6ZRM5mtyMlMQA9ZJRtAhJyqAzVLet89KVCreo=; b=fTDmSyUXe4rtrnFKr/uBJF
	0sZ89u1kmYlOPTIiD+4zwU9L7YJ2+CbMQMQeR3lZyXRMDVXAaa3rWK9xEtjd2+VK
	bzDwvfJufrQmFs5DhxFdqmsaq2S5IjbOvMs/iVJ2uNZRpTENJsGh/nmvqsGSb9M1
	rxBsIncxPUWfGsFFo8xbWlJKLF2Ivqqs87RMnMO1/RSpeeVRThFaBYsYfTrMkzRs
	GG0FP5j2Rh5+Db2GzId6VGUtqr1rT83e8aKsuL5cBoIOUKep06yj9OlQCzsIfDa7
	NkHvsfQjavyvnDYFHhuggLRFbQ2cU2jNhqH6ws34iy/MtrF/GkzCBR2baDN6pEEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r57f88ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:45:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A69jZ9L029206;
	Wed, 6 Nov 2024 09:45:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42r57f88e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:45:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68BZP1023983;
	Wed, 6 Nov 2024 09:45:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyj5kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:45:33 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A69jUhd30802462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 09:45:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E50DD20043;
	Wed,  6 Nov 2024 09:45:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831E420040;
	Wed,  6 Nov 2024 09:45:29 +0000 (GMT)
Received: from [9.152.222.93] (unknown [9.152.222.93])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Nov 2024 09:45:29 +0000 (GMT)
Message-ID: <c6509104-b8ff-41ef-8afa-a44cf740b779@linux.ibm.com>
Date: Wed, 6 Nov 2024 10:45:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] perf: Add deferred user callchains
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
        Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <1ce857387c781afa66efaa61eb88ff596b352500.1730150953.git.jpoimboe@kernel.org>
From: Jens Remus <jremus@linux.ibm.com>
Content-Language: en-US
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <1ce857387c781afa66efaa61eb88ff596b352500.1730150953.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: swUQO9jKgjXMxLyMdhtN5jKIz3DG6jzN
X-Proofpoint-ORIG-GUID: b9j_YAQ3_uLl4q74CrGwxVXWXxnfe6Bx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060073

On 28.10.2024 22:48, Josh Poimboeuf wrote:
...
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ebf143aa427b..bf97b2fa8a9c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
...
> @@ -6955,6 +6958,53 @@ static void perf_pending_irq(struct irq_work *entry)
>   		perf_swevent_put_recursion_context(rctx);
>   }
>   
> +static void perf_pending_unwind_irq(struct irq_work *entry)
> +{
> +	struct perf_event *event = container_of(entry, struct perf_event, pending_unwind_irq);
> +
> +	if (event->pending_unwind) {
> +		unwind_user_deferred(&perf_unwind_callback_cb, NULL, event);
> +		event->pending_unwind = 0;
> +	}
> +}
> +
> +struct perf_callchain_deferred_event {
> +	struct perf_event_header	header;
> +	u64				ctx_cookie;

This introduces ctx_cookie in the struct used to produce deferred events but misses to do so in the struct used to consume them. This causes the ctx_cookie value to erroneously get interpreted as nr (number of IPs) in perf:

Core was generated by `perf record -F 99 --call-graph fp /opt/binutils-sframe2/bin/objdump --sframe /opt/binutils-sframe2/bin/objdump'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  __GI_memcpy () at ../sysdeps/s390/memcpy-z900.S:209
209             mvc     0(256,%r1),0(%r3)
[Current thread is 1 (Thread 0x3ff8bb5fe80 (LWP 16554))]
(gdb) bt
#0  __GI_memcpy () at ../sysdeps/s390/memcpy-z900.S:209
#1  0x00000000012ad0ca in sample__merge_deferred_callchain (sample_orig=0x3ffd2ff53c8, sample_callchain=0x3ffd2ff5b18) at util/callchain.c:1853
...
(gdb) p/x sample_callchain->callchain->nr
$2 = 0x489cb

With debug output from perf_event_callchain_deferred() (see below):

DEBUG: perf_event_callchain_deferred: ctx_cookie=0x00000000000489cb, nr=2

> +	u64				nr;
> +	u64				ips[];
> +};
> +
> +static void perf_event_callchain_deferred(struct unwind_stacktrace *trace,
> +					  u64 ctx_cookie, void *_data)
> +{
> +	struct perf_callchain_deferred_event deferred_event;
> +	u64 callchain_context = PERF_CONTEXT_USER;
> +	struct perf_output_handle handle;
> +	struct perf_event *event = _data;
> +	struct perf_sample_data data;
> +	u64 nr = trace->nr + 1 /* callchain_context */;
> +
> +	deferred_event.header.type = PERF_RECORD_CALLCHAIN_DEFERRED;
> +	deferred_event.header.misc = PERF_RECORD_MISC_USER;
> +	deferred_event.header.size = sizeof(deferred_event) + (nr * sizeof(u64));
> +
> +	deferred_event.ctx_cookie = ctx_cookie;
> +	deferred_event.nr = nr;
> +
> +	perf_event_header__init_id(&deferred_event.header, &data, event);

	pr_info_ratelimited("DEBUG: perf_event_callchain_deferred: ctx_cookie=0x%016llx, nr=%llu\n",
		deferred_event.ctx_cookie, deferred_event.nr);

> +
> +	if (perf_output_begin(&handle, &data, event, deferred_event.header.size))
> +		return;
> +
> +	perf_output_put(&handle, deferred_event);
> +	perf_output_put(&handle, callchain_context);
> +	perf_output_copy(&handle, trace->entries, trace->nr * sizeof(u64));
> +	perf_event__output_id_sample(event, &handle, &data);
> +
> +	perf_output_end(&handle);
> +}
> +
>   static void perf_pending_task(struct callback_head *head)
>   {
>   	struct perf_event *event = container_of(head, struct perf_event, pending_task);
...

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303) and z/VSE Support
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

