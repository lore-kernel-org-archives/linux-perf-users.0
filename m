Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2D4052A6;
	Sun,  4 Oct 2026 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151780; cv=none; b=BjQWxIyvLkJ0w6P/4M/Ht4TRdcV1Ob/ILuDaVsivUlrggp0MMOnGet+WUL23Y/b85HritZS2FKEcG2kwsN8+nxalu4WJcW4BnnM+trlQaTVsxxjHm3x87CGnXdt3bCi4m4PfVtrl1wqdngp1N14MzwE6GbqtY3y4L3425Vkg13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151780; c=relaxed/simple;
	bh=wZg6gNnwTQANLDOqqjE0yli5GKAXyhPwZzpTVfy+1wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2N/C7Oz63IjSY8rm247Z5Iyj0hByCJz0+Gx+uQnAqWpjvdAnu4cdsF+TQ7EqAJsNashfRm9ITagp0orE4rlWYMqn9pRH46IA0WRRqs1dKxn59ETYsX4h8DVv3yNuqjDn32pC4TYa3/a97anD+7IIsvdcudeuLxdr9vY5zh8Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbZJVM4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbZJVM4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDDA1F00893;
	Sun,  4 Oct 2026 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151779;
	bh=CIysZCZmDY+hsmraxBJHQH/HCXeMIwx5nXj3FwnpnSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbZJVM4aJi45z4MD6FnfIIwGAZCzBlIK2SKaDsBl8ypr7Tk53Qis+r/5UedLY+0Xa
	 5MTaU7LSg0MsWm8HkKGlPyaOZM0MoHliMPdi3TZiG88ToSEOT+u4DjhSNXqjv6LcZ8
	 aBgZM3o9PVTKNHRHvUoRRmtZCV42Z2Bf2O0Aq0OF6NnRsndGAIx86Tpm1iEAmS3kCF
	 FbmPZZW2KdsFJ6nU6fu0Y2U5ff4DmLaeJiboUxUdXZ9oj4pGagrE+AdN9Idyp0pSpZ
	 tDGr4geVL0YIiwGrIZCFVjzJgUmup98Ibw7OQf+JxYbrCk0tNgDh87JN8DCFuEZHaV
	 c4Rqs044oq/rQ==
From: Will Deacon <will@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Leo Yan <leo.yan@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Subject: Re: [PATCH 0/3] perf: Suppress redundant ITRACE start records for Arm SPE and CoreSight
Date: Sun,  4 Oct 2026 23:09:16 +0100
Message-ID: <179113376395.1496517.2313914567669442516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
References: <20260901-perf_suppress_itrace_start_records-v1-0-c4fbc6860859@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Sep 2026 17:36:14 +0100, Leo Yan wrote:
> Thanks to Tamas Petz for noticing that Arm CoreSight perf data can contain
> many PERF_RECORD_ITRACE_START records.
> 
> PERF_RECORD_ITRACE_START provides the decoder with the initial thread
> context when that information is absent from the trace stream. Once
> tracing has started, Arm SPE and CoreSight decoders track subsequent
> context changes using context packets or recorded sched_switch events.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/3] perf/core: Export perf_event_itrace_started()
      https://git.kernel.org/arm64/c/ce512db53e0d
[2/3] perf: arm_spe: Suppress redundant ITRACE start records
      https://git.kernel.org/arm64/c/87f78017e8c8
[3/3] coresight: perf: Suppress ITRACE start records
      https://git.kernel.org/arm64/c/8f8301eaa400

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
