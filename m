Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5B1CD205;
	Tue,  3 Dec 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198038; cv=none; b=SzS0NKn3s95hQaEgW/pVHFnY7Mmlf/LKLA9AwJ9AZdNm4hRPHMxBJXKDCIvLrvAPr+W6FEbulGlzd50AbmqNR8o/ArIy7tz54+BHobNCt4eFkgV9lDe4P+AD5TvYTn0mRFzbX2n/r8OWR1Eux+u3NSryAEagA+UD3r4daChjhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198038; c=relaxed/simple;
	bh=VL9ywmhYUUjMMzUQwvCNc1TEisl1SHebjEVkVrkBfTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaxSTWe8pnhHrp0fOgbR+2MzjZM7EoEnAAwkIJoqCVFA47xrNOOeWs8CblD+s18HAgkQqn7hwy5MQl7nnxNJSaMgMWxwvQ/2zHllZm6hBHHpPguSTrYFeA85eOVoFMPQZ5ocneya/3W4Unfi4iOzCwcOVm7B3V96apambQthLvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/ZbTYd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/ZbTYd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F180C4CED6;
	Tue,  3 Dec 2024 03:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198038;
	bh=VL9ywmhYUUjMMzUQwvCNc1TEisl1SHebjEVkVrkBfTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/ZbTYd7e+gykDGFKEpfGbbf1uzl31vFKMZ4WSzWNb5j1spAKxy03Sa8NSi96lSZU
	 Rh2KWmxITH00aD0lQ/JC+yvXgXR9ypBt6jmWz4509DS0HzrFuvV3Hb2esY7MDQi58r
	 j2bnmNR8uyP0IxBvjI8z0/hw/kI+UIodqv/6Svo0isatJRPPrlvJ9FdUhJeJFwqxs4
	 Kq70xCPJuICSyrjpLMxFB3JQ7pZevj0IYu3Ly55GXLTYHsFFeu96w1nkMCUzPet4Kc
	 FvwVlSx1NUQl5IHMGkJHRWk9rQh4HFS+ApMUEwIrV5/QUkIKVXQPXN2cvt4ZglwZ4k
	 gcCciDC1n6pNA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 11/11] perf tools: Fix build error on generated/fs_at_flags_array.c
Date: Mon,  2 Dec 2024 19:53:49 -0800
Message-ID: <20241203035349.1901262-12-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It should only have generic flags in the array but the recent header
sync brought a new flags to fcntl.h and caused a build error.  Let's
update the shell script to exclude flags specific to name_to_handle_at().

    CC      trace/beauty/fs_at_flags.o
  In file included from trace/beauty/fs_at_flags.c:21:
  tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: error: initialized field overwritten [-Werror=override-init]
     13 |         [ilog2(0x002) + 1] = "HANDLE_CONNECTABLE",
        |                              ^~~~~~~~~~~~~~~~~~~~
  tools/perf/trace/beauty/generated/fs_at_flags_array.c:13:30: note: (near initialization for ‘fs_at_flags[2]’)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/fs_at_flags.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/beauty/fs_at_flags.sh
index e3f13f96a27c227c..fac4d0c049fcc89f 100755
--- a/tools/perf/trace/beauty/fs_at_flags.sh
+++ b/tools/perf/trace/beauty/fs_at_flags.sh
@@ -13,13 +13,14 @@ printf "static const char *fs_at_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
 # AT_EACCESS is only meaningful to faccessat, so we will special case it there...
 # AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
-# AT_HANDLE_FID and AT_HANDLE_MNT_ID_UNIQUE are reusing values and are valid only for name_to_handle_at()
+# AT_HANDLE_FID, AT_HANDLE_MNT_ID_UNIQUE and AT_HANDLE_CONNECTABLE are reusing values and are valid only for name_to_handle_at()
 # AT_RENAME_NOREPLACE reuses 0x1 and is valid only for renameat2()
 grep -E $regex ${linux_fcntl} | \
 	grep -v AT_EACCESS | \
 	grep -v AT_STATX_SYNC_TYPE | \
 	grep -v AT_HANDLE_FID | \
 	grep -v AT_HANDLE_MNT_ID_UNIQUE | \
+	grep -v AT_HANDLE_CONNECTABLE | \
 	grep -v AT_RENAME_NOREPLACE | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
-- 
2.47.0.338.g60cca15819-goog

