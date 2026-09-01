Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3139A4A0;
	Tue,  1 Sep 2026 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225668; cv=none; b=u92w1gE9NH+uvXw4KWNPPR3dhcVpP9k5/pDW93o3jKRj3P63OX7tdnetrz8yNZGgmew/ee3KqhIgj/+bbm+0CUDrfA74PWKTrjdlIEbdco+iqOurB7pBTEDuGtxVZqEmyPGuZSuNmaX12nJoFYbbwYJ5HpZ+8EVgLOrY4fsWSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225668; c=relaxed/simple;
	bh=znltqrM1P+9mvaURvC5a+K6iWkaN2azQYAMKVy8sYhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/B5M1q0fBOjjuldKweaT+a/W3wLaAic7BumPG7hvulP/xOCsYE1ZRBLWK7Qxm0zfYc8BB/+jL8du5h2u2mKranwbJzxH3tHwije+AXx81F5wL/MJLMQxYK9jDiDm4AF7MIh0/fyoeoJa0ODlbjDciHgsHOkkRzqkhJnYkU90RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVudNs4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVudNs4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A87B1F000E9;
	Tue,  1 Sep 2026 01:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225666;
	bh=8orNIjIzUT4JrVxYvCjtONO0FJhQ3qvHew8AnoJI+R8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HVudNs4EneZDpRt4nbHAt/jkOVjS9ezphRcYSiPhrqHFYYnxKJs7SOV3Epz0fnlDD
	 P5NgWH1ffh9t/jJySqSjNkAc/wGfAWJc36SQELSy6XU/6nHM2zeIWgIV6m9rxBTG7D
	 aSWW0KVO4/LKx+MJizs0cx8XFHuaqkazvywwAfcbFzjQSTH5GqR+vB7pLkJKsEroJ6
	 ZLg3/OpK+XoW1zoFVwCzcwOYUgYx2Xc+x0wylhPXJSQZpee+x77g4eQ3gyFGbls5Da
	 Y88hpMuJT/YeeK6zDzrc/3ochgyYu1KA1JsLnZO4TlUa8XA/Qg+z+Iy+m/vsHK5cVC
	 wMBLPZz2m2T/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568783924A45;
	Tue,  1 Sep 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 2/2] perf: RISC-V: store available counter mask as
 bitmap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178822560914.869454.14196508746211130249.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 01:20:09 +0000
References: <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn>
In-Reply-To: <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev,
 anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Paul Walmsley <pjw@kernel.org>:

On Tue, 18 Aug 2026 17:10:00 +0800 you wrote:
> The available-counter mask was a single unsigned long, but iteration
> uses RISCV_MAX_COUNTERS, which is 64. On RV32 that reads past the object.
> Filling with an unsigned-long bit at index 32 and above is also wrong.
> 
> Use DECLARE_BITMAP and set_bit/bitmap helpers. Walk each bitmap word
> into CFG_MATCH when checking events, when allocating an index, and when
> stopping all counters. Set the counter base to i times BITS_PER_LONG.
> Share the CFG_MATCH ecall through a small helper so the 32-bit argument
> split is not duplicated. On qemu-system-riscv32 the probe bitmap has bits
> above XLEN set, so the first word alone is not enough.
> 
> [...]

Here is the summary with links:
  - [v2,2/2] perf: RISC-V: store available counter mask as bitmap
    https://git.kernel.org/riscv/c/e7bdbf5131ff
  - [v2,1/2] perf: RISC-V: use BIT_ULL for u64 overflow masks
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


