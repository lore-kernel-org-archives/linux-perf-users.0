Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95A3806DE
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053551; cv=none; b=R9AAYCQwMiuhguFZ9maAm8oa2+s+BmIH4La5/etj7H4LS8NHqZRB5fHAsici4pxbeoZHYUkdneMSQiD8plovcqu2PTrWpyPiXsjU+HqS6J+oZRtsqLoGYGoM9/cERVd7EPoOi+ZTMb3IZSzLrJZyHCknE//yZMxiurbTkYXUaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053551; c=relaxed/simple;
	bh=cLWE7bs+0Cxg9cEMpw2DCvBK22szFSANqxVQJFFr1kA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M+SwAUawAu9gwi0bqaRrALNwxWNQqfDPDYDr3Bf9VH4NGBDhjmek86RTAo+u86CZqY7T7KWP7J5FdMvE5PG8xtGcie4R/xqTvcZiU0Fl+j6GdRUZKy8Ql5JNE3rDaUza9t8nTCaj4o8nCRRobXAyr991WO8XQxKazvedTazLqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puStblF+; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puStblF+"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so16265672c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 21:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776053542; x=1776658342; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=puStblF+3Q9702D7Qj6CEXtVIQsjHVJLAZWRrvZp3SpBzx8j06ZCAoQuPEAYlYuei2
         LZpLuTb5CHeXYOZ73unwiBVWkRsFux8c9Wn/VfPfpCS3lt+55DY4TBm18hi37/AnQlhm
         SEM/G03duPVfKpSDtw8RtUzE4KN7ycjovpO/OG6ZjjB/STNbslvtsoCE1X+4rABz+nOx
         sMj66gQ0d5Fq2pRUAfK8v/rgjD6tXYoYGUdpZHiRe7VgEmoKii27o6HQP/zw0sLGBumd
         mLgs5k4jFd3qgw5z5APgPfsjdQDW4IXwsFqDguePc2CdFbqM+4V5zy0tempk081dFLEF
         U42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776053542; x=1776658342;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18PpJMje7yTmFawrKVzMshBAHP9Be4M6fcInXM7pDdU=;
        b=Adg2UkSjf4bUK7+pUKCGNGxsR8Kop8L9bXRu1QMF8J3lrJ7Z9SepJHV0o/0MYHGcek
         z2bB8UlrlptifG2crn3X3x0oM2DWNvuqj8X9UQ1KGgE/ZUxo+GiPduzbZmVWm0+19Xgj
         6Ipbpmo+tjgAdH5pxE0C6/3IpZLRdnkUebNcLcp0EZMwCaWeVb3QzNcRiVs6C9vg3RIZ
         zmoc1Upk/vB80UDw8ukOrt9iIEklh1YppvGmws49cI6qUXkUWa0PITwgdWL31F11ktX9
         YWmF/t4eGoFXA1iiMq0Ts0qZZYdV/wbtjxw9RxF3Wc6CZDsosZqYe49k3R/0RptzOPvc
         MS1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+wsyzICKTypFZMNXushc7OkPd9eJrI4L7Cr37T85s8BNKZ6pSte5dy0M/lYmDdJOuchTR2s3Cx7uPJEEOWH1D@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJ5XfjMcti1dDL07vua2viJ/owqnVzv8YCWHeJmlxC3BmodUe
	FIofVS/u4cbToES6HzA1K1A1XIRQNAkJyISjziP9/B/ivJ748bMLsZR4aaGvpJKCB++28tu16VP
	1bagGYROU4A==
X-Received: from dlad14.prod.google.com ([2002:a05:701b:220e:b0:12a:c10f:98fe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6982:b0:11b:ade6:45a7
 with SMTP id a92af1059eb24-12c34e68d78mr6400921c88.1.1776053541928; Sun, 12
 Apr 2026 21:12:21 -0700 (PDT)
Date: Sun, 12 Apr 2026 21:11:21 -0700
In-Reply-To: <20260413041143.1736055-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413012227.1089445-1-irogers@google.com> <20260413041143.1736055-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413041143.1736055-12-irogers@google.com>
Subject: [PATCH v12 11/33] perf report: Directly use sample->evsel to avoid
 computing from sample->id
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

In count_lost_samples_events try to avoid searching for the evsel for
the sample, just use the variable within the sample.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ff7117c5470f..3deb21f4d781 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -788,9 +788,11 @@ static int count_lost_samples_event(const struct perf_tool *tool,
 				    struct machine *machine __maybe_unused)
 {
 	struct report *rep = container_of(tool, struct report, tool);
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
+
+	if (!evsel)
+		evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 
-	evsel = evlist__id2evsel(rep->session->evlist, sample->id);
 	if (evsel) {
 		struct hists *hists = evsel__hists(evsel);
 		u32 count = event->lost_samples.lost;
-- 
2.53.0.1213.gd9a14994de-goog

