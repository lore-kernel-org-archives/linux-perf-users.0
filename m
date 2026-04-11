Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817333C9450
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935083; cv=none; b=jPQGh/GGWTEyQzNZcwBNTWVU34kxakK8TAplB84bXKdLndynLcYn3C19LPm8tQ+DlpjESTEhLBsud15pfA1ZknTjyL4+1dri5BzqMx276bgiihInNWUP8lUkC7Ya7Yh9v1A8oNe7hpoiXlqsihig8n7Kfve0H6SqRp3xpynf4s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935083; c=relaxed/simple;
	bh=D6J4TrILnw+Vd5duIq8Xx5kVQzeF4EcLXmzsOqpDjuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GQoAN8lAD22c61Tk9YM25mQzTGy9oJYXlKhgk2+cwTtRxTsMYhn3X15ZeCHGTL6s+d9drScu5MjyURTzGN4iZYAwEH0r11wX+gJwjtO3estd/UgxzXI2tpH7gslNVeFh7oHw8fbdv7jdDmPtA4FlSeBUcACp1L87DBmsqeiMhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRpik4nx; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRpik4nx"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so15056235c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935082; x=1776539882; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=GRpik4nxvfpJAbEdCUd2o2G1Ycbj/eIzcWjP9ncsvcz25XCcFDuWO54dwGARo1QVs8
         mK/jGsTX1CTFmJ6rUDlULo0vgZx4XdbN521jCeQ41AioC5584wK6Y/u52W1gXpBaaMrT
         4pjCGreOHPBvnIwpDLJ9i4ZuqlbiFTlLPDmB8w+gs5apMgbfXe+HXiDzR5MqSw0+HVfy
         VsbbRfwwn3uu36YUup2jXnzNzi3k5z5RvfyhBrCSSuj4wC234gIw0AL/5TM6EpGaq1SO
         u35vcamPLi7guhoOjlMtcsBTPafX39Nmj76fi1X1gNBVLk/vqo1bJJruDpC0Aa+aAUYw
         MFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935082; x=1776539882;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtrEOzqaeIjI7JHJhlF1QdgQmfPYgnjdkQHTwBVDnJc=;
        b=jtkMRYxTP3PjgPacV4HvXHZKF+GTkX9HfhksbHjNHLI2aEhUn1kR8ChlaWJ9atQnCw
         1anFsbk9JENZW0BlopP6tKbb/Xsov9tjO1CoO95QsaKTR8Cqg4le4+DKaAXY3f0KOWnv
         vuD+Vx75QOOISET/ASE4SeKNckjf5Lg4huaQE4yf5K8tm3IQv52DW5Hi4Nc4sWv3exV5
         ybWXi1m+Qd/boUrgP0XJu+vxgVPMA0v2xF29Z0cTOjvi6HzARaGLU4vxKBd4sCKlvex0
         ppvgE68n+USUK0wbQa0SjU4WzMR90cTvhulI1wvuHwZEjD/Qmh7UZmlE8g24MzVXMwEx
         OwGg==
X-Forwarded-Encrypted: i=1; AJvYcCWCKX1Byb0eRaks1FD0hDfjeg8M26EBAYLx1DKXInYp8D06it/xROOD0N3llPhUjYL2g/2fTxdycWVnD1jJqE72@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRApmAGrYo9v5qt0cM+v8TBjuJngG+zqybITU2+1hSU+Dw2Q/
	L3OM4x5drUUcmVCup1VaH8LqxQfMR/un8mT02+TpWWn5mCFALJR41wZqQfSzHpwMGn7DrznIys8
	bRdB0WwXRAA==
X-Received: from dlbrx1.prod.google.com ([2002:a05:7022:1701:b0:12a:6c32:ffd2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3d12:b0:12c:8b9:71d9
 with SMTP id a92af1059eb24-12c34eeb383mr4020337c88.27.1775935081489; Sat, 11
 Apr 2026 12:18:01 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:17:01 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-21-irogers@google.com>
Subject: [PATCH v9 20/29] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6cf73bb0c7af..c8474f7ac658 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.1213.gd9a14994de-goog

