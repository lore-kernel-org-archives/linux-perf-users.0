Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AD222576;
	Fri, 25 Apr 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579339; cv=none; b=jzbPZwrcERrGo+/6XnrEPtPIlW2lQGjqOmi0YdaHsGvwNF93FLhiElTZIIzduiu2rMbbhfl9JSya84e+exKcLKWi1VA4zhhLn7SvF0HUSNxSTt6RlYMGz0TD/LUR3nE6Q4JDnzpDz4NxlIh/c64y+0Yp85ezZkesKcHpvuB5+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579339; c=relaxed/simple;
	bh=4uGWhOtggHYTB4yOFRQQ7tVVD0P1Ci/Mn25V+RGGLFM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzwP7H2sDvENNFB2o466aK7m2U36hQeEkrkaU5sh0EAHPWvTkDeqJKKRKX31lQruynkmV8BPAFh+lnGKvl3oNFk5ZJlFKoarECKVJeAc9nZyJQCBQLUx8x2pKQIaCA8TIiuzM/Q12jJX0aKHHyw97ApjIrAF7q7nu8Z0FTnfNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZkVRF3JcRz6L4vT;
	Fri, 25 Apr 2025 19:07:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F41C11404F5;
	Fri, 25 Apr 2025 19:08:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 13:08:54 +0200
Date: Fri, 25 Apr 2025 12:08:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Junhao He <hejunhao3@huawei.com>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <james.clark@linaro.org>, <leo.yan@arm.com>,
	<john.g.garry@oracle.com>, <will@kernel.org>, <mike.leach@linaro.org>,
	<yangyicong@hisilicon.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] perf vendor events arm64: Drop hip08
 PublicDescription if same as BriefDescription
Message-ID: <20250425120852.000073a4@huawei.com>
In-Reply-To: <20250418070812.3771441-3-hejunhao3@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
	<20250418070812.3771441-3-hejunhao3@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Apr 2025 15:08:11 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> If BriefDescription and PublicDescription are the same, only
> BriefDescription is needed. It will be used for both long and
> short format outputs.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
