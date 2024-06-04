Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50857266A7;
	Tue,  4 Jun 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503752; cv=none; b=EB9MtHGBQKkuXpGEdERN+QubVlnJbh6c6K+rMgTtZqLuDhHSESfBw0uQjdcMZF2M/Blf2Y+XBwu3g2c+JCyoOs8yFPvF/+uha9c86kJ+U17CimcL85A8XeD2/kXnkHqAQ9eyOm3sb9e7qBJPHS/Ts2WISHC4dY5wVSgcGsQS4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503752; c=relaxed/simple;
	bh=AnsQkg7zBLWIzDE3kmS0kW3H/V95QaJyCkrnfA8oOEg=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ismv3XMf+JuA1fqmi1k7YG6s58RMX/suQv15xDn+Ol4Xy4DoOinfjhyvtqOICO5lUm5XBR0k+sK8SGG7pndbOIoqfJjwZkrjYSKimFgO3xnUhXGUb/1l0MQeMQ2WgJGjdHpSENL1x7jFLE2Egr0JhIxn/P82pK4PXfbjy531TQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VtqSb6RV8zckwS;
	Tue,  4 Jun 2024 20:21:03 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BD1E180060;
	Tue,  4 Jun 2024 20:22:27 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 20:22:26 +0800
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
Message-ID: <ed04add4-e9b1-2723-b9f5-e6cd53e6ffb4@huawei.com>
Date: Tue, 4 Jun 2024 20:22:26 +0800
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

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

It should be brought by config_term_pmu() in [1]. If it's a hardware event term
and not found in the PMU's sysfs, we'll make attr->type to PERF_TYPE_HARDWARE.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n1052

Thanks.
