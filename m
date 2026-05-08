Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A638551D;
	Fri,  8 May 2026 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236544; cv=none; b=p0o7zBFqHIxdEJ1jzykQi68FJfEBueGO7oltCYF4IKTbcTi2ka/Qbq4q7dmRjC5UMfIJYFEnjo7ElFSGEUGKS3J1MEaXrwvyfHnOfEa5dA8nhtXc4Fko01CaOIy9/bQm1hW0qIjh/wK7DAyKa/8WL+yVUt8zvkMJBaUPwXHHuJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236544; c=relaxed/simple;
	bh=ISHrh37ZNX1+9L9LNPxqVYIIFEZ+t1IARFN8cjaMQmM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=RU/nL+cDWJI6mSKSS2B9mY9R9Szx/OZSkIM1w0gU74Yo8Wc/7gki3Cn/fuLx/QP2zuxrk8MX75FgkV016+vUGQzX2TaAvFkZNlZII96v9xmozaNUbJ8p5vQt+niwa7fEQywd/afFVlxRogdM8ngkh+gfzotQzDGvKTH8ReMxTCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mOxln/Cm; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mOxln/Cm"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ISHrh37ZNX1+9L9LNPxqVYIIFEZ+t1IARFN8cjaMQmM=;
	b=mOxln/Cmact+jhCpY+ikLo1lMYkDrsvQuKbvLsmiJPMRsBYutC7/ot9bqZkF2NQxYzmOUuAsA
	pNMCkNu6kpC+2V0KsTbpzdLEl908mMIGuAwmW+O3NouIQPPanIRwXkRkaoRe8UlzIlOY5BiajjV
	yZgUIpNYxmmqdz2jPX3t+/Y=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gBlgp5WsvzLlSC;
	Fri,  8 May 2026 18:28:06 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD934055B;
	Fri,  8 May 2026 18:35:40 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 18:35:40 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 18:35:38 +0800
Message-ID: <51c6ea87-7812-4be2-ae1d-0fca29973623@huawei.com>
Date: Fri, 8 May 2026 18:35:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yushan Wang <wangyushan12@huawei.com>
Subject: Re: [RFT PATCH v2 4/7] perf-x86: iostat: Change iostat_prefix() to
 static
To: Ian Rogers <irogers@google.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <james.clark@arm.com>, <john.g.garry@oracle.com>,
	<will@kernel.org>, <mike.leach@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<jic23@kernel.org>, <leo.yan@linux.dev>, <robin.murphy@arm.com>,
	<linuxarm@huawei.com>, <hejunhao3@huawei.com>, <prime.zeng@hisilicon.com>,
	<fanghao11@huawei.com>, <wangzhou1@hisilicon.com>
References: <20260507063737.3542950-1-wangyushan12@huawei.com>
 <20260507063737.3542950-5-wangyushan12@huawei.com>
 <CAP-5=fUVf-6Xcd+xQBm9FbwbWsUff0PYuH54mrBkLeVyU2cj8Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fUVf-6Xcd+xQBm9FbwbWsUff0PYuH54mrBkLeVyU2cj8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100008.china.huawei.com (7.202.194.111)

On 5/7/2026 11:39 PM, Ian Rogers wrote:
> On Wed, May 6, 2026 at 11:37 PM Yushan Wang <wangyushan12@huawei.com> wrote:
>>
>> Change iostat_prefix() to static function, since it is not used outside.
>>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
>> ---
>>  tools/perf/util/iostat.c     |  7 ------
>>  tools/perf/util/iostat.h     |  2 --
>>  tools/perf/util/x86-iostat.c | 44 ++++++++++++++++++------------------
>>  3 files changed, 22 insertions(+), 31 deletions(-)
>>
>> diff --git a/tools/perf/util/iostat.c b/tools/perf/util/iostat.c
>> index b770bd473af7..a68ab100780d 100644
>> --- a/tools/perf/util/iostat.c
>> +++ b/tools/perf/util/iostat.c
>> @@ -37,13 +37,6 @@ __weak void iostat_print_metric(struct perf_stat_config *config __maybe_unused,
>>  {
>>  }
>>
>> -__weak void iostat_prefix(struct evlist *evlist __maybe_unused,
>> -                         struct perf_stat_config *config __maybe_unused,
>> -                         char *prefix __maybe_unused,
>> -                         struct timespec *ts __maybe_unused)
>> -{
>> -}
>> -
>>  __weak void iostat_print_counters(struct evlist *evlist __maybe_unused,
>>                                   struct perf_stat_config *config __maybe_unused,
>>                                   struct timespec *ts __maybe_unused,
>
> This change doesn't remove the weak symbols, but they should go. We
> should use the ELF machine to determine which architecture version to
> use.

The weak symbols are removed in patch 6. Reserving them here keeps this patch
from failing perf build :)

Thanks,
Yushan

>
> Thanks,
> Ian
>

[...]

