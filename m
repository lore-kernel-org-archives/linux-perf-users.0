Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC631DEFE4;
	Thu, 20 Mar 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486444; cv=none; b=qqiVpx33UmVyMZxnvJEgTDZYqnAbvC3kGgfKtXEjo9TEjjzAoYHpycrYfu0aqvU+90d47+a9bivaS9FMXwfSiZpjwj8tO4e5t0ETO+UbaFk6Q8IN9JInkH5ciC7yIkL9PwMtrVdf/uTZSKd06+XtO3+yB+bQdmtY1W2Kso/YGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486444; c=relaxed/simple;
	bh=ZrZ6pPWFymFNidzRt2WThDxFrIE/cEW7YG+avE2zXmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NN/MFdentGtfCqLX17R1UAl6mtSD8tM73uIz0oPUMQikCAtf6byo2C3C336YVH7qZ5c75GF0cgv1UpHZozZpDQvO+dIdw0MvIM6enP3MHWgoy8hAffw0Nb0SHGuPoqjfEUUQj+dJDd2BAvjUgzYUOhvrDomzPKQFx4zeM0HJX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blhWxaVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blhWxaVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE694C4CEE7;
	Thu, 20 Mar 2025 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486444;
	bh=ZrZ6pPWFymFNidzRt2WThDxFrIE/cEW7YG+avE2zXmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=blhWxaVBpZm9WrQcpHom9TqivQrOSJ2wneSQXQplfAeJ0O2A7BQkrLO2LF/5CmwS5
	 SnY5OrLGPEVfrY5qOkyjfg+wNYlQAD/xk4NlETspaFD7H+k0pj+lBKp8V33c5yo/qm
	 wuvFc8DuQlWgCjZfbE340ZlYZOzzRgmgk4XAmb3sE74/oHUn7Ri1369EdxqMNdyK+m
	 CCuakzlmxHewQ4JR5CZXD4r7EldamWLlSvmiEOU1LTdXzgEA2Kv1xb3/PW+TTv4QZ0
	 VjV0ShMpocmBgiKPStprdbrjhyUrYuwnuJUp7dl74HSOEn/P0Ckp9cSGnnJnZZEleE
	 HsEqw2tuj+aOg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20250319114009.417865-1-james.clark@linaro.org>
References: <20250319114009.417865-1-james.clark@linaro.org>
Subject: Re: [PATCH] libperf: Don't remove -g when EXTRA_CFLAGS are used
Message-Id: <174248644371.3704425.15114872503087361576.b4-ty@kernel.org>
Date: Thu, 20 Mar 2025 09:00:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Mar 2025 11:40:09 +0000, James Clark wrote:
> When using EXTRA_CFLAGS, for example "EXTRA_CFLAGS=-DREFCNT_CHECKING=1",
> this construct stops setting -g which you'd expect would not be affected
> by adding extra flags. Additionally, EXTRA_CFLAGS should be the last
> thing to be appended so that it can be used to undo any defaults. And no
> condition is required, just += appends to any existing CFLAGS and also
> appends or doesn't append EXTRA_CFLAGS if they are or aren't set.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


