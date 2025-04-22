Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63CC1D9A70;
	Tue, 22 Apr 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306161; cv=none; b=ZC7618TI0fYi4znBQR/m35UdTDiodnFCwBwfFjLd+IeMcl6DugYc6QFLSoQxHsu1ZyytpBCOUXRjKWhNsmhyC9cEQh3N9gqd+q3pkvakaq0Tb3UIsu6PqG7GOtKO5kdUJ/+rtuBmdz0io79LQ7LC9MFFi940UaafIsEShxQbnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306161; c=relaxed/simple;
	bh=Uo57kmQSEs0NnxladP19sdAIEQXVG8c6++8pHMFxUog=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GEU4Yx8INERCEmceWZAXbcKIFwBNsYFF+fsmDeqrB22FH37dSeAsPp8VQQOe0a9xaaFok5mYR6KZSl4hBkkoyCCiAqbL7+DJ4q/ASd3QqyBcVWJt3Dip8ds3IbFHQplN/7KJ1Czkxt5BGg58iAtnan00SwNJu7+CI0SLArUccA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZhYMq1Pgcz2CdX1;
	Tue, 22 Apr 2025 15:12:23 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 11B3A1800B1;
	Tue, 22 Apr 2025 15:15:52 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 22 Apr 2025 15:15:51 +0800
CC: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Add hisilicon pmu json events under
 its entry
To: Junhao He <hejunhao3@huawei.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <acme@kernel.org>, <namhyung@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>,
	<leo.yan@arm.com>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<mike.leach@linaro.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
 <20250418070812.3771441-4-hejunhao3@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <e5f55b03-8026-3042-6ce9-586b7f1dad2f@huawei.com>
Date: Tue, 22 Apr 2025 15:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250418070812.3771441-4-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/4/18 15:08, Junhao He wrote:
> The all hisilicon pmu json events were missing to be listed there.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: James Clark <james.clark@linaro.org>

Acked-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00ff21b955bc..bf9588a94919 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10474,6 +10474,7 @@ W:	http://www.hisilicon.com
>  F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
>  F:	Documentation/admin-guide/perf/hisi-pmu.rst
>  F:	drivers/perf/hisilicon
> +F:	tools/perf/pmu-events/arch/arm64/hisilicon/
>  
>  HISILICON PTT DRIVER
>  M:	Yicong Yang <yangyicong@hisilicon.com>
> 
