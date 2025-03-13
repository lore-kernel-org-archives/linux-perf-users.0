Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038201547F5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 22:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741904581; cv=none; b=cGvHFnaHpujylXy6J90xn+afFENt8yBzl5oSBhT+gyW1KtrngH/PBsAXAN5zuTiWYytGDZt5wr6CU19xxo35dTen9f4PJmSDlFTpTEzNuOaHOJGakPigVIe130LP1hWYrj1TfZDU8gG7LqIHvPhKuN4cC6UtSjw9sxP8fSJKHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741904581; c=relaxed/simple;
	bh=b1hfd49heWssTk01Vsf1Xhytpjfe93HShIU5rdJiXyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGT/3VT+W0kEjTNjAkfvXbMSKZyt3y4o0WulUhD0Pvlk9oinBvWv65sZ9iy/LJVrApMYHwO+c3GoPGBEgWmoYNYUM5gIXICpLGXGPmCGRiP1cSXU/lCXnbeBEIdMys6kPV5OB9tZvOwPI+h5ol34Fhf5gmTIBsjWfTbOt0UT3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrkWeDK4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrkWeDK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2789C4CEE5;
	Thu, 13 Mar 2025 22:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741904580;
	bh=b1hfd49heWssTk01Vsf1Xhytpjfe93HShIU5rdJiXyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OrkWeDK4jqc6nowXBC+kLr1gAIlWZZlpFYaEsgru7aHVDcUGDagcKPflasADM9K+i
	 Hf3OQjAuFlpnkBrSxTT6Bq5CdZMSL2EdMrfMj7zx4pEiODype5Oidn3XdOWdVmtlSl
	 V2OB0qgJeFCptvVHmBLlUWKKJ6EB4ly15KO0gHjNOmD5IBqdWHdBHWLHUpJ0qJpuy4
	 y+1bviSAqls8r0ZKFuVWRx+Xzj+5A34c0Kt8ArkhEYEe5Lf4KVTUTUru5AHIbQpmVS
	 c/izO5QO0oGFle65jDa5iW0hpCHvR/7wFDTgnSbBA5374Df79Yu77FHb2fPCjEkBH8
	 c1DajYzrHS7sQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	bwicaksono@nvidia.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/arm_cspmu: Add PMEVFILT2R support
Date: Thu, 13 Mar 2025 22:22:54 +0000
Message-Id: <174190170500.714070.6303342038303900840.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1741190362.git.robin.murphy@arm.com>
References: <cover.1741190362.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Mar 2025 16:10:05 +0000, Robin Murphy wrote:
> This is part of something I'm working towards, but I figure it stands
> up on its own enough to be worth getting out early. Compile-tested
> only, but it's straightforward enough that I'm confident.
> 
> Cheers,
> Robin.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] perf/arm_cspmu: Move register definitons to header
      https://git.kernel.org/will/c/862f7ad4d7fd
[2/3] perf/arm_cspmu: Generalise event filtering
      https://git.kernel.org/will/c/6de0298a3925
[3/3] perf/arm_cspmu: Add PMEVFILT2R support
      https://git.kernel.org/will/c/a28f3cbfd11f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
