Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53872BDC26;
	Mon,  4 May 2026 06:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777876090; cv=none; b=IPqO0+QBayVyvW1u4aAfINLR3dPjK7SjFMs7Ol6TOw4xmUiE5ExEnug7B7zg8/wv/3TY76MRK6mRAHtph9tU1CxQ09193nw/lzWwxc9/BbMBz5r/imlEIMebPhY3sgv95HvQ2MjKNS2X/27AqJTZ1e24bOgN6xbQBarT4K5QO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777876090; c=relaxed/simple;
	bh=qIT8FxWnOR2qaYY/hOXxZD3u9KGZymYUm3k2NcPFvpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1IB3p2DUdrcP2y9eyphwUG93dbX7/+E7YTCcqq+HUOtG08Iye31cm8w+taz3lozdnIfED+n0ULHvcG8CqKfWW9qWVowmj62Wu/M8Dx/gprsb9r8tByZv/sJRz20T5CrWF2x5Ali5klPbNcFfAGJkBbIE0EqagD+b07RdFMKMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwmAd4zG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwmAd4zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB04C2BCF4;
	Mon,  4 May 2026 06:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777876089;
	bh=qIT8FxWnOR2qaYY/hOXxZD3u9KGZymYUm3k2NcPFvpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gwmAd4zGCnXm4vWfyAlKNfzKYeBjePxxo0QJofx/wWkVW1hegBSjBlnTmUmbDzJuc
	 xJUtKkvSFIJDiMCi2skNk+QUcnH78cr8xAn/yMaHSsuWXV1Ei53Dv20xDYuDpwU2UK
	 XH6cZx5HHpjE6bI1QkXd0c4S9QV/lCd8/9JPjn63kMvsPvHVDzPoiraKVTs0G+68X1
	 kcwMqDdPRgtDOHkLiRdiDN63/vrijPCp5JJEAUIRKoIzttDKXrJRiiLGCdIR7MEKd5
	 DhpsI1SbMvcdDDjMQWxBINtAcOQkwZnLcI4/A6UuNBz0fnfstREIp5ZcZUCaRO2J6L
	 7NlA/3GKiVmIg==
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
	bpf@vger.kernel.org
Subject: [PATCH v2 2/3] perf build: Add -fms-extensions for GEN_VMLINUX_H=1
Date: Sun,  3 May 2026 23:27:57 -0700
Message-ID: <20260504062758.92001-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504062758.92001-1-namhyung@kernel.org>
References: <20260504062758.92001-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On my system, `make GEN_VMLINUX_H=1` fails with a lot of error messages
like below:

  ./util/bpf_skel/vmlinux.h:134488:4: error: declaration does not declare anything [-Werror,-Wmissing-declarations]
   134488 |                         struct freelist_counters;
          |                         ^~~~~~~~~~~~~~~~~~~~~~~~
  make[2]: *** [Makefile.perf:1249: linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bpf.o] Error 1

I saw commit 835a50753579a ("selftests/bpf: Add -fms-extensions to bpf
build flags") also added the same flags to bpf programs.

Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2) use -fms-extensions and -Wno-microsoft-anon-tag  (Sashiko)

 tools/perf/Makefile.perf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c0607d2..0aba14f22a06f7a6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,6 +1249,7 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
 	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
+	  -fms-extensions -Wno-microsoft-anon-tag \
 	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
-- 
2.53.0

