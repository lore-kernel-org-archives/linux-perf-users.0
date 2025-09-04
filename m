Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C93E234966
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002664; cv=none; b=Elqhuux13+CHmcPugDNRnFflSl9IL7UH0SU8BfFD4F4OlyXqsLDsnTsaRoKfH7gt85Em5eO3Zmxy/QN/8McsdCTihX4em4mOBzX2x0saRm4vpmMLRDkIb/a4tCLFsQdUWCbYbuoHpWyuDrtBOnsqEphENyCTTYQdr2uPVyRxJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002664; c=relaxed/simple;
	bh=WbwuewpY10icGQu/W7sUvcToRo1R4qP9KKJtQKyOM0s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nbKclL6E7GC0yi6ss1GKzvuhRnKY+++Chi7/iZFLlzva8Kn9m9ogNkpTLKf9PFXXvx1ol0NbEOdepv5eGcrpXjykaB3e5xt29dzxsc6MAiI0B2z6I4evCCsjJR/iIpCqSjr9ziSJ9hvGhzrFdIhtpKqBKfOuJowTA02+pv/At6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBMKu5he; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBMKu5he"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c9e2213f8so16457485ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757002662; x=1757607462; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/UOanZ2PmR3kMJHnHNKLCAes3a/LIBraz6jr4hqu0OQ=;
        b=fBMKu5hehv14p9IF60YoyWG0JCH37j/QF4rfp9k5yfoH9U/zU6Dwq3M5Wsyu7zCVk5
         9gu9Rq3Jbf0FnO8CRvXzikJJ6S91Ta02n0U7lr+D5I7pmbFHiYdBtbx/P/dYlEcINkng
         Fzmpej1sIL22cQ7dJuV/gfRKx7x3EdNQ3bwSLfyug3p10bKDtGzmrBgYqsFBPYon/iGH
         V/d4gHmWb3WMQxeM+hcvO9l/J5PDLkIjiGxvDWtxrRBdSvIs8F4Rw3wzlETm8kLaKtS9
         70p5y+ANcfUErJ2r4RUDNAuysjblY+mQDwq0ZaaW0oWRSXpslRdqAa4lc7leX+S6ydQK
         7hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002662; x=1757607462;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/UOanZ2PmR3kMJHnHNKLCAes3a/LIBraz6jr4hqu0OQ=;
        b=bL3LxLoLsIUX/xXzcdOBlDjS7UlEiyVtKOCWNSuz7Kg8fIV/LmmBh/LWavrM+FtUVA
         s2tqZCPtRNxc2R/AntStKtBjh+9S5dtnemiQkzk7UHWgi2R8LQHk9ijWP3NuUJcCxf5G
         Wj62rhD/D3w5pv+hRRtFRIXHtm65O1ho10SIA0jPLYNWAqsVJIKXe/CWau+CSgLfvNhR
         muOTB6xy+e8fQck9Xh/43SXJzeXBPY4JlgWJL7PE0XEG478Atnpr7ZU4Ua84kBkwz60K
         V6lqllNUEbTo1bd+5yPh9K83Bi7f4AT1P9307l/jAqAKoq1tQglBWHkO4MkUC4Vgs1+6
         2AYw==
X-Forwarded-Encrypted: i=1; AJvYcCU5kL7TTIoaFBN6h5fpGDubBKaIb8dlvzhITuD1xD0Y1Hhw/jFM/kA7FzoREgS5E5NqDZZg8eKzVIxCjD2b8SuR@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVHSViVitYPDaMwSICTReg2rHxUKCmhkVxkJU2rOTwKAbq1M8
	U4UOstWP2Xn+3jfpH9FWSPL8Y+LXMC0qiNrceSbRS/TMbppLZcVdkH6IRmnK/JAS2nsfb2AX93+
	aNwHND00YeQ==
X-Google-Smtp-Source: AGHT+IHve4jHgJ8Ftz3JzIwawxkAlew/pKxKturHnhBrtdGSG7IWbPfF3US/ysEaBUE4Mj9is3lfpj8gS3tt
X-Received: from plpl17.prod.google.com ([2002:a17:903:3dd1:b0:24c:8b0f:b5e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac2:b0:24a:b5a1:10cd
 with SMTP id d9443c01a7336-24ab5a1122fmr220398345ad.52.1757002662335; Thu, 04
 Sep 2025 09:17:42 -0700 (PDT)
Date: Thu,  4 Sep 2025 09:17:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904161731.1193729-1-irogers@google.com>
Subject: [PATCH v1] perf symbol-elf: Add support for the block argument for libbfd
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?R=C3=A9mi=20Bernon?=" <rbernon@codeweavers.com>, Sam James <sam@gentoo.org>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"

James Clark caught that the BUILD_NONDISTRO=1 build with libbfd was
broken due to an update to the read_build_id function adding a
blocking argument. Add support for this argument by first opening the
file blocking or non-blocking, then switching from bfd_openr to
bfd_fdopenr and passing the opened fd. bfd_fdopenr closes the fd on
error and when bfd_close are called.

Reported-by: James Clark <james.clark@linaro.org>
Closes: https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org/
Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
Signed-off-by: Ian Rogers <irogers@google.com>
---
This patch should be applied after:
https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org/
---
 tools/perf/util/symbol-elf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 033c79231a54..1346fd180653 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -873,13 +873,17 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 
 #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
 
-static int read_build_id(const char *filename, struct build_id *bid)
+static int read_build_id(const char *filename, struct build_id *bid, bool block)
 {
 	size_t size = sizeof(bid->data);
-	int err = -1;
+	int err = -1, fd;
 	bfd *abfd;
 
-	abfd = bfd_openr(filename, NULL);
+	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
+	if (fd < 0)
+		return -1;
+
+	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
 	if (!abfd)
 		return -1;
 
-- 
2.51.0.338.gd7d06c2dae-goog

