Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F72485517
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036336; cv=none; b=BNa/LVmSUhKQtB5j5kgJcpWCbP+u0xWWlC9UVjaxGdMtVV6gW43tp3WnjZcIT/j7Yn7JJqFc7xhEP1jQp+PYoKo9mCKPekV8JussJyEUhmxp59akK95xRiswaoxhoGj5R662tbTZqNSmWOFkuLibprCSw+4QAcOKpyX5BjyGKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036336; c=relaxed/simple;
	bh=1T6xdx74KgvpnXXKwLzww061EVTlGYB+aMbSU/7g2RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9hWMpIDX4M/ehKPbjNCROiTiqUBsZEc0ZwWXsj63sA4iItsU0Mo5eheRsu6CryIuXjOwitToKBLFj4K0oD0ScagfGOFYehaiZk3abdgLvCd9qAU/G+EmpGsDi0jJdo+gSQwyNQBOomobm8JRwo8Q+UOwsikOwc93L3Wz+Y+5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9dhzPZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9dhzPZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621A31F00A3A;
	Thu,  6 Aug 2026 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036335;
	bh=NbD3F19AVXvWecKcziS92qP+6dpgOuiXS9NFtO8UefY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9dhzPZRTIMnSaqGW7duVoUiWfNXLMv8i/mBke6SSptU3hl0W0W8DODHm9ZZWj6Kz
	 iVzmv8ZScUZADuZvbx5IKJEEsQEbkSBt/mfe7xWdxlGncywWInx3cV0ykcqZF+jQcn
	 gnc7B0Kf62Gq30pP236Jmq5fu5V1zxwrlcY86wo/ew59nEbYSgprn0GvVTXyhdXGj9
	 eZzEXgM9PRNy+i4b9w8JInM9IL7QqxWCjWP/pGPvFx6IOa6JfKMS7YcaDYs1Y46mdQ
	 AAYUS3SSkw88j237gFj989Ojz1NNFu9Xfz2DhCVXmRfiK/z8/5llAcAaNma1HjYvgv
	 AzOR504tjwS3g==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	ilkka@os.amperecomputing.com,
	leo.yan@arm.com
Subject: Re: [PATCH v2 0/5] perf/arm-cmn: Support CMN S3 r2
Date: Thu,  6 Aug 2026 18:11:43 +0100
Message-ID: <178602260412.429067.9481734748320010942.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785252273.git.robin.murphy@arm.com>
References: <cover.1785252273.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 16:59:20 +0100, Robin Murphy wrote:
> v1: https://lore.kernel.org/all/cover.1782830759.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Since nothing else has come up, this is a very minor respin to fix
> the bisection nit that Leo spotted, and hopefully it's good to land?
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/5] perf/arm-cmn: Rename filter variables for clarity
      https://git.kernel.org/arm64/c/55c671f965b1
[2/5] perf/arm-cmn: Refactor event filter programming
      https://git.kernel.org/arm64/c/4da12d5c8bef
[3/5] perf/arm-cmn: Refactor event filter data
      https://git.kernel.org/arm64/c/f1b844fdc0d6
[4/5] perf/arm-cmn: Plumb in new filter types
      https://git.kernel.org/arm64/c/09178f536bb9
[5/5] perf/arm-cmn: Support CMN S3 r2
      https://git.kernel.org/arm64/c/21afe52e546c

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
