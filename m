Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6F46D2AF
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582488; cv=none; b=WdGRVcTEtXN3yIi92R5kEvnU/KdGcVxI2cTlPg3APDNfvt+bJhEfs3AN6KSEDPsjDuklmMcih+l10i9UQHT7jXenm4NxJ2Th+Tn5iRPBkugrRvGCyz2frDLkPg784zFl0otMuuAIx/WknQeFHHAB2O+1bcl8Lj86whK+51d+EpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582488; c=relaxed/simple;
	bh=6CDdhYOIkzbAq4Re/3vDTr5GJIT9uYhHLadpBifP5YA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k2HI5spJ7rhd8bSdgCbRzCmU2xmndsUKZdTXdC3oZXvvM6fAnyh++1Gd1DDOAlpy8GbZbppYDvevFS9XRBDxB1IqTcyxZSntH+32A0A9BovxO7rE9VRDLfRiWZwHkChZbYoByXfrNa7ntKYjtogw6JNt6yue1Mq1vsN9iY+aFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNbTgj5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNbTgj5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C2D1F000FF;
	Mon, 28 Sep 2026 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582482;
	bh=6CDdhYOIkzbAq4Re/3vDTr5GJIT9uYhHLadpBifP5YA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BNbTgj5qSu1vHVTz8s8n5zAGjvYtYXAq/Fj2N+6y65qEYHGPemug10xNA9frCsiab
	 bhYjcHi7rKzV8P3fiBUGrF9mVQYGQizeAK81oKPM8aXsxPvDgL7SLKwAXdMxIc18Vz
	 B0qPHDU38w6aoIWRf0f5PGiG6jv8ZqY4nAoZnrJOxQkBf8WM/YkVRHvX3PEPfEsJP+
	 ho8K1Jqfu66FQ//zDK5rP5xgD1IbQNY1bSNrXw8O1kfRUuEzWhyXcJXCrMAUqunU3S
	 h49AuZjQiYAZdqJ6a0BOCppY+p7zeaGqG5MG6oJx2lXjme1J4p5g1tN/U69PNYGZsn
	 tXbUTt83GNoDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] perf/x86/intel: Reset cached acr_cfg_b[] and
 cfg_c_val[] on CPU teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-5-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:01:21 +0000
Message-Id: <20260928080122.48C2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Reset cpuc->acr_cfg_b[] and cpuc->cfg_c_val[] and corresponding MSRs in
> the CPU offline path.
>=20
> These arrays cache the last programmed values for the *_CFG_B and
> *_CFG_C MSRs, and matching values can cause reprogramming to be skipped.
> After CPU hotplug, those MSRs may return to reset defaults, but the cached
> values may still reflect the pre-offline state. This can incorrectly
> skip MSR writes when events are enabled again, leaving the hardware with
> reset MSR contents.
>=20
> Clear both caches and corresponding *_CFG_B/*_CFG_C MSRs on CPU teardown,
> so *_CFG_B and *_CFG_C are always reprogrammed after CPU online.
>=20
> Fixes: 52448a0a7390 ("perf/x86/intel: Setup PEBS data configuration and e=
nable legacy groups")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D4

