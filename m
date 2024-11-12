Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B96201270;
	Tue, 12 Nov 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435144; cv=none; b=aWQH5leeHw9UJ7caOCzoynq9mW4npUQi1Q78WwAJUXC/4SjNT+PnrLp0o67vpg0gD2V4VqOObORfirbCC8oiKcdvMQwVEATk8qmu2O28joqaB9s0KyDNGtcrtzoF+QT2hdGOzm8BbSIvIjt6VvMh8Bv2rzFW7Sz2UiRPyL3Ktd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435144; c=relaxed/simple;
	bh=Lm1xjLW35WsQTLsZUoaGcjfhiQHCoyf859qtnUvVfn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEGHBB2vq/FTD+Vk3OBry3WCkvaovwsBnJamxI2TgkSIEYu1/nwTsEXNxDOUnceOiw1HMe2wskX32SWFdCXo7gKTdkTW22YIDQQAKeNGW1idpl09qrk1DOAhqv9yT6g5U+2gwAYWeR2FO4ACe1r0Ge+TpSutWTROE3a1idAq53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1ih57+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1ih57+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C2FC4CECD;
	Tue, 12 Nov 2024 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435144;
	bh=Lm1xjLW35WsQTLsZUoaGcjfhiQHCoyf859qtnUvVfn8=;
	h=From:To:Cc:Subject:Date:From;
	b=X1ih57+fmbW8/cqm8eh5/pZfRXgsw/BHvK+HnAt5OqoZbaFhDenaNOMmg2uu1tUcl
	 08z3kRPF/4awZmo7bfcVZVIZcvr1ZUPqiYLOeYjDZfQnwWuhPhHvwkMz9y0NbmMUeL
	 KY10X4ALGu8eD99mMJVFF2qzdnaxGTpF+cQSE7YIfXXCzKKi+ZG1XvZfmh8TEIiEdQ
	 4zkY2zHlmHMlw3A/zF4gpWcVV7RjB75AnwGUDOE4n8SPxSUghPjmhwN70cfOTFB1Tw
	 AY79/Frb3neDVx6T6zAg708tHfKk7CzDgtl98ZqMcl5yYR5Cxeq1NpRZ0SMa6blDxy
	 b1So3V/imuuvg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 0/4 perf-tools-next] perf ftrace latency linear buckets
Date: Tue, 12 Nov 2024 15:12:10 -0300
Message-ID: <20241112181214.1171244-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Gabriele has been using 'perf ftrace latency' in some
investigations at work and wanted to have an alternative way of
populating the buckets, so we came up with this series, please take a
look at the examples provided in the changesets.

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf ftrace latency: Pass ftrace pointer to histogram routines to pass more args
  perf ftrace latency: Introduce --bucket-range to ask for linear bucketing
  perf ftrace latency: Introduce --min-latency to narrow down into a latency range

Gabriele Monaco (1):
  perf ftrace latency: Add --max-latency option

 tools/perf/Documentation/perf-ftrace.txt    |  11 ++
 tools/perf/builtin-ftrace.c                 | 131 ++++++++++++++++----
 tools/perf/util/bpf_ftrace.c                |   3 +
 tools/perf/util/bpf_skel/func_latency.bpf.c |  26 +++-
 tools/perf/util/ftrace.h                    |   3 +
 5 files changed, 150 insertions(+), 24 deletions(-)

-- 
2.47.0

