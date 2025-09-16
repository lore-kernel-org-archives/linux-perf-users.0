Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85D31BCB6;
	Tue, 16 Sep 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057248; cv=none; b=M2S+Ewut3R3LtzxzwZ+3yz4tMugJs2PbiXqypKiFclOIl00drOfydwcY6ytAGmNmAagTFUPp4iPNFmiyTAlUX21PHhu95KgmO+KSxVX2tb8uBOKZIbqTEyp6vo67Elfhntftew4JPK+BfZoXgudtxxGM4MOy80Q4urp9/KruNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057248; c=relaxed/simple;
	bh=fhcQ7mAvVQamgqtHY+IP4JtTNxdI5gFnZDUASczOQrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJKd41VNKoJwczfmWfSJg+YvGdesLNjSf2L3FdItRb6FldI2f/kQKgRvOeVFFPtXL/IF6P0i7omRDws6bCkF4tCGOfEtmoD8UMORAho4pGIfgyWzrx7Pbti4Kz3j74zlVA6avwLxWd3QjJzORiJgYbJ9vNyzaBwjjMDUqdbu6zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ralJvAev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ralJvAev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BA2C4CEFA;
	Tue, 16 Sep 2025 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057248;
	bh=fhcQ7mAvVQamgqtHY+IP4JtTNxdI5gFnZDUASczOQrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ralJvAevmAck43ywds4IRoOCtDf/FHWU52FahALhd1vamULYr5PErWWEbusFxfDuY
	 FPtnmNDbFZtp0aMq6X4k865RchoW/AUkyeEx39wEaOeoF8mKVIMSyJ4vEEDunsuCqA
	 keWDAIbNqS4CE72O5EQo24hR0ASWju6mnyYZ9hC5IaHMEU1G2M0S+KiRhryVW9t+4V
	 Id19tGEOHisWHaLVLg6UeyIOdhQwdyFliSNufFnmXfAEW32W598I8+xvsGOMH3T4Tl
	 0+kk/IdXJWNEJ+i9qqecslrXGGZScEXMo9mVJ/mVVTszxHXgB9n1XvIWchQrAJw/BG
	 x4U60EYlkIjNw==
From: Will Deacon <will@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	Jeremy Linton <jeremy.linton@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	thiago.bauermann@linaro.org,
	broonie@kernel.org,
	yury.khrustalev@arm.com,
	kristina.martsenko@arm.com,
	liaochang1@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] arm64: Enable UPROBES with GCS
Date: Tue, 16 Sep 2025 22:13:49 +0100
Message-Id: <175805110604.263842.2881563818650081445.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250825033421.463669-1-jeremy.linton@arm.com>
References: <20250825033421.463669-1-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 24 Aug 2025 22:34:14 -0500, Jeremy Linton wrote:
> Currently uprobes and the Arm Guarded Control Stack (GCS) feature are
> exclusive of each other. This restriction needs to be lifted in order
> to utilize GCS for generic Linux distro images where the expectation
> is that core debugging features like uprobes work.
> 
> This series adds some user accessors to read/push/pop the userspace
> shadow stack. It then utilizes those functions in the uprobe paths as
> needed to synchronize GCS with the changes in control flow at probe
> locations.
> 
> [...]

Applied to arm64 (for-next/uprobes), thanks!

[1/7] arm64: probes: Break ret out from bl/blr
      https://git.kernel.org/arm64/c/47687aa4d9c9
[2/7] arm64: uaccess: Move existing GCS accessors definitions to gcs.h
      https://git.kernel.org/arm64/c/ea920b50ac9f
[3/7] arm64: uaccess: Add additional userspace GCS accessors
      https://git.kernel.org/arm64/c/9cd2a7f1180f
[4/7] arm64: probes: Add GCS support to bl/blr/ret
      https://git.kernel.org/arm64/c/efb07ac534e2
[5/7] arm64: uprobes: Add GCS support to uretprobes
      https://git.kernel.org/arm64/c/4a601714bb24
[6/7] arm64: Kconfig: Remove GCS restrictions on UPROBES
      https://git.kernel.org/arm64/c/cc66c711e58f
[7/7] uprobes: uprobe_warn should use passed task
      https://git.kernel.org/arm64/c/ba1afc94deb8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
