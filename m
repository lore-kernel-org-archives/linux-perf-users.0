Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF138A9BE
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658895; cv=none; b=qkjf4cWPcD/HHP+eHFcntelWXXB4iHjQVMLlShDvFRyrebGiyRhtlZseJHAdZLj99cMgQYsl0K1Pr2WPPUDJGR1cKHtqOqodmMMseFwmEONLi7A3pJgOSYN1B4MVeVhs+Meexiasr/mOHxwenvSVTiBX5zr6tqtBaPp3/ZWNJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658895; c=relaxed/simple;
	bh=GG1Bh7Zpw1Uvs+C91uLQkNMFfLMj4M+KWCfPVcQnHQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aDmp8OARzzzt+gO0TSRnkAh7zjrk1zGz2Ds7fqe5bPfc9c4AroZgOpvvNTfbvamCeIu0qUE7czLJVEIDTwwBKSDBkMe4THLolgfXK0JgSXuznv6zVGyqLSbfpTWCz55CUoMY81BN2VO43dbVVgdEALx/EP2yu5jaoeIFM7IuxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ePHcyiaE; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePHcyiaE"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711967e0eso2086311c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658895; x=1771263695; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3SY+MTqKhKx/RsdaynB2K1/i8SZLAKMnj7gakHGStbk=;
        b=ePHcyiaEGCtXeIX+bbetiixmB8IS+GgEtBq5Y2MYQ/CiceN46dQ7FNBO8GQMnDz4+2
         g91zQZdOOKhTO1Sa/1GbultOc7VjJJf8tUDSPfFyqP2GU8g7WLj8eJuEaa8R790zdwWH
         nTxbI4je8adZiJBLhz14G/yqbPjDmzRQrB4PCca0Qn7q+DouiyNGYglTEWcUb0CkLKHR
         /P5sVgBdtFoIRHojcvlDNEf9Hmu4HxHfDhITDvetr9prPR/O4bSzCSNb0eycG5770Lkl
         eN7pqK0yXfcsiZ4fTgcNzgeMhCyqB3HxFXFQNnsZpui7wgrA4FelyuaxsXRVAOtWZvYk
         yEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658895; x=1771263695;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SY+MTqKhKx/RsdaynB2K1/i8SZLAKMnj7gakHGStbk=;
        b=X1d/PVYWtLlnSkp7KbfofxZsR06T7Ed9BWFZFUYOe+Up2bNvUHAHdBl2Nkdpkf+Q43
         aKT2YImkctWsrYS0ICX4jkvNh0SmaQ9kweCUG6QRZCJ1/l28DvzI4v/waI8tOqey91eX
         i7FZ3rftxyKISXbdLkk4nqvtLwGfoKrfaYOtoorL2miPP8GxXAjdi0sUGW82cO+Y3pdj
         azLJX4Vlczvrjsz6E3gRrZ8GWEq896XX4ubz6LNK3fgjWZ3gqqO7YrNSdUjUGvotMOo3
         uwviaY3BG+0yWLcMduchVot3HJqvAfFIkWz0uzvFoFZ3+gzcnt6N1fhenSkgnH+suMhE
         ECwg==
X-Forwarded-Encrypted: i=1; AJvYcCW3lK/MDbt3NHCHaOjvxiFBSHSxOMcE/xAflSNVOl6XUKQr6Alwk3Y7tprPg7M7adyWt+Ca3mRDW139l6WeTk+l@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY1LrCP5si33imlDEeWUBbgpMJDRgTmm8Tfge30fdCaKBFEOB
	0YctxRCqtNN/TzrqUXpPi0CLUZ24tkDqv7jRgibpgoUJq21J74VAYOFfwy/IXEcRMK/+d+uCyE4
	atcY8UFS5XQ==
X-Received: from dlnn14.prod.google.com ([2002:a05:7022:618e:b0:123:291f:3e5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b90:b0:11a:126f:ee78
 with SMTP id a92af1059eb24-12704010cbemr5828183c88.34.1770658894805; Mon, 09
 Feb 2026 09:41:34 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:31 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-25-irogers@google.com>
Subject: [PATCH v1 24/25] perf s390-sample-raw: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c6ae0ae8d86a..bfa342536b9b 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -284,8 +284,9 @@ static bool s390_pai_all_test(struct perf_sample *sample)
 	return true;
 }
 
-static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
+static void s390_pai_all_dump(struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	size_t len = sample->raw_size, offset = 0;
 	unsigned char *p = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -332,14 +333,16 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 			     struct perf_sample *sample)
 {
 	const char *pai_name;
-	struct evsel *evsel;
+	struct evsel *evsel = sample->evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
-	evsel = evlist__event2evsel(evlist, event);
-	if (!evsel)
-		return;
+	if (!evsel) {
+		evsel = evlist__event2evsel(evlist, event);
+		if (!evsel)
+			return;
+	}
 
 	/* Check for raw data in sample */
 	if (!sample->raw_size || !sample->raw_data)
@@ -372,6 +375,6 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 	} else {
 		if (!evsel->pmu)
 			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		s390_pai_all_dump(evsel, sample);
+		s390_pai_all_dump(sample);
 	}
 }
-- 
2.53.0.239.g8d8fc8a987-goog

