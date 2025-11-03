Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A479932ED59
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Nov 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181887; cv=none; b=q6bpn9F+hbCwY3luRo59WTHAroCCu5jvlDFYmrrLe95nT87ZoeVf4XptWP1klGBfztoF7culSjCqB1adq6aI5aqlO5zupL5RzQQIXo7meV009qongmVcpRT614VvIgg8y4VNmyzm/RbCmsGV4jbGjhR/nXAonGM/sXRGV2P9aNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181887; c=relaxed/simple;
	bh=VB+OJdhFko++Cc4PEpxdVhhL1Tqf3bp8WQNWSVbu7VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkZ0JDTFXmAoNOqBsP1TbQ/+iMEUzWDTug769jqXBKH2GI9ZXiSGopocVWL2XOgspMF0uYJBVfLiobZUI2n4Il0xLMtcocLVV12GqUq+iozcEdOwZUbB9UJ2bISZGGxCI6zQmRWqTrNUyq8CNzeuCC+9GOtUR+uPTowUAb7kwCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdkfw/5V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdkfw/5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910E1C4CEE7;
	Mon,  3 Nov 2025 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181887;
	bh=VB+OJdhFko++Cc4PEpxdVhhL1Tqf3bp8WQNWSVbu7VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mdkfw/5VBc7WvLgks52fmjnPgUxH4An/R0ffGAuU8ozjeaLHfK+eZAu/FgfgvcFx5
	 iimo5wFdIP+w6X7S8c9uABeZ6Q0Zrt7Q3EnrSS3v0nhEcsSE9Ur9MaW9/ioMmpujQS
	 jb0FEa/tNNw0pmHbT+Dim+3LnO4IHMLOPb6YUTShaxH/hDADCdshdRjxaEgS1u8ckq
	 6DIh0KMPvbP9iwMjDrAX9clDVCKSY7pOdD7WwQmt4Bqtx8YU7zEjvmaMvyvCTiuTeY
	 IQBVvxEC/6u6Z1yLjP+c7Ib3k5uvBXN8TzlKNIU9Un8hfMsM8tl4fy0/kLfZbuoVO1
	 VTxiymJYgvnsQ==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/arm-ni: Add NoC S3 support
Date: Mon,  3 Nov 2025 14:57:49 +0000
Message-Id: <176217955803.2904482.3019050250965959797.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ddb1dbaccce2f092bbfe1029982aad3a81bded71.1760960572.git.robin.murphy@arm.com>
References: <ddb1dbaccce2f092bbfe1029982aad3a81bded71.1760960572.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 20 Oct 2025 12:44:19 +0100, Robin Murphy wrote:
> NoC S3 and its SI L1 sibling look largely similar to their predecessors,
> but add the notion of subfeatures to the discovery process, which we now
> use to find the event muxes for each device node. Plus, as ever, more
> mildly annoying shuffling around of some of the PMU registers (this time
> it's the counters...)
> 
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-ni: Add NoC S3 support
      https://git.kernel.org/will/c/8fa08f8835e5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
