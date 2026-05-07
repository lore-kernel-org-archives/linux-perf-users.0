Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D57373BEB;
	Thu,  7 May 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778138804; cv=none; b=F6KxRFNqGKlyqgpeMNXZAdYCLLdXX7gl5PaZUa/EF2CGNHAAYMQq4yt3lxVb8KCaV08EuCXoXPSnYCzW1EkG5LcBPJSItOhGGl6IqXfcTPQufUuSv3y15ZP90GKzsPCuVIqD7KYbrA+peZxN64pxCRn11cClbi6NtaNtjwVbpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778138804; c=relaxed/simple;
	bh=TLHpcRt7hn8Rr7dTuaTyazhmVGF8j/WXD3/N8u8qDmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7J8johv5GkIF7+BAaNYanX8iGjCGor0JDUQT/2f6JN4cLywch5gCjrnxLDtnclUJ4/Em5npJSsaJVmqFUpT4Q2fj3kz1OuddARYAUJHPp0XZgG7omQm+7+Z65l2FnIS7tzO+p3qZQ94y2F/AI9gJrCeg+nSvB8xhJHJ5oPQA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMVwDQxH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMVwDQxH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9C6C2BCF7;
	Thu,  7 May 2026 07:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778138804;
	bh=TLHpcRt7hn8Rr7dTuaTyazhmVGF8j/WXD3/N8u8qDmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RMVwDQxHekBTguQ/THFk9udf2C6KOOUrfwCJg9mTFTqzFiS+TaBC766Kq/xz/MuDs
	 FxDFP3a372wz8P+iNERvxB5bGZGsD22dXYUKOEtkoYYD8ptJQ4M6vswagZewUFy96j
	 6WAVFtatDJ+qnI0sX9HMziTF8sMQiHC0yEYeC5L6QsmosrR0T+wkB95lJObKAsXIaQ
	 /LiejmvcNwswu2M8TsZlQ2Cr6XS9hIt+T5pV0eKlTfxDI+Eh2rQmU+qn/94uoITVuQ
	 Ca1Os28fjD+S8HjnVSYtf8Rv6rVsh4VQLS3VJg8/a8GXI8qg7HucdzRhRIpOdvKO8L
	 w3eernWSA8UMQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH v2 7/7] perf trace: Update beautifier script for clone flags
Date: Thu,  7 May 2026 00:26:32 -0700
Message-ID: <20260507072632.37152-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507072632.37152-1-namhyung@kernel.org>
References: <20260507072632.37152-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the change in the sched.h, update the script to generate
the flags array like below.  Note that '+1' is needed to detect bitmask
pattern at index 0.

  $ cat tools/perf/trace/beauty/generated/clone_flags_array.c
  static const char *clone_flags[] = {
  	[32 + 1] = "CLEAR_SIGHAND",
  	[33 + 1] = "INTO_CGROUP",
  	[34 + 1] = "AUTOREAP",
  	[35 + 1] = "NNP",
  	[36 + 1] = "PIDFD_AUTOKILL",
  	[37 + 1] = "EMPTY_MNTNS",
  };

This was found by Sashiko during review.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/clone.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/clone.sh
index 18b6c0d75693721d..f807372519fe2c88 100755
--- a/tools/perf/trace/beauty/clone.sh
+++ b/tools/perf/trace/beauty/clone.sh
@@ -10,8 +10,8 @@ fi
 linux_sched=${beauty_uapi_linux_dir}/sched.h
 
 printf "static const char *clone_flags[] = {\n"
-regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnum:]_]+)[[:space:]]+\(1ULL[[:space:]]*<<[[:space:]]*([[:digit:]]+)\)[[:space:]]*.*'
 grep -E $regex ${linux_sched} | \
 	sed -r "s/$regex/\2 \1/g"	| \
-	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
+	xargs printf "\t[%s + 1] = \"%s\",\n"
 printf "};\n"
-- 
2.53.0

