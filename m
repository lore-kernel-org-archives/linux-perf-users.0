Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C421405F7;
	Thu, 16 Jul 2026 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162618; cv=none; b=WXuwmmZt//rQT3K5b0QcnuD8EuZqQsOK8qwNiFknDWUi9g3ca/WBPqB9nZnVIqiFIIFcNMo1DWDr99DJyiUTd/ERedLl8WA/TbBIdXyJnfYg+lkgGrvVuvUck+oOjkaGI2DxBAxcDd3fASEILs642835yClxgpd4m5aHio94KVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162618; c=relaxed/simple;
	bh=F5tQhPwZHGwF2jOlF2cKt8dP58ZUjtLvDE8eCi989s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Annz13LRb8iPQr+642doqGcid20zvjlgoICK7XTf49EqPnErNn2pgm4Zufd67mxiiPJ5TZGXVnWo0N0ccOP17kc+UaJZcfZbEfQlhMVcv56RiCSbwb5h4QAolpZfI6inqOKSf72G1pLAb6CDSqyCbIINz5t9z9Dom+k4UoSvNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmzGpE+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmzGpE+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2140A1F000E9;
	Thu, 16 Jul 2026 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784162617;
	bh=3ra5d/WWZMW1UCEnt5roi5PAsthiVEyu+xXqpunrhSA=;
	h=From:To:Cc:Subject:Date;
	b=JmzGpE+iBCLrQeHH8odnrgtkPiAIHQThcNOJ49nUJcRJi549xQEgYEz7M8E72gbHS
	 u+zSjpjLUnzJOGl3YB0CLr+5NqOp9YGr/Sn7Hu5OceaKp4HLxDX3evnVYJBGw8A1Hj
	 Ne9qk5KZKy2ISiea0oenQzWTImXj3UHvh6EgEzLOErfnHnEA9Y5NkKi/6/qPrh7TCR
	 /seLczSymcyw32BUmazx3rS9LsWfJFNsCGUS8P9Cw9+lFtJeBb4PYJcTgC8wIabB23
	 XPKb5Bqch2YbXN0gQIdrCQqk7fpTjDUC7q08Kq3e4IehOtcHTVb8Px/CEvYrmiBfcL
	 rHbutnt0SW5Kw==
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
Subject: [PATCH] perf build: Fix a compiler error in util/libbfd.c
Date: Wed, 15 Jul 2026 17:43:36 -0700
Message-ID: <20260716004336.2731086-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bfd_boolean type was gone and converted to the standard bool type
but we have some old code that uses the type.  It caused a failure in
the build test.

  util/libbfd.c: In function 'slurp_symtab':
  util/libbfd.c:94:9: error: unknown type name 'bfd_boolean'
     94 |         bfd_boolean dynamic = FALSE;
        |         ^~~~~~~~~~~
  util/libbfd.c:94:31: error: 'FALSE' undeclared (first use in this function)
     94 |         bfd_boolean dynamic = FALSE;
        |                               ^~~~~
  util/libbfd.c:94:31: note: each undeclared identifier is reported only once for each function it appears in
  util/libbfd.c:102:27: error: 'TRUE' undeclared (first use in this function)
    102 |                 dynamic = TRUE;
        |                           ^~~~

Fix it with standard bool type and constants.

Link: https://sourceware.org/pipermail/binutils-cvs/2021-March/056231.html
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/libbfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index c1c12308cc12ffea..d8241c7caac50836 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -91,7 +91,7 @@ static int slurp_symtab(bfd *abfd, struct a2l_data *a2l)
 	long storage;
 	long symcount;
 	asymbol **syms;
-	bfd_boolean dynamic = FALSE;
+	bool dynamic = false;
 
 	if ((bfd_get_file_flags(abfd) & HAS_SYMS) == 0)
 		return bfd_error(bfd_get_filename(abfd));
@@ -99,7 +99,7 @@ static int slurp_symtab(bfd *abfd, struct a2l_data *a2l)
 	storage = bfd_get_symtab_upper_bound(abfd);
 	if (storage == 0L) {
 		storage = bfd_get_dynamic_symtab_upper_bound(abfd);
-		dynamic = TRUE;
+		dynamic = true;
 	}
 	if (storage < 0L)
 		return bfd_error(bfd_get_filename(abfd));
-- 
2.55.0.141.g00534a21ce-goog

