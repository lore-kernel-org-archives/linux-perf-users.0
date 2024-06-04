Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20C144D3B;
	Tue,  4 Jun 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499572; cv=none; b=ZY31agLaSCpjEzdmpoDYty3geZ+TTzyZTHZ75jQw3FTVm4AOue/WYoTKuQDeaTRudjJMJk8dB7nZC97Eefd1WzHgXpkXRIjUN1/7b/iRwV7s6iv21yWTNK0XO/VN1la3A5QE1E/WZ6S/IEGpNpLC+VdOWiecXqjl5JylNnGqcxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499572; c=relaxed/simple;
	bh=duS0E61vDWR5VMQUABw7lBbVU+dp7FmowJtxtmTheDo=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=axyJqGRnhmGpUze4N2HFqU9st1/zb/0egprhpopsHGzH4knqp1fQUWaJouHJVSGlhueWbKhTmwDmM8YBgQxFZz+2qj4TZcgs9SY6Z51QKeK0hLjOAA8S8NehNBylSwP9ifVNXq2JeFtzBvtvO5l4OTf0qKRKXA/NHPh6a4o7nI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtnsH1GmBzwPFr;
	Tue,  4 Jun 2024 19:08:51 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F20A140FD3;
	Tue,  4 Jun 2024 19:12:46 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 19:12:45 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<acme@kernel.org>, <namhyung@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH 1/3] perf pmu: Limit PMU cpumask to online CPUs
To: Ian Rogers <irogers@google.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
 <20240603092812.46616-2-yangyicong@huawei.com>
 <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <0d45744d-c206-66b6-5861-b80ebcc9a1d6@huawei.com>
Date: Tue, 4 Jun 2024 19:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXNumMLL=_+qXdnQPqgLSwo7Z1BFmPww63NkX5EcDRDsQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/6/4 0:52, Ian Rogers wrote:
> On Mon, Jun 3, 2024 at 2:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> We'll initialize the PMU's cpumask from "cpumask" or "cpus" sysfs
>> attributes if provided by the driver without checking the CPUs
>> are online or not. In such case that CPUs provided by the driver
>> contains the offline CPUs, we'll try to open event on the offline
>> CPUs and then rejected by the kernel:
>>
>> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
>> [root@localhost yang]# ./perf_static stat -e armv8_pmuv3_0/cycles/ --timeout 100
>> Error:
>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>> /bin/dmesg | grep -i perf may provide additional information.
>>
>> So it's better to do a double check in the userspace and only include
>> the online CPUs from "cpumask" or "cpus" to avoid opening events on
>> offline CPUs.
> 
> I see where you are coming from with this but I think it is wrong. The
> cpus for an uncore PMU are a hint of the CPU to open on rather than
> the set of valid CPUs. For example:
> ```
> $ cat /sys/devices/uncore_imc_free_running_0/cpumask
> 0
> $ perf stat -vv -e uncore_imc_free_running_0/data_read/ -C 1 -a sleep 0.1
> Using CPUID GenuineIntel-6-8D-1
> Attempt to add: uncore_imc_free_running_0/data_read/
> ..after resolving event: uncore_imc_free_running_0/event=0xff,umask=0x20/
> Control descriptor is not initialized
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off cloexec flag
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0
> sys_perf_event_open failed, error -22
> switching off exclude_guest, exclude_host
> ------------------------------------------------------------
> perf_event_attr:
>   type                             24 (uncore_imc_free_running_0)
>   size                             136
>   config                           0x20ff (data_read)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>   disabled                         1
>   inherit                          1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 3
> uncore_imc_free_running_0/data_read/: 1: 4005984 102338957 102338957
> uncore_imc_free_running_0/data_read/: 4005984 102338957 102338957
> 
>  Performance counter stats for 'system wide':
> 
>             244.51 MiB  uncore_imc_free_running_0/data_read/
> 
>        0.102320376 seconds time elapsed
> ```
> So the CPU mask of the PMU says to open on CPU 0, but on the command
> line when I passed "-C 1" it opened it on CPU 1. If the cpumask file
> contained an offline CPU then this change would make it so the CPU map
> in the tool were empty, however, a different CPU may be programmable
> and online.
> 
> Fwiw, the tool will determine whether the mask is for all valid or a
> hint by using the notion of a PMU being "core" or not. That notion
> considers whether the mask was loading from a "cpumask" or "cpus"
> file:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n810
> 

I see, you're correct on this. Maybe I didn't mention it clearly in the commit,
this patch doesn't intend to change the case that user specify the CPUs explicitly.
It'll have difference in case user doesn't specify the CPU list while the PMU's
'cpus' or 'cpumask' contains offline CPUs: with this patch we'll use the online
CPUs in the PMU's 'cpus' or 'cpumask' but before this we may use the offline CPUs.
We still honor the user's input by the handling in __perf_evlist__propagate_maps().

Thanks.
