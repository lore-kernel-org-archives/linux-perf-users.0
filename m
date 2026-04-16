Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8D286AC;
	Thu, 16 Apr 2026 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298483; cv=none; b=Rru3tMh5wJGgXYn4oKpNavfpXquVQmqfjbsjU0K9DyFdT8tTIT6/LccfKEiSdjtly/7m2DTaSdP/aZNsgeYwDwYqGAvFzyPPP1vEc3zhDWoZDIJu9L2DzYp8hNdKWYk/Kr+7IA3ehbyMv+XHSoOKpvl+fIq0TCYvK2T/nZOY6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298483; c=relaxed/simple;
	bh=H6liez7WESmbfgSAy1NtmogDKAjTD1AhH+U1x5vV9kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvKMsutY9fvnMH0j/jRPuFRQtRHdAzrWIpiGOm5UtTCGsH5v0rQaDMpiJyjAm+fwCIRz9b2u/oHo69t7R5HnAo4CiLWzvKrahtbOKt7DQawa9wHS6wF3KvxwVQ7aB7aGqQ1SpaU3eEvbCZC2G8TWw8KHw9zZ3udw/Xp/4DTkKLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKxQ6lFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKxQ6lFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7261CC19424;
	Thu, 16 Apr 2026 00:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298482;
	bh=H6liez7WESmbfgSAy1NtmogDKAjTD1AhH+U1x5vV9kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKxQ6lFGmnimHMvPanb0oddpjDqxWe1weKqjw1pMtrD+DU8YVs2AaRzUZEm9zpGAI
	 lIAA4p8yU3gIJnwoABIJOGejLVn42/a8n1UVoA9ZNASF17deSqu0JsTm/tnvKtJKTA
	 H52kjoimrVaTO1M40KESN9Hloo/kJnxkYu5h+MSFxAgq+zOSFMPoIq+3yVFsTNbF2G
	 HXHYGnmCSHI6X3QQa9KcylnEUfaxsfrIFp0t/g+537cR+Gi4lCovi5D4cHnrFmFn/V
	 RP+XaDYRCu3V1md3b9FRLms9JF4DccGMOPSDOvNt2+25rWAnQq+qrpmPqYbxWRlINy
	 Ip2FX03WCCYmQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf header: Validate string length before allocating in do_read_string()
Date: Wed, 15 Apr 2026 21:14:21 -0300
Message-ID: <20260416001424.362797-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416001424.362797-1-acme@kernel.org>
References: <20260416001424.362797-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

do_read_string() reads a u32 length from the file and immediately
allocates that many bytes. A crafted perf.data could claim a huge
string length, triggering a large allocation that would only be freed
moments later when __do_read() rejects the read against the section
bounds.

Check len against the remaining section size before the malloc().

Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 13bbf8df15f66cab..c27ed90727ea6629 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -269,6 +269,9 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	if (len > ff->size - ff->offset)
+		return NULL;
+
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
-- 
2.53.0

