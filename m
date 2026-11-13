Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583957;
	b=IvOLrfminqMsE7D8IIG18sq+wvBLtrY92ZYOSWOncdgF8YFS4LksASPIR+wAoI1cZsWG
	 uPV75FLuBpYJlCJsHa8bYmvYA71HTTyE7SrE6oJYuF71H0nrUe3pUxGTcEGni+tCgHQIj
	 MojT1+WhM1qDDZaw949SR0X7+irfpaiE9PFbOBx6pWxEus/xvNbo3Z58n2R1+3cO4oHba
	 +0I0aTGcLj5uClZ5zOj4qsTFXMwIOoq9IQ1yzirB61+LVw54lBVneOx/6VmeVhG7MdURQ
	 Oxidn7CioMeHE3R/M21BIr95gUINHI8lTBgDpFOG2RrCaBjnlaIxgA34TnVX321bf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583957;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hycF4BLp3jWpVEBVM6QEm8T7MRhzKopYKARUvHWwGaU=;
	b=09F8Lw+tUXS6sk2nHR/Gej10BX2sO71/zSpz+pgfmwkQlONleNNieMkcyJGl4U8coSro
	 FiPfCYhxnsS1eEDQcP7sv3InCkOWTUGAINeU+AHAcVge6GOof9GbFp8cYOE8YyZY41Zqx
	 dMVpfD/QYMnyrtGI4TV+M1E3Wo91fLyQAbDlWYV0/cxps7Xta4tx9isR6ieRNao90sL9O
	 gm35FCVZtD//bljwIRc1nlmi6mRtPtBsGOxqcBgBFygWwXEDfEC/pVRa09lA/0hzOmbAB
	 kesJnWCozVS5ChFL61lJB+npxRnZywjDqNVgXbLs0RPr1UrPYvR85cv/U54LV1iD09g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7aRYcPE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE8606A895
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n7aRYcPE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445A61F000C9;
	Fri, 13 Nov 2026 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794583957;
	bh=hycF4BLp3jWpVEBVM6QEm8T7MRhzKopYKARUvHWwGaU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n7aRYcPE29DAuan+z1bFLhY85pgF9+ayvb/IH8ay4jvKWVtvr0BaK1DNL3qpYQvnh
	 7UMSlZxtvujTnutAIKWxMpAHuqzcOXLYmhw8Ch2RYyrmahri9xz2i1/LiTi5wKCCB4
	 NMqtjy0DB22ZIWCCBeNYCOehsK56BuFYqnEq5EpGJteAEf1BhZ8wW5HgmLlsRHXubF
	 GB6GwSkhPGIr8f2TShPRvy00Ka+uaRpPXk7cOQ9nTcNANZCMD5wyOWsfrRLLce8LqG
	 dZ7dvTVLPQI0uA/x14B7Eh8ENZBSTwjf1vu4pUqrU17TcehsbUvKPnuFcwDX1mI6d2
	 +qzEgCrsg/eMw==
Message-ID: <sashiko-outbox-213096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] x86/events/amd/iommu: Use a per-IOMMU cpumask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vasant Hegde" <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113150502.685887-1-vasant.hegde@amd.com>
References: <20261113150502.685887-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:32:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] x86/events/amd/iommu: unlocked cpumask read in
  _iommu_cpumask_show()
--

commit 90882d03fd52ecfe91f951e077a922dfbbba36d6
Author: Vasant Hegde <vasant.hegde@amd.com>

x86/events/amd/iommu: Use a per-IOMMU cpumask

This commit replaces the global CPU0-pinned cpumask in the AMD IOMMU PMU
driver with a per-IOMMU NUMA-local cpumask and adds CPU hotplug callbacks
to migrate the reader context when CPUs go offline or return online.

> diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> index f332c7089bd59..3b35702aa702b 100644
> --- a/arch/x86/events/amd/iommu.c
> +++ b/arch/x86/events/amd/iommu.c
[ ... ]
> @@ -131,13 +134,15 @@ static struct amd_iommu_event_desc amd_iommu_v2_eve=
nt_descs[] =3D {
>  /*---------------------------------------------
>   * sysfs cpumask attributes
>   *---------------------------------------------*/
> -static cpumask_t iommu_cpumask;
> -
>  static ssize_t _iommu_cpumask_show(struct device *dev,
>  				   struct device_attribute *attr,
>  				   char *buf)
>  {
> -	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&iommu_cpumask));
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	struct perf_amd_iommu *perf_iommu =3D
> +			container_of(pmu, struct perf_amd_iommu, pmu);
> +
> +	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(&perf_iommu->cpumask)=
);
>  }

[Severity: Low]
Should _iommu_cpumask_show() hold perf_iommu->lock while reading
perf_iommu->cpumask?

In iommu_pmu_cpu_offline() and iommu_pmu_cpu_online(), perf_iommu->cpumask
is cleared under perf_iommu->lock before the replacement CPU bit is set:

CPU0                              CPU1
iommu_pmu_cpu_offline()           _iommu_cpumask_show()
  raw_spin_lock_irqsave(&perf_iommu->lock, ...)
  cpumask_test_and_clear_cpu(cpu, &perf_iommu->cpumask)
                                    sysfs_emit(..., &perf_iommu->cpumask)
                                      <-- sees empty cpumask
  target =3D iommu_pmu_pick_cpu(...)
  cpumask_set_cpu(target, &perf_iommu->cpumask)
  raw_spin_unlock_irqrestore(&perf_iommu->lock, ...)

Unlike perf_iommu_event_init(), which takes perf_iommu->lock around
cpumask_first(), a concurrent sysfs read of cpumask can observe the
transiently empty mask and return an empty string to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150502.6858=
87-1-vasant.hegde@amd.com?part=3D1
