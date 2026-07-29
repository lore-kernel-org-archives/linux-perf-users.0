Received: from liger.cherry.relay.mailchannels.net (liger.cherry.relay.mailchannels.net [23.83.223.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1483B71B4;
	Wed, 29 Jul 2026 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357853; cv=none; b=tUwJKWGuR3OCfC1TgDeARlRcBI8p/yjVi+kiurbT726k2PxneLR6GRnvnnKNhVCpi+ednRBsPrZw95S1tHTKKLn3UjQhkHkDM0zmwecucopG0KCoaUvpCq5SbtXskEr9MbK7H0qDmL7qPT/N1I9EX/0bhzM2qBIWi1JWLY84q2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357853; c=relaxed/simple;
	bh=tC1mK0xzBNT+QbubKlvJt7Wor+AKPESx3oNv/9TMFmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNQ87Xbz33CAZkO704aOOWI4jvXgtP9UlTFr+Luk6NuuGatxWenNC/PeLFYTA/SHcRNva8fd0BM0QPGKyRayG4gYApwlLeJ3hnMnxyG9hCe9ayaYyR8nMRZnVE2Tlar2DEPJZnEPl7X6Nm0zOWyjPOZhHW3LYM3H1KoF5UIgQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ecJRowg3; arc=none smtp.client-ip=23.83.223.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ecJRowg3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C6E454629B8;
	Wed, 29 Jul 2026 20:27:56 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (100-111-244-76.trex-nlb.outbound.svc.cluster.local [100.111.244.76])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 69B93462F2E;
	Wed, 29 Jul 2026 20:27:56 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Coil: 176beddf74c0db34_1785356876513_18110366
X-MC-Loop-Signature: 1785356876513:3555508784
X-MC-Ingress-Time: 1785356876513
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.244.76 (trex/8.0.2);
	Wed, 29 Jul 2026 20:27:56 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4h9P636Njnz1j;
	Wed, 29 Jul 2026 13:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785356876;
	bh=ETJEjlLs2vhvLFRqvqtJ8u03Ad4+rFTsI1xNNY7f9dk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ecJRowg3vJ2O7h4RcrGkjNa1JJE3JHDW4bsCypajjCpbx3ymDLE0RVh/T6mSw+JC8
	 GZ0mqYBGFUTx7Rs38ZA0Dgvr3JhjGgzU1Ja2kdVWEP8Un56J6slSIvu4aLD5s357oi
	 J1w/MChsQuKtFIugeXzK0pmGBKYORiuka2ldYdiBERl1ZrGeC0/FWWa4QzEa3wDCkL
	 /nT1Dg9QaZxdCxlj80clgWXEbxJ/sUfKVGMBlF5GhfZy2VqSCfsisSegZDJy7LN827
	 C77SVO/MyYrmmTUs/HwVeWdK/0K8jG+Sho8680uxnL6a6LGHmahcg7hMEcUCpcAEnD
	 QTGsy8W7Pyepw==
Date: Wed, 29 Jul 2026 13:27:52 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
Message-ID: <20260729202752.e5kgjw2arxv3l4oj@offworld>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-6-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260729145555.3919550-6-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 29 Jul 2026, Dave Jiang wrote:

>The PMU pins its overflow interrupt to info->on_cpu in the hotplug
>online/offline callbacks, but requests it with only IRQF_SHARED |
>IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
>smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
>then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
>hwc->prev_count and event->count concurrently with the managing CPU;
>local64_t is only atomic against same-CPU access, so counts get
>corrupted.
>
>Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
>matching other uncore-style PMU drivers.
>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>Reported-by: sashiko-bot@kernel.org
>Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>---
> drivers/perf/cxl_pmu.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>index d1e810601e36..8b89db8f4d68 100644
>--- a/drivers/perf/cxl_pmu.c
>+++ b/drivers/perf/cxl_pmu.c
>@@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
> 	if (!irq_name)
> 		return -ENOMEM;
>
>-	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
>+	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
>+			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
> 			      irq_name, info);
> 	if (rc)
> 		return rc;
>-- 
>2.55.0
>
