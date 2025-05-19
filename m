Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221934431;
	Mon, 19 May 2025 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747697141; cv=none; b=uDSgOn2gqw9J60hCJGIGIOWbHwxViZccJe6FOaEeIZHddOv9QgYIoGH7ov8myoqZ5kWahG4ecIJNFpZ30+NFxEukN7nNO/iJZbo49napuUUhVIB8ZmvI4gY+1T1fcWNpvJQhHH4nv/k9/hTowbi78aBtmvjy0Txvqhn+pJ6FhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747697141; c=relaxed/simple;
	bh=jeM+0KCxVQu4BssWwcCM/gXTDYldLQzE6cH8hDbP7t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rG7/8pjizV2tI1fN2bLI/7zNZwotDZD6jopSMvYHrRlbjVMKjOdkF6H2n+0yBaOkaBwh4cKfj/FRmyTNZReE6FkSZkdkaKqw8OSEvTmHixZqj2XW5FxrmdpCkqBO2XG+AwrU9tA42RgN0jTeFvu0KHtbfTVidVQFwCWX9gxVx7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7W9zS4v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7W9zS4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A778C4CEE4;
	Mon, 19 May 2025 23:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747697140;
	bh=jeM+0KCxVQu4BssWwcCM/gXTDYldLQzE6cH8hDbP7t4=;
	h=From:To:Cc:Subject:Date:From;
	b=I7W9zS4v5Nxl0SZZHHJAMh8KvQBXK8Wdcn/ytlbbhwVMrTNYZr5QJTJS0EEhI/jKl
	 /lYV3NUZcul7R5n2OkkvN2wIU1HgpDa3AK7nGLdEs5XHQWS7v+Ckz5SdI18S7O3LLn
	 D+ErkHrPYXD0teLZq5oMGoeCFfPXYTpoxRz9KHIDAkDSPeC61QwIZ9Fh1oq0vnWNf3
	 qgUsyrOf5IdNxSHuiumqEzmAIj9rJdIAY560xsPMuUT2cWsmMh+2m5udhjzzOj1VHj
	 XPUCWGWcXkL+LZrkIHHQPomTAPICkeLT25dEa2Ns/vajof/fppO7Y2GYd9PUHX6ZTr
	 +a5gJtmlpuNjw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Increase syscall handler map size to 1024
Date: Mon, 19 May 2025 16:25:39 -0700
Message-ID: <20250519232539.831842-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syscalls_sys_{enter,exit} map in augmented_raw_syscalls.bpf.c has
max entries of 512.  Usually syscall numbers are smaller than this but
x86 has x32 ABI where syscalls start from 512.

That makes trace__init_syscalls_bpf_prog_array_maps() fail in the middle
of the loop when it accesses those keys.  As the loop iteration is not
ordered by syscall numbers anymore, the failure can affect non-x32
syscalls.

Let's increase the map size to 1024 so that it can handle those ABIs
too.  While most systems won't need this, increasing the size will be
safer for potential future changes.

Cc: Howard Chu <howardchu95@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index e4352881e3faa602..c814ab01f9c7800f 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -44,7 +44,7 @@ struct syscalls_sys_enter {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
 	__type(key, __u32);
 	__type(value, __u32);
-	__uint(max_entries, 512);
+	__uint(max_entries, 1024);
 } syscalls_sys_enter SEC(".maps");
 
 /*
@@ -56,7 +56,7 @@ struct syscalls_sys_exit {
 	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
 	__type(key, __u32);
 	__type(value, __u32);
-	__uint(max_entries, 512);
+	__uint(max_entries, 1024);
 } syscalls_sys_exit SEC(".maps");
 
 struct syscall_enter_args {
-- 
2.49.0.1101.gccaa498523-goog

