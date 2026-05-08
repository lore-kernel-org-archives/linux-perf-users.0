Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7526837F00C;
	Fri,  8 May 2026 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236452; cv=none; b=hVrm6ONpiGyf3MXVM8KFF0eZ09hCtZg5A9OM7bpa6yDDnqqYsjdDW/G4WRU+1nPDQnWIzfDcr8GHz9LandVFK996KRpiY7AemjfT/zPDNAi2bHM/I3RaE/FS56Mx56BjncOZuMQ0pAiqAmizgueHnrnvtoN/DgR1G5+TkVssSd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236452; c=relaxed/simple;
	bh=7JdWRHx/+mjb4lk/bEZQh+lQq/Mn7dxl20NhPE4u0a8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=idjI/NieNDCZ5kK9DwfWOniKQ82LkQoZ3lf8DGm/fTqr7Hh5xzDjpxyDMnVygvEWydlvRgcOlwr5EiorVA4YijJR5jh5O4RWgKsRJ4CRhvYBIKS3iCrxIU3Ib65X4bI1HSrphH4TSlLWFKr2kREok0Ytr5codQBf1LXgb4W0dN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yL728+Gj; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yL728+Gj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7JdWRHx/+mjb4lk/bEZQh+lQq/Mn7dxl20NhPE4u0a8=;
	b=yL728+GjveI/7wInsJjt/gcfZQk2qXvQqxMjMWoY+uOU8Y9XpIuypecPeH6DdVnEsq9gXyEby
	NuYxevfHDp+EciXq6PeegBkkJ6U8RFwG+M1u4miK2SlSOWAy44HFaSb9agtEv6AtCBVbURVLVba
	LUwwnGgBUuTX3Ne5Lhvu5Iw=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gBlf04XNVzLlX9;
	Fri,  8 May 2026 18:26:32 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A53940562;
	Fri,  8 May 2026 18:34:06 +0800 (CST)
Received: from kwepemn100008.china.huawei.com (7.202.194.111) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 8 May 2026 18:34:06 +0800
Received: from [10.67.120.139] (10.67.120.139) by
 kwepemn100008.china.huawei.com (7.202.194.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 8 May 2026 18:34:04 +0800
Message-ID: <4d7b9ce3-15e4-414b-87cf-85a6338b69ab@huawei.com>
Date: Fri, 8 May 2026 18:34:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yushan Wang <wangyushan12@huawei.com>
Subject: Re: [RFT PATCH v2 3/7] perf-x86: iostat: Move iostat arch-specific
 implementation to util
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
 <20260507063737.3542950-4-wangyushan12@huawei.com>
 <CAP-5=fV5WiyB3mghvns1ZW6ewS0=CP4nx+f_ggLgECkqv7VWww@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP-5=fV5WiyB3mghvns1ZW6ewS0=CP4nx+f_ggLgECkqv7VWww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemn100008.china.huawei.com (7.202.194.111)

 On 5/7/2026 11:35 PM, Ian Rogers wrote:
> On Wed, May 6, 2026 at 11:37 PM Yushan Wang <wangyushan12@huawei.com> wrote:
>>
>> To support cross-platform iostat capabilities, like record/report on
>> different platforms, architecture-specific implementation of iostat
>> should be moved out of arch directory to get built. Build scripts are
>> changed accordingly.
>>
>> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>
>> ---
>>  tools/perf/arch/x86/util/Build                           | 1 -
>>  tools/perf/util/Build                                    | 1 +
>>  tools/perf/{arch/x86/util/iostat.c => util/x86-iostat.c} | 0
>>  3 files changed, 1 insertion(+), 1 deletion(-)
>>  rename tools/perf/{arch/x86/util/iostat.c => util/x86-iostat.c} (100%)
>
> To avoid cluttering up tools/perf/util, would it make sense to create
> a "tools/perf/util/iostat-arch" directory similar to  annotate-arch,
> dwarf-regs-arch, kvm-stat-arch and perf-regs-arch?
>
> Thanks,
> Ian

Yes, I can do that in the next version.

In fact, as what latter comments addressed, I think merging these iostat
handlers into one source file to avoid redundancy may be better.

Thanks,
Yushan

>
