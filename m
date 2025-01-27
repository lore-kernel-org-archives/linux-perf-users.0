Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322418A6C5;
	Mon, 27 Jan 2025 18:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738002887; cv=none; b=LDRP3/e7wq7aXBlsk29rw9BRLyLyM774BcKTPovs70L3ZTmegdRQ9Xbae2ux6UOKErMCY2388LCc8/WdWLR6Nc4AoeeuygG+ZmMb+xpLAC1QQgnYtVyrdinXCyTxqdKDsRHfqFwjJxCo99KAhi3BkBfGbraQvOM8HR0miaVFTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738002887; c=relaxed/simple;
	bh=C6uwNYp70YNaFc8vV0E6ub/hzqMG8y7NkFTOy5GUAAc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WImdEiRUzDajSlmBAAoGnIeSUtOoMlNSo53zw03l2FasAlQFBlqi5yFXbMBBWlKhYnprGy0cG53TMkG+xOuvhd7ujLyDtBmvWHjksCzsoDdV91osrRkJk4Tq4ElQF5AUruuUw1F49g7rxdoIaaIHasFAlOQiogm8vKKVzOKgxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6aUNzb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6aUNzb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4130C4CED2;
	Mon, 27 Jan 2025 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738002886;
	bh=C6uwNYp70YNaFc8vV0E6ub/hzqMG8y7NkFTOy5GUAAc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=o6aUNzb3HDIg7tuL6okBPOXxD6fvZ7WDC7ZheBepTjXaG7mIIPvNc32YgYyP7gkqD
	 cDCiS2MFlyBG2sFJ9vmVnEoBztpMzgzmkPZTXtxEBBZXBeLPAX84SyRAaena4JWr/S
	 bMzsEClFgj50BZldAg17D+Jx1TUbOUxR2+oidkFoivzuWQb9H6gf4hZPDJXAVmJJxD
	 E+Fa7LL2g4Bwok6JSKA9wB3jobgrlwOPqSwitzskRbnwGpsfryc37d9bfIUzxws50I
	 NyQEvJXgXGSWOPNnRY15pmXSWznJULs/Hh1j6gi1HNAq9WMrYfAZ/W5AcfBbkiLS+Y
	 x5VzXUi9Tg+lw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Justin Stitt <justinstitt@google.com>, 
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
 Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
 Li Huafei <lihuafei1@huawei.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250124043856.1177264-1-irogers@google.com>
References: <20250124043856.1177264-1-irogers@google.com>
Subject: Re: [PATCH v2] perf annotate: Use an array for the disassembler
 preference
Message-Id: <173800288595.34239.10214825871343123909.b4-ty@kernel.org>
Date: Mon, 27 Jan 2025 10:34:45 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 23 Jan 2025 20:38:56 -0800, Ian Rogers wrote:

> Prior to this change a string was used which could cause issues with
> an unrecognized disassembler in symbol__disassembler. Change to
> initializing an array of perf_disassembler enum values. If a value
> already exists then adding it a second time is ignored to avoid array
> out of bounds problems present in the previous code, it also allows a
> statically sized array and removes memory allocation needs. Errors in
> the disassembler string are reported when the config is parsed during
> perf annotate or perf top start up. If the array is uninitialized
> after processing the config file the default llvm, capstone then
> objdump values are added but without a need to parse a string.
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

