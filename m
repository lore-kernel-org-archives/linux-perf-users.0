Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BD74FB9A7;
	Tue,  6 Oct 2026 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330199; cv=none; b=GamT57H9i/95aVrSaROZjbJ+o3rHkjm/vH+khDIh0i1YnlB8n9NW3olwbTe446XZGm0s74U9WA7WIIU043RFma/J3estyyrL7MpV9ZXG1g2+A0Jd2FtSgGHHfkQiUFz8DUvySUkdsEP+AizKj+UfQsNWIOfvJDrxAAYjQvbd9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330199; c=relaxed/simple;
	bh=8vGtOyHLykUjqsoHJOvOOQ27NjPw602nS7AFob5IjfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcNE+JWfqEgVR7DrrCJ+0SdDSrnD4FZiMdMcntLCe7vZAUeVCumWJL7yyXbsFBV/7UJJKULnUEASmYmXw1yipNr7gb5GFSlk7ypN18rG6hbwZX5LaYrXSFVHsnYlWlKZw4MvYBVWkohZmO43ZlM3bXBlU6HCfx3KicTcMOZ1V28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBnV34lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBnV34lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19BC1F0089B;
	Tue,  6 Oct 2026 23:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330198;
	bh=ICD5cqEaM2Gyp7o0f6sjlGWA2oE3pZ3o6cIHTbB23Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MBnV34lrudIO0taMFBN2u/ZzRSkREC3MkdMtpd9y7IFCQ7V/jklQSZ94s2bk9TqDi
	 jEGcKWN6vzzMwncwpY++zywE0Wu7ArEMNV1QWZDaN4+QpMxvuCGskaNYvqeO7TkR+o
	 hH43ZE3N5iiGVMdjd08lu3sOv5BxvF8fzhIN6PpGtCx+fGaTzAt4HFKw5J8LlP3wS1
	 RvOOXlPkxW0GM+8KOd5q15Gquz7GN5uqWyAe7QvSn17LRXaRkHR3BlIXdn0G/tBkV0
	 Kr9JB9D9Ua1GxGf4VYvplU42vQoUJHK13sr7Be3UNGNyEJTv9wLz6TEy0Uf60ZWJPU
	 yrD7430juppoA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 05/10] perf symbol: Set dso symtab type for libbfd
Date: Tue,  6 Oct 2026 16:43:09 -0700
Message-ID: <20261006234315.920817-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261006234315.920817-1-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It missed to set the dso symtab type when the symbols are loaded by
libbfd.  When it happens both syms_ss and runtime_ss may not be set
and won't call dso__load_sym().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fc6e4dff282bc2dc..02b096ccbc60ac2a 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1933,6 +1933,7 @@ int dso__load(struct dso *dso, struct map *map)
 			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
 
 		if (bfdrc == 0) {
+			dso__set_symtab_type(dso, symtab_type);
 			ret = 0;
 			break;
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

