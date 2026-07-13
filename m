Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC63E7179;
	Mon, 13 Jul 2026 10:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938202; cv=none; b=NYsBIApHTl2wcGdJfyIMxF8FYYA7X47iuhlT/Ezyg9z4arz1+V+6r59wXgxY4PYBojgaKc+3U0akUy5f08j1nHtEiRNPpWT+eE409l/y0TaKoe7Q5d6Q0WJQ8PlRqBtefIuKR0lTieQdt/70WbOj9nJxKGWiLXKXFMP5yRJFQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938202; c=relaxed/simple;
	bh=6eTqLSiSkSjBnSA4UpBlZYj70aPNYP76Fid2KcL9vyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uC0lI2uq5I6/h5iRkQ8G538filwbSKbbqO4vfgbWWfOeWYrn7KveiBqjo4xvc7yFznvPm9XlIgU7DU/h9fE5MMsbzQPcAf/Wygf9HGs9oV1MBkhB1UyqQhcuPo+k1wCyG+8Hk0Jq0NXaNmlU0yJSV0Sq2vyT4Zizh/Y4K7MtDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gyw18ok2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gyw18ok2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 848DE152B;
	Mon, 13 Jul 2026 03:23:15 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5667F3F93E;
	Mon, 13 Jul 2026 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783938199; bh=6eTqLSiSkSjBnSA4UpBlZYj70aPNYP76Fid2KcL9vyc=;
	h=From:Date:Subject:To:Cc:From;
	b=gyw18ok2vgzHssZtsx3BzrOChkGu/Bwk0ZV3zs+o1yslcpKX9yAR53WqizMkIMu7/
	 JxqMoD2V71TAH0q8we8fye0mCT0sNYnXdc+2E6Hc/I9qNTvOw8aQCIB8A53sSMRRwC
	 JQl1MkxyIs97OwTADuNIztVOgts5jnZzC0cqQHtA=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 13 Jul 2026 11:23:01 +0100
Subject: [PATCH] perf build: Fix static build of dlfilters
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-perf_fix_static_build-v1-1-460be1f9e4d6@arm.com>
X-B4-Tracking: v=1; b=H4sIAIS8VGoC/x2M7QpAMBRAX0X3t9U+RLyKtMbuuCW0O1Ly7pafp
 845DzBGQoaueCDiRUz7lkGVBUyL22YU5DODlrqWjTLiwBhsoNtycokmO560elH7UZq20gFRQW6
 PiNn5v/3wvh8j8xV8ZwAAAA==
X-Change-ID: 20260713-perf_fix_static_build-6db03942fee1
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Trevor Allison <tallison@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783938198; l=1382;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=6eTqLSiSkSjBnSA4UpBlZYj70aPNYP76Fid2KcL9vyc=;
 b=QqgWqd9zyy8qKan2PNNsiB8KwGk88tIoUlwbme61uW12uGR6aHUze/EnARe6EGm9rwdsFavZH
 fFNnxvV+38cCFvjUzQbWiWFcSJc7/JgAQihWvHjFoIYjV4cXVWcxI0K
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Commit e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
passes LDFLAGS when linking dlfilter shared objects. That breaks static
builds because LDFLAGS can contain -static, leading to an invalid link
command.

dlfilters are always built as shared objects, even for a static perf
binary. Filter out -static for the dlfilter .so link while preserving
the rest of LDFLAGS.

Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2b53d9e0c73b3382724b1f776880aaa8fa505f59..0031112c036e830e50711d5cb0b3867cba36e374 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -680,7 +680,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
 .SECONDARY: $(DLFILTERS:.so=.o)
 
 $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
-	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<
+	$(QUIET_LINK)$(CC) $(filter-out -static,$(LDFLAGS)) $(EXTRA_CFLAGS) -shared -o $@ $<
 
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o

---
base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
change-id: 20260713-perf_fix_static_build-6db03942fee1

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

