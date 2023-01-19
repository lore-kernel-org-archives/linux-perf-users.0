Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906AC004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 15:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjASP5C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 10:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASP5B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 10:57:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EF323A9D;
        Thu, 19 Jan 2023 07:57:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF4691758;
        Thu, 19 Jan 2023 07:57:41 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D947E3F445;
        Thu, 19 Jan 2023 07:56:56 -0800 (PST)
Message-ID: <fb6564d3-c3a2-08c1-32c5-79ba22c69200@arm.com>
Date:   Thu, 19 Jan 2023 15:56:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/8] perf cs_etm: Record ts_source in AUXTRACE_INFO for
 ETMv4 and ETE
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230119154308.3815108-1-james.clark@arm.com>
 <20230119154308.3815108-7-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230119154308.3815108-7-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 19/01/2023 15:43, James Clark wrote:
> From: German Gomez <german.gomez@arm.com>
> 
> Read the value of ts_source exposed by the driver and store it in the
> ETMv4 and ETE header. If the interface doesn't exist (such as in older
> Kernels), defaults to a safe value of -1.

Super minor nits feel free to ignore.

> 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   tools/perf/arch/arm/util/cs-etm.c | 48 +++++++++++++++++++++++++++++++
>   tools/perf/util/cs-etm-base.c     |  2 ++
>   tools/perf/util/cs-etm.h          |  2 ++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b526ffe550a5..481e170cd3f1 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -53,6 +53,7 @@ static const char * const metadata_etmv4_ro[] = {
>   	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
>   	[CS_ETMV4_TRCIDR8]		= "trcidr/trcidr8",
>   	[CS_ETMV4_TRCAUTHSTATUS]	= "mgmt/trcauthstatus",
> +	[CS_ETMV4_TS_SOURCE]		= "ts_source",
>   };
>   
>   static const char * const metadata_ete_ro[] = {
> @@ -62,6 +63,7 @@ static const char * const metadata_ete_ro[] = {
>   	[CS_ETE_TRCIDR8]		= "trcidr/trcidr8",
>   	[CS_ETE_TRCAUTHSTATUS]		= "mgmt/trcauthstatus",
>   	[CS_ETE_TRCDEVARCH]		= "mgmt/trcdevarch",
> +	[CS_ETE_TS_SOURCE]		= "ts_source",
>   };
>   
>   static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> @@ -613,6 +615,32 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>   	return val;
>   }
>   
> +static int cs_etm_get_ro_signed(struct perf_pmu *pmu, int cpu, const char *path)

minor nit: This doesn't necessarily care if it is RO ?
Also, does it make sense to rename to include cpu relation :

say,  cs_etm_pmu_cpu_get_signed() ?

> +{
> +	char pmu_path[PATH_MAX];
> +	int scan;
> +	int val = 0;
> +
> +	/* Get RO metadata from sysfs */
> +	snprintf(pmu_path, PATH_MAX, "cpu%d/%s", cpu, path);
> +
> +	scan = perf_pmu__scan_file(pmu, pmu_path, "%d", &val);
> +	if (scan != 1)
> +		pr_err("%s: error reading: %s\n", __func__, pmu_path);
> +
> +	return val;
> +}
> +
> +static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, int cpu, const char *path)

nit: cs_etm_pmu_cpu_path_exists() ? To make the "cpu" relation explicit ?

Otherwise looks good to me.

Suzuki

