Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE61A2645;
	Mon, 30 Sep 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727730473; cv=none; b=DRAI95Yr/9x1QLxl2Gg5pc5nZ4KTXdRgJcmiXJfSZiO9HHlFz1qe1rJyqoJebAvcppLiGefKm0zlcyv7C6RDpKWWPP0NvnrK80NvGcAurEOJM0cOvwXzlw4ZW34ePboEoZLdaJubtMNo8coi0B65YFIwu4S+SfwKnWdr0tix4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727730473; c=relaxed/simple;
	bh=zZeMuXBLeHDf5XqrUgWrWOJr0y1aMxOQuR7+3GzMwbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMkTkqcrInep62rHQTW6VxHGRyNniTHFujJ9ZtBbtMwdpjDy8rPS5kHlKJ0UEm4yscm/oGYBLw1ezt38iV2VaDN1HZ6Pcghs3JZJlai8aT5KA1PwfluJF4EjEchzwpntWYP5EIbaL1CwxKBWBm6YjZzjFC2isaNzCjBNpr67ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2EEOkYm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2EEOkYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B57C4CECD;
	Mon, 30 Sep 2024 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727730473;
	bh=zZeMuXBLeHDf5XqrUgWrWOJr0y1aMxOQuR7+3GzMwbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2EEOkYmncI75goVlm0hl/uPCM040t6HYey+pUFxslwIBl1CReOSY48R5mnqZJ7xr
	 XQeJZakrvmibPCpi/jXkSh6xboYECIcVla2aA0gUhCoYXt60xJOf1urrTGnXCCd2f3
	 kJbZQaxA8H9L2zpUQBWo2l3v0KHhKH9yobQsFpnmmvXBXOo27eqo2F2JaO8eJMovq3
	 J8wjfYacU7cNtE+pv+SfFF4cIjydoUMY6p5pwHtzR6gqWNwP/aXK5AYDj06iuCHgrM
	 PYyKUZXwqD019VcSll3yziLSb6Npq/kZo61sf9XtzcN4QfSIy4j1hXnIv4GArwww0p
	 yl772TLlGczXA==
Date: Mon, 30 Sep 2024 14:07:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, james.clark@linaro.org,
	mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
	mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf vendor events arm64: Add i.MX91 DDR Performance
 Monitor metrics
Message-ID: <ZvsTJ47yHFUjo1uw@google.com>
References: <20240924061251.3387850-1-xu.yang_2@nxp.com>
 <20240924061251.3387850-3-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924061251.3387850-3-xu.yang_2@nxp.com>

Hello,

On Tue, Sep 24, 2024 at 02:12:51PM +0800, Xu Yang wrote:
> Add JSON metrics for i.MX91 DDR Performance Monitor.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  .../arch/arm64/freescale/imx91/sys/ddrc.json  |  9 +++++++
>  .../arm64/freescale/imx91/sys/metrics.json    | 26 +++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json

How do you want to route this?  As it's mixed with kernel changes, I
would generally request to split but it's a change just to add new
files so it should be ok to go with other tree.  In that case,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> new file mode 100644
> index 000000000000..74ac12660a29
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx91_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx91"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> new file mode 100644
> index 000000000000..f0c5911eb2d0
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
> @@ -0,0 +1,26 @@
> +[
> +   {
> +	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
> +	    "MetricName": "imx91_bandwidth_usage.lpddr4",
> +	    "MetricExpr": "(((( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8 ) + (( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32 )) / duration_time) / (2400 * 1000000 * 2)",
> +	    "ScaleUnit": "1e2%",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx91"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters read from ddr",
> +	    "MetricName": "imx91_ddr_read.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_0@ ) * 2 * 8",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx91"
> +   },
> +   {
> +	    "BriefDescription": "bytes all masters write to ddr",
> +	    "MetricName": "imx91_ddr_write.all",
> +	    "MetricExpr": "( imx9_ddr0@ddrc_pm_3@ + imx9_ddr0@ddrc_pm_5@ + imx9_ddr0@ddrc_pm_7@ + imx9_ddr0@ddrc_pm_9@ - imx9_ddr0@ddrc_pm_2@ - imx9_ddr0@ddrc_pm_4@ - imx9_ddr0@ddrc_pm_6@ - imx9_ddr0@ddrc_pm_8@ ) * 32",
> +	    "ScaleUnit": "9.765625e-4KB",
> +	    "Unit": "imx9_ddr",
> +	    "Compat": "imx91"
> +   }
> +]
> -- 
> 2.34.1
> 
