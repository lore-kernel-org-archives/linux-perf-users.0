Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD729D264;
	Thu,  4 Jun 2026 19:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600094; cv=none; b=ubijygApDfqrs3FwUnop9niVDM5KwWmVqlalDztsgei08Q+vA3FKeyy0PKe9H7uV/+5WaOLvkmXmSB0WMRailuAJlg+IKh6KWrZhzZjkXoEL4aWpVP4FgFGVp4+oJkv6mGwrXQ9w0LQ55+pt4Z8Qt7g+GNuT7yvx5vcd8d6B5AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600094; c=relaxed/simple;
	bh=N0G3F/oZEusxr26Gjt74aYeawMsLE951PANBGPirn6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkuJg1b67pSTY8QxTXZEKG5q7vf607hg+neroSXIi3MlQheoGEPwyvjTg80iy45MXUXOzwh/Em1ArN6o44k4JvQkw14b0sBGAnRdicq2Uki/FBW4bsEEqzjZr9+UA+pQ/KNib9E1rLCEWGYrUo8IPCQ5NpuFOy1jq0kltEGyJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnnbvduY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnnbvduY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292BC1F00893;
	Thu,  4 Jun 2026 19:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600093;
	bh=91OnvSCHqySElLUpJ2Invj2Wgtm4Hj7+RrbdiGjtIwc=;
	h=From:To:Cc:Subject:Date;
	b=NnnbvduYGzzH2nHg91uvn961IqKJwEN7gHT5ZrpnNs7vHCL28gECz1wBctctnEjRR
	 i9rebWX5DxXrON7ST+7uvay0JbGoxYiv8iJB6E+NfKJaejBW/AB6ZkoM5UlxsirvdZ
	 YNYbhbvSzE9JEkrIXpqBEV2WR3e0+ZBXc08Xjul/Bz51rikmCKuMRjlDDEjZjW67PG
	 4C2MedcZUaG1TsukK98zm71PE3lqWoNbKd80G4+Cd90FSRgtrg2ZmJOUHY2IaOYbMO
	 oaxJtCM37umgm0XDwIvueaIY0dLI41cniazgUC0MocRPLZjvyRoBIPiAWah0DQIZc7
	 zMWBc2+WTgmag==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/4] perf timechart: Small optimization for backtrace
Date: Thu,  4 Jun 2026 12:08:06 -0700
Message-ID: <20260604190812.2168118-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found an issue int timechart backtrace handling during the last review.
The goal is to reduce unnecessary work in generating backtrace string.

Thanks,
Namhyung


Namhyung Kim (4):
  perf timechart: Don't pass @event to cat_backtrace()
  perf timechart: Generate backtrace only if needed
  perf timechart: Remove unused backtrace in trace_handler
  perf timechart: Remove unnecessary copy of backtrace

 tools/perf/builtin-timechart.c | 88 ++++++++++++++--------------------
 1 file changed, 36 insertions(+), 52 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

