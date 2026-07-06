Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552B1CEAC2;
	Mon,  6 Jul 2026 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357101; cv=none; b=i3VttpVJvyDEmBZvXyKBC5RFAzTPYLgCdm2W09yV8A4Io4NZ9LRIdTx/FNJm67JNEYuJzjrTax5mRExLbWQHXmg3Md4/LHOQV3E00K62Y6zLtFRv8YjiIHq27i8Bb0Qh6nJbKMfrnhF+YrdQT5eHManx26we9gUW5H8Lpo2cHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357101; c=relaxed/simple;
	bh=Vxq8wm1tuwg5ViUg5kBv/LtXnM8Cl0ZVEh3EzgzLfRA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kF8Cd6ghJcMJvC2moELVAl5F0T+QoT50bxlbsgr/3wLnmNxLUA2R+HMfEINTlNyU0/9ummamdPwxahSP8Z1IBNrvU86a/9/d3eghbGZ3F15Sj0oKp4HgrvbZiuatgiHK/BRxoiDLwauY0BZHNeA+e1+nIWenj0oRF//jlevrc5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDvoyNGJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDvoyNGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54671F00ACA;
	Mon,  6 Jul 2026 16:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783357100;
	bh=BELjauPHS4gd/xEhBh1cfXqn6iRUBInz8sqBuH7iNvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WDvoyNGJqb7FQS1EYOprUaCsuMT+Y48BrYjMm6t23QQezKhv5GcNwdpfzrLY8Ah2y
	 uD8aYEVbuZ69FG+36Z0T8HYAJ+dbeZ5ua7Adlk1MYjEYxj6oV2VJ0Nz8CIwtKDB7Lz
	 RdM9lUiCAEo3mmtuUuFw8nF38pPEdv8rptGyUj5S9DNPMmZRHVGtZ3+4h5TkN5lOoC
	 gsZ9ldfEFiLK082HSq/uP7hFwMYFinmJnZBQTyj8p9sw3ShHUnDB6g+aAGiwaRdgPV
	 ghzpFx21u0JKcKSb+jQhWpyFaN/82w1R6crkz0FQQdat2WLI30a0LEdzd43CfjghmI
	 k1yCgSTnRK6vQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sandipan Das <sandipan.das@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, x86@kernel.org, 
 "H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 Ananth Narayan <ananth.narayan@amd.com>
In-Reply-To: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
References: <619d0a273011c935b2654eab5121a4eba5ab1c03.1780383172.git.sandipan.das@amd.com>
Subject: Re: [PATCH v2 1/2] perf vendor events amd: Update Zen 5 core
 events
Message-Id: <178335709983.2202965.9092443963678808556.b4-ty@kernel.org>
Date: Mon, 06 Jul 2026 09:58:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 23 Jun 2026 10:58:31 +0530, Sandipan Das wrote:
> Update definitions for the following events.
>   * PMCx00A - Add missing unit masks
>   * PMCx00B - Add missing unit masks and fix descriptions
>   * PMCx00C - Add missing unit masks
>   * PMCx00D - Add missing unit masks
>   * PMCx025 - Add missing unit masks and fix descriptions
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


