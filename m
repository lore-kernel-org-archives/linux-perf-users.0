Received: from grey.cherry.relay.mailchannels.net (grey.cherry.relay.mailchannels.net [23.83.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAC3B8D6D;
	Wed, 29 Jul 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355151; cv=none; b=as8MrRFRRyUTn7CNvEeMCb6QayCMBRc8spjavNw+c7/41WArgDqO8PG8t27bXKFrjQ+d5cFgV5a18+7n++2K41/yLX9ynhVnUzbJOh5BwLyvT0mB5HSFKd5I3M2NDhbM85rEHqyK/BZ/ymYuxWBkCfJsw28rlUEqGrvFqj6A5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355151; c=relaxed/simple;
	bh=yv4gxrYusJaqPIE/rxyxefXIcwFh5Cals1Sn1zQ+2Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCzCitY9L5HLSYjpYkDy+JHhR8M6SKGkW55pW2Ne/YmqHx+HqqCv6MdeZw9O+6qDwV8FYzdejTA4b9SffTkCNmy0gmDjcuSf2Bqz73u3uyT+xu9+rERoSJIFCccipsElTZxbk2Y+rvP3Mx/qINf4HhH1M6AtCTS0GeqJ9aMstCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=W1Jv71Np; arc=none smtp.client-ip=23.83.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="W1Jv71Np"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1E1ED3E358D;
	Wed, 29 Jul 2026 19:59:09 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-green-0.trex.outbound.svc.cluster.local [100.111.241.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CBD583E30AD;
	Wed, 29 Jul 2026 19:59:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Arithmetic: 4f6211e700d07759_1785355148925_4103598619
X-MC-Loop-Signature: 1785355148925:2882594769
X-MC-Ingress-Time: 1785355148925
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.241.158 (trex/8.0.2);
	Wed, 29 Jul 2026 19:59:08 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4h9NSq72X0z1Py;
	Wed, 29 Jul 2026 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785355148;
	bh=yv4gxrYusJaqPIE/rxyxefXIcwFh5Cals1Sn1zQ+2Zs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=W1Jv71Np6ba2LydQXYbolwKi0OpM2ekbZEFbR8I6/bFgwFY+MqtwC5tF8QFkBwSFp
	 1m19/2JNJCCyjLlJO+20G9m/sA+8TbVF/GSyOIiTDXHvQiCI5BeUp9X17ZTSqk90vy
	 fIdDgh/Yf6m5uD5m/5YYznX1sSpmcRwLL7koEoJ9P17vBm/GTIjWlio+eH0X7DaP75
	 zoLT7TKiQh8Fp9HTz29xpZRxrf5xkEEdKJaNuswoYGfIIn3ML5FT+jOR/GXfqrA0Yh
	 5df/WpNcob/420/FrO5ioIYsqs1fdogiyS1Hy7tf48+Ce1nXc2V/q67peCpuKlSGmi
	 j6O6YxnYdVShg==
Date: Wed, 29 Jul 2026 12:59:05 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
Message-ID: <20260729195905.67ohjozomgkamzyq@offworld>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-5-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260729145555.3919550-5-dave.jiang@intel.com>
User-Agent: NeoMutt/20220429

On Wed, 29 Jul 2026, Dave Jiang wrote:

>cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
>info->irq holds the MSI/MSI-X message number the device signals overflow
>on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
>interrupt support". Message number 0 is valid and pci_irq_vector() takes
>a 0-based index, so a compliant device signalling on the first vector is
>wrongly refused and fails to probe.
>
>Reject only the no-interrupt case (info->irq < 0), matching the sibling
>CXL mailbox and event IRQ handling.
>
>Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>Reported-by: sashiko-bot@kernel.org
>Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
