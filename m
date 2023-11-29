Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/snFXEy"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E419B9
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 00:10:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db410931c23so7779154276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Nov 2023 00:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701245430; x=1701850230; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=X/snFXEy8faZNX6QoGJzhEUbNV1WjZARbZDPCvqBThRN12rlcWhd6juUuU6E+vfzIF
         HDnaayxQuUF+Wg33rLzJp0HqET17oiK+ooFXT1yuMAzRpaUSIpAwy71YUDItnPoNdh9T
         zVpN+dx/k/AY3od4+skeLV+Dv3aOsP0PGgniJTo5cvZU2RmfXGZRJgTs1y6szv57iXsj
         kYThJ24xeEQVP4oG979Pe/oPCrj5/8mHHO/nRFYIGRh6cqVG9y/ZxVlxvWIeetXt9qNC
         1q9m9mUF1pCKhbIY3iAntfnnQBzOIHX5QfWv8JNc8DstLN72noFnuMCUiV5TSpzsMoTz
         lxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701245430; x=1701850230;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cizzxjAOXVtNMhutvuRuFXeQ97rL+0eSPOInOH69jLw=;
        b=FKzEVzOAKk3noe4zWKSKAULuTBxVdglji4EddQ+U8jGm/GQqb//4/5ALvtTf2hVh40
         vwE7czPwVqy8p9FjVVsbuITa9kxhVIRB24rTJMzuWEO+Z3XimyeYgoISJ2pYyHZYrKPk
         5hd4SdWajgTcBMOL3/D8nDsKTMY7I0dC/mD7gzh3gN8TcbPaFwhI7VYGFA8s+xPJ2eYU
         OlTuOdZtfSKjR7G5YMfPwo1wfzN82d5IeCJLyMzeFxe0hlYWdlvkJvzUWPF7bkMTeN7u
         3IMNxhkxdbniGFdMyrbHEkFN2U7lykIOmWTfYUfZCgCNBg0OE7a9EVQKbhCJIr9Ez2ja
         Om7A==
X-Gm-Message-State: AOJu0YwnbmCAobg/+24P2Go/BT/hxsk2l8gOHuWWmWvtlsxbhYv7OxHV
	KZWr/Hi3TT2V5VUBluQWUuYBBEnGZnPa
X-Google-Smtp-Source: AGHT+IGmneAGaPYvOs8mdl9PtOV8N6GGuxvdo2hPaYRLDR7wynZTsfXHXMus8ynoyI5qMDICYh6DPo/GfI/B
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:763b:80fa:23ca:96f8])
 (user=irogers job=sendgmr) by 2002:a25:ca04:0:b0:da3:a91c:7356 with SMTP id
 a4-20020a25ca04000000b00da3a91c7356mr440438ybg.8.1701245429912; Wed, 29 Nov
 2023 00:10:29 -0800 (PST)
Date: Wed, 29 Nov 2023 00:10:03 -0800
Message-Id: <20231129081004.1918096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v1 1/2] perf list: Fix json segfault
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Json output didn't set the skip_duplicate_pmus callback yielding a
segfault.

Fixes: cd4e1efbbc40 ("perf pmus: Skip duplicate PMUs and don't print list suffix by default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a343823c8ddf..61c2c96cc070 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -434,6 +434,11 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool json_skip_duplicate_pmus(void *ps __maybe_unused)
+{
+	return false;
+}
+
 static bool default_skip_duplicate_pmus(void *ps)
 {
 	struct print_state *print_state = ps;
@@ -503,6 +508,7 @@ int cmd_list(int argc, const char **argv)
 			.print_end = json_print_end,
 			.print_event = json_print_event,
 			.print_metric = json_print_metric,
+			.skip_duplicate_pmus = json_skip_duplicate_pmus,
 		};
 		ps = &json_ps;
 	} else {
-- 
2.43.0.rc1.413.gea7ed67945-goog

