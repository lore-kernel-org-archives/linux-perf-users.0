Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F485D2FF;
	Mon, 14 Jul 2025 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470146; cv=none; b=IjntCl0Xw8evnhFr8TyktwPzbf1ApAqyPBrPhVQABj8feFiXx9UMx71xbbZmzpvRWNjg/fyOvx0ymy8rn7z/MBc/upP51BQYWy1te2/VUW+OMUuqZTOl3Jw6DLEgdiR0kdQrqTQKOa/5qqXMutBxZOFsF1dH6ESpyCtiaXENR50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470146; c=relaxed/simple;
	bh=3Zio1HgVHjR3u+O4tSXZLt8lZjOvmTUKk8T66mWWPEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VTiD2rS8rkLK6qAiRTSGw62AA5en1/9ngVb2XPAKPUAZUKPDqUGIBfaQi0jukNnC72rZgnZxJo8NuJP4Yi1GRz2gPae+L4XQx0ZhXUKUoTmxryk8wjfztg64EkLhAvgpWcuhf6bsbJq4iIc4vgZ6+fH+Si0XHyIwkNKs9PKdFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQDDu+Kb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQDDu+Kb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B661DC4CEED;
	Mon, 14 Jul 2025 05:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752470146;
	bh=3Zio1HgVHjR3u+O4tSXZLt8lZjOvmTUKk8T66mWWPEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RQDDu+KbGKcVto/EG+rPMKOE5vYXf4WLofUofuOM5qa92WNrsnoB8IGEs93Lo05RL
	 WLA79YvhtM9uEL442H/d+nWoA+TPyeS3LoNR/wDU92vIVMxkpDgYof0b97lc1sRcJ9
	 HyZ8wyKPrc9o5z/Vz/B0DmDzYqaMF8PbyLnTEK+0C1J+KAMXLlRiDqqyfOq+w3k+gl
	 I7ZLtc9rBMm4tTZ7KIyduqAbBVmbhjEY8i/t610R0VudNPfYRV3b9g1Cs/ZAb5jWPu
	 t4giI05IT1QZdUeVfGC7lnJptuwPMTJHRFLTv2i1NRKFcUKzzJEdx+nABVZNU4PxHg
	 BIV0xIvfz7wvg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aishwarya TCV <aishwarya.tcv@arm.com>
In-Reply-To: <20250711-perf_fix_breakpoint_accounting-v1-1-b314393023f9@arm.com>
References: <20250711-perf_fix_breakpoint_accounting-v1-1-b314393023f9@arm.com>
Subject: Re: [PATCH] perf tests bp_account: Fix leaked file descriptor
Message-Id: <175247014569.2439485.13518661338130989352.b4-ty@kernel.org>
Date: Sun, 13 Jul 2025 22:15:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 11 Jul 2025 12:10:15 +0100, Leo Yan wrote:
> Since the commit e9846f5ead26 ("perf test: In forked mode add check that
> fds aren't leaked"), the test "Breakpoint accounting" reports the error:
> 
>   # perf test -vvv "Breakpoint accounting"
>   20: Breakpoint accounting:
>   --- start ---
>   test child forked, pid 373
>   failed opening event 0
>   failed opening event 0
>   watchpoints count 4, breakpoints count 6, has_ioctl 1, share 0
>   wp 0 created
>   wp 1 created
>   wp 2 created
>   wp 3 created
>   wp 0 modified to bp
>   wp max created
>   ---- end(0) ----
>   Leak of file descriptor 7 that opened: 'anon_inode:[perf_event]'
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


