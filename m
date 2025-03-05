Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F61519B8;
	Wed,  5 Mar 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141911; cv=none; b=hqcZUnwjCR9oNfprwA5f/e8zKI0/v3acVuTooO1IJQasOaGlxlKIVvug1j4/ZDN06asrprbf1rs7qs+wFokaTitVDVUWAnyN+qkW4RhTF8ZHreSE2NETVr8NyUISlhbn+SX1eXBjFlL3vWUTr6PHOmnp0RysTdfLb2EKfDJ6i1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141911; c=relaxed/simple;
	bh=7fhh67LYhq45a0aUpnYryOepQlK24N1EWs5FHFehNUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruzBErPCgZtFfQodRzc+oF2ObrA9d8iHg3ihX45m01xeu/MYCYuwFCX5mcS3SnK9oNdiJn4lHzeZfj8BYpcsNJw1hjJyKSLWAaOiNkIJJxXufmxpptXdpg+M1KowM07pC6lyNBhFaDQbsvslvptV/XiI81/1ujyK2Xe5p4KLbaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=pZr1C1gZ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="pZr1C1gZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BgsGMifzhNygoMh7yl563AYJnAUXiTMgUBTo6PD8vEQ=; b=pZr1C1gZxkkM1tzk
	jji1Kt1Nw9s1XAVBL82fq1ucdmS3vggfDCVfWRVQ11EVckll7XWWnIhVwWd0oZjXpornmTu2nBl4R
	pzP9G1jInTQrYKfk9+ARouvmPW95wU0G8YEictDfPJ2rnHeOxxw8qKB9j9FOuC4rmljkq5jT2159k
	Q4gG/FtpzEGdDIMm8Jc3gyLSP6Ou8F82S0SXRl+M0vJMoQrq3153faXz5c8x22yr0VOWxdG4bh/yU
	J4sydvLA8eGw9+CKAfXhaKoYhcRyftRDwRUS/dI6dOnE7XRfb1UAy4Z3DIOhWjktYCkFG1KDwYnEf
	EuScZNpM4UIu/JonYQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tpeXj-002ic7-2y;
	Wed, 05 Mar 2025 02:31:31 +0000
From: linux@treblig.org
To: irogers@google.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	namhyung@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/6] perf util: Remove unused perf_color_default_config
Date: Wed,  5 Mar 2025 02:31:16 +0000
Message-ID: <20250305023120.155420-3-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305023120.155420-1-linux@treblig.org>
References: <20250305023120.155420-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

perf_color_default_config() was added in 2009 by
commit 8fc0321f1ad0 ("perf_counter tools: Add color terminal output
support")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/color.h        |  5 -----
 tools/perf/util/color_config.c | 11 -----------
 2 files changed, 16 deletions(-)

diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 9a7248dbe2d7..0319546decca 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -30,11 +30,6 @@
 extern int perf_use_color_default;
 
 
-/*
- * Use this instead of perf_default_config if you need the value of color.ui.
- */
-int perf_color_default_config(const char *var, const char *value, void *cb);
-
 int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 int color_vsnprintf(char *bf, size_t size, const char *color,
 		    const char *fmt, va_list args);
diff --git a/tools/perf/util/color_config.c b/tools/perf/util/color_config.c
index dc09ba7cb31e..301031ddc025 100644
--- a/tools/perf/util/color_config.c
+++ b/tools/perf/util/color_config.c
@@ -35,14 +35,3 @@ int perf_config_colorbool(const char *var, const char *value, int stdout_is_tty)
 	}
 	return 0;
 }
-
-int perf_color_default_config(const char *var, const char *value,
-			      void *cb __maybe_unused)
-{
-	if (!strcmp(var, "color.ui")) {
-		perf_use_color_default = perf_config_colorbool(var, value, -1);
-		return 0;
-	}
-
-	return 0;
-}
-- 
2.48.1

