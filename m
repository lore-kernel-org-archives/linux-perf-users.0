Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD063A7193
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259712; cv=none; b=mIICArBtXGZNjmXQfUQI6v31W9rT6X+CdZR2iYg34y/QfC/nlMNEuBLLLnpWM+Lkyca+nXl/r24BpOFRsKzY8YjcuqWLgIn5pxyFQAAGKtX/ljoH5ACK11O0TR8agQCMfi+nrMECdy9DR5zWlsRMzAZ8mGvPa9fjcrQqWWE0G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259712; c=relaxed/simple;
	bh=LdRqfYW89uofR6tAJTdTGQmwf9gmFBmDRzi9+itJXKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MCvnCBYfYKwq71MT6Ac/kxtTn7mr7k/G+n+OHesK5dynOCFmQDBSTRMheiajoMXQQzpCyLVge9bEKo3VRsoN02OuFwpCs+M5VYRWosOaMf/cfdiyojycTRjvVbr/M4x+ghgXA0Vd40UlS0BiRl/DBLCfN+BJlogT0wg/IGXU0XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q46l23bz; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q46l23bz"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2537419a91.2
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259710; x=1786864510; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvCKU3o2iNN7R3SZ+QP0rUsV6kh1WL0nD/UwzkIgjsg=;
        b=q46l23bz49NMhZb2zIr7eOxK33PC1ks97x8GZNRDy5a2X/2b3kD1QCGN+QjlhDdYpa
         5d3BzcoOGMUQmZskIQcrD9sot5CuuChDJiyYqjUOO3JEwpmEew/hVJ8B6W+HC6LHcHa8
         k2tWqF0uPQ065U5hDlXH2xViIJRwPmRiAv/CGCXkTh0qiVVWicax6+GPUP8Rnbi+vqrx
         kB5WTzf0vXNjtq/AsHwfhLPALRginnbmWohC+UZ1lGVlbmJ/sEraoMHL4ig6KaknL94F
         U87xpTUgHpNznMBHXzb5VCPIPUGScGV+dMsVcFzaazscY/OP6lKiM/nzTsIZS/I75QUp
         rsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259710; x=1786864510;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YvCKU3o2iNN7R3SZ+QP0rUsV6kh1WL0nD/UwzkIgjsg=;
        b=amYygh3hbH4Sql8U0KXgneiB3+rznj83ceyYE9MLJM2cHPjVgZG1YQ3OycvYdiho6k
         ukSdp4ZP7XqQd+kbY6ioDCPFF8phEtCuApzos2nHXL0P8iOkOG8hxlWeaN0O2E5n23LO
         38fb2e7sHm+8gp3ejLSE4OCU2bCjA1rCs4W3qhKh+QFVWifwkaOiLFxM5W3UM+LuRjya
         A01WaopEUGRAHjrbvNND+AOvmgXUbNiaSacgxhh1bYUea4YIIYN17p3kqtCtz1eUBnZA
         C8fINVBZbfbGf5Cw+CTE22ybKmY20BjmWgblgzHylzpll9JN6qpq3bVKZbWk65HYGmxK
         SWjA==
X-Forwarded-Encrypted: i=1; AHgh+RpcM9ZhCcKR920adXa3f9ZUdcl6NsSX1ivk75rQj61dBLQWONKhzM/ao6Q/9HqMNUxRiFRwnoCOaXNgLGx8p2WC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPr9OrbeFDsR4Jprtux8qC346s2nR6n2+hiIwYVG0n8m4JVQna
	2Il4iXx45PsaRjpIF8KhnIuHCujlhPlFPNFeD3bLALvhMKep6rdMR81ioLnKmILaOOlNJpUwfN4
	Vaock/q/aMQ==
X-Received: from dld11.prod.google.com ([2002:a05:7022:30b:b0:13e:5fe8:61ef])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3391:b0:39c:126c:93b5
 with SMTP id adf61e73a8af0-3cbc03b56b6mr19321582637.21.1786259710311; Sun, 09
 Aug 2026 00:15:10 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:43 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-5-irogers@google.com>
Subject: [PATCH v3 04/15] perf python: Fix memory leak in pyrf_evlist__get_pollfd
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a Python list object leak in pyrf_evlist__get_pollfd() by adding
a missing Py_DECREF on the error exit path.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 877108e42b1b ("perf tools: Initial python binding")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index af85c0771c44..c7ae1f85aec6 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2825,6 +2825,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	evlist = pevlist->evlist;
 	list = PyList_New(0);
+	if (!list)
+		return NULL;
 
 	for (i = 0; i < evlist__core(evlist)->pollfd.nr; ++i) {
 		PyObject *file;
@@ -2843,6 +2845,7 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
 
 	return list;
 free_list:
+	Py_XDECREF(list);
 	return PyErr_NoMemory();
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

