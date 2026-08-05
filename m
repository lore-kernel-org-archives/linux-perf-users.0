Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFA3C13EC;
	Wed,  5 Aug 2026 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965272; cv=none; b=foKU9+aoc+TEtk1iV3niFzCIwGcbGB9tyhCTT5mST/adbX1D+/e4E7VSDFxvmitSy64+XapzeacixhPXNNtATfqu40xellnVHZrrsEKAelflV12via7TpjIRLqwH9+jZs1q0Bm7wO4DCTD1LmwCQ/U8CjYTYoqXT+xJ/VHoK6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965272; c=relaxed/simple;
	bh=gZcEwumJlpFRCvPvjBMaB87q+60D7+O4hVvSDjnIxts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHJtoVhpd9XIB50twrczPpTeovp9MDzqgfcpTml6HEpfGHnfJtyNDfJPPBX9sr7yn1IYhisB06H1U38MYJ2F+LfpK8Jq42S3ULFTXd/ks6hrbzkU/4wbmPRGZs3wx+gF8BVX62CvyWq0MnqsshU14+b1NXm9y+C0gUlekyWwI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwuxw0Rn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwuxw0Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586AF1F00A3A;
	Wed,  5 Aug 2026 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965271;
	bh=+G+AKucJ1isjhdkxWVgPseggtu3KkKfR+/WNxL4KFcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwuxw0RnSa9fYRvJIgR2ixVmLQtJSqfWORRKNvpUpXbKxQi7QttexTdCDthYJuSWd
	 c7lQNinOLewYMi91SBSk4xfxWu3Hc5UtX+nvNqjHfuKhMovFiqN/dL781ZtRpO/9ln
	 J+4RKFWtNwbvXANeoOpvhJ6UbHvEMw/oHugWrF2xlf0bReUddD1h9KJ5GlEk8r4hb6
	 /6IbMuq4yNA0uSve7tUUO72ES7dRcRoxOOS+q4YCR3K6ttlon9j81TLywp+i804rbV
	 sVuCBg+gq+6e0J+KevmOJLS0sE6xRhtb/skDv6g+2cSmgXjd3bp0L18kTCtj4mdkBN
	 cmL2/pZ/e2kzQ==
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
Subject: [PATCH 07/12] perf jitdump: Free event in jit_repipe_code_move()
Date: Wed,  5 Aug 2026 18:26:57 -0300
Message-ID: <20260805212704.267779-8-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805212704.267779-1-acme@kernel.org>
References: <20260805212704.267779-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_repipe_code_move() allocates a perf_event with calloc but never
frees it — the 'out' label exits with only perf_sample__exit().

The sibling function jit_repipe_code_load() correctly calls
free(event) at its out label.  Add the same free(event) to
jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e865a43f6ea8f884..f3d9a2b01053a92b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -683,6 +683,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
 out:
 	perf_sample__exit(&sample);
+	free(event);
 	return ret;
 }
 
-- 
2.55.0

