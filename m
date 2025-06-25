Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC86286422;
	Wed, 25 Jun 2025 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842316; cv=none; b=rNml1ngkDfOQsXDhCEqsubY0Ks7XAOeA6GT+EO4ScMUdmxUf9UQp9Rk2xLvICwxmY5lFmMd6Izh4vk9XwTC6mV7/LbRVculkd/Xcgw8OKBDJ+17DO8C3UamRS1Xy+4HG8sSml/f6fApifGXd+enlA4q7vxwGO7+zgy4Ld9J5xOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842316; c=relaxed/simple;
	bh=ENbIt35blLVVdonVJShKKuqn0xG/16BBjS5D+QLQFOw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMo7SfArmpNgvrfovamLMAt12LgdU4m6xhhZ7S5Wic0ZhiOxirLlK9R1svze+oM7O+r5LYV+AHNSYL73JqP+SkeengNnNxfIVYgzPekxdXZiAuXIBtc/4aZ/75Zgfq+tixMM8VDmJT+Oi9axGTZbKZB8HBcYGxLHSSyH/m/5BA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bRwnX4gr3z6GDDB;
	Wed, 25 Jun 2025 17:02:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E8A6914027A;
	Wed, 25 Jun 2025 17:05:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Jun
 2025 11:05:12 +0200
Date: Wed, 25 Jun 2025 10:05:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <linux-cxl@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] perf/cxlpmu: Fix typos in cxl_pmu.c comments and
 documentation
Message-ID: <20250625100510.00005f0b@huawei.com>
In-Reply-To: <20250624194350.109790-4-alok.a.tiwari@oracle.com>
References: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
	<20250624194350.109790-4-alok.a.tiwari@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 12:43:40 -0700
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:

> Fix several minor typo errors in comments:
> - Remove duplicated word "a" in "a a VID / GroupID".
> - Correct "Opcopdes" to "Opcodes" in CXL spec reference.
> - Fix spelling of "implemnted" to "implemented".
> 
> Improves code readability and documentation consistency.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
One day I'll remember to run a spell checker :(

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/perf/cxl_pmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 5a475a5a1f095..d094030220bf2 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -113,7 +113,7 @@ struct cxl_pmu_info {
>  
>  /*
>   * All CPMU counters are discoverable via the Event Capabilities Registers.
> - * Each Event Capability register contains a a VID / GroupID.
> + * Each Event Capability register contains a VID / GroupID.
>   * A counter may then count any combination (by summing) of events in
>   * that group which are in the Supported Events Bitmask.
>   * However, there are some complexities to the scheme.
> @@ -406,7 +406,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
> -	/* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
> +	/* CXL rev 3.1 Table 3-50 S2M NDR Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
> @@ -627,7 +627,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
>  	hwc->state = 0;
>  
>  	/*
> -	 * Currently only hdm filter control is implemnted, this code will
> +	 * Currently only hdm filter control is implemented, this code will
>  	 * want generalizing when more filters are added.
>  	 */
>  	if (info->filter_hdm) {

