Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448988;
	b=Fc1+78Qbyj2weMz4qei7OrTthHVVXNQXZcHDIonXX/EBc+poP+FulAsaxlDTTiDG5JNS
	 NnFdm8/mm5izhZhkVHZiSn5zsRsAg3wpD9s6rpRbHmxh8N5oCk0T/vFfvcEPQqVhvUuNq
	 /r2Wet7kuXsUGJf4pmFZLWDHKPeCyMOoUWKh1sH+Lui0nQ6EViE61xC7XxJxoDp3vGygG
	 m2ahMOoqbN+cJS8eGF6dSPgRW2ZbZDvwZ/kChghEYGoLqSUp61nf6lvvN7IVYixhBH9jY
	 AY4T6tDwMMCmzw8ZD3bbM9aip4zaCgS41yXR0jdIrJWfJgrZdiJlbIXjy1kTjdsiPWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
	b=xY2i2WrEwAEaS7z6NVlLySla76bGciUO/kS+PBPyNiVUPY7B7NYmh2Ka6cK5GEXeJKOv
	 JcgzmUzBH2WaDdHaqmGj96Iz+LnMmKZ/w8vMsl8vb1b5MFx8K3fDkqnvg0KiwtT8riDno
	 8xvN773B80HhcW6IRs0GtxGhpO/VVsYNBcNE2oOreRAeTgtlVKslBUdxnJbYS0N1gIgVF
	 RvgFf85hIJMNnNBveszy/0LVItd/R5lcyM2iaJAqZaF3yF/7ERjEwUjiJj43eMMlqj51/
	 U2ReugiDx0YNADoR3KQ2o/TnEcysegzJf5oBb6ktnGEaUjr5cLCNhVLdmSd+3O+csNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--praan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SpWPTY4F;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2E606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE2E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SpWPTY4F
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cde9044a96aso797963a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795448987; x=1796053787; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
        b=SpWPTY4F85dNRzaA70ukgpGaruaayL5uwoejzjZXWeXrnVdALfaRO9aeIHNqKdfqcx
         UlZg3TElsIYRS+zI8Zsn1EHYrbHlgCqvWTrrScw5fOC6CCLpgPTtQI1IIG6IwmJCuptO
         vl7LsV5z5YCefT7j4obKQu7iD4hfW1MxwRD5ir3drwQTnMnyKE47c3nNuAo0aI/3n3ye
         8B5Xee+dry5LT748usG9YjeBrYdEVOKVApf11uKwxNMZ/xY80b6XPUL6ulA39k7Ht2vL
         53oltTwnRiR2qoeri0py6WEat7ZQosCwfVcql7+EqnAAOvYgQY9tPKbG7MGGZBS+QfLI
         DQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795448987; x=1796053787;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ampCWU9YaRxYyU/2VqzGl7j5fZT5bJdrecIR7kU5Uc4=;
        b=RUZ7d46Dxd/pjggExTCoF3taREDRyAksl62eFSuIraswe41y7eRNeZqNsul3K0dbrP
         fihT94ZtjiG0bGFKs8uAwrwWkOuzaq68n3cFknW/85bI5NDKpQUqviNsbkFOARCFPN8u
         oAxZQ/go5Jt+QRfrNuTyNg7xar5AgZlMDxcTVoi46PRcW7Vlq9msKYxN+aIOrkqLjjel
         x9xqN1bq619nPFP0BebnDDVojkQz2NJEasSir/vbchmt5hvAyP2qWLbLwwEexguLBco1
         obPNZSXOufRlw7w8L9fXHd5diEUGiwy/hMXPJc9fo+cio0eaRL4s5RL1t25AhtdFjuen
         4NrQ==
X-Forwarded-Encrypted: i=1; AL+hErHvK+8cpJGuvuhH1w0As9DEVLxgAFMKHIKOPNQnJJaI6+qHaxryu1vbv8SPdrWXt+Dnbv64bQ3yqtEqmIF4mYPH@vger.kernel.org
X-Gm-Message-State: APuU4Z8/Nqqsx57dlyKgjgFfFony33Cj86N65cAiqatQN1oUonEkuT1s
	LP4icg+R0qRGK3kJuOKS9hFmnCvZ2jmpbzUKHlDMW/r6sO5RSar5swc3f2IGHgtxngxkldzEQGf
	QBw==
X-Received: from pfbfd26.prod.google.com ([2002:a05:6a00:2e9a:b0:8a0:70d8:a2ef])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:218b:b0:3f8:f0b1:e7c0
 with SMTP id adf61e73a8af0-4014da5fc3emr11235211637.59.1795448987022; Mon, 23
 Nov 2026 07:49:47 -0800 (PST)
Date: Mon, 23 Nov 2026 15:49:45 +0000
In-Reply-To: <20261118101913.3135869-3-amitamishra@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118101913.3135869-3-amitamishra@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123154945.3083888-1-praan@google.com>
Subject: Re: [PATCH 2/2] perf/smmuv3: Add runtime PM support
From: Pranjal Shrivastava <praan@google.com>
To: amitamishra@google.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, robh@kernel.org, 
	robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev, 
	smostafa@google.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 18, 2026 at 10:19:13AM +0000, Amita Mishra wrote:

Hi Amita,

+iommu@lists.linux.dev
Please CC the iommu list as well.

> On SoCs where an SMMUv3 PMCG resides in a switchable power domain,
> probing the PMCG attaches and powers on the domain, but without runtime
> PM support the domain remains permanently powered on even when no perf
> events are active.

I'm interested to know which PMCGs are these? Upstream arm-smmu-v3 
doesn't have runtime PM yet, thus, a PMCG that shares its SMMU's power 
domain gains nothing from this today: the SMMU keeps the domain on anyway

With my arm-smmu-v3 runtime PM series [1], the SMMU lets go of the domain
once it has no active clients, and then a PMCG without runtime PM would be
the one keeping it on, the two series seem to fit together. For TBU PMCGs
in a subsystem's domain this matters either way.

I'm wondering if you have PMCGs in power-domains that are neither tied to
the SMMU power-domain and nor it's clients' power-domain? 
(That'd be a bit odd but possible).

[...]

> +    /* The same condition smmu_pmu_probe() enables runtime PM on. */
> +    if (dev->pm_domain) {
> +        int ret = pm_runtime_resume_and_get(dev);
> +
> +        if (ret < 0)
> +            return ret;
> +        event->destroy = smmu_pmu_event_destroy;
>      }

This keeps the domain powered for as long as the event exists, even
while it is disabled or not scheduled. I'd be surprised if the 
production devices that use runtime PM keep a PMCG event open requiring
this? 

For a PMCG in the SMMU's domain, with [1] that means a perf event keeps
the domain on while the SMMU itself is suspended (SMMUEN=0, GBPA=Abort).
The SMMU only suspends once all its clients are idle, so apart from
cycles there's nothing meaningful to count.

For a TBU PMCG, it keeps the subsystem's domain powered, which changes
what's being measured: the TBU's TLBs and config caches survive what
would otherwise be power-offs, so tlb_miss and config_cache_miss can
under-report compared to the unmonitored system.

Which makes me question whether the PMCG needs runtime PM at all. It's
a profiling tool, and I'd be surprised if production devices that use
runtime PM keep PMCG events open. Without events nothing needs the PMCG
powered, so all this buys is not pinning the domain while the driver is
probed but unused..

Do you probe the PMCGs on production devices? If they're only used for
profiling and not in-field, not loading the driver there (or leaving the
node disabled) avoids the problem without runtime PM in the driver.

If we do need it, a couple of issues with the implementation below:

[...]

> @@ -975,15 +1040,45 @@ static void smmu_pmu_remove(struct platform_device *pdev)
>
>      perf_pmu_unregister(&smmu_pmu->pmu);
>      cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
> +    if (pdev->dev.pm_domain)
> +        pm_runtime_disable(&pdev->dev);
>  }

Events hold a module reference and bind/unbind is suppressed, so this
only runs with no events, i.e. normally with the PMCG runtime-suspended.
devres then frees the IRQ: free_irq() -> msi_domain_deactivate() ->
smmu_pmu_write_msi_msg() writes to the unpowered PMCG, since the PM
domain is only detached after devres in device_unbind_cleanup(). Wired
interrupts are fine, and the CPU hotplug path Sashiko mentioned
shouldn't rewrite the message with a GICv3 ITS parent, so in practice
this is MSIs plus module unload.

With the MSI message cached by the core (see below),
smmu_pmu_write_msi_msg() could simply skip the MMIO while the PMCG is
suspended and leave it to resume. Note it would have to check
pm_runtime_status_suspended(), since runtime PM is already disabled by
the time devres runs. Alternatively, keep the PMCG resumed across the
devres teardown.

[...]

> +static int smmu_pmu_runtime_resume(struct device *dev)
> +{
> +    struct smmu_pmu *smmu_pmu = dev_get_drvdata(dev);
> +
> +    smmu_pmu_reset(smmu_pmu);
> +    return 0;
> +}

Sashiko flagged this too: after a power-off the IRQ configuration is
gone, and smmu_pmu_reset() doesn't put it back. With MSIs, overflow
interrupts stop arriving and counters wrap unnoticed. With a wired
interrupt on an MSI-capable PMCG, IRQ_CFG0 comes back UNKNOWN, so an
overflow can send an MSI write to a garbage address, which is exactly
why probe clears it.

This is the same problem I had to solve for the SMMU in [1]: patches
7-8 make the genirq/msi core cache the message in
irq_chip_write_msi_msg() and add msi_device_domain_restore_msi_msgs(),
and arm_smmu_resume_msis() in patch 9 clears the IRQ_CFG0 registers and
then calls it (a no-op for wired IRQs). The PMCG resume needs the same:

    writeq_relaxed(0, smmu_pmu->reg_base + SMMU_PMCG_IRQ_CFG0);
    msi_device_domain_restore_msi_msgs(dev, MSI_DEFAULT_DOMAIN);

Minor: an autosuspend delay would avoid powering the domain on and off
for every event open/close.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260929034510.2023173-1-praan@google.com/
