Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578E64E06C2;
	Tue,  6 Oct 2026 23:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330197; cv=none; b=G3hIkO7J16hBvebdiTnwVpcHGdg8rIrMOKuU0WarCt4Gt6tCGWlcXmdqmZ9pRObTj+TS5JeRhunPaujh7fw5aR4zWmEfnoy6oP+zjFSyDTHT+3cq9P9ICcNTS9qMpHZios8dRbQg5m9Kq8XoVzkSo2RIzWjG+pqPQzKd8v6XC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330197; c=relaxed/simple;
	bh=6LztdQU/aVbI2jO/EGYoCz4lpiTtsmIXyiDcXJbkU3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpH6RfB3KcUAGQgK0M4h2pwz4qFiCzKXBOajPrKIx75SzPYxlj2Im5ZAvcN8ufMnnWHsi8aZc1tHc50EfVMS2VNm8uQ0CfIA6hNwbNmgSUbEEGDg6N2DGOuDEYLSe4Sey7vKV8sWWogi8jADgpdS3gdYiV4z5ngwBK5tl45Y5OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ9IImMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ9IImMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DE41F0089C;
	Tue,  6 Oct 2026 23:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791330196;
	bh=KrJx+y56rkSpRgY4OmmHUZywXuNepZW0jfsbY795ggc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQ9IImMx9VrG+3tceU8LK77PjvnXyPcfQs2XHBCIf/kc+57u+n2Iu1ODZBq3REYRp
	 mijgYXN/jEoriPZGcgd5PARubkSM1B1z7i4LQvHzyWBo/btdq8sA3Gqgm+OTErVUZi
	 3CdRWXxtfIA4jgRwwPhOlMINqLQfP23UjgjGjfhy+1wBI9wOLlRCRlV9RyMKi3vUky
	 5sju9R4I9XGJ5tiQsf1U5V/rEQyMIosHseAT9Pi//jQRGrblBbkzcK5SOU+I+EddZA
	 JjlOZ+mA15n2U6vFpaIA8GBxtTEqyDSyjv06fEi04qmW0pnRm5vxJg/04O+A+NFRXu
	 35y2EjH45o1vQ==
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
Subject: [PATCH v2 01/10] perf tools: Remove redundant dso data init
Date: Tue,  6 Oct 2026 16:43:05 -0700
Message-ID: <20261006234315.920817-2-namhyung@kernel.org>
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

The fd and status are initialized later with cache.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dso.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d3017c82ffb5f4b1..df03f84c9723560e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1722,8 +1722,6 @@ struct dso *dso__new_id(const char *name, const struct dso_id *id)
 		dso->srclines = RB_ROOT_CACHED;
 		dso->data_types = RB_ROOT;
 		dso->global_vars = RB_ROOT;
-		dso->data.fd = -1;
-		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->binary_type = DSO_BINARY_TYPE__NOT_FOUND;
 		dso->dbginfo_type = DSO_BINARY_TYPE__NOT_FOUND;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

