Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A671D5166;
	Fri, 15 Nov 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685007; cv=none; b=q1ILwmzU6E+NL9061ASkctI63L5iQwLHR4dUpdMXs5AnFvze1Ki1wHByhfVZOxl44/Q8oGMNfmLFE6lyctC8uFwypvWEGcO/9NbUOGSNQdlinMcuu2U8xROwg8wQ6jHivNFktR/b1eFyNRZbIKCF3Pm3Nq9d461gZGGNVVM/cM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685007; c=relaxed/simple;
	bh=RWllNGWig39/Uip4eAybblk2rATHme+ZwdnTDKkfdWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUKmdDIctsPkTGqXJfyYBx0aKniaNBuiLutdxI23il2UHhTB4Dvhe8YowMDoTMe65FPdFbOXwUXeJzPVGRO4UOEi3Xs2M+eqHgtAQ4Bs8liLvZ+czwzOH+epmVOv5okNC5LMSDDByryRUKOLqQWqxDPhWxl/kp+YVrpFmen7rvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA/qCSqO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA/qCSqO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13804C4CED2;
	Fri, 15 Nov 2024 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685006;
	bh=RWllNGWig39/Uip4eAybblk2rATHme+ZwdnTDKkfdWY=;
	h=From:To:Cc:Subject:Date:From;
	b=IA/qCSqOvECNFk3NA2Xvt5ESUeMtbhd8e7ydhUDmQEFD+Ir9YOVZBvuMn85rkMhcQ
	 lD5mTOQzHI3Fij+a0LUMav8yB/gWTq7UdrX0L7KYh8dCKYW+2CWu4XmSu0mCk8euKh
	 uI1lKpU0qC2EvlJtkZKT8XR4MqIYr1cOx95gWHIqRicsMhq7LFwvenPq8ePBobFDDJ
	 bkuaV5/Ez/7/6d53vfZIcSD+IWiq8CNQwu1h8MCxBBOkZ4tcXOEh8UEDc+rNMHYBTo
	 CQUWjdJfDkstHs0CjOV0i50SAxwHGyepUkoiOI135wgJo+MkMHlwbeUme8PPVeyREs
	 Z4ZRjm9kDTsdg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Benjamin Peterson <benjamin@engflow.com>,
	Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/2] perf test shell trace_exit_race improvements
Date: Fri, 15 Nov 2024 12:36:32 -0300
Message-ID: <20241115153634.314742-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	Here is v2, folding a slightly modified version from Howard
reviewing patch, with an extra patch to use --no-comm with 'perf trace'
as discussed previously and in the patch log message,

	Please see if everything is all right now,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf test shell trace_exit_race: Show what went wrong in verbose mode
  perf test shell trace_exit_race: Use --no-comm to avoid cases where
    COMM isn't resolved

 tools/perf/tests/shell/trace_exit_race.sh | 26 ++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.47.0

