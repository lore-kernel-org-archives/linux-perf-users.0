Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C836E46D;
	Tue,  3 Feb 2026 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150553; cv=none; b=kLHI3B/GPofWNO+S7/apBO7HpcKQraMChRgRIfGKxDCqO/NNiuY9eQeiVkegEasfEe9q4k1+CQXALlpdKfq2gVA8J0Am/KAKgGUc6IKFS+qn9SDjsYXO1efDGkktIh2t3+vQqbVGU9Xl7w0iFBFCd0oIlN7NYHAbHL0QZcyAMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150553; c=relaxed/simple;
	bh=HV9GtDj+hx1JotaPaT2FhgGu/piJ23CCSZj/DKzldBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URQTgiyQUVHalK1yPxOalZN16QyXrDvcfl8u4qD3N12LjZ8bA9Zf3H5ThdmhuHoz457uVXg+uWn0vXQWvrmBiAUSmPzsn3jNutbjtnyrdttmmJ7YUOYgkAFuTGvLk15SAUJBi0LPCbr6cnSbP/r9SX/SfrdbZ6jyoHMqczBge4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hrar6Kr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hrar6Kr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF4EC116D0;
	Tue,  3 Feb 2026 20:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150553;
	bh=HV9GtDj+hx1JotaPaT2FhgGu/piJ23CCSZj/DKzldBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hrar6Kr0tachNUhq+EIJ0VQ4KiFJ9cEHPth9Ue/TKJP6BiLld3Z/fY7/qeRVRXhoU
	 hhGAeWmcQPXPomEaEIrACKJGaqm7UKJ7vohFZtZ2K6s6GOwmn0+FZpPbB6BXzm7qcB
	 DLHWzb7odWmsv8ZuixLPn9i8ghjPLCNBVi29rMFiVQ+D68BcVF0aUk2yBdOMQ3aWRP
	 pY+RUp9P6YyigPa6yerOp1FnK7+IGSfglzeAYwGu2skY0uIaJPDNDfyqcMcSQmLBe4
	 kTxHWd8ZKIer7X/EiaGniIu2LW+pANXL0O7xEywWOHRLv9RdB6R9wP+EI9xUKDtjqx
	 0A54yuiFdcEOA==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf: arm_spe: Properly set hw.state on failures
Date: Tue,  3 Feb 2026 20:29:02 +0000
Message-ID: <177014771123.2668461.9075722971112388662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203-arm_spe_fix_truncated_flag-v4-1-1e07df317584@arm.com>
References: <20260203-arm_spe_fix_truncated_flag-v4-1-1e07df317584@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Feb 2026 14:40:43 +0000, Leo Yan wrote:
> When arm_spe_pmu_next_off() fails to calculate a valid limit, it returns
> zero to indicate that tracing should not start.  However, the caller
> arm_spe_perf_aux_output_begin() does not propagate this failure by
> updating hwc->state, cause the error to be silently ignored by upper
> layers.
> 
> Because hwc->state remains zero after a failure, arm_spe_pmu_start()
> continues to programs filter registers unnecessarily.  The driver
> still reports success to the perf core, so the core assumes the SPE
> event was enabled and proceeds to enable other events.  This breaks
> event group semantics: SPE is already stopped while other events in the
> same group are enabled.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] perf: arm_spe: Properly set hw.state on failures
      https://git.kernel.org/arm64/c/283182c1c239

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
