Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6535A3AF;
	Wed, 10 Jun 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121213; cv=none; b=LF48Ne/obtpMwwWBQjtX7ABnbTycin5RgiWf0LOvR+Cf6Hog2uEgUPcLLCizwmUnO+2cCLjErOcE4rhWo9gqObR+B/c/EpdxDURILXKOlbtfGk8GRap52Su3xCugc8lfyWbj0tbzB7rFYc2KHbT2dyk3YOi4n0lN2X5Oty2BR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121213; c=relaxed/simple;
	bh=fF2wOELixWnem9vEH2jl3CcWguN6tg6SBSd+AAJhoW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXgk7JYGicZf89ADjQPvH6r4ijNRRcZc9luywposTBRrbnULOdnJHf6INwsrOSwDhCVH+Phn5jFWxrmmTkGBw113UlXUkpBIKURZ32sVX5GMI6Upa2QFV9skuDzTau7L5wf399+6XBkBCws33qMG4OvHOLBm4VxND9daSQxufgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrzDQnT5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrzDQnT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D871F00893;
	Wed, 10 Jun 2026 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121212;
	bh=dwkstMBvP9yLEOrxgQIAnrXQfEQyyMbjgTy2XJxqMe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrzDQnT56FMbe91s+Vd11r/uk6wCpPNXueoowdbMK9JIzo5w1EssTuh1pHamMrRpQ
	 g1/ltr7f58VjfMK9RpJifaI2foI869HPeH4Lo64ChX0Pw4PhghblqU9+C9pJS53ZI8
	 dHcYJDIlBOGGiM2NHXLngyTQpAVMWeXrkUbxoxxt0KQ0AzN45GekPjIjG3vgQL47ns
	 H/C3CGMiNO2AJlxjHSX85rlxKHhpZx1Ua6eChtwwd+KT62fVMlPweXq+GPIW8yyo4s
	 +A6G7PHpEbN/aOKIFhV3C7mcVifgGtOFgS7naLB7iMHdgvyjnkhrDwWAbI07cdcG2U
	 lZzDhUBdpWaOA==
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
	Kan Liang <kan.liang@intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 17/23] tools lib api: Fix filename__write_int() writing uninitialized stack data
Date: Wed, 10 Jun 2026 16:51:50 -0300
Message-ID: <20260610195157.2091137-18-acme@kernel.org>
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

filename__write_int() formats an integer into a 64-byte buffer with
sprintf() then passes sizeof(buf) (64) as the write length.  This
writes all 64 bytes including uninitialized stack data past the
formatted string.  Most sysfs files reject the oversized write,
making the function always return -1.

Fix by capturing the sprintf() return value and using it as the
write length.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 3b00ea938653d136 ("tools lib api fs: Add sysfs__write_int function")
Cc: Kan Liang <kan.liang@intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 3cc302d4c47b1669..d16911818d4d3569 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -376,12 +376,13 @@ int filename__write_int(const char *filename, int value)
 {
 	int fd = open(filename, O_WRONLY), err = -1;
 	char buf[64];
+	int len;
 
 	if (fd < 0)
 		return -errno;
 
-	sprintf(buf, "%d", value);
-	if (write(fd, buf, sizeof(buf)) == sizeof(buf))
+	len = sprintf(buf, "%d", value);
+	if (write(fd, buf, len) == len)
 		err = 0;
 
 	close(fd);
-- 
2.54.0

