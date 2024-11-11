Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D342A8A;
	Mon, 11 Nov 2024 08:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314359; cv=none; b=I9ujIY5sXKpr7+Q+SUcxF5xN4uQ7UBKaCJ15imzD6jpsCZQ/YUVse/nuIHvHB+MyGzAklLNEBuPRIV8oYJlTUjfqdiWi1ls+HAzow0h6VYITviy9XeVL2au1iQwBSPaznG9gDw6J5VxgTUsXwwFWR6IwUE7WEjA6DjLJLHtQ89k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314359; c=relaxed/simple;
	bh=lYYYEUm2oPHWg2EHbK4EHCvhRqZvYy5u46TnSMY16mI=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XnhOb0IsBe5tZEEbZJt8DJ9oDEENrjcy1yHhyB5E0/w+K1fuLtiHadpPlbN1URnTy5tzPqBL+ZQ8IhMYG/x1XTIug7o5nz6aP/xZwxue9DOv98hdH/5V7v/snbAKwPIBTms0GecvSMZhmlvsTpiUSM24+bsCWum997k7Nd0Fxnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xn2wb1nvlz10VB1;
	Mon, 11 Nov 2024 16:37:19 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DA53140257;
	Mon, 11 Nov 2024 16:39:11 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 11 Nov 2024 16:39:09 +0800
CC: <yangyicong@hisilicon.com>, Xu Yang <xu.yang_2@nxp.com>, John Garry
	<john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James Clark
	<james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
	<leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen
	<chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Athira Rajeev
	<atrajeev@linux.vnet.ibm.com>, Ben Zong-You Xie <ben717@andestech.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, Sandipan Das
	<sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, Ravi Bangoria
	<ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=c3=a9ment_Le_Goffic?=
	<clement.legoffic@foss.st.com>, "Masami Hiramatsu (Google)"
	<mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, "Dr. David Alan
 Gilbert" <linux@treblig.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Junhao He <hejunhao3@huawei.com>
Subject: Re: [PATCH v2 8/8] perf pmu: Move pmu_metrics_table__find and remove
 ARM override
To: Ian Rogers <irogers@google.com>
References: <20241107162035.52206-1-irogers@google.com>
 <20241107162035.52206-9-irogers@google.com>
 <5a57de7c-924e-ccd6-8981-b9fddc647465@huawei.com>
 <CAP-5=fWw04Qi+3=y7M4uMrhgrFWpnF7mZ09yb4v0P0qFT1Gfnw@mail.gmail.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <e8603b0c-86db-c258-179a-f228c43ebf0b@huawei.com>
Date: Mon, 11 Nov 2024 16:39:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWw04Qi+3=y7M4uMrhgrFWpnF7mZ09yb4v0P0qFT1Gfnw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/11/10 0:10, Ian Rogers wrote:
> On Sat, Nov 9, 2024 at 2:54 AM Yicong Yang <yangyicong@huawei.com> wrote:
>>
>> Hi,
>>
>> On 2024/11/8 0:20, Ian Rogers wrote:
>>> Move pmu_metrics_table__find to the jevents.py generated pmu-events.c
>>> and remove indirection override for ARM. The movement removes
>>> perf_pmu__find_metrics_table that exists to enable the ARM
>>> override. The ARM override isn't necessary as just the CPUID, not PMU,
>>> is used in the metric table lookup. On non-ARM the CPU argument is
>>> just ignored for the CPUID, for ARM -1 is passed so that the CPUID for
>>> the first logical CPU is read.
>>
>> Since the logic here's already been touching, is it possible to step it further to just
>> ignore the CPUID matching when finding the system metrics/events tables? It's may not be
>> that reasonable for finding a system metrics/events from the CPUID, since one system PMU may
>> exists on different platforms with different CPU types.
> 
> The issue is for conciseness reasons we let metrics and metric
> thresholds refer to other metrics, for example:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json#n78
> ```
>     {
>         "BriefDescription": "This category represents fraction of
> slots where no uops are being delivered due to a lack of required
> resources for accepting new uops in the Backend",
>         "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5
> * cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=1\\,edge@ / tma_info_slots",
>         "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
>         "MetricName": "tma_backend_bound",
>         "MetricThreshold": "tma_backend_bound > 0.2",
>         "MetricgroupNoGroup": "TopdownL1",
>         "PublicDescription": "This category represents fraction of
> slots where no uops are being delivered due to a lack of required
> resources for accepting new uops in the Backend. Backend is the
> portion of the processor core where the out-of-order scheduler
> dispatches ready uops into their respective execution units; and once
> completed these uops get retired according to program order. For
> example; stalls due to data-cache misses or stalls due to the divider
> unit being overloaded are both categorized under Backend Bound.
> Backend Bound is further divided into two main categories: Memory
> Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>         "ScaleUnit": "100%"
>     },
> ```
> 
> The system metrics were added on top of this and we never rethought
> the design. For a metric to refer to another metric there needs to be
> some kind of place we look up from and for that we use the CPUID
> associated table. Perhaps the easiest thing is that if no CPUID table
> is matched we have an empty table.
> 

thanks for the clarificaiton. ok then it's different from my problem and I
shouldn't have mixed them up.

Thanks.
