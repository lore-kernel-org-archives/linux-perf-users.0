Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94782254863;
	Thu, 17 Apr 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900072; cv=none; b=LowbvC35m+DeN1/IV6g3UAnWYjL6GHjOWJVPTXKZd/OGVC4ev/JhIxPQURPlKi8GEwXP99J/tQoZHPrtAWWwzq29ewgx1qszlriy8nBVuXtaSikBpqkMNWJ3yKKuNZVLAroUbKbGTfjlTj5/fIlWD96RH+1fbBPgkuyLTMt+lDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900072; c=relaxed/simple;
	bh=OPly8D2XQu2bxfiyA5S6Ib+YauTHnSi9SxZQPh7ctz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdZ94es855HFgMg6LrhndXfZwAgVJXQk/YC9csZWGoevotZKoMZK3lh8ejAVdGNs4GJG0FqOHJ92hMshzfWn2ak6D/imspMOrasYVmjF1oJUlTd6ThTpGweXI2nsoPV960bzQy+YY2+GDpN7zLMpuSpKju7wpj/EO0ICwKg/ahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzrWfm7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzrWfm7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F17C4CEEA;
	Thu, 17 Apr 2025 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900072;
	bh=OPly8D2XQu2bxfiyA5S6Ib+YauTHnSi9SxZQPh7ctz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzrWfm7XoLjvVMKrTdk+TFsnQRA9SBfxaDwgJicMXGC2Xamdh3oUMB8EekTeP+Def
	 bcAKZidsE0o3QbxoxDd65oR2vAFnubxqdTkaDE/wonU2wz6jgwepX2ErJd1SaHtFKr
	 v6qQ2ueHfRXy0zJXSgbdbsmgyNpQ++Cnn4eGVedKZc7Av6B5OnGi/hCJSOvASeihcq
	 Ht8K6YqRCpbhPgDZ19cV4fsRPqCw/f6FQRxxX2Sov91ldWY0NLb35UJikxLkibkBLi
	 O2JxRYokwXR2is2t98A+nEacDNP2NrmuaIvzLihAM5yAyIfEb1+GjWq6c62HF/in4B
	 gfpBREDoFUw8w==
From: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] perf: Do not enable by default during compile testing
Date: Thu, 17 Apr 2025 15:27:27 +0100
Message-Id: <174489653742.2697847.1079663986499485577.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250417074650.81561-1-krzysztof.kozlowski@linaro.org>
References: <20250417074650.81561-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 17 Apr 2025 09:46:50 +0200, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers, but only allow to choose to compile them.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf: Do not enable by default during compile testing
      https://git.kernel.org/will/c/70cbcb2850ec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
