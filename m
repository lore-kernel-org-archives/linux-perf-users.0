Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFF1A00D2;
	Tue, 12 Nov 2024 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731394740; cv=none; b=bb4lQWzu9lA5rldMu9gUff9YmioJYtOlirObrWHLEWywD1ttMMCoGyBYODakYIYDEQXUcyOaRsL16WlonInrMAexfwnNaBNPEU0obmZlVSaC9je6vx2J1xaGtWBFZvhCCPrrrS5ifzzqPBw3/vHVKbVH94t4Eb0jmfIVDWu3qXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731394740; c=relaxed/simple;
	bh=NuNcNThvqK+Myni+fSAxbqsTc+OtZApgJqibiVY2ro4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIYTQUuWKEB5+/CdoNivz7ZBAl4eQ+apNvv84wQOPy7GIcdgt2a+TVfUJj8TYyNUzoActVvmhRvhh851RfEQsSv77zw+7cB10aQPS77yoDpDmCduKR/8QYllAO8UgaC3xUGv7ASw04BkOZ4P07kj2yKt6YtYt3M9ySzJqnQ5hgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36732fcadf14-db73a;
	Tue, 12 Nov 2024 14:58:53 +0800 (CST)
X-RM-TRANSID:2ee36732fcadf14-db73a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6732fcadbd7-4b9b4;
	Tue, 12 Nov 2024 14:58:53 +0800 (CST)
X-RM-TRANSID:2eea6732fcadbd7-4b9b4
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] perf jvmti: Properly handle return value checks in jvmti_write_code
Date: Tue, 12 Nov 2024 14:58:51 +0800
Message-Id: <20241112065851.282787-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241112064704.282702-1-luoyifan@cmss.chinamobile.com>
References: <20241112064704.282702-1-luoyifan@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the approach in the jvmti_write_debug_info function, add
some return value checks in jvmti_write_code.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 tools/perf/jvmti/jvmti_agent.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 526dcaf9f..b52466a0c 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -361,9 +361,8 @@ jvmti_write_code(void *agent, char const *sym,
 {
 	static int code_generation = 1;
 	struct jr_code_load rec;
-	size_t sym_len;
+	size_t sret, sym_len;
 	FILE *fp = agent;
-	int ret = -1;
 
 	/* don't care about 0 length function, no samples */
 	if (size == 0)
@@ -400,17 +399,25 @@ jvmti_write_code(void *agent, char const *sym,
 	 */
 	rec.code_index = code_generation++;
 
-	ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
-	fwrite_unlocked(sym, sym_len, 1, fp);
-
-	if (code)
-		fwrite_unlocked(code, size, 1, fp);
+	sret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
+	if (sret != 1)
+		goto error;
 
-	funlockfile(fp);
+	sret = fwrite_unlocked(sym, sym_len, 1, fp);
+	if (sret != 1)
+		goto error;
 
-	ret = 0;
+	if (code) {
+		sret = fwrite_unlocked(code, size, 1, fp);
+		if (sret != 1)
+			goto error;
+	}
 
-	return ret;
+	funlockfile(fp);
+	return 0;
+error:
+	funlockfile(fp);
+	return -1;
 }
 
 int
-- 
2.33.0



