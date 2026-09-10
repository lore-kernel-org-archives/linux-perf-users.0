Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E475563FA2
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063003; cv=none; b=YDMIpTHl0SYzceaLytI9A4smKU4aNjM49Ezl6AjBBrm2Tp0h07O/TYG24n+bw0Wwhocht/xFYQah4oHH37pZh3Z8z30rn21AtaYXEcRrrP3MsWAcRt7d5RI4+RO2VGR+3bK495sS+lV5aQVcs36txS2H4dkq5WOn81H7ripkLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063003; c=relaxed/simple;
	bh=vaBOM7gJFJP/iDNYbksPS4xPwihltpK6FFy2L5l2j5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LyJTM4ZZhCWcKJoMd8nWKc6c43wH2Ll9VxIKpiaH2P742t48Vl+VIgpCpiBlnY3qCsgjihcsiFEHjNogn8saNAFI2CmmV5giZReNBxHib+MRWEvzjZNMe9nhphcNKbaCILS+VnOJwO4Po8tpK5liX8zSB3gWoiJz+gexKQr79vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCYtnWaE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCYtnWaE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-398fe469aa0so12283718a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789063002; x=1789667802; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnzBeOHTZJ3ZGeQaPHN7X7+9Lkvg1S3DJgXkiyBoNCg=;
        b=WCYtnWaE1kA5HTFfLxCC00A7wyHFRtLsUy1Z4xpd+aMfOPZO3DW7P6VUAHUtjNNhof
         3FJjaVw3k9ciNiVYYaKVVNkpcCKpeDmJWZutNiChUTvi5qENuFDgu7XG1ANmcyJK4d+4
         in8lUQ0+/a6FbVkYRwZK6rX4ZnMJJ8UOf3GD6DYCayWp0sBCCJdGyaF8D1nR/s2719us
         8hUrLkOLBKs5YNhMPN3Sht7Dyswa2WXv13ccAmCvyvoGdfsQigcHu0ZEJKd3b5wbhYDp
         XK9n4uMIFJc0IyoWEHV5RlwS8bp5j4ApD6msH/baPQfpbnb8nlFE/TqTzoU4QJEykrkj
         d+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063002; x=1789667802;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnzBeOHTZJ3ZGeQaPHN7X7+9Lkvg1S3DJgXkiyBoNCg=;
        b=p4jaRwUz1S6nKPJA/X/rMyH30cW0vxcVAXi/9vCAkcEAowxX27fVhbXclDBHO92W4b
         tD3f2tA4RbBPjqON5pNXYtkQPEH5ExDbUq+1SgYLAZFP7r6bWtVvLrXT+DPggHEzkeOk
         Wx/2nyTpLzkkxcjj0wfwPd4RMM7iNUyOfiGWi85AjoMi9+dHSiGLeIk94a101Eei/Cuf
         oeLSC2DbBPW5brdZOQg6TrU3d4OEcQgJnXA9ZmX2qy04FCTI5gVB/jY+t14InxOWXcsP
         nInMdxmavMHOKsZf9QvxmthiKy2ZOwxP60x+78fDRW/WtasSLembjanuvpqrnEQLrKbJ
         fFLA==
X-Forwarded-Encrypted: i=1; AKwUvBw1/hrhRW1KPRBcOQ6GuuFl3Z9ZhA8hThyhNOJg9uNyIyOhCRvp9onQbOMDzTBzF0e98TPxXBrVTczfGXvmc7GD@vger.kernel.org
X-Gm-Message-State: AFuF++nXGHkA4SnQ89u22uc92wotrrgYfa4RqRtbzDAmUWQpPR1fHLoi
	8TnOkqjJ/zYwjC8Yqf6tMr0LB0bCsBQVhF0X2G5aelSwPqX86ThKPcdw48f/svujBbnb+JG55iU
	W9IFm2H+hfA==
X-Received: from dybdb32.prod.google.com ([2002:a05:7300:b0a0:b0:33b:9d11:a879])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d88:b0:39b:92bb:9ef0
 with SMTP id 98e67ed59e1d1-39d70b46171mr11858633a91.20.1789063001455; Thu, 10
 Sep 2026 10:56:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:56:34 -0700
In-Reply-To: <20260910175634.3014018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910173715.2996571-1-irogers@google.com> <20260910175634.3014018-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910175634.3014018-3-irogers@google.com>
Subject: [PATCH v2 3/3] perf header: Fix potential memory corruption in cpu_cache_level__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

strim may advance the pointer assigned to cache->size which causes
later frees to crash. Fix by performing the strim and then memmove-ing
the potentially shifted string back over the original string. The bug
was introduced by the transition from rtrim to strim, as rtrim
wouldn't move on the left.

Fixes: 13c230ab6e56 ("perf tools: Ditch rtrim(), use strim() from tools/lib")
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.1-pro
---
 tools/perf/util/header.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index bdd79d7542ef..78b16a098148 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1267,7 +1267,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 		return -1;
 
 	cache->type[len] = 0;
-	cache->type = strim(cache->type);
+	{
+		char *trimmed = strim(cache->type);
+
+		memmove(cache->type, trimmed, strlen(trimmed) + 1);
+	}
 
 	scnprintf(file, PATH_MAX, "%s/size", path);
 	if (sysfs__read_str(file, &cache->size, &len)) {
@@ -1276,7 +1280,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->size[len] = 0;
-	cache->size = strim(cache->size);
+	{
+		char *trimmed = strim(cache->size);
+
+		memmove(cache->size, trimmed, strlen(trimmed) + 1);
+	}
 
 	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
 	if (sysfs__read_str(file, &cache->map, &len)) {
@@ -1286,7 +1294,11 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->map[len] = 0;
-	cache->map = strim(cache->map);
+	{
+		char *trimmed = strim(cache->map);
+
+		memmove(cache->map, trimmed, strlen(trimmed) + 1);
+	}
 	return 0;
 }
 
-- 
2.55.0.1007.g17ff1f9808-goog

