Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCCD26A
	for <linux-perf-users@vger.kernel.org>; Fri,  3 May 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757590; cv=none; b=HHK0pxsziazlLebUw1wQXtC55IyvRQj16l7LBgEZE9Mf4PuylggVAWR4ckxakj5n6MSjmhAyer8C3ZxQA8TQH8Ryt2Hx/gAXPNGpZN2SB9HeVgpwnThWkLLDXvBWw9QFsLUJcxsgVfgcX8yjwWSwkryGMtKGAljMnFnhuL3Ix0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757590; c=relaxed/simple;
	bh=QkHY9wC1vHTe5PjjtPVhxTK+2sy4+HiOlp07IzKsFrI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNtoslkI23eXH7Lvz/VBphGoCjLIByk6UcNGuYQMuSMDNEVjqa4y9mijk+3kpeqTF1YPtv7nNQoib9NjJ3fDu0zZQh3KiAw3KAIVHNGRyF/3QuO6zwiBQ5+zHYSneL3426h6SCb6dPOm6G4ttqODjOJeZ/n6LB5ADpvIjwEhjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9qh/Fak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9qh/Fak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB53C32789;
	Fri,  3 May 2024 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714757590;
	bh=QkHY9wC1vHTe5PjjtPVhxTK+2sy4+HiOlp07IzKsFrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q9qh/FakP+zRbMzq6bLLiXGlYJVkVzU4aIBdmIQ/9JV5VAbH+Kh6R8kqbtG2wzszI
	 qyjercuIiOhhqAOKlfFxqsLHjdlYwl9GGDc8SGh4p10r7h91tgbfmk4zlrmG5BLGCp
	 ju88fjBBJygHyNacZuC7i6aVRGnsXx9HIrKINSCQ+r7uLoz0RrfRyw1LQZCmvXMB1a
	 bnVeNoPoyfDYbb1tzUGcDiRmaf8i39rK1Gdk6U8V6fTnw7O2JfxLoMhECWaCHYRo3v
	 DVAf5Nkp2kuxBoS90WU/GsIEUE+Mjx60eqwF2PMW+acdKLU95JBpPCjr9dzYAfCWiA
	 yukjdB76cDaQQ==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kaleshsingh@google.com,
	ardb@kernel.org,
	chenqiwu <qiwuchen55@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	chenqiwu <qiwu.chen@transsion.com>
Subject: Re: [RESEND v3] arm64: Add USER_STACKTRACE support
Date: Fri,  3 May 2024 18:32:58 +0100
Message-Id: <171474196646.3291931.10296754669267003473.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231219022229.10230-1-qiwu.chen@transsion.com>
References: <20231219022229.10230-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 19 Dec 2023 10:22:29 +0800, chenqiwu wrote:
> Currently, userstacktrace is unsupported for ftrace and uprobe
> tracers on arm64. This patch uses the perf_callchain_user() code
> as blueprint to implement the arch_stack_walk_user() which add
> userstacktrace support on arm64.
> Meanwhile, we can use arch_stack_walk_user() to simplify the
> implementation of perf_callchain_user().
> This patch is tested pass with ftrace, uprobe and perf tracers
> profiling userstacktrace cases.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm64: Add USER_STACKTRACE support
      https://git.kernel.org/will/c/410e471f8746

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
