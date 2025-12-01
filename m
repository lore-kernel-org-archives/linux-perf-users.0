Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4128506B
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622554; cv=none; b=sX6h9UYXsb8KA191geTLU1KoC+0LPuOX32ixPvULGYmsrEja4a2Bc8pETHGw94ZYzwhNxpIplheXRzQ9qNZhB5g6yfNJnQf9fAy27fINt410qhm6/Qw4B53UEokIj5qxqaTXFJHeEs4GaKxDewUQYdw+rpNQ8qt1kRLIXLEwSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622554; c=relaxed/simple;
	bh=Ok/xo7eYhBLF4aYLIQP94dASAk5ZaAh8Axv9S/Q7Ark=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Z75kY5prXJptmATY2YUg7VglSlECPco05LGQ33m4HUlCOLEXMv2fD4SE3glh9gT+XRVhw8fvQVtMgeLS1yd9rLu2REyh0Gk4b7MAlANgDa9XzMNcx01Gm3ORxABQCCI+ZjqO7OX04mWZxxNiXqFCKKEUw1rX1ibgi8H0iOkFIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SphHWViA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SphHWViA"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so6675769a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 12:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764622551; x=1765227351; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hsbicSz/UZUD8nTk2GV2IFD5/kDi3KGaf2M5SRJ974=;
        b=SphHWViASlv0bFpGMsuooA4tsc+UHRmd/p/6eLd77O0rdZAJqr6QgiHYenFNy5GJe5
         4ls5RmyMM7lS51rEGpZ34kmMnRBbozSa/eQNZceJuypzf7FAJy8oPFFkK/sX4SoAjqIm
         6llwMtUcpThtiH72uBmBT7LQir+jCK3Yxf67OINX+3GDCPuw2l7+4OVLO6U6lk44eO0k
         45qM+NmR4IXMUJHMGRGA2inElQ4ENTYvTa8WWhj+kVNqqr3NNNCpf8HlahUHtXNTGS07
         w0Qj8BjRY/G+J1joh773rv2gFB1C4ewJn310hEKM+5FMrXPAXe1WGUkeTKdHz4VyppIv
         eQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764622551; x=1765227351;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hsbicSz/UZUD8nTk2GV2IFD5/kDi3KGaf2M5SRJ974=;
        b=EnkPIgkZhDUsfQzAmm/SFHR9kYUd6tO5Zes+TgwM04jyqFQZShlmb9kyrSGyjlE6oZ
         DXogNh0lOYywITmBREOqKYOt89RDMXnZYpjmz0NYXJxJJ+od3Cc8hT/Wvnrwju+ReA3M
         EGKIiyYj2JWvvKVqqu4n3jErcvAW/3DojOBfxwT13xM9YLSxPo2PI6nFQ4UxwMWlJJAj
         wdVxmjO/hb6H2ITs+ZE34gNtWW4q4nmFZxd7gdIOFFVcmjXUh+fLLoWG//GRUXbyniw2
         JmZ0kH5s4JqzYnNliTsohh81fZEZRsL+44qwoc05T5GeDeHJbWBklJG1ro2YLHYMAsWT
         ky1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBpNRaZQFERqVc/pkTZD9CA5M5R/AMt2y24biH5f8zMA9GOgthV+QAC9CeUDYfp5gCFh+gRRX3CaKSeTi6XOHd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf37vdminmfBlse37czv285zIM7jrTK1tAU/RfRpRYQ5OEumQP
	+vjEPMI3xgN8+zEZUtkudqbxznoX86BXcLJP8UqhHnOpjpj62ayxQKjU3Gm1YMG4J1bNMs5IKbi
	5Eq6dLe9Qtw==
X-Google-Smtp-Source: AGHT+IHx1ya3ZH1MrXnmPeWa+EXedBYXHbjkOhwpTt6Nn3WfS/q8PIEYjleWe0E0pr+lonU84zZsQJ7Haz0+
X-Received: from dlak23.prod.google.com ([2002:a05:701b:2917:b0:119:49ca:6b90])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:24a2:b0:119:e569:f611
 with SMTP id a92af1059eb24-11c9d60e253mr27718362c88.10.1764622551457; Mon, 01
 Dec 2025 12:55:51 -0800 (PST)
Date: Mon,  1 Dec 2025 12:55:09 -0800
In-Reply-To: <20251201205509.195451-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201205509.195451-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201205509.195451-11-irogers@google.com>
Subject: [PATCH v2 10/10] perf symbol: Fix ENOENT case for filename__read_build_id
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, tanze <tanze@kylinos.cn>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some callers of filename__read_build_id assume the error value must be
-1, fix by making them handle all < 0 values.

If is_regular_file fails in filename__read_build_id then it could be
the file is missing (ENOENT) and it would be wrong to return
-EWOULDBLOCK in that case. Fix the logic so -EWOULDBLOCK is only
reported if other errors with stat haven't occurred.

Fixes: 834ebb5678d7 ("perf tools: Don't read build-ids from non-regular files")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 tools/perf/util/symbol.c           | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index c98104481c8a..539e779e3268 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -276,12 +276,14 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 {
 	char filename[PATH_MAX];
 	struct build_id bid = { .size = 0, };
+	int err;
 
 	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
 		return true;
 
-	if (filename__read_build_id(filename, &bid) == -1) {
-		if (errno == ENOENT)
+	err = filename__read_build_id(filename, &bid);
+	if (err < 0) {
+		if (err == -ENOENT)
 			return false;
 
 		pr_warning("Problems with %s file, consider removing it from the cache\n",
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 76dc5b70350a..f43e30019e21 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2008,8 +2008,9 @@ int filename__read_build_id(const char *filename, struct build_id *bid)
 	if (!filename)
 		return -EFAULT;
 
+	errno = 0;
 	if (!is_regular_file(filename))
-		return -EWOULDBLOCK;
+		return errno == 0 ? -EWOULDBLOCK : -errno;
 
 	err = kmod_path__parse(&m, filename);
 	if (err)
-- 
2.52.0.158.g65b55ccf14-goog

