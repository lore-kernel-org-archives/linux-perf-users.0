Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7245D5D9
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582284; cv=none; b=rQIDGpfwFeimHec63yIn6TGSe58INh7mBkehSesRly0PiWFTz4d/Awl54HebN3Da6OJCnkafzGveH+IayHCvfs8TCRndrmDWltdP784giK73L3xtouzik19TtwAkq5/40+Ei+wJ4ZpnhDn63DEphMjtCkHKJtXv6eF3egePKwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582284; c=relaxed/simple;
	bh=qwg5j522+uuasirT1RCmlbz8L9ooaAjnmC1djT35bQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=doHCmcf6DgnZC3SA0d60jZRJ3ccLp5RVW8FVGrBCUNrRZ9negoN57KzYYvkf1i8VS/ZndDcvzSpQsr9QRkVzq1BsmPn6rRnxCFWkiihnPWKOMUs/pbnPyA/+oWLYw4G4soqG8/v+iyaKYfoaUn6bol0sLZGFjuo5+kfrPW2sqrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaOYyFgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaOYyFgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0961F000FF;
	Mon, 28 Sep 2026 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582282;
	bh=qwg5j522+uuasirT1RCmlbz8L9ooaAjnmC1djT35bQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aaOYyFgvPQevw38L62KYxUL3I7yxXxC+ejaKBSBmRAYbWhn1bcKm1rv9duH/jaVGh
	 PXo9sq0PGypGxAgzBtoG64IXJ2rJq9LjGjckS6T6+WN57WVzbVL7DK9kJIIiHb/V8G
	 ansFyB8ZQPtf6GjzGewK4GT5PRz2Bjn2BBpdR+n3BEpWELtYzE1xDrG2laNqpjLtuu
	 9DYW7RAMieGwjOQw0fSfyho/R3IlZsLfd0doGm+6N9tXCMeILKgetVDcqbiZFmgkOn
	 nfSEeWaKsZCTVGk31IsdofmgatIWAZe+bYnvvke00R54RrtYOiOBw8Q9GP6icpBu5k
	 eK03hCLFN3tlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/15] perf/x86/intel: Pass correct PEBS counter mask to
 no-drain update path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-6-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 07:58:01 +0000
Message-Id: <20260928075802.4B0961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> intel_pmu_drain_arch_pebs() calls intel_pmu_pebs_event_update_no_drain()
> with X86_PMC_IDX_MAX, but that parameter is a counter bitmask, not a
> max index value. As a result, PEBS event state is not updated/restored
> correctly on the no-drain path.
>=20
> Pass the PEBS counter mask to intel_pmu_pebs_event_update_no_drain().
>=20
> Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record=
 fragments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D5

