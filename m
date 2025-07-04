Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E142F4328;
	Fri,  4 Jul 2025 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651079; cv=none; b=MhtYiEgis21Zy5QZ5ajidwspZ2xYchuaDyOuMArFgugHVFwgA1NqH+F+PVw//FxYV9K/lJ3z8qaNTY8EZ/utCRNKwLjtPpDgRCsZwHgbI82ZPfRcoTzUE/PIniROhkG0vCo6imKAka0AjBLfRsckFDHsON9k4MZf0BTkv6Z494w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651079; c=relaxed/simple;
	bh=jaOjuh9ezxdhTwYcV1byDDNFMNy1vCBmMI29BMRsjzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7hfZkxa5oUBPqdMlxvY+b/BdwxF3rgr+YvkF4HqDyD3/BN2t9LewY+AxupdO7YSMgpdOAjhUlQ04grA4YFPzaHB/yMh2BtlyZc3Ywo3p2llpaBzjyUm7EbzjNfBMu1EVHovPef4zrFvCMEuTF1iqCN1PI51xDrMSe/nqnt9FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBk53Sbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBk53Sbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D6AC4CEE3;
	Fri,  4 Jul 2025 17:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651078;
	bh=jaOjuh9ezxdhTwYcV1byDDNFMNy1vCBmMI29BMRsjzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBk53SbiQxkcXuLVklXYlmlOZ9J2mjwMLe2UbGAqFjJw6NSNwxgXzFQQTVkC+zitA
	 1KEVw5Yb6E8newabjPuUj8op7FBBKs/lityI/KRl+mwLt4eLIRJ9uKumQVhcxdGa9h
	 EZCoKDAzvzpoYLkJ/wMkkIIsO48nrMAWIfywE8mEjIoxaFvnF6Gv2oyu7Su0XP5XP9
	 qWdfwat8g/1YA5nIEwCMYUp0IIick0j6GUPu5zat9Rq4W5N+nHzo/JJTNiNldXbvil
	 oY4Hs2Lz1B7a2q8BbbKu2tE2rptkIS2u8LXYo235BEgOnADVc7YGBUee5eIjuXMTOX
	 LHqWQdcnmteEQ==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com,
	mark.rutland@arm.com,
	Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Broaden module description for wider interconnect support
Date: Fri,  4 Jul 2025 18:44:13 +0100
Message-Id: <175164870782.4003146.18058724639917920993.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250522032122.949373-1-daizhiyuan@phytium.com.cn>
References: <20250522032122.949373-1-daizhiyuan@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 May 2025 11:21:22 +0800, Zhiyuan Dai wrote:
> The current MODULE_DESCRIPTION only mentions CMN-600, but this driver
> now supports several Arm mesh interconnects including CMN-650, CMN-700,
> CI-700, and CMN-S3.
> 
> Update the MODULE_DESCRIPTION to reflect the expanded scope.
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Broaden module description for wider interconnect support
      https://git.kernel.org/will/c/8b177e9a4ecd

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
