Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71AC4D8CE;
	Wed, 21 Aug 2024 01:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724204363; cv=none; b=rmgkHzIZJJzYtsk3dLXpbSQWUxIPgaCA50YlAwKIOXQugE13kypowKt0fAJ3iKYXZ/VxEnPtuePAZO86ySZ5nzK1M7IBOaJFJRTX9tI/XGNRxOtOFu0+xDngD9x8ipVaaqhfP1qeko3WCBhd+1R91kPcw5KXnq0tQrJGQ1UmcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724204363; c=relaxed/simple;
	bh=UJHalFk+nApOOHUpDeWowIIoi4cZRSx8rCxcwx6QPh8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=C86R/N4E3D5y6piosvIi27VaMWKtl9VlnovOc5zIMLOMnB2QPno31zozKZsIVdWr/OqV0m3yGQUR4tXTF3dRAmp9iAnkpUk06LvrujpOs+2SFLyhYInaPKsgqPHLC3kMSPDl2OFKqVn1o46jBXeLZnLS9uFHBMfpXixza7F4ux4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WpTWM3kCQz13jPS;
	Wed, 21 Aug 2024 09:38:39 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id F398B1401F4;
	Wed, 21 Aug 2024 09:39:17 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 09:39:17 +0800
Subject: Re: [PATCH 1/1] uprobe: fix comment of uprobe_apply()
To: Oleg Nesterov <oleg@redhat.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang
 Kan <kan.liang@linux.intel.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240820135232.1913-1-thunder.leizhen@huawei.com>
 <20240820143001.GC12400@redhat.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <01c48cd3-9675-8350-217b-039a6812a2e8@huawei.com>
Date: Wed, 21 Aug 2024 09:39:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820143001.GC12400@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/8/20 22:30, Oleg Nesterov wrote:
> On 08/20, Zhen Lei wrote:
>>
>> Depending on the argument 'add', uprobe_apply() may be registering or
>> unregistering a probe.
> 
> ...
> 
>>  /*
>> - * uprobe_apply - unregister an already registered probe.
>> - * @inode: the file in which the probe has to be removed.
>> + * uprobe_apply - register a probe or unregister an already registered probe.
> 
> Not really.
> 
> See the commit 3c83a9ad0295eb63bd ("uprobes: make uprobe_register() return struct uprobe *")
> in tip/perf/core which changed this description
> 
> 	* uprobe_apply - add or remove the breakpoints according to @uc->filter
> 
> still looks confusing, yes...

OK, I got it. I mistakenly thought the comment was based on register_for_each_vma.
It seems necessary to rename 'register_for_each_vma' to 'apply_for_each_vma',
or some other more appropriate name.

> 
> Oleg.
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei
