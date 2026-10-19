Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB363CAA2F
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394451; cv=none; b=FkapJ3OoMcKmA/EOHWxMO+wqov52sCxrXAMxh4839w8NrzVNnabGXpWbUYGhYSdWe6ANvWuvQ3n3a6uBzgP43IY7JngTHax+lXmvBsCgR6tLQt1Ye4K5tA8Qacl6e9pLIlZhYxcE1C7a5IEHfl5J0DDBuIHu0qCSoJMXOAD96Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394451; c=relaxed/simple;
	bh=WtrKtI1A+m21Ht5hvR6m/vJuMgQn7+UliAFxD6iJhks=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r9X+Wiwm7Qj81k1xDeLmdHhJYx73IeEXpvufIykDfFPmGYhorXdl9KrGid7jRD/Iiuw+TgbkZSeuwax8YoPfdJen/wUQMHdt70mR36mMOqMnVbT8Ic4PlECWmXvc4/RpJlBj7cOPtpNV+moAzWhRE/F9VPApjPzNkOwCXf5ygLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwrIM92k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwrIM92k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62E51F000C4;
	Mon, 19 Oct 2026 07:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394449;
	bh=WtrKtI1A+m21Ht5hvR6m/vJuMgQn7+UliAFxD6iJhks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwrIM92kvvcEyu9SPGw6QBcQYq2BB7tmFSKZO8iMQrj+57bzKzAJOxKIFwm8fjF/8
	 stxsQy+rVCg9VtO2r9/0ItBtzMjQmqYZlIJTlPwmSO7yUkRWDNh7+frBLn8iu1Nnpo
	 FQxLMG7zRbVnC2y5Kefd38Ip3tgmJc+SrSO6ljVN2VBAljRysQoNIuKsXHBe3eRZmq
	 zgcg1z+iUd4angMUAqg5ValXI2fhfJ5m6E+BL3kCRwhZ+m6FOIkCllNu3nZ4hOwYBw
	 y5auQygKjtjgZ6D3sc+I7ve66UJt0MwYTILbKSYb0CgqanGOL5h1SUjdIOi+Ea5BjI
	 V9ekFqTAw2Ukw==
Message-ID: <sashiko-outbox-176741@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 2/4] perf/x86/amd/lbr: Limit branch snapshots to
 valid entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261019070836.2972403-3-dapeng1.mi@linux.intel.com>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:20:49 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Sandipan Das <sandipan.das@amd.com>
>=20
> The branch snapshot callback used by bpf_get_branch_snapshot() copies
> up to x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr are
> invalid, but they end up reaching BPF programs.
>=20
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> amd_pmu_lbr_read() skips reading the registers, so that a stale count
> is never reused.
>=20
> Fixes: a4d18112e531 ("perf/x86/amd: Support capturing LBR from software e=
vents")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019070836.2972=
403-1-dapeng1.mi@linux.intel.com?part=3D2

