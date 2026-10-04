Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211A3DCDBF;
	Sun,  4 Oct 2026 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151771; cv=none; b=AlLWNQpF67LWWARLUF8M1vj7iXHwC7xI7VOR9Rx6lGEf+HCVzqRVyVtewvKWioJQL0XqQr9lgNcta2M9oOMOCObut6hKj2PMWcFAlc3QFQjqJ9QtvFKlnfdgJ5Uw6nie/NJK/SqDYwjF3yHy8j2VAPhHiNz64p476ZYFYIA6O6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151771; c=relaxed/simple;
	bh=dVywEJobUEoFYQ/MOQP61gc7xA+xPFX84o7qHb8HNqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t50mXA41TFM8ORJ5DkSAbJ95dUL3YrJVZQOvMkDJbqpYOUx6j6QY2/B7z5/HzD0t93eF3B8B4AahMqFH4nOyUBETfjv6fXjrrzovFBt+q7fV9/KU4ZJEwDcfExrULlK1X399sXcususcl07r2SVriiJBJ4RlS97TLKcHN2QPNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMngzF0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMngzF0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425C01F000FF;
	Sun,  4 Oct 2026 22:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151769;
	bh=CgA1DfGNrfOBt1OVKRPv+ER/a3F57vpvG01ZXsSAyhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hMngzF0NokD97R5TxX1Qvwe6lSC3LTvhAJEE/RXtAzhrCw/OVfue7LQpdyKwu3i8L
	 XmUTKqvfwT78ExIF7uDGJVOCziiL1Gfh/7hLebo8i6k+nw2vfmm3D/+EiqchaAMaeM
	 8WoGdWZ11JMW7m6w50m2anUdgPRU/iZWxG8X+0TevCT33A28QyHdkIRdAHa2mOerO3
	 VJN6HNp7bDkOmyTae8Xa+Lp6gBmeFmKdkNygSRWPo1n3WuMoZsex+Qn2J/DEpudWf5
	 r8Wc8oJXZSgZaSJBHci0yztuBPic4DEun2+JfrNfbSHVQx+G0eyztjHX4dGK8ar6JA
	 cm9IgMh1HXzlw==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Yury Norov <ynorov@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: marvell: avoid large stack variables
Date: Sun,  4 Oct 2026 23:09:13 +0100
Message-ID: <179113453253.1503657.5347304408862116037.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925130440.4107512-1-arnd@kernel.org>
References: <20260925130440.4107512-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 25 Sep 2026 15:04:30 +0200, Arnd Bergmann wrote:
> The probe function in this driver constructs multiple large structures
> on the stack, which ends up causing a size warning:
> 
> drivers/perf/marvell_cn10k_ddr_pmu.c:1168:12: error: stack frame size (1296) exceeds limit (1280) in 'cn10k_ddr_perf_probe' [-Werror,-Wframe-larger-than]
>  1168 | static int cn10k_ddr_perf_probe(struct platform_device *pdev)
>       |            ^
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf: marvell: avoid large stack variables
      https://git.kernel.org/arm64/c/7e17084177aa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
