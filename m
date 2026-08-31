Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54933D6F7;
	Mon, 31 Aug 2026 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181894; cv=none; b=VvLVLaqCM6b1rGyLV0qYwlRplcPCLD5ij+oJo97VD5c/v3dLv7sHlUqQZ9zFFevOUq/erTmkXbcoJgVQIR33lXiFLJPXPYegy8dvPLP2EPzTAbepyk1aiTpt5P6raYIL2xIjhFNv96QM3kq6BfWe7EmdvLdYC5j2oSMUirK0S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181894; c=relaxed/simple;
	bh=PkmIIdfHx/N23qc2OX//duYuVGo7nKRZz614GKDL9e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiGe4tpdrfP2nsAlLyLU8LlimO6w+qRou9Op/tS6IqmqV+2C43P7i4TD2uvfn4FVwVTNWvdtEkZTEJ+4jNV63GSGNCnJroCvO5cngU4gghGHyzaSrqRsyGPlYG+d5Ufmn2f+pF73ESq8RelHjxE3dmTvN+NvusNzQ47Xnw1x8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6ay6jJN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6ay6jJN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CDF1F000E9;
	Mon, 31 Aug 2026 13:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181893;
	bh=cX/28PGpuDv9PzjzEDzpUDECpxJ3PzWqb3WeckAUN04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6ay6jJNAvQ1Ow9VbUfRuhxWnILeZI0//nKmsVf4fixsN0IQ2W0rxDLmdi+oyIDPE
	 1oD7aecH0fGtIIfSj6gl+TzVkOfnFqWWaHmlN2QZn24R462Sb3E9PqVagpLNlQAvJR
	 az1RQP4FvgM+HbZo4XYPiQT6pb1rTx5HCz9wExjnviFtHzDXkALpEL0GQPC09fcn0Q
	 i9ruyp5OpmNvh5Z9Pz23USLSVsLkg8oEtmSqLie1AJrLM1XHaf5N+9w/iuco0Nzik1
	 c7NuRLYA3GMcLr5x+HOtGIKQuH5T58DmYjp3D0NuFhvMBZSpRVdMsqiMQ+9lcUmfYb
	 /aHcXut0HAHtA==
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
Date: Mon, 31 Aug 2026 10:10:58 -0300
Message-ID: <20260831131110.4681-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
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

