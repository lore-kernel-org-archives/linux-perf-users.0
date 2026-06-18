Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BFB261B8D;
	Thu, 18 Jun 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797836; cv=none; b=RGIn+ThCNF5vuaY5uzjhufUMAsHCJOARkVj8Mqciskjhs+TK4diIy8wKlJvrGw7CmZMFExEQFB8UPVI99tsuk4TQC7jeQ8pmmq1G9bG8hCwsHVJ68bzQBpGNnyRGO9RWyZbmMtp4Hv7MIKFsX5nZ9/YoaI7PTzgcd6UAYA2pFKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797836; c=relaxed/simple;
	bh=s9PcYK8QRLOWZjbOc6NbfL12nHOWCPzRaUPq94lMwiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j94+bHmBvj4hsCCJkv7pwWeMgKUUYaBOlxivhdBKg/Ho6SgW+kOWdIVCnZCTUJVZvatd/Veb5fMZjAf5gWoD7q8EIQ79FKT7uS4o1CSXOiVhW7Q7F7Xf5gqzJJ33IWy41sZ+V6OB1OVOvahDZQGJpFUCvZ95ozP5f0/WjJtSOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCXf3x6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCXf3x6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302C1F000E9;
	Thu, 18 Jun 2026 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781797835;
	bh=XwbqrbJv6EKup/KTahAlQ1yiP7J01L/9ibEvOZ9qNfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gCXf3x6fCogjYKVAfDm1oARvvxVm/qNjbJ6rYRCcl1fXUfCF077BHuppsYxjM/W95
	 juk7T9RrJHYa/p9VccdSRnbSD/af2xPBZm9/StZd/3WgVXsQPShkO8DHROg/kQsCm/
	 YDBgeee9lmQY4LK07PcnTfvZx5PgKqxs53KPDJGEPI1zj3XoWC+fK1UwCZLGr88Xzn
	 Tos4z5OxWq7geVlB3KT8ciiwEzPojmiT9jmWt6VuxymLo4229bdQC6GoYdEw+xBLLp
	 3umyeVLhxJGtg4QburcGLH3CVZfULtMhnhT31IiG885QoQ0MouYCJloXum6aaefXK7
	 5VOoqgcXD6tdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] perf: marvell: Add MPAM partid filtering to
 CN10K TAD PMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geetha sowjanya" <gakula@marvell.com>
Cc: linux-perf-users@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260618153610.13649-2-gakula@marvell.com>
References: <20260618153610.13649-1-gakula@marvell.com>
 <20260618153610.13649-2-gakula@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 15:50:34 +0000
Message-Id: <20260618155034.E302C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `perf_ready` early return in `tad_pmu_offline_cpu()` completel=
y skips updating `pmu->cpu`, potentially pinning the PMU to an offline CPU =
permanently.
- [Medium] The commit message contradicts the implementation regarding the =
registration order of the PMU and CPU hotplug instance.
--

commit c5919d39926621f8d8420dda8d78271eeeb122e2
Author: Tanmay Jagdale <tanmay@marvell.com>
Subject: perf: marvell: Add MPAM partid filtering to CN10K TAD PMU

This commit adds MPAM partition ID filtering to the CN10K TAD PMU. It updat=
es
the counter programming to use MPAM-capable filtering for specific events. =
It
also modifies the probe function's MMIO mapping and attempts to address
hotplug registration races.

> Probe no longer mutates the platform_device MMIO resource (walk a local
> map_start), rejects tad-cnt / page sizes of zero, validates the memory
> window against tad-cnt, and registers the perf PMU before hotplug with
> correct unwind.

[Severity: Medium]
The commit message states that it "registers the perf PMU before hotplug
with correct unwind", but looking at tad_pmu_probe(), the hotplug instance
is still registered before the perf PMU:

	ret =3D cpuhp_state_add_instance_nocalls(tad_pmu_cpuhp_state,
					       &tad_pmu->node);
	if (ret) {
		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
		return ret;
	}

	ret =3D perf_pmu_register(&tad_pmu->pmu, "tad", -1);

Could the commit message be updated, or was the code reordering missed?

> diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_=
cn10k_tad_pmu.c
> index 51ccb0befa05d..340be3776fe75 100644
> --- a/drivers/perf/marvell_cn10k_tad_pmu.c
> +++ b/drivers/perf/marvell_cn10k_tad_pmu.c
[ ... ]
> @@ -451,6 +570,9 @@ static int tad_pmu_offline_cpu(unsigned int cpu, stru=
ct hlist_node *node)
>  	struct tad_pmu *pmu =3D hlist_entry_safe(node, struct tad_pmu, node);
>  	unsigned int target;
> =20
> +	if (!READ_ONCE(pmu->perf_ready))
> +		return 0;
> +

[Severity: High]
If the originally assigned CPU goes offline during the race window between
cpuhp_state_add_instance_nocalls() and the setting of perf_ready =3D true in
tad_pmu_probe(), does this early return skip reassigning pmu->cpu?

Since this driver does not define an online CPU hotplug callback, if
tad_pmu_offline_cpu() returns early here, could pmu->cpu permanently remain
assigned to the offline CPU and break the PMU once registration finishes?

>  	if (cpu !=3D pmu->cpu)
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618153610.1364=
9-1-gakula@marvell.com?part=3D1
