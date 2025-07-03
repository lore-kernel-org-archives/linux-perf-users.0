Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06AA25A359;
	Thu,  3 Jul 2025 18:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566612; cv=none; b=NgrIWRlXONAAJqTYVTqEysWEfLvZCzUb+5m5fSC6U1+Ufr94MDLI68cs6CU041ZqNLGvcoodNEaXrtEchP0TSxebTur4/6WtiJ5cTUDHVf+APW5Bws4lFIa1qlVC2xR1b/fZ997ceKQqkaBio9hMCb+sBGeDBc5ogEp8yRftv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566612; c=relaxed/simple;
	bh=o1ygfIUs2D6Ii+zImBhRlv7diqysGMQalvVlCf2CpLc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XoJ+vr9sZS/UNkeNR0pCSLnt4Y8hBa14eQPvceXw+hMEEcoY8VJ9KtVRaB2B0cwx2rIs9lABiFym+gfsTCYUv/T+4U4fVq+FslZyvU686PkzkpRP2tcw6kB2u00waNzVl4VRQ8WW7Bi9Dl9HwxhuIofl4XUdhVBpjzI1Jx5DzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hauDdlfP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hauDdlfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C4C4CEED;
	Thu,  3 Jul 2025 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751566612;
	bh=o1ygfIUs2D6Ii+zImBhRlv7diqysGMQalvVlCf2CpLc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hauDdlfPgciEyOgS5M4jqm6nJxMhcwm14S2hw1Jib9mqLOuzcflv7Jid8jxB7nvVH
	 SvN7NPIHzaKEGXuqOoTwab/NQd4PDSZ3Bbkz3H/KWwx+Z7/HniDFllf4QiX8yXD9UG
	 /TrvEYTKTV6Vzy7THv7+XUQ1QeevJq/InzGsWhYK9pq3+RYnEXq1BQ0Hdnn1Yr3WS7
	 2sZUgFy+Bp2+ZGohH+KmvRsluSXw5XNDS8KdvFV5qn+KZWg/GhGf7we2B3zwKxJmpK
	 fxqYjyOmLuLYLZ31+4ZYL9HdIhuOi79eapuJbA/8U4rzadyojQkpnNpQiV8WQi4eGd
	 kPueKGIjHauiA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Yuzhuo Jing <yuzhuo@google.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250702175402.761818-1-irogers@google.com>
References: <20250702175402.761818-1-irogers@google.com>
Subject: Re: [PATCH v1] perf genelf: Fix NO_LIBDW=1 build
Message-Id: <175156661205.2551523.17663329970815067941.b4-ty@kernel.org>
Date: Thu, 03 Jul 2025 11:16:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 02 Jul 2025 10:54:02 -0700, Ian Rogers wrote:
> With NO_LIBDW=1 a new unused-parameter warning/error has appeared:
> ```
> util/genelf.c: In function ‘jit_write_elf’:
> util/genelf.c:163:32: error: unused parameter ‘load_addr’ [-Werror=unused-parameter]
>   163 | jit_write_elf(int fd, uint64_t load_addr, const char *sym,
> ```
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


