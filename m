Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB631448E0
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610965; cv=none; b=KV+x7/ezXs+H398WQv0HCjgctFZwx7RVJpbUce11LNPfSnU6DaotNrgiIpi+P+2GY1TTSQdrovlS/1gidIMqAJy/IdFQ+weT3bojzeHxffigaO3R6yF/ndidLlMFA+qN1Ri1d8gY5bC1/vlJj6RMp68IC6rh8yqBjRKahMGlcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610965; c=relaxed/simple;
	bh=DBqEMxxaiJL42XI1pGJfmkimvFR493ND4qIyJn51+9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mfy0A/n65hPsY2ZHoEKU3f1w94csWQHq3ezu5UMIzn/2w+WcFz4MpXcVo5Iagkf6wauLuhJn3EVtKzNPY20j+dQKz8XErJ/oXPXu7OdpIZbOT2HdPDrUfPDBDHhunMs01kuNR7OnwAaqk5PXy/LP+EglBNk+7Af99v8kXQEDHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEStkiDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEStkiDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82D31F000FF;
	Thu, 17 Sep 2026 02:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610964;
	bh=DBqEMxxaiJL42XI1pGJfmkimvFR493ND4qIyJn51+9Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEStkiDJzRTy8FhtSMT39+sZ0ItF7b0B532SxbkafDvmMXQgaweIMq5xVfZjfKMrb
	 CtOB5y0a7aI7Ki/fYsrurxicJPgRL7k4KiCFaajDLPskq9WKo4fuaDtT1QV8F+lrRl
	 bz8s9hAeflCx68yyNzwzzeG8cDgkOk88UD8YZnpnfBnp7nrFoA5l5OopkMjQEYhdQU
	 k4mSOiGtUqotzdifM6xnZdvwNiljDY+cCo2KiCYbn5gJUQSl58Wgexvsg/seI62SF3
	 KfLVng0iDRN+vAt3iUQV+w1KyrG6IWrFJJvCwPpRCWnJ2Yo9iKX7A6v8JjQS5yiXW6
	 mcITjJrNDUuSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] perf/x86/intel: Fix DKT PEBS load/store direction
 for latency events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-4-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:09:23 +0000
Message-Id: <20260917020923.C82D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Same issue exists on Darkmont, intel_dkt_pebs_event_constraints[]
> applies LAT_CONSTRAINT constraints to
> MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
> LOAD/STORE flags for those events.
>=20
> The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
> the event flags to determine memory operation direction. Without an
> explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
> misclassified as LOADs.
>=20
> Set explicit LOAD/STORE flags in intel_dkt_pebs_event_constraints[] for:
> - MEM_UOPS_RETIRED.LOAD_LATENCY
> - MEM_UOPS_RETIRED.STORE_LATENCY
>=20
> This fixes incorrect STORE sample classification. Additionally remove
> INTEL_HYBRID_LAT_CONSTRAINT() since no one uses it anymore.
>=20
> Fixes: 65fd435095bb ("perf/x86/intel: Update event constraints for PTL")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D3

