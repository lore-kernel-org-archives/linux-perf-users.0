Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35026982C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561222; cv=none; b=gBCPg0NiLJFRuJNCybX9f8Ee6ih/R7EcqHvpOwCEu6W6SvtnW00Cg8k3QSxBo1FWMQOq1nXu9Oq2aRS0JTYj1ujorywjjarjFVYgxHq4lwML74uOVQjvIJ335417LbreQTCiWNaYT1gRzdMN0oAxiLq6EBjNcgtAdmfTReKcKrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561222; c=relaxed/simple;
	bh=2xz+LrgRBQ8wu6YkGBCWoxxLPfyEpTTX2ns8jAxx5rg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5n56NvPnVnp0HgeOzc0VveDI0gTzgFPlB2w4mPqZ6DKrI27HclS/Y8EY4OiupJyy98zo90sQ1EjxEdAYwH1GW8b9x6pm4phGOnKdJ7iAOGEHTvQOsvGqhlQSjrCtndFV451BoFAdqGZJ1DhhdMWMDxy+QjUhukOovT+aaamc1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7OST0q6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7OST0q6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505D71F000E9;
	Mon, 24 Aug 2026 08:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561218;
	bh=vRUN2bYCGX2bBLmc6m59LHRLDtYcNE4O07K5Kbq+zzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g7OST0q6rQycsaOz8B0AabLM/BgyEafg9ZiHKW8CswvcGb0ix9DPkoqCGZft4TbGo
	 gPUdjcoNMGljoySkAMs16ufX9OSNl03Pmrm7asqBc7yNLWWmHz3PNt3lnRLxoIPiU1
	 OExexNSBcDmRG3hslMYF8pp/Vuv1T7+Prg1YKq+NbjT7DYdp04Ve6wKfmQfgQ9ySXm
	 JUBPT49O3w5gbRV77HE2XI9BusLko7s3nMh6mnCY9rZu4TISHbybsst9HrA+rdBw/Y
	 VpuowTzf5BTtsBX0G1rFnhgcFSHWUmFiZccN4LairWfUyoc0RLgjl/9Nw3DyDPjP1t
	 +4yDsg+1hbMkQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND Patch v10 03/23] perf/x86/intel: Convert x86_perf_regs
 to per-cpu variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824082731.1013973-4-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:46:57 +0000
Message-Id: <20260824084658.505D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, the drain_pebs() helpers, e.g., intel_pmu_drain_arch_pebs()
> define an on-stack x86_perf_regs. Upcoming patches will add new fields
> like *ymm_regs and *zmm_regs to the x86_perf_regs structure to support
> sampling for these SIMD registers. This would increase the stack size
> consumed by these helpers, potentially triggering the warning:
>=20
> "the frame size of 1048 bytes is larger than 1024 bytes
>  [-Wframe-larger-than=3D]".
>=20
> To eliminate this warning, convert x86_perf_regs to per-cpu variables.
>=20
> Please note drain_pebs() can't be interrupted by other NMIs since
> either it's already in NMI context or PMU is already disabled.
>=20
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082731.1013=
973-1-dapeng1.mi@linux.intel.com?part=3D3

