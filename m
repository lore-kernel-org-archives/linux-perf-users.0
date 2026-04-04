Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D7346E71
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274275; cv=none; b=tRyWgWrMGX9qpd1k5cn5oxJd38S847WBAH02vAuAjJ1Ryz/Vm2R29jXtiz5Sbk72YxSWFXWKvktwezP3a2Cf8O7P/YT0UWzh0uhlbfn3i6eClsoF11wqGxKy13ARWiEDvt3hCPzEzMBlVBqrB3qRbIeWMoYsE63IJsjt3aaUwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274275; c=relaxed/simple;
	bh=p3zEoq/bmQlpgAQt3/UAgTTaA4JyI4UO/QfGKpe/qI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWK5H9+8im47spcemvuTxXV0JoOWyJ4+y4pK3ba+u5Vz/iZLvBQqdMEHmocfsen8zDzpWJgfM74NifxgQ4fIw1XY3L0qxfVFy6ZIe8IzPBsGZt89ZanYPqDradaNRfDKoGkT561MwHurbYHbccNtX0vb/JGVOp/9pTXtmvgZ9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QWNIp688; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWNIp688"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bda35eab74so2765384eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274274; x=1775879074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=QWNIp688BkQmlPNebN5pcNbVrsfNXxwWC59bI8X/hZ/0S3mLJlUF3B8TSmLOwmR63P
         4idq4skW+Lxf/M7TKcauHjFQHbdVEpZS9IXiffGwVdOKRY1KzvOrmXxx/Hsz+wKk6BNW
         krlSBMMHPfC6CWlR/9M8xGuMh8/XHAwnKbeEFamBr4+FZMk9+kOhsNKTp+GRbgwaC6AK
         9e5vNWUwNmn8WcmXaVq9CQSh1TM0NinZCkZe7QDt/nvcFc5glCpBHjjK1RzEOQdoul/r
         AbYMyyTx6QrNBkYPMyHjesdFhyconQI62lzMyqNnzZZNvG/yajEjHg2agTjg/dMwr40M
         0NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274274; x=1775879074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8QqzSuQNDbhCu1T3qPBkA3LFLyljNgjUWQeDCGZhEI=;
        b=a+3Pyb16MpgICgS78hKXhBP3iE7Jo4tonjhGTAm0hvvUF0983WsNTP9oEq061ty0HR
         +ViRhPmynLCbf1FX7kZOFXWbGvfu9oVzECZIL58q66fksZ0K+bVKCfdAz88fu70aIwy2
         g3ni7x3FfQ6GH+L11kSTKXp2co4gas0YK5jSaUMjKP3AnO+9O1HmDyIhxT1RDUaqEL4w
         UM07L7rNjJSUTWGcA2oVoqRTzLDADJC9tJxCrtMLVl1jbQgKbonCJAeYLiS+IYgtI+kx
         K66jDZJmuFuzPN6ayseBMbUs5v9ZeGi2Sp9nXG02YnIJlbXP00y4F8+HWAtYRmf/2Fo7
         a2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm3kw6WQmw5zx+AFV6pyFv8A9TIuBSpSNdgSPCMqza+k2RMBhpneFmCnmYp0GInADKl7T44UmzPzYEsknZhL3s@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFF7gbWfPmdye3ZEaRQ0BlB31/Tq4G0jabSXzd54f4x6A0cxZ
	XIThg6YbxSd3F1LTRRn5sIWfidZgMx11651A5a9j0yY1/xueTkBR6XFZAFhF3j2fkK7FhYchxdQ
	2XNl4GvM90Q==
X-Received: from dybmx6.prod.google.com ([2002:a05:7300:d406:b0:2c1:5b29:d58f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a98f:b0:2c0:c6f6:b075
 with SMTP id 5a478bee46e88-2cad6baf6bfmr3844802eec.8.1775274273472; Fri, 03
 Apr 2026 20:44:33 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:24 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-25-irogers@google.com>
Subject: [PATCH v6 24/25] perf s390-sample-raw: Don't pass evsel or its PMU
 with sample
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and its PMU so it is unnecessary to pass
the evsel as well.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-sample-raw.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-sample-raw.c
index c6ae0ae8d86a..52bbca5c56c8 100644
--- a/tools/perf/util/s390-sample-raw.c
+++ b/tools/perf/util/s390-sample-raw.c
@@ -222,8 +222,9 @@ static char *get_counter_name(int set, int nr, struct perf_pmu *pmu)
 	return result;
 }
 
-static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sample *sample)
+static void s390_cpumcfdg_dump(struct perf_sample *sample)
 {
+	struct perf_pmu *pmu = sample->evsel->pmu;
 	size_t i, len = sample->raw_size, offset = 0;
 	unsigned char *buf = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -284,8 +285,9 @@ static bool s390_pai_all_test(struct perf_sample *sample)
 	return true;
 }
 
-static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample *sample)
+static void s390_pai_all_dump(struct perf_sample *sample)
 {
+	struct evsel *evsel = sample->evsel;
 	size_t len = sample->raw_size, offset = 0;
 	unsigned char *p = sample->raw_data;
 	const char *color = PERF_COLOR_BLUE;
@@ -332,31 +334,32 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 			     struct perf_sample *sample)
 {
 	const char *pai_name;
-	struct evsel *evsel;
 
 	if (event->header.type != PERF_RECORD_SAMPLE)
 		return;
 
-	evsel = evlist__event2evsel(evlist, event);
-	if (!evsel)
-		return;
+	if (!sample->evsel) {
+		sample->evsel = evlist__event2evsel(evlist, event);
+		if (!sample->evsel)
+			return;
+	}
 
 	/* Check for raw data in sample */
 	if (!sample->raw_size || !sample->raw_data)
 		return;
 
 	/* Display raw data on screen */
-	if (evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
-		if (!evsel->pmu)
-			evsel->pmu = perf_pmus__find("cpum_cf");
+	if (sample->evsel->core.attr.config == PERF_EVENT_CPUM_CF_DIAG) {
+		if (!sample->evsel->pmu)
+			sample->evsel->pmu = perf_pmus__find("cpum_cf");
 		if (!s390_cpumcfdg_testctr(sample))
 			pr_err("Invalid counter set data encountered\n");
 		else
-			s390_cpumcfdg_dump(evsel->pmu, sample);
+			s390_cpumcfdg_dump(sample);
 		return;
 	}
 
-	switch (evsel->core.attr.config) {
+	switch (sample->evsel->core.attr.config) {
 	case PERF_EVENT_PAI_NNPA_ALL:
 		pai_name = "NNPA_ALL";
 		break;
@@ -370,8 +373,8 @@ void evlist__s390_sample_raw(struct evlist *evlist, union perf_event *event,
 	if (!s390_pai_all_test(sample)) {
 		pr_err("Invalid %s raw data encountered\n", pai_name);
 	} else {
-		if (!evsel->pmu)
-			evsel->pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-		s390_pai_all_dump(evsel, sample);
+		if (!sample->evsel->pmu)
+			sample->evsel->pmu = perf_pmus__find_by_type(sample->evsel->core.attr.type);
+		s390_pai_all_dump(sample);
 	}
 }
-- 
2.53.0.1213.gd9a14994de-goog

