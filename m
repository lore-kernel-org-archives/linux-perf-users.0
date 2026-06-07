Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5804F2EEE7D;
	Sun,  7 Jun 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837492; cv=none; b=u0BxpfyCt13mqsYo3yYzQmPl5WMZanZslW1V3VlT0yOhUqGiSuk6o/g+xwVdM9JDGaPePRZGduZbaD92rIphfg5GBZZVsVecvO5hQYW4S0zNM7I2EE009sL2xsbyYXyq+mnu8zqzukRf8+4ekjGl8lKRFppJwdgt9wfOcfA3ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837492; c=relaxed/simple;
	bh=F1QyJjX1yFzlyg1M22MRH9BXgHyjN1RlYcMUrY74d9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJsjmkPD0+/KX7AF5X5Muw2IhVZYj1fE+FYx2KVK/oGpzRvFk5poCAXvh4vtTACEv8P7fdFBM6TbtNaJtQNXr3ktDWu1UZhit96n3RDY6Gb/cUNvi5VLB8o/z6qU5C+W0YwXzesQ48OZW8BippsJyOQP4ovCETT1U1WS/2oNaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpYLeGF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpYLeGF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A561F00893;
	Sun,  7 Jun 2026 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780837491;
	bh=AWVTn/ddSiFqVnROl7IYlnKOGqz+FIezPvnF8nLm35M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpYLeGF1NWlirpxxDtdwVwk1p3YYF6q1iI7QoflU/8WP3jFmCgTgz1JVlXxBTr44x
	 hDQL5N7vWGwpEYfGY4T2Iwj+BCmIuB0RpII2J85OYvmvul7i5eXQ3Af1QO3bRSYI8Z
	 LJy0a77MebG0XXhLnt5Ey2NSqDQZT4FwTvOWki1ewXV+lMRVRcATaMbi7Gj1fL+hWc
	 3+HerthI9qnRvmFQOj1HKi89S916fi4tg8GG3mpClhxL2fCNmeE1W3a0x9brIlhqiL
	 yNlIls7X0SfFFTQrnCBdTOTA6i+EyrZrIUbYVMrmaEcdcC0m4J/wedIB8jXl244GIr
	 UPD7yvjjUgN3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf: marvell: Add CN20K LLC-TAD PMU support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260607125101.17778-3-gakula@marvell.com>
References: <20260607125101.17778-3-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 13:04:50 +0000
Message-Id: <20260607130450.B8A561F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] The shifted `partid` value overlaps with the hardcoded Non-Secure =
(`NS`) flag on CN20K (V3), corrupting the filter configuration.
- [Medium] The driver shares the PMU events attribute array between CN10K (=
V1) and CN20K (V3) without visibility checks, exposing unsupported V3 event=
s on V1 systems and breaking the pre-existing `tad_tot_cycle` (0xFF) event.
- [Medium] The PMU driver prevents users from profiling MPAM PARTID 0, as i=
t overloads `partid =3D=3D 0` to mean 'filtering disabled'.

Pre-existing issues:
- [High] Malformed ACPI/DT memory resources cause NULL pointer dereferences=
 if they are smaller than `tad_cnt`, as the driver unconditionally assigns =
the expected count instead of the mapped count.
- [High] The driver modifies the global platform_device resource bounds dur=
ing probe, corrupting subsequent ioremap attempts and causing driver rebind=
s to fail.
- [High] Missing `hwc->prev_count` reset when starting counters leads to bo=
gus perf event counts upon read.
--

commit db735a497cd5d9c282e3c5a1fa6ad9ee8d6ea442
Author: Geetha sowjanya <gakula@marvell.com>
Subject: perf: marvell: Add CN20K LLC-TAD PMU support

Adds support for the CN20K LLC-TAD PMU by defining a TAD_PMU_V3 profile
with per-platform register bases. It extends the CN10K event map for new
counters and matches the block via OF and ACPI.

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 7a3b659c999a2..4daf109b89eea 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
[ ... ]
> @@ -80,8 +83,14 @@ static void tad_pmu_start_counter(struct tad_pmu *pmu,
>  	if (partid && event_idx > 0x19 && event_idx < 0x21) {

[Severity: High]
This is a pre-existing issue, but does tad_pmu_event_counter_start() fail to
reset the software prev_count when starting the counters?

When the hardware counters are zeroed out earlier in tad_pmu_start_counter(=
),
local64_set(&hwc->prev_count, 0) is not called to match. When the counter is
later stopped or read, computing new minus prev can underflow because prev
still holds the value from the previous time the event was stopped.

[Severity: Medium]
Does checking if partid is non-zero prevent users from profiling MPAM PARTI=
D 0?

If a user explicitly specifies partid 0, which is a valid MPAM partition, it
evaluates to false. This bypasses the hardware filter configuration entirel=
y,
causing the hardware to count events for all partitions instead of exclusiv=
ely
restricting to PARTID 0.

>  		partid_filter =3D TAD_PRF_MATCH_PARTID | TAD_PRF_PARTID_NS |
>  				((u64)partid << 11);
> +
> +		if (pdata->id =3D=3D TAD_PMU_V3)
> +			partid_filter =3D TAD_PRF_MATCH_PARTID | BIT_ULL(25) |
> +				((u64)partid << 10);

[Severity: High]
Does shifting a 16-bit partid by 10 cause a bit collision with the hardcoded
Non-Secure flag at bit 25?

Because BIT_ULL(25) occupies the exact same bit position as the most
significant bit (bit 15) of the shifted 16-bit partid, any user-provided
partid with bit 15 set might corrupt the hardware filter value.

>  	}
> =20
> +	if (pdata->id =3D=3D TAD_PMU_V1 && event_idx > 0x24)
> +		return;

[Severity: Medium]
Does this early return prevent tad_tot_cycle (0xFF) from working on V1
hardware?

Because 0xFF is greater than 0x24, attempting to measure the total cycle
event on V1 will be silently ignored, leaving the counter unprogrammed.

> =20
>  	for (i =3D 0; i < pmu->region_cnt; i++) {
>  		reg_val =3D event_idx & 0xFF;
[ ... ]
> @@ -261,6 +270,18 @@ static struct attribute *tad_pmu_event_attrs[] =3D {
>  	TAD_PMU_EVENT_ATTR(tad_dat_rd_byp, 0x22),
>  	TAD_PMU_EVENT_ATTR(tad_ifb_occ, 0x23),
>  	TAD_PMU_EVENT_ATTR(tad_req_occ, 0x24),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dtg_evict, 0x25),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_ltg_evict, 0x26),
> +	TAD_PMU_EVENT_ATTR(tad_rsp_msh_out_mpam, 0x28),
> +	TAD_PMU_EVENT_ATTR(tad_replays, 0x29),
> +	TAD_PMU_EVENT_ATTR(tad_req_byp0, 0x2a),
> +	TAD_PMU_EVENT_ATTR(tad_req_byp1, 0x2b),
> +	TAD_PMU_EVENT_ATTR(tad_txreq_byp, 0x2c),
> +	TAD_PMU_EVENT_ATTR(tad_time_in_dslp, 0x2d),
> +	TAD_PMU_EVENT_ATTR(tad_time_elapsed, 0x2e),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_rd_128mrg, 0x2f),
> +	TAD_PMU_EVENT_ATTR(tad_req_msh_out_dss_wr_128mrg, 0x30),
> +	TAD_PMU_EVENT_ATTR(tad_tot_cycle, 0xff),
>  	NULL
>  };

[Severity: Medium]
Since these V3-specific events are added to the shared attribute array
without an is_visible callback, are they incorrectly advertised to
userspace on V1 hardware?

[ ... ]
> @@ -440,7 +460,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
>  		.read		=3D tad_pmu_event_counter_read,
>  	};
> =20
> -	if (version =3D=3D TAD_PMU_V1) {
> +	if (version =3D=3D TAD_PMU_V1 || version =3D=3D TAD_PMU_V3) {
>  		tad_pmu->pmu.attr_groups =3D tad_pmu_attr_groups;
>  		tad_pmu->ops		 =3D &tad_pmu_ops;
>  	} else {

[Severity: High]
This is a pre-existing issue, but in the region initialization loop earlier
in tad_pmu_probe():

for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
    ...
}
tad_pmu->region_cnt =3D tad_cnt;

If the loop terminates early due to the resource size being smaller than
expected, region_cnt is unconditionally assigned tad_cnt instead of the
successfully mapped count (i). Does this lead to NULL pointer dereferences
later when PMU operations iterate up to region_cnt and access the
uninitialized base pointers?

[Severity: High]
This is another pre-existing issue, but in that same tad_pmu_probe()
initialization loop:

for (i =3D 0; i < tad_cnt && res->start < res->end; i++) {
    ...
    res->start +=3D tad_page_size;
}

Does modifying res->start directly corrupt the global platform_device
resource bounds?

Since platform_get_resource() returns a direct pointer to the device's
resource descriptor, permanently altering it means subsequent ioremap
attempts will start from the corrupted offset if the driver module is
reloaded or if probe defers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607125101.1777=
8-1-gakula@marvell.com?part=3D2
