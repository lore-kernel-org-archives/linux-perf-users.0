Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D963DA7F3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988874; cv=none; b=fZNBDnNIUJsHV29SqlEnluI4rhfk2xHOVEb6VihlUIc+jEjgb0WlmszPAGeMUltsgff/laL6uWDbc8SvD118mkwKMoog0z8t3puU8XK2WUxVSq98BXc68MMxrHzRoOnSKo2xnIA+fS1UUMG5/3LOOcVmPRwb6/9p+tYvOYDkWSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988874; c=relaxed/simple;
	bh=CPAJiqP85MtVfxcVBaEaPWgup7ptDFM4XkRTGGxiA4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R8c7t2JIoww+jdw3u6pTDQlWhztg4zvGlHX3jyWjhbHiM6X6bgqGR8SdGZwx9JzjOPXHeAToCM40lSzzmFOX9NHEmXwIbE9A6hyljbt8Ak7zu5cnTjOa+/+RooxYh1upEWxCqAnFlA4PMDrivYkRXyd8mfy92UfUUT4STj6Oh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gERMhvN5; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gERMhvN5"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304d0d0b28eso4722950eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988867; x=1781593667; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nQ6SihkTIAHNVuQde+l6sb21AGloI7WP9qqXJPRNAs=;
        b=gERMhvN5QejjHKWnqBtTIgLDfsnKA1CIJtwjc5EeiN4jGhXgowkFaTm3RGJKnFmWWW
         7DIIQ41C96CDV1Y6nQ2E7v6KY2nX/vcqm6J30bUiFvKvDKqvMkeTKNRPO1zRrJRUghJc
         tFijML/zz3YjCPqWGvcfQHtb7cM6SGhg5BadAXcmYZ1Oe5+9FZdPLhpmV6FsZrkavlfX
         wpjR8rgjljAqd666iJddwujH6svvdZ44ww8PwAOaK8zBAEPcDk15FkoBwZYzfaJ632W8
         FlTy/k+sjJq5GLJZtJDtuwNg7g/iqqV7yCsy2ppVr98D1Ck4s50HUCbNGFR0EPaCJThZ
         PCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988867; x=1781593667;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nQ6SihkTIAHNVuQde+l6sb21AGloI7WP9qqXJPRNAs=;
        b=QsN1bmgtrms083/ITBDM2t4S7/X3Pk9kXDT6MWzKam05qa9KVptF/ib4kfwtmyA3eb
         k4INRLuTE0xLFpw5RidC7/HHj9Z4k2luRKz4zgjMk23ldENNSCfamVqtcshBFNCuInod
         cMh90TohbGsyfwOHu0g9sOlTdRWeSMJndgtvVCmSIBsrydjiUIlf5kLL6MTRcu0NgRLP
         RGGk6wn5IOfOxRGxLIiN2OGs0/PYJiVpze2gM+AZ6ZntRfRsGug3sBOTwIMm+oHLAaBh
         auISUZ5XdhnQIxGQTKVH3qzM3VYUUeRSB6gs39fy6oTyxFcLjNyFy9qIwMeAVFUe/FO6
         6DNw==
X-Forwarded-Encrypted: i=1; AFNElJ/69BQsJqq6J79qNOn9Rl0pM43ErIuliWvxJpwrjge4kYzP/DDQ/fFXvS5wI+vXCJMoRIMd2D1KCO78296GeerV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz73ZjArktbNGbh0cqSjAj+RGbwoxiJDQEdYjYyPCY6sUfnP+n
	H4P9aVFUoH4sVlhwvih1l72MszbijGZbCb/J7RBo8EkpDyF/WBy3JYkwLzDW6qWw68NsmjS5DUN
	o0rINhZMeKg==
X-Received: from dyaa27.prod.google.com ([2002:a05:693c:40db:b0:304:ee01:7777])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:834d:b0:307:91f5:9377
 with SMTP id 5a478bee46e88-30791f63488mr5547656eec.9.1780988867157; Tue, 09
 Jun 2026 00:07:47 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:07:29 -0700
In-Reply-To: <20260609070732.545416-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070732.545416-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070732.545416-5-irogers@google.com>
Subject: [PATCH v2 4/7] perf annotate: Add --disassembler command-line option
From: Ian Rogers <irogers@google.com>
To: Serhei Makarov <serhei@serhei.io>, mark@klomp.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add the --disassembler command-line option to perf annotate. This
allows users to explicitly request or override the disassembler
preferences (e.g. --disassembler libasm) directly on the command
line.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 8a0eb30eac24..57a88adfb130 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -699,6 +699,7 @@ int cmd_annotate(int argc, const char **argv)
 		.set = 0,
 	};
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
+	const char *disassemblers_str = NULL;
 	struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file",
 		    "input file name"),
@@ -782,6 +783,8 @@ int cmd_annotate(int argc, const char **argv)
 		    "Do not display empty (or dummy) events in the output"),
 	OPT_BOOLEAN(0, "code-with-type", &annotate_opts.code_with_type,
 		    "Show data type info in code annotation (memory instructions only)"),
+	OPT_STRING(0, "disassembler", &disassemblers_str, "names",
+		   "comma separated list of disassemblers to use"),
 	OPT_END()
 	};
 	int ret;
@@ -825,6 +828,13 @@ int cmd_annotate(int argc, const char **argv)
 			return -ENOMEM;
 	}
 
+	if (disassemblers_str) {
+		memset(annotate_opts.disassemblers, 0, sizeof(annotate_opts.disassemblers));
+		ret = annotation_options__add_disassemblers_str(&annotate_opts, disassemblers_str);
+		if (ret)
+			return -EINVAL;
+	}
+
 	if (annotate_check_args() < 0)
 		return -EINVAL;
 
-- 
2.54.0.1064.gd145956f57-goog

