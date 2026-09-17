Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359438330E
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611254; cv=none; b=RZpmZHeDpXap1y/EQTi7pz14UTMrCNc+dTrJgX51D7Z+13ycNSzeDa81ITEmhKm70FfINX0y3nimn/xypDyFFNA1nasibWbB1udFNy/+5Mtr/1LK5BNRzWIjK5fswN8WhvVM8BIfecMlLytsQ1lB4BaPtRpRu7A1Jfl9aFehOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611254; c=relaxed/simple;
	bh=YYYOOM6Wwp1hFFa/OdeGfxNdlLrxnWrd1CaStCuCStA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJgFTDdkPAifL9Xe2loqj8TUIfGhRJZBsg+mab0UfYMuZg/xhp0feBPBkPEr0v/ZJ8MuKJdNIessQWUlCgmFNtfRtJTw29MYtqZjDjVxgBiXrOA+J6C1u35D4YXpvCelR8/AfkaBO3zyQGLJYTbc0WXRgnip9zkLVg46MTTLeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfrtGrQQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfrtGrQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F21F00893;
	Thu, 17 Sep 2026 02:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789611253;
	bh=YYYOOM6Wwp1hFFa/OdeGfxNdlLrxnWrd1CaStCuCStA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfrtGrQQMrxTP4vByG65XpkoEkAINX/OfpYUw01N4JX0cFFf4WuH0YfFct2IG89Sc
	 QIupx7gUYRsq89ugJhMH8cDdEtQT+ltx5xw4lJvua3qrA3rNs21cHVzrKCxUu+7G8B
	 w8bh9jZXPMY3b2owrUGkUApzXUduW3vrpYmoYUi1m3yig4knwCqJS5ZFXvvnTvXMND
	 VcpU7lPVe4snNuydToew8yzDaJDrhoR4vcDFUElXDRpIwkmzt74CggwrBkKpbA5Tre
	 c4pyQTrAV17sfSqyKuZYIuC+YgfKG0dqkbQn8dY6o24dPsDVkV1fKRy9e+ooagTyXx
	 f3EnaVYjR9FTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf/x86/intel: Fix GRT PEBS load/store direction
 for latency events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-2-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:14:12 +0000
Message-Id: <20260917021413.399F21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On Gracemont, intel_grt_pebs_event_constraints[] applies LAT_CONSTRAINT
> constraints to MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set
> explicit LOAD/STORE flags for those events.
>=20
> The PEBS latency path (pebs_latency_data(), via __grt_latency_data())
> uses the event flags to determine memory operation direction. Without an
> explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
> misclassified as LOADs.
>=20
> Set explicit LOAD/STORE flags in intel_grt_pebs_event_constraints[] for:
> - MEM_UOPS_RETIRED.LOAD_LATENCY
> - MEM_UOPS_RETIRED.STORE_LATENCY
>=20
> Also update __grt_latency_data() to explicitly interpret these flags when
> assigning the sampled memory operation direction.
>=20
> This fixes incorrect STORE sample classification.
>=20
> Fixes: 39a41278f041 ("perf/x86/intel: Fix PEBS memory access info encodin=
g for ADL")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D1

