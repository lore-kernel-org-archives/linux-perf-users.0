Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B63563EB;
	Fri,  4 Sep 2026 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489937; cv=none; b=Zx37Y2gv1eEO+OvQNDcSHyPZDssaKfpx05ErLYbEbRA2fEsgzl0B56DrEv6yc7RQaeMJxY8G3T914TjrNlYtsRb6hi0HhQ8W6y1YJdLsMhiCcj8KC4PE00uLBjLHHk1STwUIqTvHtlY2CmxyTdig2RHj3y3e7kNrFiLGLRNUzdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489937; c=relaxed/simple;
	bh=svFL5GVsyMxjyZIfVZFUtOkSOeDAIlVTUrJgAyi3XSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xsxh4Im8jhHFIAISgVGvYH1z3bLElq1tVPBAUTV/VmhyGpvSBCrthmtjCXmh3+t/ljY1jzhSDmz7rIiYPMDdJ9lmspkVM7wa0we0e/9RbD+aKgsABFDvC3Dvoukglx3xe6Tv0VZLEgvolx3aP1TftANMOtLDFKrLPpr108Xi2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cINy1kgF; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cINy1kgF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=svFL5GVsyMxjyZIfVZFUtOkSOeDAIlVTUrJgAyi3XSk=;
	b=cINy1kgFclwLdhJA3KbeBlH1oUeCPoLQa8e/26fjaRkyyiDD2TOnlfdkf6We6uYk4b6fV6AC9
	n6/JPCwwZa0Gxdh72Ayfj8EX49k2wnXcSM4NG5FbTbIh2awM3Rh598vgapeiOnJoEE4Vlr6ImR8
	ajTzc6Un2pGtwVwidjVZTcQ=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hbgXS4jZgzLlXF;
	Fri,  4 Sep 2026 10:34:32 +0800 (CST)
Received: from kwepemo100012.china.huawei.com (unknown [7.202.195.139])
	by mail.maildlp.com (Postfix) with ESMTPS id B080840578;
	Fri,  4 Sep 2026 10:45:23 +0800 (CST)
Received: from [10.67.120.222] (10.67.120.222) by
 kwepemo100012.china.huawei.com (7.202.195.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 4 Sep 2026 10:45:22 +0800
Message-ID: <4f755a7f-0a55-4292-892a-28346ed235a4@huawei.com>
Date: Fri, 4 Sep 2026 10:45:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] perf/core: sched_task() dispatch and branch entry
 fixes
To: Puranjay Mohan <puranjay@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, Usama Arif <usama.arif@linux.dev>, Will
 Deacon <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Ravi
 Bangoria <ravi.bangoria@amd.com>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260810133540.1947118-1-puranjay@kernel.org>
From: wuyifan <wuyifan50@huawei.com>
In-Reply-To: <20260810133540.1947118-1-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo100012.china.huawei.com (7.202.195.139)

Hi Puranjay,

On 8/10/2026 9:35 PM, Puranjay Mohan wrote:
> These three fixes were found while adding BRBE support for
> bpf_get_branch_snapshot() on arm64 and were carried in that series until
> v6 [1]. They do not depend on it, so they go on their own; the version
> number continues from that series to avoid two numbering schemes for the
> same patches.
perf record -C <cpu> -b [<command>] triggers a NULL pointer dereference
in armv8pmu_sched_task().

Commit fa9d27773873 ("perf: arm_pmu: Kill last use of per-CPU cpu_armpmu
pointer") changed armv8pmu_sched_task() from reading the per-CPU
cpu_armpmu variable to dereferencing pmu_ctx->pmu via
to_arm_pmu(pmu_ctx->pmu). Meanwhile, commit bd2756811766 ("perf:
Rewrite core context handling") made __perf_pmu_sched_task() pass
cpc->task_epc to pmu->sched_task(). cpc->task_epc is only non-NULL
while a task context is scheduled in; CPU-bound events do not schedule a
task context, so cpc->task_epc stays NULL. The NULL argument is dereferenced
and crashes.

With the patches applied, perf record -C <cpu> -b no longer crashes,
and system-wide perf record -b -e <event> -a alongside a task-bound event
on a different CPU runs without any WARN_ON.

Tested-by: Yifan Wu <wuyifan50@huawei.com>

