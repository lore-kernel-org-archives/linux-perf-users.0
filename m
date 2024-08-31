Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C3170855
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087880; cv=none; b=q8U3l1cjHsPXcTf63njmbHl4AH+2Ha29KDDSPb2a/q6m1Us9Dg2x6dtMaU2eZJAnTx7tXt3Fmnz5KZ12pzNZ3/a5VAtdn4j9AnqIRU8TyzzrCRoK/wXp26FCiSmhcUG8FQToEoWXAqkLCDbOW664yNHtVbF8RtGN7WkoulJS+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087880; c=relaxed/simple;
	bh=neE8KUj5swSBbTAvkEmb7HlGQpVC/JyPFNunQxVwu/U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Oqy4HEiiDf5PpRmDVBYFZk9r3Wz8FUdG1EpyKV92u3Jn1q2QJJCFNL1+70duPRM48y+SE/vLCHhOlHcrknqMJ6GfNHmjNzWiqY47b3IMXs+WxJM5lKoyTA7R5xeBIhHMOoqk2ybsIjw32Vh1h/gFEBMbmOoan0F2VTYxJbhgNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bTYqouWs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bTYqouWs"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so54767687b3.3
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 00:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725087877; x=1725692677; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMHouUPm/pUbpqXHpAwu3f/Ggg/o8qY6+an2XmPnD00=;
        b=bTYqouWsvhPu/wRbjJDDrLM9vx9g9U/ljPv/SCltgoZKaAKi9laHtmCY+8CDdKyD4q
         XHWJirKM6rruYrjRN21+5Hspl5xvaj3LBov1vfCJf56i5mXwFtqS+7occ5upO0oS23N8
         mvz3bQ8eORRS44ip3EGyxG6JCTYBMshOkeYeiVLPEIcdOy6xAGDI0K7hTFCQVeBEuNcG
         i6OEMlglaoj3p1jmRuPGkA4bwYnHmICnib5Qit2pr4VkY9onSo0EIxDwzFa0F48cyTKc
         kKFN6MGYqVpDChUF2O1i0P1dN27rTISoK8kNH2JMXXh6w+zHA91chg2V0Sdjp/t0KwhY
         Efhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725087877; x=1725692677;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hMHouUPm/pUbpqXHpAwu3f/Ggg/o8qY6+an2XmPnD00=;
        b=YzH1feOUCqvs4fcHa55kr4/gCdCJE2MGnK72OmYFRdZj58jpbgWz9XbP0LMWF8Nrww
         vbnYQh6p6BDpcO9OEET31xlEbUCVkW4NJbONcYwTkCRUcWF+3OsbivIIIiS8OE0amaoe
         MAKFa5rut2Jvigr1WlWIzWuwKLP4bkwwctxIvJcM57TkMQEAI5EnxEtf7E+cCD/HO8r8
         WynJEkoG8nrc4SEJiEsnjtkLaVS4tkucw2eB0Y7jrXhpGtKKEoeTVJ4ctZi6L4oo0Y9M
         v3xK5jNym2eS6fIhktmSIVKFe74KgRRaXiB3XSCC35hCYcWgcgP/qqvVO1As229DwHJh
         V/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHpoE5XwN/Qzk15Q5glesHWgBWNia7TWnuz+S7b5oUOD8svDXLN7VSTCPnFFZjp/H/DOp9kEj3ViuBDL4stoVN@vger.kernel.org
X-Gm-Message-State: AOJu0YysTlKSU40QE3GyLoqfocuDQqmzkbSZMfwn+15bNlVG2qEJ2u+T
	vQ8Axl7SwvtEfz+86aX2GZebLjEz90/IHUOOha3sIFbZFtA/tcowpP83iVs4StYqaPwIGBA0GYf
	LZajNxQ==
X-Google-Smtp-Source: AGHT+IEQRxwFyMDSw6Mj2d4DGqVL/glGW1ecwaCsu3ve2y6MdyDP3o6KRg8tCHoQeSLhIeD+/Ar8hkGrgI+x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4974:82ff:2f9:edb6])
 (user=irogers job=sendgmr) by 2002:a5b:1:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e1a7a176b02mr7463276.8.1725087877533; Sat, 31 Aug 2024 00:04:37
 -0700 (PDT)
Date: Sat, 31 Aug 2024 00:04:14 -0700
In-Reply-To: <20240831070415.506194-1-irogers@google.com>
Message-Id: <20240831070415.506194-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240831070415.506194-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 5/6] perf parse-events: Vary default_breakpoint_len on i386
 and arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	David Ahern <dsa@cumulusnetworks.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On arm64 the breakpoint length should be 4-bytes but 8-bytes is
tolerated as perf passes that as sizeof(long). Just pass the correct
value.

On i386 the sizeof(long) check in the kernel needs to match the
kernel's long size. Check using an environment (uname checks) whether
4 or 8 bytes needs to be passed. Cache the value in a static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index dfb951bb184b..c7fe8b4167d7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -8,6 +8,7 @@
 #include <sys/ioctl.h>
 #include <sys/param.h>
 #include "term.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include <subcmd/parse-options.h>
@@ -672,7 +673,22 @@ static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
 
 int default_breakpoint_len(void)
 {
+#if defined(__i386__)
+	static int len;
+
+	if (len == 0) {
+		struct perf_env env = {};
+
+		perf_env__init(&env);
+		len = perf_env__kernel_is_64_bit(&env) ? sizeof(u64) : sizeof(long);
+		perf_env__exit(&env);
+	}
+	return len;
+#elif defined(__aarch64__)
+	return 4;
+#else
 	return sizeof(long);
+#endif
 }
 
 static int
-- 
2.46.0.469.g59c65b2a67-goog

