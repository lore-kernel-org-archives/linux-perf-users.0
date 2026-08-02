Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218603ADBA5;
	Sun,  2 Aug 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785672770; cv=none; b=EKHvw0Zgy56PO902JH+X1ptYFH9Ggc7N3Yjj8gZD8k+X3+kXS8tLrvK7F8PChfhZO3BzAzBiXDCVM6LQkf+wnFYgszhHfCI61bylarYx6vkeGFT3xcjxycKYS9Wc9ZacSNS6nWy8ZFZFiWlbzG+vwPU3fhiPjWj7DquFiGbq0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785672770; c=relaxed/simple;
	bh=LZvokkyyUtHaBfyJpu3FvrAsjZY4bw5AaSbJZ1kAgfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3LGPw1K08apAZUs+BRsTBL9tEKadTvbxhK6/iygNUdx1ZPejuDpxKqkscof5sj7ssORA4XMTTAJiQIiaarPpriIBB5QrYfPbLRNLNCR73fpJ0+9dLN+1xiFQlqcZDk/vWe+/iTjsg2pO2T+qCgJXWsxqs/sabYEB3/jkeLFln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw0g52M4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw0g52M4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2F91F00A3D;
	Sun,  2 Aug 2026 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785672768;
	bh=SaSaz8RGZsqNo9m1yeqv6Ao6iUzBXu2udzfAfkEquIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gw0g52M4dq27e4eHhLAvR0akOBYMrcbdKqzevfujnx7xBDHnRdE2Up5IE8YMCzXXh
	 goAmdcwYlLgjgjhIkjitMH4ytpS6TcPlztE43ZHmyB+fyevvaswsAqLU3G9oFfjVfU
	 TsNsWgzSddKQDRG4rWC6jfJaRIk7AOd8g7TinbCrIADwneHtf6JQpBhboViranGKap
	 ceQE+Ih+YtWa2meIcwt/uvQfjCmyuz5ziqS1pvzr3UMW7idlp8JKHlidG56FaZpHoP
	 uAYe71KG5eQs9G20Ed3MEIrUco1t+UaGqILffDaeeosUKVobpmqxAGKlNhCkqt7nj1
	 ZEXcDZkhru2hA==
From: Will Deacon <will@kernel.org>
To: jic23@kernel.org,
	mark.rutland@arm.com,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 0/3] perf/cxlpmu: Misc updates
Date: Sun,  2 Aug 2026 13:12:22 +0100
Message-ID: <178566820605.1852506.11910406697826871109.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260715191454.459673-1-dave@stgolabs.net>
References: <20260715191454.459673-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Jul 2026 12:14:51 -0700, Davidlohr Bueso wrote:
> Changes from v3 (https://lore.kernel.org/all/20260713061112.105419-1-dave@stgolabs.net/):
>  - Validate the event vendor ID for CRB filtering, the Table 13-5
>    event groups are scoped by the CXL VID in patch 3 (Richard).
>  - Add Richard's Reviewed-by tag to patch 1.
> 
> Three patches for the CXL PMU driver.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
      https://git.kernel.org/arm64/c/ea434e8fd3a5
[2/3] perf/cxlpmu: Add missing CXL 4.0 events
      https://git.kernel.org/arm64/c/227137792148
[3/3] perf/cxlpmu: Support Channel/Rank/Bank filter
      https://git.kernel.org/arm64/c/0263e0b788d5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
