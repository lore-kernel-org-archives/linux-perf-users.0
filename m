Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9E2DBF75;
	Fri, 11 Sep 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134260; cv=none; b=PBKi6KRDsfOtM8rLWs22YiinCMWi/AqxjT3JffCDvusWRSVJXHRrG5RO4l785mas5NAhXATfN3oKN43VL/ILHt39RUK3l2NgbF158HR7424eLvPiUJ48JmeBJqQOLoANMUiSoG/CdWBnZaDROP03rrnA48vq1TqcKCZfABlybK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134260; c=relaxed/simple;
	bh=/588s+rJpOsY25pnPcf+owaXgmcnRBqpg/KNxrJjmWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCFkXg26ezESx1PaZfZWGVOb0hFtQOTLv+297YwsMwWCU5VnUQAtvl45sVA5KHjuLF9uPfr91Y6RZ83beIFTfIjJq2JwtZ8UWQj+tqJ6Dbe0976Nvpbvsfbh4bNiSzua64WgrqSDzsIcbm1Sr+DflqOOkLC7P9ltGAg9u8tIjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbNj34mI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbNj34mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0BF1F000FF;
	Fri, 11 Sep 2026 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134259;
	bh=n9WC43RiWACipaJVVputek92HstgNSaNHPvk7+Q6kjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gbNj34mIcxztxPJbOWUNJYdSbplYgK4TOEeBGAQ2dTOfuNB3piJzRpzmmEnRU/2iI
	 aNqN6KCz11dEoEnchenQ02aCVf3pzWEndcS97bWSWagU4w67pdN5ow6rkEVa6LTVvO
	 edYbUUbdJ5xfkOwADk2xEuabG6T3PKxVrXF3mQKX3qC8pEv4P/xhMPqkqiOhbGOHnm
	 tVHpWzsCYAZrzP6k8AJpsWes/CuQtgiVp41bEKA3XSwPXAMZndEe223cL/NcZeMKSk
	 Q7U/G4X7NKf9yRl/s+7ct7RBoB2qZNoUuxbui5To+DreHPC8w8hdeXXKZfFNe07gBg
	 ftGOiGLJqN38A==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	Shouping Wang <allen.wang@hj-micro.com>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	peter.du@hj-micro.com,
	andy.xu@hj-micro.com
Subject: Re: [PATCH v2] perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM configurations
Date: Fri, 11 Sep 2026 14:44:07 +0100
Message-ID: <178912838524.2439009.7355093627260324589.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910114601.165237-1-allen.wang@hj-micro.com>
References: <2fb3bda7-cd64-4dc0-99f8-c0fda8d42cf9@arm.com> <20260910114601.165237-1-allen.wang@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 10 Sep 2026 19:46:01 +0800, Shouping Wang wrote:
> When MXP_MULTIPLE_DTM_EN is TRUE, each DTM will monitor at most
> two device ports. In this case, {wp_dev_sel2, wp_dev_sel} will
> only use values 2'b00 and 2'b01 per DTM.
> 
> Previously the setting allowed values beyond the supported range
> per DTM, which could cause each DTM to select invalid ports when
> MXP_MULTIPLE_DTM_EN is TRUE.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Fix wp_dev_sel2 setting for multi-DTM configurations
      https://git.kernel.org/arm64/c/49daa3d668b6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
