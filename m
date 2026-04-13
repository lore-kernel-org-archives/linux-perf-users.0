Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8C73815DE
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102659; cv=none; b=UmiZmADofAXCTdC/S2pjhX58asVpsVgk0mdJfkJiBTqKJ1de07OdUGYJqXpWgOwgQOw8Uxz1AnXhmFBvemFBmQzEIlMJwdqy/KXktGI1UIaiP2mTHLgFdRmaBOp0qYQlYMsN7D0OKATszMVJTNWpD+ZNKvZ/juqpLgLGXrxgdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102659; c=relaxed/simple;
	bh=FMDQBLMwujNIvI3vTSmo+6CQvvROLWPSWmpRYJ1YCtk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tdJPfnUyk9RZqgL7g9RbmwfLE2All1Ph5llmQTSp9rqOs7LyrQnYwbYXzTDzciKBZZDy7+Lgi9OmyRNc+Je4I65GTN1ZEjyyqIXJZBqXvAqtCE+s5hAlNRu1xhscFVO+UFFAf5Nf9eY7pHWydPjmLl3fSHxxCk3zXHbxjZzsIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOQCg+qR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOQCg+qR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1700C2BCAF;
	Mon, 13 Apr 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776102659;
	bh=FMDQBLMwujNIvI3vTSmo+6CQvvROLWPSWmpRYJ1YCtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LOQCg+qRPsVW4/P/HwC9KnIA/HMRqFBozzgVgLsoJgaBu4J8e+FfopXubsA3UlkUx
	 if1WVQXx4SF1ZkJMVhVeR7ibyMf3KilE+0oIlGeOA+rMAAcSegOrMrvFZ1YAAml9iF
	 87C0+6lC9E9GdDDOwaBE78DgLnoeViZy7SLmN2+PoYeyH9zFxhtXRyyz7/ztN3SVe4
	 5CTQ0NqmJ9OFHLiT3DfUm30QdN0r3utkrEKV1WUNWVOccQRttQbpqWghDoc4gdJy4t
	 jTAuGAOwLEO1TQbdfXwxYsgXtVqk/3e/M2HGPzEn+Lrtcq1b6GFlSZWE8cy+CQXm10
	 8mHo5G5fprd1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf: marvell: Add CN20K DDR PMU support
Reply-To: sashiko@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413165621.10921-3-gakula@marvell.com>
References: <20260413165621.10921-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 17:50:58 +0000
Message-Id: <20260413175058.E1700C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Missing Hardware Initialization for CN20K Programmable Counters.
- [High] Undefined Behavior via Unvalidated Event `config` on CN20K.
- [Medium] Event ID Conflicts and Incorrect Hardware Routing.
- [Medium] Broken Enable Logic and Stale Hardware State for `cfg1_base` Eve=
nts.
--

commit 5466234dfcbce6dad8475395fbdf56b2dfd56308
Author: Geetha sowjanya <gakula@marvell.com>

    perf: marvell: Add CN20K DDR PMU support
   =20
    The CN20K DRAM Subsystem exposes eight programmable
    performance counters and two fixed counters for DDR
    read and write traffic.  Software selects events for
    the programmable counters from traffic at the DDR PHY
    interface, the CHI interconnect, or inside the DDR controller.

> diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_=
cn10k_ddr_pmu.c
> index 72ac17efd846a..7e2e1823b009c 100644
> --- a/drivers/perf/marvell_cn10k_ddr_pmu.c
> +++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
[ ... ]
> @@ -61,6 +73,23 @@
>   * DO NOT change these event-id numbers, they are used to
>   * program event bitmap in h/w.
>   */
> +
> +/* CN20K specific events */
> +#define EVENT_PERF_OP_IS_RD16			61
> +#define EVENT_PERF_OP_IS_RD32			60
> +#define EVENT_PERF_OP_IS_WR16			59
> +#define EVENT_PERF_OP_IS_WR32			58
> +#define EVENT_OP_IS_ENTER_DSM			44
> +#define EVENT_OP_IS_RFM				43
> +
> +#define EVENT_CN20K_OP_IS_TCR_MRR			50
> +#define EVENT_CN20K_OP_IS_DQSOSC_MRR			49
> +#define EVENT_CN20K_OP_IS_DQSOSC_MPC			48
> +#define EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_WR	47
> +#define EVENT_CN20K_VISIBLE_WIN_LIMIT_REACHED_RD	46
> +#define EVENT_CN20K_OP_IS_ZQLATCH			21
> +#define EVENT_CN20K_OP_IS_ZQSTART			22
> +

Could these new EVENT_CN20K_OP_IS_ZQ* IDs conflict with existing events?

For example, EVENT_PRECHARGE_FOR_OTHER is also 21, and EVENT_RDWR_TRANSITIO=
NS
is 22. Since they share the same ID value, wouldn't standard events 21 and =
22
incorrectly trigger the cfg1_base routing logic added in
cn10k_ddr_perf_event_add() for CN20K?

[ ... ]
> @@ -524,9 +637,9 @@ static void cn10k_ddr_perf_counter_enable(struct cn10=
k_ddr_pmu *pmu,
>  					  int counter, bool enable)
>  {
>  	const struct ddr_pmu_platform_data *p_data =3D pmu->p_data;
> +	unsigned int silicon_flags =3D pmu->p_data->silicon_flags;
>  	u64 ctrl_reg =3D pmu->p_data->cnt_op_mode_ctrl;
>  	const struct ddr_pmu_ops *ops =3D pmu->ops;
> -	bool is_ody =3D pmu->p_data->is_ody;
>  	u32 reg;
>  	u64 val;
> =20
> @@ -546,7 +659,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10=
k_ddr_pmu *pmu,
> =20
>  		writeq_relaxed(val, pmu->base + reg);
> =20
> -		if (is_ody) {
> +		if (silicon_flags & IS_ODY) {
>  			if (enable) {
>  				/*
>  				 * Setup the PMU counter to work in

Are CN20K programmable counters ever actually enabled?

Unlike CN10K, CN20K does not register global .pmu_enable or .pmu_disable
callbacks during probe. And since this check is only for IS_ODY, the hardwa=
re
counters are never configured to work in manual mode or started via
cn10k_ddr_perf_counter_start(), which might leave them non-functional.

Additionally, just before this block, the function applies EVENT_ENABLE
exclusively to cfg_base:

    reg =3D DDRC_PERF_CFG(p_data->cfg_base, counter);
    val =3D readq_relaxed(pmu->base + reg);

    if (enable)
        val |=3D EVENT_ENABLE;

How are the ZQSTART and ZQLATCH events handled, since they are supposed to =
be
written to cfg1_base? It looks like EVENT_ENABLE would inadvertently be
applied to cfg_base instead.

[ ... ]
> @@ -642,10 +756,17 @@ static int cn10k_ddr_perf_event_add(struct perf_eve=
nt *event, int flags)
>  	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
>  		/* Generic counters, configure event id */
>  		reg_offset =3D DDRC_PERF_CFG(p_data->cfg_base, counter);
> -		ret =3D ddr_perf_get_event_bitmap(config, &val, pmu);
> -		if (ret)
> -			return ret;
> =20
> +		if (silicon_flags & IS_CN20K) {
> +			val =3D  (1ULL << (config - 1));
> +			if (config =3D=3D EVENT_CN20K_OP_IS_ZQSTART ||
> +			    config =3D=3D EVENT_CN20K_OP_IS_ZQLATCH)
> +				reg_offset =3D DDRC_PERF_CFG(p_data->cfg1_base, counter);
> +		} else {
> +			ret =3D ddr_perf_get_event_bitmap(config, &val, pmu);
> +			if (ret)
> +				return ret;
> +		}
>  		writeq_relaxed(val, pmu->base + reg_offset);
>  	} else {

Is it possible for the config variable (which comes from event->attr.config)
to cause undefined behavior here?

Since the CN20K path bypasses ddr_perf_get_event_bitmap(), it lacks
bounds checking on config. If a user provides config =3D 0, config - 1
could result in a negative shift. If config >=3D 65, the shift amount
would exceed the width of the 64-bit operand.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413165621.1092=
1-1-gakula@marvell.com?part=3D2
