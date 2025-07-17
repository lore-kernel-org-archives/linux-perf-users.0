Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658082F8C50
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764952; cv=none; b=doB0kQqxAQXXP2nZ6YcQnk00Qvg4eaXkBMqmrj88HhBQ31iuwK+PbqIwUmbGOFlTThx14U+pq5P0CdM65fZOQZJAVUeF8Hxmof30eJFCj5wU+lOIc9ERtHkUw5bbAHc+pl7dhX6xOwFJMUXlfspOrwKOKOSTsBvAajG1NkZPRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764952; c=relaxed/simple;
	bh=yk5WicchXH7kEqMOOINlnmBRjpljp2ExxBrZz1eU5C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i9jhat4L8M6gzjuolzRC2C8QPwjS4PJ4KX95SFunev+WzyymXrHfaYAUkId5QMLAJ+bcOWBGmKy3GK4KicRim7U812VS4/bEQO934th0/a5aD8c5BZLrO3fAGOCD5D94HsZPu3Y25URxWGmI6a83Ol6hQbcUAi2Wtr3LhDM2llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sjr0KQq; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sjr0KQq"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-300254d9399so586606fac.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752764950; x=1753369750; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=2sjr0KQqJ7gCuxw7R69bR4POfd8Zk0KZyBu5f+pewdZVDFaGj+ASo+TMHKfRNgusnV
         eMB3gx+RXM1B40y3UP5AZh7HSEoPguIhkaqS/8J5d7snp5P5Tx7mlgD1ZZALCsWfdwTS
         LACEv12QaHLT0E88eF6l4wrWDEAAlNGt2vYAqs15piIJM+f4v2KT0Um69dcxQX3Yeg6p
         RHClDt6LoNb6KoBkZC2bj1NzGZ1O62l5/375Owb3j0PWP8kTqQVazenB2T8DCyighlEC
         TQZQ9B1Ti9tFMcU0uET2XLrR0lPS/ZwvGb4xIYbk7xrM813eIN2IBPVe1xpOvZU2eLIG
         X/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764950; x=1753369750;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9YYyU2vUox54cPmAD4uAW1jDEZGoCp+ay+KflLB/XBk=;
        b=YiVM7y9TggR6fknE6dI61jOI9xdfIZW645parIMY8jUKvlEdyKYuEsWLTlDqBBNtzd
         eYXwB2jxB9XKW00hhxHBwK3Dxbirp8kKDBYpyHIsARfAyrj33N2pQCWDLzYEdbO4PrnB
         UzoYHA10qeXcfs29B0BtFf8PCZzw2nCuH9Xm3z9PVQu/QfEUXtyaRt1Cakoome1mdEdi
         pWwaZhrlep+qqzW85ZNe8zi6SkGRMLki9PFqvi2KRR2wFFSm+VER8myWi6f0A/dzRUv2
         fJ8Y5wmYmtEqWJcjqAWQs6kEqCWZwxf5osIkxW/0LEMrZNT4yLQEYkVOYeb9vjzWsQrD
         yn3g==
X-Forwarded-Encrypted: i=1; AJvYcCVW2k0qXgxWy/ijHXdx9hSSuEEuGIiZAahEHhV66viBdOo3lnQ/LzQ4BKZ6kvhU6YBkwnEwlWWuq5p/QzZkN5BX@vger.kernel.org
X-Gm-Message-State: AOJu0YzJYUOjjyjdsCRnFlvlD1566XsUAtVDX6IXhFnXLihfeZwi+Q7B
	/MEfdxNhc23dzf9pih3U9PTOkU75FQGWEL6T6V8Rt1BfYYRgkS5+Ym/xLWn0gK/57JqvYj2nWZr
	Ab1V8BUyCog==
X-Google-Smtp-Source: AGHT+IHuliN83IC5yCzu25KQ7jXi3r5RebwiytHJsRDzpP0JlthTbt75BQHnqwSI+kC34hatoiwpaeL2NT81
X-Received: from oacdz7.prod.google.com ([2002:a05:6871:ac07:b0:2eb:8b8c:22d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:80a:b0:2ff:a802:68a0
 with SMTP id 586e51a60fabf-2ffaf2c7465mr5321830fac.10.1752764950394; Thu, 17
 Jul 2025 08:09:10 -0700 (PDT)
Date: Thu, 17 Jul 2025 08:08:55 -0700
In-Reply-To: <20250717150855.1032526-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717150855.1032526-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717150855.1032526-3-irogers@google.com>
Subject: [PATCH v2 3/3] perf ui scripts: Switch FILENAME_MAX to NAME_MAX
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

FILENAME_MAX is the same as PATH_MAX (4kb) in glibc rather than
NAME_MAX's 255. Switch to using NAME_MAX and ensure the '\0' is
accounted for in the path's buffer size.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/scripts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 2d04ece833aa..1e8c2c2f952d 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -94,7 +94,7 @@ static int check_ev_match(int dir_fd, const char *scriptname, struct perf_sessio
 	FILE *fp;
 
 	{
-		char filename[FILENAME_MAX + 5];
+		char filename[NAME_MAX + 5];
 		int fd;
 
 		scnprintf(filename, sizeof(filename), "bin/%s-record", scriptname);
-- 
2.50.0.727.gbf7dc18ff4-goog

