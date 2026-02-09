Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED243A7F5D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658897; cv=none; b=PrCIupPBZVM/NUQqzUVOUDixMVNuU9cIkGjje09o/Mdt+6BQzsC0kI4k6wuxhaSc86ryniTxJ/t4a8cCR129cy3d06YBXsVPoRK1tDLYZhBemPxZYHcQLXvGUq8cDR03nEZsYR9jWnPybF9AbEcjQEJtT6hBYarQ48tdu/IDq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658897; c=relaxed/simple;
	bh=eiHGa554VoouQjkLP84Hc3Tz1Qjrz7ST6/1UQlFUX9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lG3lc+T0IVD8ESGiZubC8r99JtM1CGHh/8xw584Xf72fj8FHFqr9YCrif+dLUL4CUNEKr8WkRuKZR4aCwr5SZqq/I0Ez74lnM5sQLDKNu80dwdXsWwIo3+YhBr8xy6E7QV1GE9QWjGsbPDXp85waKHxR5ORJXEkGvyo1Ao+euY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FuyQlK19; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FuyQlK19"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a38e8980so3816945c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770658897; x=1771263697; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdotLyD11lWL4GWl2pBkwF07IbBlZLJhbJnZyLiuGdE=;
        b=FuyQlK19L1R+DEg+ld617cUU3qdL/dAkqw61N0+fs6SVC7mvFSSaXeynbOyoDHx1pq
         YGN6nkDbXUMhQR7fAaQtAGcUVjQlz4DkzEAXXxrjl4yYRSzTVA41oLZjQsfzsTy8uIR5
         MejOPF7MgFpF1Ro5kt/BYXUtBg3uqol/XUCaYXYBstySqsFX025u+TcgoJPKyaiWjo0O
         T294phMXqnXLrvTgj49jzrHKLp2n+c5iq3pb9lCOJmG3bI/tgzJROLrHm/jJRlVkXU6Y
         LbS+e50JD+6a1A9xVMLW8GMe5jlQ8Uyb4jAxG1QBMuz4+Bn+zKDOtP16oFzYqr4coRN5
         omFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658897; x=1771263697;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdotLyD11lWL4GWl2pBkwF07IbBlZLJhbJnZyLiuGdE=;
        b=MjSaPXKsQK6a9oYzhtLr3LDbC0Xuj8kluTZz/8ekR+FttHHa6XlHyTTY82EhkzODkj
         O736O+hioi3Jp5kkUU66WFXoC7fE9SQ78eLO1CGxXkNbsW0lQ/obmZU0YIAfnDavNin7
         m8wwMgXevp1kLVjNN6+tXoemhG+LguE3wSXQRoV5pT2cJcbkhmep2jMTWFXNMmAmMdPC
         2PbIBAjsJ2N50WPrgfaKltcLV1chssvjMEoVCzpGIidS7x2ydsjsxy1maTgw4vWe1dj6
         Gh736VKJs/DTl74/TfdcL2lywp22Y7eJIUCJC0/WnHpEw/JYeQPFC42XR33op5vv5vKT
         KMTw==
X-Forwarded-Encrypted: i=1; AJvYcCV36WfycsRKEi9QzgTeXHWjZbcUQLgquaN0QDmfeDqPynfzLo4ZSCGE2CJjTwovbUs26TeAoPNZS2+fw9C4L0kc@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoU14y4OJ+X2gL38BMzQdHig3kCk2vhTu61lT+/HJT5wPMZ0S
	+fkfr8ka92Xt16hLXAOYMvsSyx0eSdZOzNUqWwzbcnI9jNZ4PpYeBckyIjGfIyUSpSEa/nqwwD9
	P5X2jFNC02Q==
X-Received: from dlw6.prod.google.com ([2002:a05:7022:46:b0:127:e77:9377])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:a86:b0:123:330b:398
 with SMTP id a92af1059eb24-12703f51b55mr5057729c88.19.1770658896959; Mon, 09
 Feb 2026 09:41:36 -0800 (PST)
Date: Mon,  9 Feb 2026 09:40:32 -0800
In-Reply-To: <20260209174032.4142096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260209174032.4142096-26-irogers@google.com>
Subject: [PATCH v1 25/25] perf evsel: Don't pass evsel with sample
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

Arrange for the sample to contain the evsel and so it is unnecessary
to pass the evsel as well. This is done for uniformity, although
parsing of the sample is arguably a special case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 041766d39ec3..21602d121260 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2997,10 +2997,10 @@ int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads)
 	return ret;
 }
 
-static int perf_evsel__parse_id_sample(const struct evsel *evsel,
-				       const union perf_event *event,
+static int perf_evsel__parse_id_sample(const union perf_event *event,
 				       struct perf_sample *sample)
 {
+	const struct evsel *evsel = sample->evsel;
 	u64 type = evsel->core.attr.sample_type;
 	const __u64 *array = event->sample.array;
 	bool swapped = evsel->needs_swap;
@@ -3239,14 +3239,14 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		data->deferred_cookie = event->callchain_deferred.cookie;
 
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 
 		return 0;
 	}
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (evsel->core.attr.sample_id_all)
-			perf_evsel__parse_id_sample(evsel, event, data);
+			perf_evsel__parse_id_sample(event, data);
 		return 0;
 	}
 
@@ -3606,12 +3606,13 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		struct perf_sample data = {
+			.evsel = evsel,
 			.time = -1ULL,
 		};
 
 		if (!evsel->core.attr.sample_id_all)
 			return -1;
-		if (perf_evsel__parse_id_sample(evsel, event, &data))
+		if (perf_evsel__parse_id_sample(event, &data))
 			return -1;
 
 		*timestamp = data.time;
-- 
2.53.0.239.g8d8fc8a987-goog

