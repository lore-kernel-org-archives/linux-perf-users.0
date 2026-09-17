Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D337DEAB
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610889; cv=none; b=aNbQt5BBdD8WcWiUYwYcmEZgkLDzbnHM6+1ZgOhwat/OYJxZUVmTzBcOPgxkFbgn/UlLyIexMJv0C+ExD1ad+OjaKUUphaKbpRZoUfzLnAk3sqO4zLhKY7Xt7Xt3986whjYIgGGFNNlE+wPO1VmXuDp7fCop6k74Zpr8/+YZScA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610889; c=relaxed/simple;
	bh=iay7mnfMpBPDsbV1ODnFR1WVjeiR5Q6JI7kpMmAaoUk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtHjFjYvi2jJ8S2VWpGb6DdQcv71QBLxtBS+6PwSPgp98pWB7UfAulC6iFF/gIF39s7OWGT2zuAvmYfizu5BKQueg3cxs6TjLYWXcJ+5zM5ITIz1Iov1hpi8bji84Y6XNO5K50WgIhvJGOA8sOWiEnwwQNEA9UII31BEX8iu/0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aamvmby9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aamvmby9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA091F000FF;
	Thu, 17 Sep 2026 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610888;
	bh=iay7mnfMpBPDsbV1ODnFR1WVjeiR5Q6JI7kpMmAaoUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aamvmby9onhjHLb3Bw+c42DbXL3pTjaUTIEucZRYo8GO1YM0CDCIrILzBmhML/rz/
	 PRh3v+y+HC25GyUBlhOT/TF1GXqGdd0PdWjMiCX5grlmpBsMT42j8TuBd4ph+euf32
	 uayzj5zf1Zu8oUqYVNW+oL0JYC+q0/85DnMQtfjlQdCRkUrLvmSHoVM0nGzv4zuF/P
	 dHGpm1xVXlGCMjCxObLmMiYDhCh3UL4BT5hv9YhPVrEJTMXaxhamaIOkpjtUMlUZCL
	 IWpNYVKiMHeDxCeEahM+S+IqLUROUcFFitoaREeFUoN2BDBWu+kOccGGdz4pqxT5pg
	 GTcnquH+wuTIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] perf/x86/intel: Fix CMT PEBS load/store direction
 for latency events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-3-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:08:07 +0000
Message-Id: <20260917020808.0BA091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Same issue exists on Crestmont, intel_cmt_pebs_event_constraints[]
> applies LAT_CONSTRAINT constraints to
> MEM_UOPS_RETIRED.{LOAD,STORE}_LATENCY, but does not set explicit
> LOAD/STORE flags for those events.
>=20
> The PEBS latency path (pebs_latency_data(), via cmt_latency_data) uses
> the event flags to determine memory operation direction. Without an
> explicit STORE flag, samples from MEM_UOPS_RETIRED.STORE_LATENCY can be
> misclassified as LOADs.
>=20
> Set explicit LOAD/STORE flags in intel_cmt_pebs_event_constraints[] for:
> - MEM_UOPS_RETIRED.LOAD_LATENCY
> - MEM_UOPS_RETIRED.STORE_LATENCY
>=20
> This fixes incorrect STORE sample classification.
>=20
> Fixes: e99fb45436ea ("perf/x86/intel: Update event constraints and cache_=
extra_regsfor MTL")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D2

