Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE182356BA
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104832; cv=none; b=Ki6XQIUzUb6a66RMu11rvYvOth+RUzFuC3/R8MTvYVSHgDtM2gh6VfAXg3108Ng6ski2bbSu/YVAG587g569tL3olXYWy9B2GqP0GM/3ZnPY1inWsClfaJkx+h8CFyDAg49vuLd8TXcOL8/pTEXb7jViouJro6RN/mu/ROenM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104832; c=relaxed/simple;
	bh=X1MjIcGZucyzCm2r2IlBzTymaxjsdQoFFc+rtk3RK20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GdYkEGHgMW9MastwHHu4DZzHwNSE96F0+A6dSRUrsK0xE8LYRNE+tWEKZYt9OfgN6zK34YowvcRT/G7ke0leqNhGxswYKm7dxEFAzkmKWgG16DwqEoVNziY7Ongh4y+nP5qidoPfApqKjtqoaGkrTGQzUBo5QAezPAurTbukGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qgQPifxI; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qgQPifxI"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b1766192e6so4351102eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104829; x=1768709629; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeyCcyFu8+y/NnCQ7WsdxHS48sCTNn9MjknKssLg0z0=;
        b=qgQPifxIhI4RueJYM5SAEnX48tZdoNJe6+coANDuTNBLU3i6qz/Bg+0WNOaLwfCvd5
         bQFMepJ6PHhcD0tPiAK1xz7XIg+Hkf0K5HKZZkN1UNZWei7bBb3Edg4zXHCarTmzXeRF
         3wFzUoDunA4sm4f0kZMWvGxDYhU8/7WU6EhHKU7VyU2FuBgL0BaaTXpqFRseclGmw/qZ
         xaXuld5ow+q1wIC61m+jhJK+B90ewlRZsojWwKFsFE6L1DHNB5E/RNCmT0msS403pvtL
         NFO1JhdZ/H6qQ/lMDeQE2gj+bH3W+Q8BBXzAmz/Vs4CBw0wC36eGZZSd/awLonIPGn5j
         LcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104829; x=1768709629;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeyCcyFu8+y/NnCQ7WsdxHS48sCTNn9MjknKssLg0z0=;
        b=Vb1FAHB3W5x/8huMZWOU0XD7xN930hQyyO4R8G6VxWpCglIppP0clNL6RSJbhUQpFV
         0mK1J4HJHsR4nItmaGbAXbLii3dqXJaFEkolI8Iut4NKnECs4uuoJgSLU4TaBSLcRdoL
         fecvzNS1JASwVVhxV5qYteejdnKKU0ULvMNK7NV4fvjZU5nQkU+KFQNNNjigCwn8N4Qq
         lRKvM0Dwp5tPoQyZggKgBOHpcOAtNgjKm2nGdkOT9czuvHpZcTr+Nk2SUWmAJo8mArsv
         2rEVnoq/slzkJ1kmiVLo9OMrl/Es+5+xt1mCSOeE5TAiJifn8mQPWTRMZlqVPzDqpFBU
         3oQg==
X-Forwarded-Encrypted: i=1; AJvYcCUemDFampqglKbjhEFS1hZ9+WnDI+IFcaVse7mexNx08h7XkfpJJRZ9sTtLAv5kbkQtm3D4uZTEeHDpb+6S12tJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LCHB/ch7LaQocahTLTNbvpWBI0IKuOgEA3Ip2BMfqBhv9G6e
	89/n3MEAt6DzWhlr3Io8lOK976GiRbdQG+R57i17w+j1lcGM/RU1aPdurtR5n2M11TL31bmsz9p
	WeJACRaH35A==
X-Google-Smtp-Source: AGHT+IEOpSLg0Wg/xFruyE/3OQJpn0D12uVPbilAjvNA51c/zUib3AzwGvK2CWnUK7QZbSNCw1dFzUtvvSEe
X-Received: from dlbcy9.prod.google.com ([2002:a05:7022:b89:b0:121:778d:9d5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b14:b0:11f:391c:d01f
 with SMTP id a92af1059eb24-121f8b8d709mr13112430c88.38.1768104829335; Sat, 10
 Jan 2026 20:13:49 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:34 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-4-irogers@google.com>
Subject: [PATCH v3 3/7] perf addr2line.c: Rename a2l_style to cmd_a2l_style
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The a2l_style is only relevant to the command line version, so rename
to make this clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/addr2line.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index f2d94a3272d7..0f1499350d47 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -90,16 +90,16 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	return a2l;
 }
 
-enum a2l_style {
+enum cmd_a2l_style {
 	BROKEN,
 	GNU_BINUTILS,
 	LLVM,
 };
 
-static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
+static enum cmd_a2l_style cmd_addr2line_configure(struct child_process *a2l, const char *dso_name)
 {
 	static bool cached;
-	static enum a2l_style style;
+	static enum cmd_a2l_style style;
 
 	if (!cached) {
 		char buf[128];
@@ -149,7 +149,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 }
 
 static int read_addr2line_record(struct io *io,
-				 enum a2l_style style,
+				 enum cmd_a2l_style style,
 				 const char *dso_name,
 				 u64 addr,
 				 bool first,
@@ -298,7 +298,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	char buf[128];
 	ssize_t written;
 	struct io io = { .eof = false };
-	enum a2l_style a2l_style;
+	enum cmd_a2l_style cmd_a2l_style;
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
@@ -314,8 +314,8 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
-	a2l_style = addr2line_configure(a2l, dso_name);
-	if (a2l_style == BROKEN)
+	cmd_a2l_style = cmd_addr2line_configure(a2l, dso_name);
+	if (cmd_a2l_style == BROKEN)
 		goto out;
 
 	/*
@@ -336,7 +336,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 	io.timeout_ms = addr2line_timeout_ms;
-	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
+	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
@@ -351,7 +351,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 		 * binutils, also force a non-zero address as we're no longer
 		 * reading that record.
 		 */
-		switch (read_addr2line_record(&io, a2l_style, dso_name,
+		switch (read_addr2line_record(&io, cmd_a2l_style, dso_name,
 					      /*addr=*/1, /*first=*/true,
 					      NULL, NULL, NULL)) {
 		case -1:
@@ -397,7 +397,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	 * as we're reading records beyond the first.
 	 */
 	while ((record_status = read_addr2line_record(&io,
-						      a2l_style,
+						      cmd_a2l_style,
 						      dso_name,
 						      /*addr=*/1,
 						      /*first=*/false,
-- 
2.52.0.457.g6b5491de43-goog

