Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4DC2F746F
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799594; cv=none; b=L7x/CzOw15TDIPZzSgmOYHHs2+oYMYcWY+1ldJxjX2oPtpkdGrFK+wCVNkwSDZmHLsMgHWTRgapGZslh/gou/vrvOOVVXlf/LDwnP8gXZAwwHX3pBRbwF2bWOrIn+zzq62Nd2HbaFtRAL218WbNgI2hVSVBXu0lKWgRpK7doCNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799594; c=relaxed/simple;
	bh=mA2MV5rABJcjF/Lb3elai2grZOHKvTen6356CVQDrh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Gl+dJwIc1EZ3pU20tNzZspIeJ8pgucOssTO8gQ7KaRxLKNTkFCy8mwH3HXIkmYImAPTeUxwSoRsCo6v2CK7lbnyF4sFNw5vn6TBHgeROUQVgEC59ZpwS1IQAyLF3rc8mkoU+RCE5AMZ8H4IvCNghK9SEVE+uHQx2N2xFPagy/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlKDkXsL; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlKDkXsL"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2a467c4e74bso2791223eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799591; x=1764404391; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsSDzsXsk7nkJCCyX2QLE9nfb83/Aje7A45oAxCcY8g=;
        b=BlKDkXsL8NajDh8vzCQlsZICTM6YBc+uwOhq5S8J1pTJ09pF7Fzt6mcbnxPDOsQub5
         wcXCZ7zM/CmC5a7miuPoXnNMUzdeC/8qKi14GJYrFAPxpGkkn3OilOSrdikN+W1pfEz7
         4983iBtp9qknTxc/YxKWBGSgQfIXCYMGFNuiWnOHkk5OHJCgb+TZ9gAE5qEx9+cexDWa
         0XPVSJR5SmLiwbB4tfYvjX9nG9Pqipk3v0PHX812nF1PJZJ+cfyKX4L2G6vRP+WN+XTw
         OkwjUEj70MGgTEIZPsN0BVC4++4QwQuxrhQmottPi/pU5TPR6NLjFdEcwLGtaEo4MbaH
         oKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799591; x=1764404391;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsSDzsXsk7nkJCCyX2QLE9nfb83/Aje7A45oAxCcY8g=;
        b=A2ybzqzEkY/WlMwQVecSk3Vne3beer07000Vyzr12UoCDa1JWBnP6k4m4C4CVzGWTR
         zDNoJXN5VAn3YTTXsAUX5FDIP+InVsmvBoe7AQZNiKuluVEn/GHKNE+z/tPox12u95Ax
         ZXBXGdDLZtrXu8KgDkHure2cPlsHPlYf8VDH9DJadd8F+uJYZC2Dc+yQtnAZrYwGJ7cX
         Bf/WzvdJZBB8JkxhH72srPNQ1e2HaACpQVP3fUx1IY/6alGyJ4OBL021L1ftgngyBzSI
         yfnpViB3h7VOUaKPgpBPZl0IUsizBKh8Xt2F6z7kTZIPkhCLBtYpAUysgPeUKhhXBupe
         R5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUP8Miro1n8wJ4nP4pAUrtNgOlumtZ6qm6k5ljvVEDyqOc8grQIBFS9mjMh1SfevvIJnElyi5Uva2bOkx5Ke7Fy@vger.kernel.org
X-Gm-Message-State: AOJu0YxOtwCv1QnKkwtOm9qGWHYhf5I/OKNyRcfr71gg7nrBC8Ljwp43
	5hCDt1dvcknOV4SxeaVScjGnoeGAvSESy6VebBzGoUDtMRXe+j8S6Nz3ts+Xc6j9DaR/Pwb/7a3
	6IqwehyFQhQ==
X-Google-Smtp-Source: AGHT+IGvRNnYPnvu9nAfMweclq/awekQFDS+3hr5JAVyvkLJ4/DHctkejCiJNKtlY1+ut608pSd8vDTDbLdI
X-Received: from dlbdx35.prod.google.com ([2002:a05:7022:e23:b0:11b:d561:bbfa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fc83:b0:2a7:721:f615
 with SMTP id 5a478bee46e88-2a707220f28mr2252054eec.12.1763799591182; Sat, 22
 Nov 2025 00:19:51 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:20 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-9-irogers@google.com>
Subject: [PATCH v1 08/17] perf jitdump: Fix missed dso__put
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reference count checking caught a missing dso__put following a
machine__findnew_dso_id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index b062b1f234b6..27a2ea1b000b 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -546,6 +546,8 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 
 		if (dso)
 			dso__set_hit(dso);
+
+		dso__put(dso);
 	}
 out:
 	perf_sample__exit(&sample);
-- 
2.52.0.rc2.455.g230fcf2819-goog

