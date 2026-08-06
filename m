Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC07E2475CF;
	Thu,  6 Aug 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019785; cv=none; b=BAqK1wpBlWxc7rQQJR3/xCZAcNd6mqJ4mnp4+cdOQxNqq7e8pi5wkM3Odk9yN6LhnJYWTQNwyQgekkwSroQZQJpVEMy5NaJxkVhp9X9KZEDiybqqUljEzaRwD2d4P75viE9QknUV3Hh7IFUbR8PK33WDpM/wTAu7SJrsG3K7s1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019785; c=relaxed/simple;
	bh=6Ni7j0E/bIou28tOwawA8ovzn9pVVf3EUrKSs4YbOmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsNiz71gKLspv/ZH4pFnvEZcTbf/g021TwNRyCuepbMqzJt4JQqqDGrX7MbLl+6Ct2FZ8IlawDqZNhsVkyj9nRtzpCfxQSjiNOV1dGiFtU2RrPwwJC+KzkspFMDzsEJQzOT3Vi3g+tfuFq50AnvQQ/gYPTg5JfTslght637QEQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmBJngA6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmBJngA6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F471F000E9;
	Thu,  6 Aug 2026 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019783;
	bh=cOlsHJTllobXCXHA2FciNnYd7K+XwZx7chaSeLWgM1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FmBJngA6/Jb/mwQypxOhdctUUdDNG0aXBCHWQmbHX6GGn8YcMPESL2ei/KtI72lL2
	 HhdZY6k9EIQzwNAHblAaptzga4lXrUemsrpHeUvfrBTcr6WHUVQ2mZOzr2pnyRBUlf
	 u0aOv/++BO9Tg/GYxF+FiX4+vgamd8IbQqWX+P3R9IBv/vxY/afwpFf8mzZWe33sV0
	 smkkOpujdyj4XLHofgC8DKKlN3xEWXz4iZYgzwWVdmPPFkMeYOLVcVmBZWPpE22OAB
	 lI2ZlS+TFEsZcTDEmX0MiBGpeVX3dLAAo14Algfuera/1csZFhpvIxQvv+JBCPCqSK
	 uvyeiAOV/c2pQ==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 02/12] perf jitdump: Fix debug_data and unwinding_data leaks
Date: Thu,  6 Aug 2026 09:35:53 -0300
Message-ID: <20260806123604.271277-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806123604.271277-1-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_debug_info() overwrites jd->debug_data without freeing the
previous allocation.  If two consecutive JIT_CODE_DEBUG_INFO records
appear without an intervening LOAD record consuming the data, the first
allocation leaks.

The sibling jit_repipe_unwinding_info() already frees the old
jd->unwinding_data before reassignment — add the same pattern to
jit_repipe_debug_info() using zfree().

Also add cleanup of both buffers in jit_close() so they are freed when
the jitdump session ends, even if no LOAD record consumed them.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 4b7c7ba7cd95ddbb..dcb26d9c6c8fc551 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -117,6 +117,8 @@ jit_close(struct jit_buf_desc *jd)
 	funlockfile(jd->in);
 	fclose(jd->in);
 	jd->in = NULL;
+	zfree(&jd->debug_data);
+	zfree(&jd->unwinding_data);
 }
 
 static int
@@ -665,6 +667,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	memcpy(data, &jr->info.entries, sz);
 
+	zfree(&jd->debug_data);
 	jd->debug_data       = data;
 
 	/*
-- 
2.55.0

