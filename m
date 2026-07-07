Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DC20ED;
	Tue,  7 Jul 2026 00:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382644; cv=none; b=IngIRMJnnxkQX1+C1nzGOHS6WxTQq4cvMsYp0V82Dh29RwHBpvzMRa1FzeQdSJvofUi9fTyMzv2kQRk/She8/LgQBG8Xv6FF0mIP+3HJQqHf1TVmey0xjGza/F18w9RooCa2ejjNsG0ZYMT949UrkltTb5/EabNk+Ml9awBjPCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382644; c=relaxed/simple;
	bh=5sWnK/mcwU5EFxKfsnOovqiNa0uzDvY2yMgQ2zmzkik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gguOJChNRtM/8XRSxbaOyDz/aNZ1dKkVgvsEPJzIpd/Q/8LkvE6jJLVrkM2rsfxiXw8szbh9vOT7GlKwoxnFHTYK5tFA07qIOoqLPnJrtRUFHzOf69AGPCqbpvb8UPf8d5WtJrzVt33FaAwFLvOkZi1JXfdM4NIKusOIBE6Wvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGHqVHj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGHqVHj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B501F000E9;
	Tue,  7 Jul 2026 00:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382643;
	bh=XE+LT6QRcIQzeTOm4EXRVFr8jNU4pb6cI6PGB6HIxmo=;
	h=From:To:Cc:Subject:Date;
	b=IGHqVHj50gF1ozQlZrpYY1tVdYGkAA2Kce/f2QJU5N43tmNxp0t9P++FpwPN0d3/T
	 x8rfLJtb/Eo7c7gxeW29MKrT2Ty8PCjny5PivcHZv/irbJPpumN6AdlAlL1l0dn95y
	 OMurx2fnRTIsDCAq8+P+GMRep3juzRrkAhQJeg3aTtxvkK4AkKj9nZIoH8ecxAC9aR
	 +0WLN3T3vystc+92qHO6XDX4RPMIqqoCO30cTOufqK2Eyg33ECFCxDuvs1xJUUHzkW
	 UZcyXpL3D/3fO2sddDl/NgGZqvl8Nac8nD3sTnLD2YyMpDDqKumn1XxdqS4yaq0/ZV
	 UR/Yldf+tqFlA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Trevor Allison <tallison@redhat.com>
Subject: [PATCH] perf build: Do not pass -static to dlfilters
Date: Mon,  6 Jul 2026 17:03:57 -0700
Message-ID: <20260707000357.823509-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent commit caused a failure in make build-test for static builds.
Let's not pass -static the option to dlfilters which is dynamically
loaded as it's hard-coded with -shared even for static builds.

Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
Cc: Trevor Allison <tallison@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 2b53d9e0c73b3382..0031112c036e830e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -680,7 +680,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
 .SECONDARY: $(DLFILTERS:.so=.o)
 
 $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
-	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<
+	$(QUIET_LINK)$(CC) $(filter-out -static,$(LDFLAGS)) $(EXTRA_CFLAGS) -shared -o $@ $<
 
 ifndef NO_JVMTI
 LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

