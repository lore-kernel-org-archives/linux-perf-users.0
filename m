Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAF1FA178;
	Fri, 25 Apr 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579228; cv=none; b=q8/bXhseSJFxMgY/Ug76BccwEhqt0olZA3kplD1UU3m7T4QM2n/RDnkB+4CexVvkjHprnWdLnlTHI7g4Ju5+QX18/Mqfte9kAYg1UMjCQ5UEPLUl32sksxMS7vIHcE1NJ1vO7fOkfsgp45ASy0tKhoXVgeaTDKScl5G0PatqpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579228; c=relaxed/simple;
	bh=TQxxHPxVPG60Du/u0mqBRKexL0FyDvxwJCebfpvyI/Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnHXw3iLz2X+hayPK0AcGnxn62LOdG8H80xRdHxo2lKMf/rLAOx9a+LPJgeUX9nGaaWGbbeQhVetMnLEPNo9zgFO/Bpu6PdYPWuHPYnDF2Iw+z9oV1aFU7DdgN5PuqPU3duo4FAD6NhuD2HUT887KjzljRG1gxZZ5Mhoi1NsY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZkVKj39nWz6K9Hm;
	Fri, 25 Apr 2025 19:02:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 067ED1400D7;
	Fri, 25 Apr 2025 19:06:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Apr
 2025 13:06:56 +0200
Date: Fri, 25 Apr 2025 12:06:54 +0100
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
Subject: Re: [PATCH v2 1/3] perf vendor events arm64: Fill up Desc field for
 Hisi hip08 hha pmu
Message-ID: <20250425120654.00007e4c@huawei.com>
In-Reply-To: <20250418070812.3771441-2-hejunhao3@huawei.com>
References: <20250418070812.3771441-1-hejunhao3@huawei.com>
	<20250418070812.3771441-2-hejunhao3@huawei.com>
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

On Fri, 18 Apr 2025 15:08:10 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> In the same PMU, when some JSON events have the "BriefDescription" field
> populated while others do not, the cmp_sevent() function will split these
> two types of events into separate groups. As a result, when using perf
> list to display events, the two types of events cannot be grouped together
> in the output.
> 
> before patch:
>  $ perf list pmu
>  ...
>  uncore hha:
>    hisi_sccl1_hha2/sdir-hit/
>    hisi_sccl1_hha2/sdir-lookup/
>  ...
>  uncore hha:
>    edir-hit
>       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
>  ...
> 
> after patch:
>  $ perf list pmu
>  ...
>  uncore hha:
>    edir-hit
>       [Count of The number of HHA E-Dir hit operations. Unit: hisi_sccl1_hha2]
>    sdir-hit
>       [Count of The number of HHA S-Dir hit operations. Unit: hisi_sccl1_hha2]
>    sdir-lookup
>       [Count of the number of HHA S-Dir lookup operations. Unit: hisi_sccl1_hha2]
>  ...
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Reviewed-by: James Clark <james.clark@linaro.org>
One trivial comment inline that might be good to tidy up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>     {
>  	    "ConfigCode": "0x38",
>  	    "EventName": "rx_snprspdata",
> +	    "BriefDescription": "Count of the number of SnprspData flit operations that HHA has received",

Not SnpRspData?  For Snoop Response Data flit ?


>  	    "Unit": "hisi_sccl,hha"
>     },
>     {
>  	    "ConfigCode": "0x3c",
>  	    "EventName": "rx_snprsp_outer",
> +	    "BriefDescription": "Count of the number of SnprspData operations that HHA has received from another socket",

Similar on the capitalization.

>  	    "Unit": "hisi_sccl,hha"
>     },


