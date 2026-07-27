Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9542047A;
	Mon, 27 Jul 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169046; cv=none; b=KWarbpB6AXeDo08Eg1SIG701Ad3S9fCjnOv0CtET4hR92NfGdSIMdKZJhGLas6ECzXIvbjgl5dsg8yM0LwGO0zjmQVMI+R4+EiPCOG3w8+30IYsBcltw9PHgo2Sh+E5mhcZcVKSzFK2woQODrYwwFJr4Yo5KTXLMXzs6sg5afFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169046; c=relaxed/simple;
	bh=f6vOzQfFALCGWHsydpmF/9bh5rHN2IotmtiER0C/p88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJAwVxNXaL3No2TFjemHluSV4vTmqR+Ww/7UFfFNK4khX9pcgreNuj5MOeb2Zqji0wUYyxGFTXdT5zUNYqfvo/CHgPtSRwq6KA4VFaTmLqq2v9G35bgiJPvZZJGI8AFHS74f7bHDAdErRBsJY0HBmO9nFcyGV1M6xGJPL7LA2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGOeIHz3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGOeIHz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7402F1F00A3D;
	Mon, 27 Jul 2026 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169045;
	bh=t+q8PoH66cXwZ6uMLAf3XybaDlPVha7EfQcBztJGi6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iGOeIHz3eg4h+o+Y+qRXtzvIclafPAJuvYAUsJIxqSDCjXkRh/MOMaZ1JI37bS6iH
	 DLGQH/fzcnIrwXvkgXeopSOJJTN8dNxW9POC1q8h/WGKTULAhFKcHhGkLk9Koawfzg
	 FiH3mjYR+wX/tZwXUzNgM7z6K3niqWopFoYWu4RG87tqflQgWUInzTljxF28sRjFXr
	 Ua8mjt7HITkIwPzpmxOQzciY0GD+4UObaLK0af9ZgET9/u7YploO/JkxXVC4ZHgtTs
	 1HgOScMhfLeRupzcVm8Zf5NLt0jnNNVF7weaPL0501YkjgthWM0cCbf/mT0nRVOCEB
	 NPI9YxzgOQKtQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 3/5] perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
Date: Mon, 27 Jul 2026 13:17:03 -0300
Message-ID: <20260727161705.64807-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

min_sz is set to sizeof(u64) * INTEL_PT_PER_CPU_MMAPS, but the code
accesses auxtrace_info->priv[INTEL_PT_PER_CPU_MMAPS], which requires
at least INTEL_PT_PER_CPU_MMAPS + 1 elements.  A file with exactly
min_sz bytes of priv data passes the size check but the access reads
one u64 past the validated region.

Use (INTEL_PT_PER_CPU_MMAPS + 1) to ensure the highest accessed index
is within bounds.

Fixes: 90e457f7be087005 ("perf tools: Add Intel PT support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d83439c8c7b0ab0f..9d6628169fd95772 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -4432,7 +4432,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 				   struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
-	size_t min_sz = sizeof(u64) * INTEL_PT_PER_CPU_MMAPS;
+	size_t min_sz = sizeof(u64) * (INTEL_PT_PER_CPU_MMAPS + 1);
 	struct intel_pt *pt;
 	void *info_end;
 	__u64 *info;
-- 
2.55.0

