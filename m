Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFB1FA8
	for <linux-perf-users@vger.kernel.org>; Sat, 30 Sep 2023 06:02:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50CD1AB
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:02:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d814634fe4bso22102558276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 23:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696053730; x=1696658530; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cU4DkRhMMObnbg1TBpXu9txqpW0yzEXEW8Tp/xyl+oo=;
        b=bpXV+zYvE2cxvvl/1gaUgMyixQrwB9VJf9L/hMb/ZCrF3qId+BcBMnPxwHno/uMte0
         xln6OCBfwF48UVrNn8kcTQcdnfJb2F+VGcukTjgB6WMsymSwrVg8hgs+JJiPo3N+0LC2
         qFys8HXBhqU8d+WMC9aFrLQn5crc2JeG6jbjYo852TLTU+A+JLt7Q79hBpN9Ceg8TPMq
         749eJrUWTKAQb4KdsJ6oNE5xK/TkBhDyrndjmTngDInxu18fB+q9l0KxvEqJbu8l/UlH
         8o9Y90auqIpqdLUkucz4O0+wMPQcwW/1epwFnV0yb7pksGpGAJ+GOkAa/CIMg1NtFE9E
         Rn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696053730; x=1696658530;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cU4DkRhMMObnbg1TBpXu9txqpW0yzEXEW8Tp/xyl+oo=;
        b=MszFQcdPsbQ3xr5Juj/1DEhW7I+zyqtnai1E/7RjJot01YJqv6y2cP3oblFOgHlMHI
         kcUO7fTavC8+aZxzcr445hIU0jQa9RsT4cJloDVQhC8CAHzWAnMKagkAStIUW7H37uZX
         mz0degJ8grGtD3YfFh2scC1KThfME73X5LCAwQJ5u/Ncik+BhUX5U2fUBgSB04YnNWoV
         ILmv2gLTK7OwMXvU8ZHZZiSQIDjNYmc8rYvy8nhJ1VnmD0ERZ+droUYaKtoavLMcsYrY
         fyDhkzmGeGOeR98omOlKNENSOcPAWGZFbVjbq6B6sgKT/ze53gAGpxnQHDNR6qilcvBY
         9chA==
X-Gm-Message-State: AOJu0YzI183/nmhoMaSYqDjKOliqz5TJrz/RjkHijNBjvDueTCPyitRe
	5SIwneJEMFEx/k+nNGnh3RzOD1oQQozp
X-Google-Smtp-Source: AGHT+IFf3OtArKfBaf8atKyaUGrFAb5gugXFkNmnFJO8fikSHGT4eNwBXflHB1gAdsfB0dSo9TvNFXcxs5hB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:fdf7:6873:7ca4:e9e5])
 (user=irogers job=sendgmr) by 2002:a25:d0a:0:b0:d35:bf85:5aa0 with SMTP id
 10-20020a250d0a000000b00d35bf855aa0mr88172ybn.4.1696053729995; Fri, 29 Sep
 2023 23:02:09 -0700 (PDT)
Date: Fri, 29 Sep 2023 23:02:06 -0700
Message-Id: <20230930060206.2353141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Subject: [PATCH v1] perf test: Avoid system wide when not privileged
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Switch the test program to sleep that makes more sense for system wide
events. Only enable system wide when root or not paranoid. This avoids
failures under some testing conditions like ARM cloud.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index cb35e488809a..f3e305649e2c 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -4,9 +4,21 @@
 
 set -e
 
-for m in $(perf list --raw-dump metricgroups); do
+function ParanoidAndNotRoot()
+{
+  [ "$(id -u)" != 0 ] && [ "$(cat /proc/sys/kernel/perf_event_paranoid)" -gt $1 ]
+}
+
+system_wide_flag="-a"
+if ParanoidAndNotRoot 0
+then
+  system_wide_flag=""
+fi
+
+for m in $(perf list --raw-dump metricgroups)
+do
   echo "Testing $m"
-  perf stat -M "$m" -a true
+  perf stat -M "$m" $system_wide_flag sleep 0.01
 done
 
 exit 0
-- 
2.42.0.582.g8ccd20d70d-goog

