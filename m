Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CF1B81C3;
	Fri, 30 Aug 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034352; cv=none; b=fsF99+4iKr3pmu+8msRS3cZlMEPnwLJNmyeiQ0SRpYhNnpjxPbdya/RRJDcK/qvVv2gMLSEMfQpQtAkVV9VZM4+TvmkdYtVMeBFBoLuDg7JT3oQWRvKXrrvx0GYAmJF7TZpMuBWmwUIUSgmYxU0h0yOMy/tA6+DjrZwFzzje2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034352; c=relaxed/simple;
	bh=g9XfvD3q/Dl8PLtHo/kQwHc+kLWhm5eWuih+JylYTPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fl2mFghdoD4tIw3ux4pi44KBO0DlXYyb6KO8Z2cWAmY2siXEgihhAjCc/Dm1/ceuqJjV/TnD3egoYZ9OqF04X9uTLMb+zlUqisTD1yi3y4/isGhX2DDORoaHK87TpZ1kYDOhLQIfnVOfEzBc5cyRoQDBSCc4i6Sax32eD7K/eEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIvQ8xI5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIvQ8xI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FB6C4CEC2;
	Fri, 30 Aug 2024 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725034351;
	bh=g9XfvD3q/Dl8PLtHo/kQwHc+kLWhm5eWuih+JylYTPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIvQ8xI55U6+R+O9IUubidSB5JhbqvFcQrMgEk53F2adJN5+xg0OltcyjjgJeuIni
	 M6dpheSuwFrWjx2C5E2n3FXxP8uEo2aYc76/CmXUGgzDFA30SUsmO8cvqpJtRCXymo
	 Q4AsK0c8Q76hAdlU82d2YM0bzddAPLaZSWW/I9coboruTKrWQti6D78kqAG/e4M5B8
	 UDZG04SkNt5bSNWgAEXhnIYhkP9+j8OEkIEh1oNr7zpV/kq5BLeCQBms+JvuBZqpqI
	 zRyKQM9N2pNikoCPzz/+O/XKWxgP0yt6GrjhmAFVYGMjpUgaAe+2bHmSQ2kFRAfA2I
	 6gP/kH7Qudwog==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	James Clark <james.clark@linaro.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	peterz@infradead.org,
	Al Grant <al.grant@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
Date: Fri, 30 Aug 2024 17:12:11 +0100
Message-Id: <172501332409.1008166.7238309612916378266.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240827145113.1224604-1-james.clark@linaro.org>
References: <20240827145113.1224604-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 15:51:12 +0100, James Clark wrote:
> Use perf_allow_kernel() for 'pa_enable' (physical addresses),
> 'pct_enable' (physical timestamps) and context IDs. This means that
> perf_event_paranoid is now taken into account and LSM hooks can be used,
> which is more consistent with other perf_event_open calls. For example
> PERF_SAMPLE_PHYS_ADDR uses perf_allow_kernel() rather than just
> perfmon_capable().
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] drivers/perf: arm_spe: Use perf_allow_kernel() for permissions
      https://git.kernel.org/arm64/c/5e9629d0ae97

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
