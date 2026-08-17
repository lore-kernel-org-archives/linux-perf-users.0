Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2742544A3E6
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983431; cv=none; b=k8XOEFkOXjIYvo03TB1avyu/O6UV7lCCVb9A+uUIvLH78pfSTSrs6PiQ4J7B85RQyyug6KEAol9uWzp0UdBeob18P9mTqQf73ZSEmNSJfiV8JT2Qw/N2DqbbcTl/z3CgVZ4XQxX0Sg6bp16c3AOOWtELTyrYoLhafzzAq2MbaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983431; c=relaxed/simple;
	bh=uUdgN581rycDNFkyKyNbAYhMaroS3eHRxWBxtlm66wE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YKPg+DV8CMPi2zrxwfVY33nZOzeSY9V3NruhR+1nAA94BuVwuDcbRvcImCBkQewntU3Fuo4WE3DnfWopsYBWlWrNiBagizRjwCz1+V2fO4rR6mN37K93Gg+UmDjH0V1d/7F1cWwe28oppOgAbOE5HMEspiGgME4PDEGIljIuFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2zdneFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2zdneFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F01F000E9;
	Mon, 17 Aug 2026 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786983428;
	bh=PMPvJgzdG+igIgfHLV95rozrqhc3wadb4jiryH0TFk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2zdneFWUqwqds8E304urktFSyaHc8/r/XB6GqS6ztrWQNDqWZrOIi9IRayLtqRjD
	 c4FqWklOCM7wzGUWZb8Au84cBICXo16JbXST/McTaZ3ffL1c+QXrkg3OeIg95woo8C
	 pCSjiBoW/x2AqxyJ16c/fX01Qv+jqItw2ZhJ3FqMvVHclokLr7vuy7rKG2UETaNTUM
	 Bm9yCca+gkcV8YkkLdiYI/+XcqtdHmnczKQWFF/6pM7u/V6LneBBibJXP8KGyZAkH7
	 Wj4wsDme0G3Y+4ahP8oXl8Q6DwcfXsr8A99YxbHtlLCPKmWAP+6epmJJ/cur485EmH
	 3rXhT2tTfEx2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] perf/riscv: Use Sspesa for precise sample
 attribution
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mayuresh Chitale" <mayuresh.chitale@oss.qualcomm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com>
References: <20260817160222.3313295-1-mayuresh.chitale@oss.qualcomm.com>
 <20260817160222.3313295-4-mayuresh.chitale@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 16:17:07 +0000
Message-Id: <20260817161707.E68F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Logical counter index is incorrectly compared against the physical=
 hardware counter ID when SBI PMU snapshots are used.
- [Medium] Overriding `data.ip` without adjusting the privilege mode in `re=
gs` causes misattribution of precise samples.
--

--- Patch [3]: [RFC PATCH 3/3] perf/riscv: Use Sspesa for precise sample at=
tribution ---
commit b7b8e4e381234c44a7ea95a7ce26fb9dadf28f3a
Author: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date:   Mon Aug 17 16:02:19 2026 +0000

perf/riscv: Use Sspesa for precise sample attribution

This commit adds support for the Sspesa extension to provide precise event
sample attribution on RISC-V. It uses the shpmspc and shpmsdata registers
to report accurate instruction pointers and raw sample data on counter
overflow.

> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dfc886dee5ad0..1b0b1cc612def 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c

[ ... ]

> @@ -1123,6 +1140,15 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, vo=
id *dev)
>  		riscv_pmu_event_update(event);
>  		hw_evt->state |=3D PERF_HES_UPTODATE;
>  		perf_sample_data_init(&data, 0, hw_evt->last_period);
> +		if (sspesa_available && hidx =3D=3D sample_cntrid) {

[Severity: High]
Earlier in pmu_sbi_ovf_handler(), hidx can be assigned the logical index:

    if (sbi_pmu_snapshot_available())
        hidx =3D lidx;

Since sample_cntrid represents a physical hardware index read from
CSR_SHPMSDATA, does comparing the logical hidx against the physical
sample_cntrid cause precise samples to be dropped or incorrectly attributed
when SBI PMU snapshots are enabled?

> +			data.ip =3D sample_pc;
> +			data.sample_flags |=3D PERF_SAMPLE_IP;
> +
> +			raw_sample =3D sample_data;
> +			raw.frag.size =3D sizeof(raw_sample);
> +			raw.frag.data =3D &raw_sample;
> +			perf_sample_save_raw_data(&data, event, &raw);
> +		}

[Severity: Medium]
When overriding data.ip with the precise PC (sample_pc), could we run into
privilege mode mismatches?

If an overflow occurs in user space but the interrupt skids into kernel spa=
ce,
data.ip gets the precise user-space PC, but regs still reflects the skidded
kernel state.

Since perf_event_overflow() is called shortly after this block and relies on
perf_misc_flags(regs) to determine the privilege level, will this cause
userspace tools to attempt resolving user-space addresses against the kernel
symbol map?

>  		if (riscv_pmu_event_set_period(event)) {
>  			/*
>  			 * Unlike other ISAs, RISC-V don't have to disable interrupts

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817160222.3313=
295-1-mayuresh.chitale@oss.qualcomm.com?part=3D3
