Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095901311AC;
	Wed, 24 Sep 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730206; cv=none; b=PWcv3T4lsC7gsIGie5L7KA4cPLiQUIfVAIndRB8fHg9432h1gUB3KLgUjyjp4XaWJGxWjZbQeuFKq3vdZJtUSfsmntUdismX7BdoIbFTuAtI8XiEgKAQMz2qBWrWZRMsNSarN+HPgrDQzSG1tL076A91bZQIkwr8GlxGyV6QQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730206; c=relaxed/simple;
	bh=oZMitb7M22Ej6GRU2hUfNuXfDkljVEWaa1LZL7XbmAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4Qoi7GxIgru9szPXZQEjwXORZcE2ch5ibr9oFSnNzXvYUDI9KJufKUhrNo97nD6qjlIQT6LuGFhKunC9+CBhRbgy4tPOAQLU0eXLuJMCWj8qjXivxXtbEhtgtI8JeTcmBON8Yrf+YRQVzCnUQFdK7J1QOEvIohHF1yVIUrQ6H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig6xByBE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig6xByBE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62172C4CEE7;
	Wed, 24 Sep 2025 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758730205;
	bh=oZMitb7M22Ej6GRU2hUfNuXfDkljVEWaa1LZL7XbmAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ig6xByBEBw/6LKeaCNF8IllhULFNjthYcNuED5Mu9YT+mpc6F/iF8noUoy+TfAEXa
	 k/oJX9OqDwIDjzx6l7gVvtq9g4iK7vuWLtgOsgh5eM6Uv8gl5sgC1cXH93D6OR23F3
	 iQLp+z/JOLRiZOt51PUz+pM9Tb0jHajco2oY3hOOp+p3/ISoGPeJKcGgAkn80ZLPG4
	 EXSjh64SQlRwwmpNYTQU880gymK4JSHEtgeGz63bMzbFJH4Vb3iDca7WjniBYL5dpX
	 if9a609uJvcOR+q976D34VLr9M9zdiLE+bC2qBcaXDBhJIGRAvn/Tcw6jTwpI7qMxh
	 epNhwte9caNOA==
From: Will Deacon <will@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	dan.carpenter@linaro.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/dwc_pcie: Fix use of uninitialized variable
Date: Wed, 24 Sep 2025 17:09:56 +0100
Message-Id: <175871240090.2379729.10967323290224502441.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923213136.8107-1-ilkka@os.amperecomputing.com>
References: <20250923213136.8107-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Sep 2025 14:31:36 -0700, Ilkka Koskinen wrote:
> Fix use of uninitialized variable in group validation code.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/dwc_pcie: Fix use of uninitialized variable
      https://git.kernel.org/will/c/2084660ad288

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
