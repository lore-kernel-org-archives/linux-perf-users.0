Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DC1E9B36
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907361; cv=none; b=NsJFgkpOaWrssgfIpA+SJsxiUzvkL0SPBUVmaZCn2ZPZgIqekoaGh0JD8iifnXqNxahG5qB3eKXqP7Ix/cCu2LLmjEHM+5Hhmr4QfgDY7bWDu9Jr7V78t12ZhwLaud5A1zPl/3MS8X1ZA7zuBfhyGJAZf963SW6h6r8pjHr8fBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907361; c=relaxed/simple;
	bh=SHiag0Flwix2IL/7LkzmO5BJXZF9o/yMIBz5/KtMkQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hS5srZc/ECRHeubYWlAHTTKxiwnms46cRGJOFBA3F6991Txz7S4nj2Ba51psztYDbcADblyxKkApmkhx83eyylu6I8RJs9O5cSoNJ035bssVCid+LSFm9Csa3PfvuEt9wmFvsgoyZab/xdUOD+b7/OpZScy43IrbMgFQabSQKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqNZpfoM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqNZpfoM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a044dce2so71462935e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 00:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733907358; x=1734512158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMCW/XO9o+mmi32R54QM1qNspZAsbttLauYO9rQfjbM=;
        b=aqNZpfoMJrcTjaYrdi4/JCNwQDBGmX1R/5VJdBcWzTCBFKrCm+gWvuadyVLgfUjs1z
         Ndqpk5jTda9M3UEjCXpZnTRDjgR/jhhL6K4it/BspyuDG3wutzfIU7GVR89CdeL6Q61w
         k+T6el3USsGAh0S9tAQBalYLJxK4qmra4dZiEcMESPMirhT9N6IPDMTMLKfuRMppqTbV
         aKnoZesbuhEUHd6MjXaABrQAG8RzqTH6SvTORfsJUonw37cEbVL6sAUitw5MtIlE9lwC
         IjA/k+5VzIY4isaVcxsnQ1OyRUKHvtkvk9zEKwcYxMfWaeNci7WzQxoP/wfaiswWdRSI
         utTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733907358; x=1734512158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMCW/XO9o+mmi32R54QM1qNspZAsbttLauYO9rQfjbM=;
        b=VtKca3iBAAk3R9l8OLG1Chewd6JBN6lYJ1nEf3KeiX/Pfph50o3PcJbdsCpv8s91mw
         YGf8p6OQipAUPAmTtBqvQBo4D8fRL4Y0ZO3eQmV4vfhfcQV623WuiW+q3wME8CDjcrlS
         3NT6/wzWDRTi6i40E+0MaMdtYf4uPB6SPnQ+dIeoiHTJmS64S51ohDQivo6rW1QCF9pm
         D+wPv+zMPtBGYbqyFK09nBC83O0xDGky3CbbroGQYUh9RO1dk0sQJUZLpJP3U72EB8AB
         Yp5W64yguCWAGGb2Txb05hW/y/KCZP5JHXa99gPcN1jsoMsiMicCmDSuUfYmllQdYEHO
         cDuQ==
X-Gm-Message-State: AOJu0YzrFIc4HxTi6HH9RmlP+PoXwXoPGqT1zYtaFPQk5GD1eJEI3sVO
	x33smhbLYH2I59RlxGAIdmE+QiftaGzHXoufbJiBwMi2mGcVRQ4z6EkhQpM2pXUA5EUx/wg+umt
	3
X-Gm-Gg: ASbGnctWWYYdC9uuZbZqQz87N52CHPPTusgk031LfooiZuqmfrJk+Wbu5FjjgwQ/KGz
	PDMMGvDGyCv/TLUGZz0uua3n3jMRz7PjBny4+/nbCx2LJQJcbyzZMO14xjv7uCbP/bmFIRUfHVJ
	ZQOyMPkHqXuSp/6usNBKV63MdXzz4EfPU4eLEH9xFuZSnuxiDuBpD4RFdSGHNaEna0RK11nKqhh
	8N5AfIT8ftIB25utkLvyr7ITRBZ/zSWwE9TmILOZXZmCNifJOTvquA=
X-Google-Smtp-Source: AGHT+IFXpwNlVA326/ez1WlH2MCgtyYBdzEE9ZmE3eSWrE0KHUhUUv+qurdmdnKSG7iuu4tiLtSwwA==
X-Received: by 2002:a05:600c:3acf:b0:434:fddf:5c0c with SMTP id 5b1f17b1804b1-4361c393cc1mr14674875e9.4.1733907358562;
        Wed, 11 Dec 2024 00:55:58 -0800 (PST)
Received: from pop-os.. ([209.198.129.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm257204185e9.44.2024.12.11.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 00:55:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	namhyung@kernel.org,
	acme@kernel.org,
	mhiramat@kernel.org
Cc: James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] perf probe: Rename err label
Date: Wed, 11 Dec 2024 08:55:24 +0000
Message-Id: <20241211085525.519458-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211085525.519458-1-james.clark@linaro.org>
References: <20241211085525.519458-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename err to out to avoid confusion because buf is still supposed to be
freed in non error cases.

Tested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/probe-event.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index eaa0318e9b87..35af6570cf9b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (p == buf) {
 			semantic_error("No file/function name in '%s'.\n", p);
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 		*(p++) = '\0';
 
 		err = parse_line_num(&p, &lr->start, "start line");
 		if (err)
-			goto err;
+			goto out;
 
 		if (*p == '+' || *p == '-') {
 			const char c = *(p++);
 
 			err = parse_line_num(&p, &lr->end, "end line");
 			if (err)
-				goto err;
+				goto out;
 
 			if (c == '+') {
 				lr->end += lr->start;
@@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (lr->start > lr->end) {
 			semantic_error("Start line must be smaller"
 				       " than end line.\n");
-			goto err;
+			goto out;
 		}
 		if (*p != '\0') {
 			semantic_error("Tailing with invalid str '%s'.\n", p);
-			goto err;
+			goto out;
 		}
 	}
 
@@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 			lr->file = strdup_esq(p);
 			if (lr->file == NULL) {
 				err = -ENOMEM;
-				goto err;
+				goto out;
 			}
 		}
 		if (*buf != '\0')
@@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		if (!lr->function && !lr->file) {
 			semantic_error("Only '@*' is not allowed.\n");
 			err = -EINVAL;
-			goto err;
+			goto out;
 		}
 	} else if (strpbrk_esq(buf, "/."))
 		lr->file = strdup_esq(buf);
@@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	else {	/* Invalid name */
 		semantic_error("'%s' is not a valid function name.\n", buf);
 		err = -EINVAL;
-		goto err;
+		goto out;
 	}
 
-err:
+out:
 	free(buf);
 	return err;
 }
-- 
2.34.1

