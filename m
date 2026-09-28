Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42253457E7A
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582865; cv=none; b=DYZR3KdJB8CxV1VgqTFP6cZJinIyI1o0npzNGrqQQOnX99uloTgvG7dGpoRJH4BC298Q7uEZGps7B7zwTDNgGXZOK3a1uGe0s/Qd7RewHcQAEKtfAYJwDEiWDfstXCkqpEDyHUb+jtOh8OJUiKoO1Tol9IHVo/eHlZRezNJihZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582865; c=relaxed/simple;
	bh=F9mK19ei5VjROcHyT/PnyfIU5zQOILp+dZQjfXTlKeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n18gbCvaSi/3gZ4m/wTcXfGUmtsuMBqHo6PksOL0e94uG0rW6xwLl3p873c6LlF37iala+hlu0kgOwl/MzwxDAvhvWozpwBLYjh774hlU5Bl5FKq9+hMi0hLqEHwjsdGANgT2fvMP7yUHxzVIqLnivKUZ96OjyaOHhdFcjy0sh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/6R00eH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/6R00eH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEDC1F000FF;
	Mon, 28 Sep 2026 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582864;
	bh=F9mK19ei5VjROcHyT/PnyfIU5zQOILp+dZQjfXTlKeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l/6R00eHTDD1Xza9CdQn0yLh3OMgZLguHheiB5hMFNOr9fSLWpNy5OZr9CXM1Pd9X
	 elIPjWIVMySAq5Ng8UD0oEKmnCpBVPkk1Ifay6jAUUluH3iaHPhwUC8eL8INW0RkTJ
	 6OyhmUQfuvNGRCQrgYMxRILUQUbBhXium04CohjVgD+4yXbufhedtK26iPcMmrGEBO
	 DirzySo6gELCQyY2C89qBOabnqjAlO7fnXh6Ww2wuHKPF32Ih+HxuLZs6V6eBAQzsx
	 lYcg3rT/rSqj8tZv/cocfh9B37DmStPsoxwcHbJcF2Y1PqqpdBLwkxffYB1N2uQ4Uu
	 CzUXtyYFME+WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/15] perf/x86/intel: Reset active_pebs_data_cfg on CPU
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928074309.898043-4-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:07:43 +0000
Message-Id: <20260928080743.EBEDC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> cpuc->active_pebs_data_cfg tracks the PEBS data configuration currently
> programmed into MSR_PEBS_DATA_CFG, and reprogramming is skipped when the
> new value matches the cached one.
>=20
> After a CPU offline/online cycle, MSR_PEBS_DATA_CFG may return to its
> reset state, but active_pebs_data_cfg may still hold the pre-offline
> value. If the next computed PEBS data configuration matches that stale
> cache entry, the MSR update is incorrectly skipped, leaving
> MSR_PEBS_DATA_CFG uninitialized for PEBS sampling and resulting in
> incorrect PEBS records.
>=20
> Clear active_pebs_data_cfg and MSR_PEBS_DATA_CFG during CPU teardown so
> MSR_PEBS_DATA_CFG is always reprogrammed when the CPU comes back online.
>=20
> Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928074309.8980=
43-1-dapeng1.mi@linux.intel.com?part=3D3

