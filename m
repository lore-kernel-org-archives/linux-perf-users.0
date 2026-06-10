Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60837757D;
	Wed, 10 Jun 2026 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121152; cv=none; b=afIP8lEnzwJPB56Wpk2I9nzLsdDPIRHmp+s84WYgidNi2uHlgsGBQu8rK+iAMFaavEnK54svNqEwcE49/861TOw+koAISI33NZSZb05FCuw1Ll4LGBBeJg38/w+nMjPl7jPnOTWCpS/OgEfEnAWiQ6kYh+1aCD98NdJNtAEhnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121152; c=relaxed/simple;
	bh=mWMZvQ3szNUMMGiS97I/ZGxdxnEjHlTcIoVIWEs1p1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyv8KsBJnZVdZegvsCGHbJ3XgOrB2JHNipc24P0FhELW/fNWXCpQjU5UR0dNbHPmUrZnqKQOvol4iPia5gAARiK0X0dp119kcnJNMARGDVkm2bGO/PkQkga3x+8v0/0LlKImt2wQWdXbsNNVEM2MA4nx0AEuWDZ2HYxRd/DCNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsvoGhxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsvoGhxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E81F00898;
	Wed, 10 Jun 2026 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121151;
	bh=ZZonzbJn8Ew+XBpCpDdjHy3ZMYfpCPmxVupabwUmqns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SsvoGhxvDy9M5nLW6IZcF4Tj3WXgHxwJsinAcdXn8cGfWuAdIrKU+bZoveKBrPVK+
	 g4Jw7fAcy++LaQvgdp/R24+7coGwQxauVrPG3VTqeMLA1BwnMUtKiGsuomzoC2vaPb
	 HDYmAZMU0pXuMs3kFH4IxRo/m2yxmSuN2lrRbacV7c2LuKrcvsib8kYQviWtmm4APJ
	 zqRTneydovr9o7MOZMCVQfzA2zd5/nK8nlf3PSQyQjJFm8MlG9Efa6cZH8vmDM/GVV
	 e4juwadwO0aKo9ACCllBYwYH15zAvCU3BFCJ3PPzRFglO6VqHGe9DvR0VW/oBgl9hE
	 xitaNOX8v2siQ==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 05/23] perf symbols: Bounds-check .gnu_debuglink section data
Date: Wed, 10 Jun 2026 16:51:38 -0300
Message-ID: <20260610195157.2091137-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

filename__read_debuglink() copies .gnu_debuglink section data into a
caller-provided buffer via:

    strncpy(debuglink, data->d_buf, size);

where size is PATH_MAX.  If the ELF section is smaller than size and
lacks a null terminator, strncpy reads past data->d_buf into adjacent
memory.  A malformed ELF file can trigger this, potentially causing a
segfault or leaking heap data.

Additionally, strncpy does not guarantee null termination when the
source fills the buffer.

Replace with an explicit memcpy bounded by both the output buffer
size and the actual section data size (data->d_size), followed by
explicit null termination.

Fixes: e5a1845fc0aeca85 ("perf symbols: Split out util/symbol-elf.c")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8fb25a5692b56c53..51e7cfe0f5934875 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1027,7 +1027,14 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 		goto out_elf_end;
 
 	/* the start of this section is a zero-terminated string */
-	strncpy(debuglink, data->d_buf, size);
+	if (data->d_size > 0) {
+		size_t len = min(size - 1, data->d_size);
+
+		memcpy(debuglink, data->d_buf, len);
+		debuglink[len] = '\0';
+	} else {
+		debuglink[0] = '\0';
+	}
 
 	err = 0;
 
-- 
2.54.0

