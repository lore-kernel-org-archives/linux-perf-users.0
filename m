Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F04052A6;
	Sun,  4 Oct 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151776; cv=none; b=n2uTUVoaOeMA4ig/P8bc+zf4u3POKHrHh1uT+N5vp1Ww8TD0tCeL5DVQFEl5d4HVvFCmdOOLzxz9O7KTYocpq7qibvujFIOHWbRyeSL+Kkkvl6TenVrTe5rbewnYpJY7dY2Y6ZrPacuaNpcMZtUO1A6W44Ps/vpOvos8hnw1gK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151776; c=relaxed/simple;
	bh=8XkuxXD4O9U4///l1k3Zt33hLcv2Km+nxXqtxuDKE5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G48w/WZ2iTew2F9QQ/BTezMbQGj/CAEZZHajzy4bNdUE1EkLtjqp+MXtRwb3jQbQHajHD1SKhY+w5o86qMo5A3+sUDok1MIt3TzZgAGwQs20NFQKXgyOPq3AuFZBpujtghb4+spY4rXf2Z+QgsKWsikh3d3lHAcIflikwJdAs1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVcIcIjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVcIcIjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B14F1F000FF;
	Sun,  4 Oct 2026 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151775;
	bh=Xv3TTQo4TBFnFYWiozxXJYJCOwSs0TX6BGcg6r5MAHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVcIcIjnplESrLEdPZ1NMvOVDUZVvTzT024w1BUyL9NT28/ObG9ShLVaqrMVMC6XX
	 apmz+QMmQqiAT/nc7FzgY91ae/HWUuhPioGxpRFpEdo3zye5xFhyNbu7p583fHxtQq
	 dn92kRvN5xco/wK4Hd6sR/OSeVibQ4OY7gedu1OfBWUU5jED6A/Nf4VMUH0yrZkxMk
	 HIHwzQ8r5FQk1vcgskK+kBHY3LNAxzAIb+OCm6mTGo+8PQe18IkARy1pKNfEAb2oFw
	 eNcNJU2fzVa3CK+hSKSyVTT6+dU16NgUexps4X75MUJk3ErIDhhVS+zJoWeffCI+Vd
	 ST/8dahpzT3sQ==
From: Will Deacon <will@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: Re: [PATCH] perf/marvell: cn10k_tad: Publish the OF module alias
Date: Sun,  4 Oct 2026 23:09:15 +0100
Message-ID: <179114873097.1632144.14759850922777064324.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905134317.67317-1-hppiscas@163.com>
References: <20260905134317.67317-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 05 Sep 2026 21:43:17 +0800, hpp.iscas wrote:
> The TAD PMU platform driver has ACPI and OF match tables, but only
> the ACPI table is published. A Device Tree platform device emits an
> OF modalias, so the ACPI alias does not select this module for it.
> 
> Publish the OF table inside CONFIG_OF and retain ACPI support.
> 
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf/marvell: cn10k_tad: Publish the OF module alias
      https://git.kernel.org/arm64/c/848468c86f71

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
