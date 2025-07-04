Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59022DEA9D;
	Fri,  4 Jul 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651076; cv=none; b=WliW7EhmOg6bKELv76NZ+Z7h3dRdJltsCrHUkao1roYYA4uYASevmFJdLndGMs76+4eK7CaE9Nf6oA0DRbdDkCgIaNvwALak9XDQpic+BhM/yijc/83aD2mKqTRsq0068Ta9I6m8Tp92ogh3PXA8akVd7KPxDAMWYwHAYUgRmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651076; c=relaxed/simple;
	bh=v4HqrO/Loccpnm9IAZIiomMoOx53gCodU0/+eM3L62c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCVZgd0RjZI9TZzbH4vaDlL2rnzXUQuV4vWsI82OtIfZOOD3IfqKcg4mPoDGUNTIzM6BUbHR7Am1eo9dusE0640263gxM/EfPy3eaMf5SH4NtGKmbYHXsvpFmO0BuVzUZyJ+2bf3051ext37+WIBh6aa3Cb7Ysxuq8aaVpT9J4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEi8pj/k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEi8pj/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA0EC4CEED;
	Fri,  4 Jul 2025 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751651076;
	bh=v4HqrO/Loccpnm9IAZIiomMoOx53gCodU0/+eM3L62c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEi8pj/kCMl95J2lMztV2IxkDV8mgs4XOj5do6SyB7RcJ2kfsBK4xKMnFKuHFMxwC
	 7ZvMJy9KuGqDeHL0ZihnSDnxIEZvVlIRgTtK06oW9mB5aWdW/YPoVUF9bzYQgp/ibE
	 7lsO6jb0mEzBe5/S286MAekCB5dooB3Av9pNnlUCDjDiBy7qLcwgyMSAz1M+lU7HEo
	 zTk6cWB8Dgo2nmUD1kCJ+j6vMQzEfF9JExGzusMbiL20MHHlcjQPwKzYGegn6igtfU
	 00JTL5PmJeoLZrojg/I0nqwt4jtwodMdWDZsFBpiyw7qlAmLalCww8CN9fYC8BWMmY
	 wn/u5S88Z2dpw==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev,
	Colin Ian King <colin.i.king@gmail.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] perf: imx9_perf: make the read-only array mask static const
Date: Fri,  4 Jul 2025 18:44:12 +0100
Message-Id: <175164874778.4003522.7716174042065513096.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250611133917.170888-1-colin.i.king@gmail.com>
References: <20250611133917.170888-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 11 Jun 2025 14:39:17 +0100, Colin Ian King wrote:
> Don't populate the read-only array mask on the stack at run time,
> instead make it static const.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: imx9_perf: make the read-only array mask static const
      https://git.kernel.org/will/c/b6e37b27bf68

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
