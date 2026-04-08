Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551233BB4A;
	Wed,  8 Apr 2026 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627590; cv=none; b=HsR2ieYZ8ge5VXD9aeICLahjkYyXoYG0a7CvzXIJjeXS6RtC7+9oCEkhra+9X3w6Y1QXuOrctSHr1v3y0GuoNLiZowHgcaI9rT5SSYTNpiOKO6KPWWi69a4L2TYyT0+z/VoJzOwxUcgMUmR8HmrSv/yNjT9dnvICyPO7a99DkNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627590; c=relaxed/simple;
	bh=tbrYApG/NtLbSePwUubAvAtB9DPup9vrDkjrSeN/GEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTINPZeuoaBRpLp5rSw/+3Ryj5Lc9dfp75kQ6siut8zGFHzbq7OcYipBniZlj4rg5kCtLmxE7sncuFbOubeqj42oJczubcPhR8liNcKQxzVfrdG7+D/1xQjb4hyWYiLP///KLHdMAVlp7cTHe8OWzEElhQJGZLi/lCfGB6sZx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CutBCc5O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CutBCc5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D600C19425;
	Wed,  8 Apr 2026 05:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775627589;
	bh=tbrYApG/NtLbSePwUubAvAtB9DPup9vrDkjrSeN/GEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CutBCc5OhDKXVbm+/CvvP73kQWgzw66VQ8RpmS+QAT4v6dx2n83Dx4a5afecLoHv3
	 5b4DApQZh4gYAkun9nqN0Zbgdh+mQlF+Z/6lFxgOFRnxhkAh4aU0nMUrdgMMOsfOCv
	 ndFJlK3jBqlYGufhVX7QV+hk1OkrvefyTZli6bQcaARfexV40g66qjpY9sGQ8LyBBc
	 T3Wezv08jdtwsr8Fh5L4RgGg6LcKVjiK4UVYNxNN7OImtsB0l3URUS9CRJaPDbL8xw
	 LGIrk51gs1wZyf5bH6nOC8Q1/GsnmBzA69I12eUqMWoGVfyCS+y3nueJQSSAPLVb2D
	 etytLW7O1Ir5w==
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
Subject: [PATCH 2/2] perf build: Add -Wno-missing-declarations for GEN_VMLINUX_H=1
Date: Tue,  7 Apr 2026 22:52:59 -0700
Message-ID: <20260408055259.374744-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408055259.374744-1-namhyung@kernel.org>
References: <20260408055259.374744-1-namhyung@kernel.org>
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

It seems clang doesn't like forward declarations in the current setting.
Let's suppress the warning by adding the no warning flags.

Cc: bpf@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index cee19c923c0607d2..a41e0dd34d8df660 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,7 +1249,7 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
 	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
 	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
-	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
+	  -Wno-missing-declarations -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
 
 $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
-- 
2.53.0

