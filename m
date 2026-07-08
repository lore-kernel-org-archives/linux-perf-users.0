Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DBD346AC2;
	Wed,  8 Jul 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783538743; cv=none; b=gvrv/kW/pu/1dKeTCTGteNHE1VWq7WhG8WNlg1OVe6fQQImVIsCbn3JSP4JlRFj7UCBn33WlEYMzygwFH8wjxxQjO0Ko9n7tgpU6E3Y5aPqnSsqOC1k+Ov7/iREa+eVVe2oGQMjBCKRNVgZVBO+UrBpeHNRaF9H/hWv2q5/HrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783538743; c=relaxed/simple;
	bh=2lMP3T8s5y6/OTrJW6e9TQwDN5jec+oJwWkhjKLZBAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZZAesNf7R7UE7FUulFfKCFQntDLr836P/TgZIuvKaLhvtO9vU6bAI+Hz4lhHm4V/dmvCEZBWdPQEg3Vj24LMY2kpYWUOFjFFAehcveExtmLRFhRPJqufEfrKNADp7O7n1SydkRALUin2csNPuNlkaRFjgR/qL0+xbl//oEL1bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHh0AnBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHh0AnBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF831F000E9;
	Wed,  8 Jul 2026 19:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538742;
	bh=wEwYvq4Kna9CZprHkbDpGWysvlPJ/8MrVm/9TmW/SjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QHh0AnBFybK1ooa0wl4kXQp+NhYyodYlwrO5JSv4N9Ueb2V7Zl06b82tCRBHyFBRA
	 PW5LPwSaMJW1kKWzJmmBiiSyeAtlX7ZBgTnGZojnHV0aI9U1I7VTbzpANkNRR6P3Ab
	 7apF1TiZSfYa9STdzvLu+is/y3wtpHAlANBMV1KjWw/K3BXm9RK7GeTW5XzJgOVXXG
	 euK4nU+7t7zN69ra9P1C1OdSWSm7EpWKJfFha+Y6E92PSSwLpMjtlmxeytrhgAKIqh
	 IwdKHv2Lwe6zdYZo9q8iPpTIONbdvShLJjQNPWcPRppMqhPSTnD1lR6EZGR9JjOrI5
	 3vSyW3vCmCjDA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jiawei Sun <abyssmystery@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
 mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
 james.clark@linaro.org, alexey.budankov@linux.intel.com
In-Reply-To: <20260707153801.315352-1-abyssmystery@gmail.com>
References: <20260707153801.315352-1-abyssmystery@gmail.com>
Subject: Re: [PATCH] perf record: fix poll storm when monitored threads
 exit
Message-Id: <178353874226.478719.6694278917863620651.b4-ty@kernel.org>
Date: Wed, 08 Jul 2026 12:25:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 07 Jul 2026 23:38:00 +0800, Jiawei Sun wrote:
> When `perf record` samples a multi-threaded process and one of the
> target threads exits during the session, perf itself may start burning
> 100% CPU (up to 200% across two cores) until the session ends.  A
> single dead fd is sufficient to trigger this; it can be reproduced with
> 15 pthreads in a compute loop where one thread exits halfway through.
> 
> The root cause is two independent instances of the same defect: dead
> perf_event ring-buffer fds are left in a pollfd array.  When a monitored
> thread exits, the kernel closes its ring-buffer fd, which then returns
> POLLHUP.  POSIX specifies that poll() always reports POLLHUP and POLLERR
> regardless of the events mask, so any dead fd left in the array makes
> poll() return immediately every time, spinning in a tight loop:
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


