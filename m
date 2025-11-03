Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199A27EC7C;
	Mon,  3 Nov 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180272; cv=none; b=TvIz9jsuaK6PHgUElAVEt9wY7fJE8M4P9HjfuVllDcfCXqZSqUMWqJqn73u/EbMIrF3cmiKegIVD8RUzAfQY2pf4/TE24FfDTC24x4NqYrkycUchsxnV+lePO654G3Gz2r8uVYNfZuGiM1Y3iAwoKZr4s7QAxEDLl61i6+Urhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180272; c=relaxed/simple;
	bh=s5mGY2hJlehqy9L4juCXHyC5hvvTQy2D2clApxv+kos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O14zvMFNEhwdbERRn9aX89n2bfWw9/lmVue3DMPydL2F0moAJ7WTxuKO1Jur0d6n9sH9/7d9E6jSVI5sJAvmOTLXDrVgFhEOO7ObZA0cYvml+Vlbj6DkhPjD27/fILFktIZRhGP8dbOGQfn93Sc6aonfyryeO+Ka0GvLaIQc+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRyxR9At; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRyxR9At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4B2C4CEE7;
	Mon,  3 Nov 2025 14:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762180271;
	bh=s5mGY2hJlehqy9L4juCXHyC5hvvTQy2D2clApxv+kos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRyxR9AtU8LB5uO5mPIUStqZ2gK47Cih9yqBxGo0WaoNe4WcQ2pp440PncVgN3Zmq
	 AIVF4XbvcczvPP7ZRexr5K+3DtxNWyOlIuaB0BmtDHYLFaEMvLQ+Sf8d5biA0B396p
	 RNJIJ2qfEiKVpakKEOuqQLJ55IngPgJcIoIVccBWrfP7RhjhcJIX9IeTFKqJnY3E89
	 HQBmIJGYdXV00RYiRPPP/r7xScsWeCgh/eno8CH4dKzUTNFx3Mwh55szuZKnL6YOLR
	 aCmbpmhJiQ69oY0lUZE/jaO4Q8Jqa6tg/T6z/2svECVynbfBVCH/Kn5yQb3tpF3Sw7
	 t6gTMp7QkdraQ==
Date: Mon, 3 Nov 2025 14:31:05 +0000
From: Will Deacon <will@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH v2 4/6] perf/imx_ddr: Add support for PMU in DB (system
 interconnects)
Message-ID: <aQi8qUzLHypULQJP@willie-the-truck>
References: <20251024-qm_dts-v2-0-7a7e07022ed6@nxp.com>
 <20251024-qm_dts-v2-4-7a7e07022ed6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-qm_dts-v2-4-7a7e07022ed6@nxp.com>

On Fri, Oct 24, 2025 at 02:17:14PM -0400, Frank Li wrote:
> From: Joakim Zhang <qiangqing.zhang@nxp.com>
> 
> There is a PMU in DB, which has the same function with PMU in DDR
> subsystem, the difference is PMU in DB only supports cycles, axid-read,
> axid-write events.
> 
> e.g.
> perf stat -a -e imx8_db0/axid-read,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd
> perf stat -a -e imx8_db0/axid-write,axi_mask=0xMMMM,axi_id=0xDDDD,axi_port=0xPP,axi_channel=0xH/ cmd
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 65 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 2a8426a74af98cf46725c2c70534829e198746f3..328287ab6326e3832aed85633957196548435d67 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -53,18 +53,27 @@
>  #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
>  
>  #define DDR_PERF_DEV_NAME	"imx8_ddr"
> +#define DB_PERF_DEV_NAME	"imx8_db"
>  #define DDR_CPUHP_CB_NAME	DDR_PERF_DEV_NAME "_perf_pmu"
>  
>  static DEFINE_IDA(ddr_ida);
> +static DEFINE_IDA(db_ida);
>  
>  /* DDR Perf hardware feature */
>  #define DDR_CAP_AXI_ID_FILTER			0x1     /* support AXI ID filter */
>  #define DDR_CAP_AXI_ID_FILTER_ENHANCED		0x3     /* support enhanced AXI ID filter */
>  #define DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER	0x4	/* support AXI ID PORT CHANNEL filter */
>  
> +/* Perf type */
> +enum fsl_ddr_type {
> +	DDR_PERF_TYPE = 0,	/* ddr Perf (default) */
> +	DB_PERF_TYPE,		/* db Perf */
> +};
> +
>  struct fsl_ddr_devtype_data {
>  	unsigned int quirks;    /* quirks needed for different DDR Perf core */
>  	const char *identifier;	/* system PMU identifier for userspace */
> +	enum fsl_ddr_type type;	/* types of Perf, ddr or db */
>  };
>  
>  static const struct fsl_ddr_devtype_data imx8_devtype_data;
> @@ -98,6 +107,12 @@ static const struct fsl_ddr_devtype_data imx8dxl_devtype_data = {
>  	.identifier = "i.MX8DXL",
>  };
>  
> +static const struct fsl_ddr_devtype_data imx8dxl_db_devtype_data = {
> +	.quirks = DDR_CAP_AXI_ID_PORT_CHANNEL_FILTER,
> +	.identifier = "i.MX8DXL",

Is this identifier useful given that you don't add
'ddr_perf_identifier_attrs' here:

> +static const struct attribute_group *db_attr_groups[] = {
> +	&db_perf_events_attr_group,
> +	&ddr_perf_format_attr_group,
> +	&ddr_perf_cpumask_attr_group,
> +	&ddr_perf_filter_cap_attr_group,
> +	NULL,
> +};

?

Perhaps it would be better if you avoided adding a new array of attribute
groups and instead implemented the '.is_visible' callback for
'ddr_perf_events_attr_group'? That way, you avoid the duplication and
you can hide everything except for the three events you want in the DB
PMU.

Will
