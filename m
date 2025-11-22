Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71462F7AA6
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 08:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763799595; cv=none; b=CEYMd33801TLObschgU9hw2mIMs0pdMl5rCXICFfJDXA4sDdPwpBbdb4EDg2teZulf3Js98GKutZx0YbSTgF3EViWKE3x8Vpx9/06fPkEhihpequSMiJitDo1DZVfjL5V443qZ9XADzg3YLkPFP/Mzqz+T3ekkdqHnV5nNZVcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763799595; c=relaxed/simple;
	bh=hokyhNCY+MHNMohzynNm3sybgVsho518d99UEKSGFb8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=k5BbGudZA4MaZI1dChla1bk1vIwm1Zkgd7n1vGqRafWff2K1QEI2xhRSjQjmY9E0/foESK+TUJIN/U8OdokW+bbf107qnqIG0I8NQyj+zK724eWIoBQ6V5iZOR9oD83qoBc2mqz1V0vfmbo8jvVGtCm1K96Tnjdrzi+NpH9GIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bzLQWK9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bzLQWK9"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b90740249dso5276109b3a.0
        for <linux-perf-users@vger.kernel.org>; Sat, 22 Nov 2025 00:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763799593; x=1764404393; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26FhnXWE4Dsn0zAV9ZwtQIoSpCE1XR4rqqIzFCKLx+o=;
        b=4bzLQWK9V1y3LL6p/vsbw1TuSha2y/QHPJr1spge2EKXv5wxXQnZ4LHd9tMuDb862v
         gId/QVHOawkCNE81WZ0zWUBokBNsN6LWT9+zKfwk1hC12Nm8lm8fB5dQ5vUbuLX1m+fL
         pbAN31xm8kW4CshkNPRIZQ8+b83IQ4Vlw+OAFh7RK1efCzQkdarAikGtizv+vsGmSOc8
         3c+BoxIltvlK4dYtxz9+LjR0jxBgAt5iRyndRjhajYUbkPCJZzSCwOFBWySiiw+V8/dW
         rOTxTu1hWA9JzuVt80J2AkRatAvOsyNtuSxLww2cTBpR9LMwEL5fqKJ6VvsZBm0HbDxI
         0QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763799593; x=1764404393;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26FhnXWE4Dsn0zAV9ZwtQIoSpCE1XR4rqqIzFCKLx+o=;
        b=sNQRu6X3ncGD65ClVGbQK/FmdHfz0jbNtCosJ95hgVkBgg9rrLT3bhwIENUVYZUh3F
         C+ez3iwmNzB4dsrG7x0DkfA+IU7cycrDJvsviukEtMdhAbPyQcUsVNA8zj1J1vV7/ujJ
         0+XgPOk67BUYdj2++WyHs0+xmGDVZpJFNBdd8HaOV/pe+j+kHDX1eXnRFi/AKEb43ww3
         88lG1lxeSFg0rQmLIY+jYNm5tKbpoCm5QERKj6LlCd9LKOdo0/WljXejBSuLK01L5ZVu
         3DPup9HDw19tZi8xqT/tZycbkEM6SAjBhEkDMUnED4u8yKtBc0EqZBu/epocf0bwN7au
         AIzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA+mVBUlpVjSFlT7Tr/LvhPuDbf0bIisC1QTEMMF/pxk66j89If3CelEW3D3+A2c10q+ILJK8OhiNOvp6jM1V6@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEZmRPk4nMb2JbRRYBZXUuXeITz2GS7VRP4y7rwxsaEGr0GDs
	4pzH/5G4ujdEHxH0+b6zWIAfegYs/SxIpP8W52pPfH6TaIbTzIBMURzlAg7gUe32qGxHdkhx8t7
	LloCeBRUs5g==
X-Google-Smtp-Source: AGHT+IF30nRtHoEub+YkqFq2fygrJaHFjXNsptZmI4tghtBxkzV5nNyD0cEO4D+YMpyWWt86zI9LwysnHYJE
X-Received: from dlbvt2.prod.google.com ([2002:a05:7022:3f82:b0:119:49ca:6b8c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:b903:b0:11b:d990:1de1
 with SMTP id a92af1059eb24-11c9d865e98mr2048215c88.39.1763799593123; Sat, 22
 Nov 2025 00:19:53 -0800 (PST)
Date: Sat, 22 Nov 2025 00:19:21 -0800
In-Reply-To: <20251122081929.7588-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251122081929.7588-10-irogers@google.com>
Subject: [PATCH v1 09/17] perf c2c: Clean up some defensive gets and make asan clean
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To deal with histogram code that had missing gets the c2c code had
some defensive gets. Those other issues were cleaned up by the
reference count checker, clean them up for the c2c command here.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 14c3823f8fed..d390ae4e3ec8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -322,7 +322,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	struct c2c_stats stats = { .nr_entries = 0, };
 	struct hist_entry *he;
 	struct addr_location al;
-	struct mem_info *mi, *mi_dup;
+	struct mem_info *mi = NULL;
 	struct callchain_cursor *cursor;
 	int ret;
 
@@ -349,20 +349,15 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		goto out;
 	}
 
-	/*
-	 * The mi object is released in hists__add_entry_ops,
-	 * if it gets sorted out into existing data, so we need
-	 * to take the copy now.
-	 */
-	mi_dup = mem_info__get(mi);
-
 	c2c_decode_stats(&stats, mi);
 
 	he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 				  &al, NULL, NULL, mi, NULL,
 				  sample, true);
-	if (he == NULL)
-		goto free_mi;
+	if (he == NULL) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_add_stats(&c2c_he->stats, &stats);
@@ -393,17 +388,19 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 		int cpu = sample->cpu == (unsigned int) -1 ? 0 : sample->cpu;
 		int node = c2c.cpu2node[cpu];
 
-		mi = mi_dup;
-
 		c2c_hists = he__get_c2c_hists(he, c2c.cl_sort, 2, machine->env);
-		if (!c2c_hists)
-			goto free_mi;
+		if (!c2c_hists) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		he = hists__add_entry_ops(&c2c_hists->hists, &c2c_entry_ops,
 					  &al, NULL, NULL, mi, NULL,
 					  sample, true);
-		if (he == NULL)
-			goto free_mi;
+		if (he == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		c2c_he = container_of(he, struct c2c_hist_entry, he);
 		c2c_add_stats(&c2c_he->stats, &stats);
@@ -421,14 +418,9 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	}
 
 out:
+	mem_info__put(mi);
 	addr_location__exit(&al);
 	return ret;
-
-free_mi:
-	mem_info__put(mi_dup);
-	mem_info__put(mi);
-	ret = -ENOMEM;
-	goto out;
 }
 
 static const char * const c2c_usage[] = {
-- 
2.52.0.rc2.455.g230fcf2819-goog

