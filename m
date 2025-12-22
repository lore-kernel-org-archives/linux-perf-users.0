Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7932110E
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446465; cv=none; b=FXWfq8WuFPW2r67FcBcaRFKhIpbj0wEliAV2nluA62rh/qKggqmT4x9L6XpKRlFl3GJFTPFGPpnMJtJ254dUAy+d8jlWc25GRwM4Fa/eRpauqw9BbANaCaqeRmWGWClWwYLtz2qM4NEXI8nVicC4QD+rlvpOSUzuesCRtPd3N00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446465; c=relaxed/simple;
	bh=FuNiP9iz1gU14XcrzpSaPj75EgDbX+xdf6ajGqXrJbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rtXmrP4bCYa/OmR/ltpokzDgWNozjAYW2Ac3GMf8lLNhdcaUe8lJofHGyhRR/Lt65PjiclZYkOypjTzBhBpB1JZWJ9Jariri9nbjV+wsNckPF/vefKY/VW5XyiRjtng29KuxsEYfjC9H7B7Q1D6xAnr2oyxQbvmb4jVSE+/OuNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lONA1k5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lONA1k5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6E0C4CEF1;
	Mon, 22 Dec 2025 23:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766446465;
	bh=FuNiP9iz1gU14XcrzpSaPj75EgDbX+xdf6ajGqXrJbE=;
	h=Date:From:To:Cc:Subject:From;
	b=lONA1k5s1EPXOr2sKazoskaKRY50sNpldVaEuhpKB/CSSi9w+PLOEbuVghG9EQC+W
	 LBsCCxpV0xbUsZkkmo63d0DMU0a39wytBHPvdDSHQaYW8Dzg/6b7s7+7vHMBjr9sV6
	 7E7UD083DC+jUrC5TQU9g73OCtbHC3OckzpaO1FgeeW0gFxZSx8jm4+PEHHfySx0X6
	 X3OIKQ1aHfbjPjjiG8llkrCFReCNKOzZa7M+8TVFeoSSxG7vOE18RgEKgccCMgT+Nz
	 gTZIKjl3Yklnb13h5FL667C8o6c5Wwz75WSm23dILL4JC6BjofVy+uF9B5nH101J7+
	 GdyJVtz6DFClQ==
Date: Mon, 22 Dec 2025 15:34:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org
Subject: [BUG] Task stuck on global_ctx_data_rwsem
Message-ID: <aUnVfxDtLNUDJM_v@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

I got a report that a task is stuck in perf_event_exit_task() waiting
for global_ctx_data_rwsem.  On large systems, it'd have performance
issues when it grabs the lock to iterate all threads in the system to
allocate the context data.  And it'd block task exit path which is
problematic especially under memory pressure.

  perf_event_open
    perf_event_alloc
      attach_perf_ctx_data
        attach_global_ctx_data
          percpu_down_write (global_ctx_data_rwsem)
            for_each_process_thread
              alloc_task_ctx_data
                                               do_exit
                                                 perf_event_exit_task
                                                   percpu_down_read (global_ctx_data_rwsem)

I think attach_global_ctx_data() should skip tasks with PF_EXITING and
it'd be nice if perf_event_exit_task() could release the ctx_data
unconditionally.  But I'm not sure how to synchronize them properly.

Any thoughts?

Thanks,
Namhyung

