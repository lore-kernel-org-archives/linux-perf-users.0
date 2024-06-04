Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF57F446CF;
	Tue,  4 Jun 2024 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488238; cv=none; b=a3xGQgrAkAyT7SJK2+2S8DYF4bpc9n8/foz7Dm+i2yHXcJpkW7QIZFxNT7vm6agUctmUnNm0CMrFhMeBGE+nN5G/+m4gW5mC4K3CUYT/pxtpZc/QF3Ia4CkuYfWiuG5kmdggNYY59JU+vjnX8h0DD/jjcqVJZ5v2SJATHUMprsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488238; c=relaxed/simple;
	bh=V0bP/pgginWSfLSzil5x4CQ2ljLMsquK2SkQRT5M5bo=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZOVRWGFBM+NztcNo9x3MwPtWLWu1DDhS+/u5PFs33Qw6ykaWwQPymoGzdKrSDzpYbIkIBpyWfV3EAwDU+IA/N8Hwt6OQ9nLXWUz7v0MbP7etc3viC0GcbYgBDvJc7YsN8IKYq/3Wr1D15pjjVmVSVKr8N1wMaUtg7jiPQODFXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vtjh4643hzPnsm;
	Tue,  4 Jun 2024 16:00:36 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 0692A18007E;
	Tue,  4 Jun 2024 16:03:53 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:03:52 +0800
CC: <yangyicong@hisilicon.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<acme@kernel.org>, <namhyung@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<james.clark@arm.com>, <dongli.zhang@oracle.com>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH 0/3] Perf avoid opening events on offline CPUs
To: Ian Rogers <irogers@google.com>
References: <20240603092812.46616-1-yangyicong@huawei.com>
 <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <3f43ecf1-ae3c-3418-9798-9f1aa0dcc3d2@huawei.com>
Date: Tue, 4 Jun 2024 16:03:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXw0=dHORC-kObYFiAco64PGP4_uFr__f9YmVctWtGSfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/6/4 0:42, Ian Rogers wrote:
> On Mon, Jun 3, 2024 at 2:33 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> If user doesn't specify the CPUs, perf will try to open events on CPUs
>> of the PMU which is initialized from the PMU's "cpumask" or "cpus" sysfs
>> attributes if provided. But we doesn't check whether the CPUs provided
>> by the PMU are all online. So we may open events on offline CPUs if PMU
>> driver provide offline CPUs and then we'll be rejected by the kernel:
>>
>> [root@localhost yang]# echo 0 > /sys/devices/system/cpu/cpu0/online
> 
> Generally Linux won't let you take CPU0 off line, I'm not able to
> follow this step on x86 Linux. Fwiw, I routinely run perf with the
> core hyperthread siblings offline.
> 

It doesn't matter if it's the CPU0 offline or other CPUs. There's no restriction
for CPU0 can go offline or not on arm64 and I just use this for example.

I cannot reproduce it on x86. I think it may because we're initializing the
pmu->cpus in different routines in pmu_cpumask(). There's no "cpus"
for x86's core pmu on my x86 machine:
root@ubuntu204:~# ls /sys/bus/event_source/devices/cpu/
allow_tsx_force_abort  caps  events  format  freeze_on_smi  perf_event_mux_interval_ms  power  rdpmc  subsystem  type  uevent

So pmu_cpumask() will infer it as an core pmu and initialize the cpus
with online CPUs [1]. For arm64 there lies a "cpus" sysfs attributes
so pmu->cpus are initialized from the "cpus" without checking each
CPUs is online or not. That's what proposed in Patch 1/3.

There's a "cpus" sysfs for x86's hybrid machine, reading from the code [2].
And it seems always reflect the online CPUs supported by that PMU.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n779
[2] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree//arch/x86/events/intel/core.c#n5736

Thanks.
