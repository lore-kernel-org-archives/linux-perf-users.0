Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70B2701CB;
	Tue, 14 Apr 2026 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776199754; cv=none; b=ARo0K6AJJJWBNG4SA/q5OsiSuqY/5VVvXlpjxIyykjUKH49mGlXY3oPJY2awdm+MyW4hCdNR6PwG4lern7NhUGqPdJQ0Fsii3ZsyQ6YV+p5SEmw9MPZNoaIb6jInh5IKN+EJQNEpXET4GrmKg9KqLoZAyjz0OW7TCkE0UWM0HHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776199754; c=relaxed/simple;
	bh=b9KuWLHGp4d6LPrZIWdIc5EMU8/nY2xzH90YL8LFwok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdmll7k6HCjm38+KAavqlb3Nff7O16xz9hyYEM370XzE85dBtmIGfIamO7FQE/i8oB72GXMqJGU+dlpIO5FNdh5VwMn7jsFXvrXxaXizwmI2vhGb4y19AfANIFwRZyx82PumoPjyMrw6tw0spzpmOzNBYqxPuvFwxZEC/iNshnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odWpkxnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odWpkxnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B81AC19425;
	Tue, 14 Apr 2026 20:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776199754;
	bh=b9KuWLHGp4d6LPrZIWdIc5EMU8/nY2xzH90YL8LFwok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odWpkxnRPEfBrAX7eGw8R5rN1uxpqc5tRFrnXpXTh5VRcYPW8kNhAaNmBqTMyZa3B
	 gFJ+clfjoTV6Sixr9VBCopYNDzft184BQPuscJU72rtPEiPXUXzt46FTSHPt1TgFHx
	 mHlCbEVT1A7wpK37MoEQsh3ZxyIdDgQ56Er6mzFOB86TP6jSNzTggkItDPNhKyyJIF
	 NhejKfZnXzIuwsuxDhhThYRnxmwa82fS7VyNXw4d3Gs1zgsW1j9yVEfNOdbj8ad00/
	 MKRI4C9E8xeGF3XvVcb4P9h4yzIrpS5QUSSoq8L77rEPVmR6tZyzRgqAdHPsESWFv+
	 MQq1Ps7SwmEZQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf header: Validate bitmap size before allocating in do_read_bitmap()
Date: Tue, 14 Apr 2026 17:48:47 -0300
Message-ID: <20260414204847.293557-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414204847.293557-1-acme@kernel.org>
References: <20260414204847.293557-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_read_bitmap() reads a u64 bit count from the file and passes it
to bitmap_zalloc() without checking it against the remaining section
size. A crafted perf.data could trigger a large allocation that would
only fail later when the per-element reads exceed section bounds.

Check that the data needed (BITS_TO_U64(size) u64 values) fits in
the remaining section before allocating.

Currently used by process_mem_topology() for HEADER_MEM_TOPOLOGY.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 3302748bac786fdf..f2d0b8408cc29744 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -300,6 +300,9 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (ret)
 		return ret;
 
+	if (BITS_TO_U64(size) > (ff->size - ff->offset) / sizeof(u64))
+		return -1;
+
 	set = bitmap_zalloc(size);
 	if (!set)
 		return -ENOMEM;
-- 
2.53.0

