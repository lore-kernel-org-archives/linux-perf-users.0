Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5522D4EB;
	Thu, 17 Apr 2025 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878144; cv=none; b=XwIKvTP9W9+IflhpOhdp0sXVjF8dynb2P7yThsuhSQTzH2AGv+im2tQLOX3GyDzk2Zw5FqPAoUYNqp8M+JftYN4jPr7AfPKGS440Ty/3VmaUTH+WJ+wusHL8qxs0849ccV8jJjGF1UUpyMI3LNx6vDzDf2+5gNs1mMD2hThmBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878144; c=relaxed/simple;
	bh=PzkIBzvinUW2oPWntBhM6dLX4AXexyJnbByjvs0DJ94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAabUR+HpOqKHLNxfOJxCMeJNMksh0Zel2DAFMfKR3rMaZP4sHZsXhlifFqx0ygK/k1ID1uRFChSHCxcuTncKPKDoyB658AGA5R+W0fhO3YLhxK4ovuGMYBU7rUt9kv7wyXB5tF8zHzLyR9zSRy/cQ/7hH/R9LOwTpfgLkS293w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLIy3IaG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLIy3IaG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7wdRp015008;
	Thu, 17 Apr 2025 08:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Xx+Qq
	lGnemhmirWT8bkH9kSx479Ey0v4BVTqYKjZfs=; b=YLIy3IaGvGp8JgylzRVYXD
	LnqGzbXVSdlqqXA9wbI88OiWmFG1D+bdy4s24ioA3bDYjLASM37FOjuRUvVQ6yVz
	KC6lcGiRHt1f8FPneIfd1UYgF3rOz2sMAboUhH1YAU9J9vntK2xifSn0xDm7JjoN
	/CSJ5zXlG/BHTxYpCKivBjFd5IG6iSQULqGzHtTqxxAtSpQRt3QYPIvi6tvHrjsn
	nOXc00LUw7+Ch4nzbmWrKlZjG1GBpRxsEu6LX+KUEF0u+0jwr4D8a9Z/mtdN4/0b
	NhaeirB+xeLYGC6aviJHbTEdioCEAo7Q+h3Lo/I2KgC+MIMUtHwquAFAdhajokxQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7tc53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:22:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53H8Fo4m003626;
	Thu, 17 Apr 2025 08:22:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462mn7tc52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:22:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53H7GYIY010415;
	Thu, 17 Apr 2025 08:22:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qkcg5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 08:22:05 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53H8M49Q34865888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 08:22:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B472004B;
	Thu, 17 Apr 2025 08:22:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CECE20040;
	Thu, 17 Apr 2025 08:22:00 +0000 (GMT)
Received: from [9.109.199.221] (unknown [9.109.199.221])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Apr 2025 08:22:00 +0000 (GMT)
Message-ID: <cfc1576a-6c69-4047-890d-3f51e8a5995b@linux.ibm.com>
Date: Thu, 17 Apr 2025 13:51:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf trace: Speed up startup time by bypassing the
 creation of kernel maps
To: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@linaro.org,
        charlie@rivosinc.com, mpetlan@redhat.com, vmolnaro@redhat.com,
        linux@treblig.org, mhiramat@kernel.org, leo.yan@arm.com,
        dima@secretsauce.net, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.m.lopatowski@gmail.com
References: <20250405031213.3502708-1-howardchu95@gmail.com>
Content-Language: en-US
From: Aditya Bodkhe <adityab1@linux.ibm.com>
In-Reply-To: <20250405031213.3502708-1-howardchu95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ANnAolku c=1 sm=1 tr=0 ts=6800ba2f cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=uy4nFIpy6xwnJLC1:21 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tCK5g1jhulg5S5MmH4MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ba7M40Aj1pI70ftrUMu9u645IQUyqRSY
X-Proofpoint-ORIG-GUID: 0b94XlSJsJyIPCKyZC7rLrl6nQ0FJVbI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170062

Hi Howard

I tested this patch on powerpc platform and got following results

Average real time over 10 runs : 2.130 Seconds (Without Patch)

Average real time over 10 runs : 2.062 Secomds (With Patch)

Am i missing something here

Thanks

Aditya


On 05/04/25 8:42 am, Howard Chu wrote:
> If perf trace isn't run with '--call-graph' and '--kernel-syscall-graph'
> options, e.g.
>
> sudo ./perf trace --call-graph fp --kernel-syscall-graph -a
>
> there is no need for creating kernel maps.
>
> before:
>
> perf $ time sudo ./perf trace -- sleep 1
>           ? (         ): sleep/3462908  ... [continued]: execve())                                           = 0
> 	 ...
>    1001.459 (         ): sleep/3463166 exit_group()                                                          = ?
>
> real    0m2.834s
> user    0m0.011s
> sys     0m0.012s
>
> after:
>
> perf $ time sudo ./perf trace -- sleep 1
>           ? (         ): sleep/3459948  ... [continued]: execve())                                           = 0
> 	 ...
>    1001.471 (         ): 3459948 exit_group()                                                          = ?
>
> real    0m1.810s
> user    0m0.008s
> sys     0m0.015s
>
> I also want to express my gratitude to Krzysztof Łopatowski—his
> profiling of the perf trace [1] inspired this patch. I'm not sure why
> the discussion stalled, and I apologize for not being able to answer his
> questions. Since his findings significantly improve the startup time of
> perf trace, I don't want to take credit for that. So Krzysztof, please
> let me know if you'd like a Suggested-by: or anything else.
>
> [1]: https://lore.kernel.org/linux-perf-users/CAOQCU67EsHyw_FsqGbRuityahZTSAtWzffU=hLUJ7K=aZ=1hhA@mail.gmail.com/
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> Cc: "Krzysztof Łopatowski" <krzysztof.m.lopatowski@gmail.com>
> ---
>   tools/perf/builtin-buildid-list.c     | 2 +-
>   tools/perf/builtin-trace.c            | 2 +-
>   tools/perf/tests/code-reading.c       | 2 +-
>   tools/perf/tests/dlfilter-test.c      | 2 +-
>   tools/perf/tests/dwarf-unwind.c       | 2 +-
>   tools/perf/tests/mmap-thread-lookup.c | 2 +-
>   tools/perf/tests/symbols.c            | 2 +-
>   tools/perf/util/machine.c             | 6 +++---
>   tools/perf/util/machine.h             | 2 +-
>   tools/perf/util/probe-event.c         | 2 +-
>   10 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
> index 52dfacaff8e3..357201d8ef0c 100644
> --- a/tools/perf/builtin-buildid-list.c
> +++ b/tools/perf/builtin-buildid-list.c
> @@ -47,7 +47,7 @@ static void buildid__show_kernel_maps(void)
>   {
>   	struct machine *machine;
>   
> -	machine = machine__new_host();
> +	machine = machine__new_host(true);
>   	machine__for_each_kernel_map(machine, buildid__map_cb, NULL);
>   	machine__delete(machine);
>   }
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f55a8a6481f2..39f23ce39842 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1963,7 +1963,7 @@ static int trace__symbols_init(struct trace *trace, struct evlist *evlist)
>   	if (err)
>   		return err;
>   
> -	trace->host = machine__new_host();
> +	trace->host = machine__new_host(callchain_param.enabled && trace->kernel_syscallchains);
>   	if (trace->host == NULL)
>   		return -ENOMEM;
>   
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index cf6edbe697b2..17c7b9f95532 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -654,7 +654,7 @@ static int do_test_code_reading(bool try_kcore)
>   
>   	pid = getpid();
>   
> -	machine = machine__new_host();
> +	machine = machine__new_host(true);
>   	machine->env = &perf_env;
>   
>   	ret = machine__create_kernel_maps(machine);
> diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
> index 54f59d1246bc..11f70ebabacf 100644
> --- a/tools/perf/tests/dlfilter-test.c
> +++ b/tools/perf/tests/dlfilter-test.c
> @@ -352,7 +352,7 @@ static int test__dlfilter_test(struct test_data *td)
>   		return test_result("Failed to find program symbols", TEST_FAIL);
>   
>   	pr_debug("Creating new host machine structure\n");
> -	td->machine = machine__new_host();
> +	td->machine = machine__new_host(true);
>   	td->machine->env = &perf_env;
>   
>   	td->fd = creat(td->perf_data_file_name, 0644);
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index 4803ab2d97ba..b76712f68403 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -203,7 +203,7 @@ noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
>   	struct thread *thread;
>   	int err = -1;
>   
> -	machine = machine__new_host();
> +	machine = machine__new_host(true);
>   	if (!machine) {
>   		pr_err("Could not get machine\n");
>   		return -1;
> diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
> index ddd1da9a4ba9..194b5affaa41 100644
> --- a/tools/perf/tests/mmap-thread-lookup.c
> +++ b/tools/perf/tests/mmap-thread-lookup.c
> @@ -167,7 +167,7 @@ static int mmap_events(synth_cb synth)
>   	 */
>   	TEST_ASSERT_VAL("failed to create threads", !threads_create());
>   
> -	machine = machine__new_host();
> +	machine = machine__new_host(true);
>   
>   	dump_trace = verbose > 1 ? 1 : 0;
>   
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index ee20a366f32f..6b22a451211a 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -19,7 +19,7 @@ struct test_info {
>   
>   static int init_test_info(struct test_info *ti)
>   {
> -	ti->machine = machine__new_host();
> +	ti->machine = machine__new_host(true);
>   	if (!ti->machine) {
>   		pr_debug("machine__new_host() failed!\n");
>   		return TEST_FAIL;
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 55d4977b9913..b1828e3922f2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -125,14 +125,14 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
>   	return 0;
>   }
>   
> -struct machine *machine__new_host(void)
> +struct machine *machine__new_host(bool create_kmaps)
>   {
>   	struct machine *machine = malloc(sizeof(*machine));
>   
>   	if (machine != NULL) {
>   		machine__init(machine, "", HOST_KERNEL_ID);
>   
> -		if (machine__create_kernel_maps(machine) < 0)
> +		if (create_kmaps && machine__create_kernel_maps(machine) < 0)
>   			goto out_delete;
>   
>   		machine->env = &perf_env;
> @@ -146,7 +146,7 @@ struct machine *machine__new_host(void)
>   
>   struct machine *machine__new_kallsyms(void)
>   {
> -	struct machine *machine = machine__new_host();
> +	struct machine *machine = machine__new_host(true);
>   	/*
>   	 * FIXME:
>   	 * 1) We should switch to machine__load_kallsyms(), i.e. not explicitly
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index ae3e5542d57d..e6faf8cd06e7 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -163,7 +163,7 @@ struct thread *machine__findnew_guest_code(struct machine *machine, pid_t pid);
>   void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
>   void machines__set_comm_exec(struct machines *machines, bool comm_exec);
>   
> -struct machine *machine__new_host(void);
> +struct machine *machine__new_host(bool create_kmaps);
>   struct machine *machine__new_kallsyms(void);
>   int machine__init(struct machine *machine, const char *root_dir, pid_t pid);
>   void machine__exit(struct machine *machine);
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 307ad6242a4e..6b5b5542f454 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -94,7 +94,7 @@ int init_probe_symbol_maps(bool user_only)
>   	if (symbol_conf.vmlinux_name)
>   		pr_debug("Use vmlinux: %s\n", symbol_conf.vmlinux_name);
>   
> -	host_machine = machine__new_host();
> +	host_machine = machine__new_host(true);
>   	if (!host_machine) {
>   		pr_debug("machine__new_host() failed.\n");
>   		symbol__exit();
