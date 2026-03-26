Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F86402B83
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Mar 2026 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539267; cv=none; b=OzJS5HC3fLFCa8YCnQMW8v0KDk8Fw5ObuKBESeWlK5Sb3TwUxnoYd1w1m/FjU9GtMzDJmOmLE59JrblCdiFlseSAG1xqVJkKyjza+naPuLyPGDWItcW+p2jxNQgWblEjEC57uW0OarB0ouY+b2d6f/IeQe/wDfnRF6CONrfh48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539267; c=relaxed/simple;
	bh=FqheqJk1lL6/P39LtBNTxi4+TPbTmvmtoB118+COPRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBx/fzLL2e+sSyfNyQ1X2j4Z2JgscIMJBSR3hMjwZ6baqQ1TQBAQ3g6IJre8ZyEsIdLrtZjFW8lyY6MXFmMYh3GH2DDHRxqFmRulbuYcM7dKM65fTROwknsHZmULlGmOGIjZdqz0wY2cSh4xdumYx4sc3sfeJQLkhlksA2mafC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/OddXja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/OddXja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F806C19423;
	Thu, 26 Mar 2026 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774539266;
	bh=FqheqJk1lL6/P39LtBNTxi4+TPbTmvmtoB118+COPRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/OddXjaNt/vGeELtgAtqyNwf84ftpgYLToGk2lM9YUjVXbDQ26QaWoqsaHAKCg1t
	 l62qEQyUv7WIb7v7+q+t8uxvqCXLRGVzAqm1J7uh0Dx6vkkTpB93R7FIZ/ijB51bYv
	 6xVXVRvxxD7LV6jMAsY8O1f9dKPonlWuPZs6rH2ztYRbbgZJkcDJKvMiK1aEVxi6X+
	 NvNUaPq6Cttxvrl6hh6d3P0BpFu+Zkg8UYMv5xq+0QZFwqLpgFY/XcpV96KoHb/AIo
	 vbp+0UiGSwASXdhoxT9kZh54qR3QMdxSLosfbaUN3P2AMV00APxkaeoOPinwNQ3qPu
	 iysrfvQmRm5wg==
From: Will Deacon <will@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix incorrect error check for devm_ioremap()
Date: Thu, 26 Mar 2026 15:34:16 +0000
Message-ID: <177453861968.567299.14799580759740118541.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326090856.644136-1-nichen@iscas.ac.cn>
References: <20260326090856.644136-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 17:08:56 +0800, Chen Ni wrote:
> Check devm_ioremap() return value for NULL instead of ERR_PTR and return
> -ENOMEM on failure. devm_ioremap() never returns ERR_PTR, using IS_ERR()
> skips the error path and may cause a NULL pointer dereference.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix incorrect error check for devm_ioremap()
      https://git.kernel.org/will/c/d49802b6617b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
