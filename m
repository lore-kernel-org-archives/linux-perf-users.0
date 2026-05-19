Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4135F5E6;
	Tue, 19 May 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172985; cv=none; b=EiHWsHRDSnBQVc2+injlQX22NPcxXD45dLssInXdZZkUY6ZeKWnapkfL6j9XuiXm5ilJWOTx/umbdXqcAy0lYb16LGmX3r1fM0BKhWRUIOHN7yPwjwA5AuYwK99Th8kip6/MqQxs4zqRN2DWplE+wwZ+zfxnZhn3/JZDewOeDiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172985; c=relaxed/simple;
	bh=H8Fptah9SqIWeF9rWYT8DTa7dGli71s3ZktQ7OCk52o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWHqHXjOuRHtB2AJ3C78QiNKQUIxn7edXUnYUS1UR1XSVY3OErO/UflbhOJP2L/aDcBhIvV9mz1sR1wT0oqG2A3grKdEDn0zODMRppOLaRtCBkuffutkqnk5UraA15UH8/ftHb+pFSYbXTsITXmLIcwDQnWY8047LNxOUici3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpNezcun; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpNezcun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52458C2BCB3;
	Tue, 19 May 2026 06:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779172984;
	bh=H8Fptah9SqIWeF9rWYT8DTa7dGli71s3ZktQ7OCk52o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpNezcun+nVJy++bieENGCQzR6I3PSpG5cqaIqzua0kvDyf6A7LtjNDHglHMx3QdL
	 vHis4zVYtu+86JXHXHEeUbFbCWQbRp3iJzxXQ47p4pvBErztLzZUiqiVFDl6Ui6PEv
	 /URtyLNovcHFPVhQn3zIy9ImpgfllxHqmouQro5hN9mkYF9kNQ118QVI/GhxQK68q6
	 4mNxL527N7/ZKw49l7Z9ilEn5Z/FKAuemwwhrmEZxkyQIp5FNkDfQAA2A5sq6lrJui
	 99wAaD81BDG0nni0yTlkjFU6L202pnJl5IHXzQv9bt3JnAkej7hrMDfGPXHKrZ3k5M
	 UVvIH2Zh8gzzA==
Date: Mon, 18 May 2026 23:43:02 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	nigro.fra@gmail.com, peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v4 1/2] perf tool_pmu: Make tool PMU events respect
 enable/disable
Message-ID: <agwGdqBaeEEXnAtp@z2>
References: <20260518223733.3034897-1-irogers@google.com>
 <20260519014106.3089452-1-irogers@google.com>
 <20260519014106.3089452-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519014106.3089452-2-irogers@google.com>

On Mon, May 18, 2026 at 06:41:05PM -0700, Ian Rogers wrote:
> Tool PMU events (duration_time, user_time, system_time) currently
> count from when the event is opened to when it is read. This causes
> issues with features like the delay option (-D) or control fd, where
> events are opened but should not start counting immediately.
> 
> Make these events behave more like regular counters by implementing
> proper enable and disable support. Add accumulated_time to struct
> evsel to track time while enabled, and implement enable/disable CPU
> callbacks to start/stop counting.
> 
> Also generalize userspace PMU mixed group handling. Userspace synthetic
> PMUs (type > PERF_PMU_TYPE_PE_END) do not have kernel implementations and
> cannot be grouped in the kernel (opened with group_fd = -1), and are
> skipped by kernel enable/disable calls. Iterate over group members in
> userspace and manually enable/disable any members if the leader or the
> member is a non-perf-event open PMU, and synchronize their disabled flags.

Can we divide the commit into smaller pieces?  I think we can have

 * preparation for accumulated_time
 * implement enable/disable for tool PMU
 * wire them to evsel__{enable,disable}[_cpu]
 * support group members properly

What do you think?

Thanks,
Namhyung

> 
> Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
> Reported-by: Francesco Nigro <nigro.fra@gmail.com>
> Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nigro.fra@gmail.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> Assisted-by: Antigravity:gemini-3-flash
> ---
>  tools/perf/util/evlist.c   |  10 +-
>  tools/perf/util/evsel.c    | 197 ++++++++++++++++++++++-------
>  tools/perf/util/evsel.h    |  15 ++-
>  tools/perf/util/tool_pmu.c | 250 +++++++++++++++++++++++++++++--------
>  tools/perf/util/tool_pmu.h |   4 +
>  5 files changed, 377 insertions(+), 99 deletions(-)
