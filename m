Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB841411CA;
	Tue,  4 Jun 2024 07:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487023; cv=none; b=fEoU36hyzL5rkQgyw925UfhlJgeAVIFqcMEgkNHmIofMV3wub1Fl/x71DZ+CJQxqMzu80CjTU51A4xHtYn4jURRo7LlC+bnyr4Xls3P5BK6SwAWmbQ+5QNNsksy9L539PD+cGsKBdJ4Y5Tws4KmJ0sOl0ujHphMHhAFxzN7UpZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487023; c=relaxed/simple;
	bh=rmrq0CC543j83YlXev509NtGiSbQwtYK4+nRu8TmMLk=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KM19n/rNY8TIlz1TxfYs8TE1HjNYPpoCxZtJ35w8Lxw274s+YJhYyg98Pj7ZRRoaolCJrUv+soU8tG8nCMibfS5F8Rj895jRZiQwU3GlUPwuLWr6YuRtWP0t0jlHGpi2nULKQvgMHoz9weW5ZFcPtj370ZbhtTyqzpAGro+Rkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VtjDD30zXz1S66v;
	Tue,  4 Jun 2024 15:39:56 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 24B071A0188;
	Tue,  4 Jun 2024 15:43:37 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 15:43:36 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<acme@kernel.org>, <namhyung@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH 2/3] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
To: Ian Rogers <irogers@google.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
 <20240603092812.46616-3-yangyicong@huawei.com>
 <CAP-5=fXDPor-WsO-TGB3z6QpSWZOFJC31GJpuwZUA3qz_3WsYQ@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <b348d9dd-75cb-6b83-a4be-cfd29e15eb99@huawei.com>
Date: Tue, 4 Jun 2024 15:43:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXDPor-WsO-TGB3z6QpSWZOFJC31GJpuwZUA3qz_3WsYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi Ian,

On 2024/6/4 0:20, Ian Rogers wrote:
> On Mon, Jun 3, 2024 at 2:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> When there're CPUs offline after system booting, perf will failed:
>> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
>> Error:
>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>> /bin/dmesg | grep -i perf may provide additional information.
> 
> Thanks for debugging this Yicong! The fact cycles is falling back on
> cpu-clock I'm confused by, on ARM the PMU type generally isn't
> PERF_TYPE_HARDWARE and so this fallback shouldn't happen:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c?h=perf-tools-next#n2900
> I note your command line is for system wide event opening rather than
> for a process. It is more strange the fallback is giving "No such
> device".
> 
>> This is due to PMU's "cpus" is not updated and still contains offline
>> CPUs and perf will try to open perf event on the offlined CPUs.
> 
> The perf tool will try to only open online CPUs. Unfortunately the
> naming around this is confusing:
> 
> - any - an event may follow a task and schedule on "any" CPU. We
> encode this with -1.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n24
> - online - the set of online CPU.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n33
> - all - I try to avoid this but it may still be in the code, "all"
> usually is another name for online. Hopefully when we use this name it
> is clearly defined:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/internal/evlist.h?h=perf-tools-next#n23
> 
>> Make "cpus" attribute only shows online CPUs and introduced a new
>> "supported_cpus" where users can get the range of the CPUs this
>> PMU supported monitoring.
> 
> I don't think this should be necessary as by default the CPUs the perf
> tool will use will be the "online" CPUs:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=perf-tools-next#n40
> 
> Could you create a reproduction of the problem you are encountering?
> My expectation is for a core PMU to advertise the online and offline
> CPUs it is valid for, and for perf to intersect:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/include/perf/cpumap.h?h=perf-tools-next#n44
> those CPUs with the online CPUs so the perf_event_open doesn't fail.
> 

Thanks for the comments and detailed illustration!

Actually it can be reproduced easily using the armv8_pmuv3's events. Tested on 6.10-rc1 with
perf version 6.10.rc1.g1613e604df0c:
# offline any CPU
[root@localhost tmp]# echo 0 > /sys//devices/system/cpu/cpu1/online
# try any event of armv8_pmuv3, with -a or without
[root@localhost tmp]# ./perf stat -e armv8_pmuv3_0/ll_cache/ -vvv
Control descriptor is not initialized
Opening: armv8_pmuv3_0/ll_cache/
------------------------------------------------------------
perf_event_attr:
  type                             10 (armv8_pmuv3_0)
  size                             136
  config                           0x32 (ll_cache)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
Opening: armv8_pmuv3_0/ll_cache/
------------------------------------------------------------
perf_event_attr:
  type                             10 (armv8_pmuv3_0)
  size                             136
  config                           0x32 (ll_cache)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8
sys_perf_event_open failed, error -19
Error:
The sys_perf_event_open() syscall returned with 19 (No such device) for event (armv8_pmuv3_0/ll_cache/).
/bin/dmesg | grep -i perf may provide additional information.

As you can see, we're trying to open event on CPU 0 first (succeed) and then CPU 1 but
failed on CPU1. Actually we don't enter any branch which handle the evsel->cpus in
__perf_evlist__propagate_maps() so the evsel->cpus keeps as is which should be initialized
from the pmu->cpumask. You referenced to [1] but in this case perf_evsel->system_wide == false
as I checked. perf_evsel->system_wide will set to true in perf_evlist__go_system_wide() and it
maybe only set for dummy events. Please correct me if I misread here.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/lib/perf/evlist.c?h=perf-tools-next#n40

Thanks.

