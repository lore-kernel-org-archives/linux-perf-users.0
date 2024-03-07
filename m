Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40933130E3B
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833228; cv=none; b=cSJ4i9z+ibYW0t/f1dtdDfwaLtRMV4axvrKFj4H5e8r9dmpxZu/eUI4Q7/4kkSWOAJz2HVCdKJV4k5vactz2EeAzU7hujytW05x7sjNk9NUn1ejEgxRTAwzQTuGMsz4XRjtxAVN4FIrGkk3HpysD5FCDZVAdgEt/Qpfqb2vhwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833228; c=relaxed/simple;
	bh=zZMAjPThw9neF0rFKQqn5K77WjJlmrho8flUA6F99+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H1n/22qKpx4M4fDk7wJUaunPDZkdc+4Wh4riNBcvzdNQSCze57JwoAkXas4I7NwUG7N4vuVni4KqbRnB4jYXhRueEEAa4R/dcohSQH3Mw72rNuYyvVgEdecBYFW0GJnk/7d3Zz77NsDqepwsURDm/ZaS13nVGVoVXA8ldlXEp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BBCU+VEa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBCU+VEa"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6047fed0132so18474097b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833225; x=1710438025; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=BBCU+VEabxMteTfQQ0YbHVlpHHe8FZCvBBaJuRl4Dd2futHm+M7gLFgEm9cbD5HfRv
         AkTTF1anKkI8rsJM60PhVXHTQKXIZQ/76oHeCipPZiyPPHX4pMTP+1a4KBt+K3dlTxyp
         DHdahlfx6ZGDQ8Y18lRdQlPJHx18P8Md6fYB/aWVXLcPfwSyS45VAwjyexZZ2h3nWIO1
         MorSdSMkWEea2ckkLN8JCqDjlDMd86pKrPwksEoVB8DlfLwqitQmCIXYQEc9uL/NVm0q
         W5QUaao5yRj6qWEguF41Tg2Ec3d59IYeM4PpGJGsDMVOhebrvk3fWLOJxYClev8/mIMl
         Rd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833225; x=1710438025;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=C+XHV9A11YcNLT4Wmatifa1Xm0amvDl5PZgGA9N8gy16jrAzOOlHVIPSwQHhpH0Evl
         js75m8SBHYgqHkzJ6j1xrhaSvtBhBzh5e2fxyxNHmS+a+eD9/y8R3RttJ/bW3zyHPxoe
         tNf+7oh5GmDP2GYxpp7UT9RmlLk4eoV2VSJddrhR6AgsBrxXshCXEgRT4rFAJWeJChze
         nFsIDIhZO0ouKSGXAyIilJkBqI/W2ajmukQUKpun1jeAhkrydf/C+HfxKhH8kwEGVlho
         yD3LinQMa2aigoklZ6EQqH5joZ5WoQRl82RxnbtX3uDxuxqN8oTyXKGXo4n6Xf+kdqM4
         DyGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQntj8z5yg4UHCB2PbsokqfvIleEJGOKBAPX6y39WyS8lL3fDu5mkWsSgv4OUpviAK2cuKL2O6OPCf3SteKpBEU8yDbipaF1P10VVqFqEODQ==
X-Gm-Message-State: AOJu0YwFY4lireYOPcMzOPCuAp5PiT4Dr9TuuztC5j3DwoWgeCdOnIQT
	ZJm86z5FE1w4S0x3O91ehJ1cq6YPlufQ8C72wDtReJXffAiQMMsLy87v28idmc5qBwCmdadtIPl
	oA1G9Og==
X-Google-Smtp-Source: AGHT+IFi8pCz2tpIMM3csNv3mom/3CvP1+s6BJFEc09p5I4T6sVJFww7h8sxsrG+ozo/wb7E1npkw5pklwNz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:3581:b0:609:4293:23eb with SMTP
 id fr1-20020a05690c358100b00609429323ebmr4024349ywb.10.1709833225272; Thu, 07
 Mar 2024 09:40:25 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:50 -0800
In-Reply-To: <20240307173955.3982040-1-irogers@google.com>
Message-Id: <20240307173955.3982040-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307173955.3982040-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 1/6] perf list: Add tracepoint encoding to detailed output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The tracepoint id holds the config value and is probed in determining
what an event is. Add reading of the id so that we can display the
event encoding as:

```
$ perf list --details
...
  alarmtimer:alarmtimer_cancel                       [Tracepoint event]
        tracepoint/config=0x18c/
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/print-events.c | 35 ++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 7b54e9385442..e0d2b49bab66 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 
 #include <api/fs/tracing_path.h>
+#include <api/io.h>
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/zalloc.h>
@@ -92,34 +93,48 @@ void print_tracepoint_events(const struct print_callbacks *print_cb __maybe_unus
 
 		evt_items = scandirat(events_fd, sys_dirent->d_name, &evt_namelist, NULL, alphasort);
 		for (int j = 0; j < evt_items; j++) {
+			/*
+			 * Buffer sized at twice the max filename length + 1
+			 * separator + 1 \0 terminator.
+			 */
+			char buf[NAME_MAX * 2 + 2];
+			/* 16 possible hex digits and 22 other characters and \0. */
+			char encoding[16 + 22];
 			struct dirent *evt_dirent = evt_namelist[j];
-			char evt_path[MAXPATHLEN];
-			int evt_fd;
+			struct io id;
+			__u64 config;
 
 			if (evt_dirent->d_type != DT_DIR ||
 			    !strcmp(evt_dirent->d_name, ".") ||
 			    !strcmp(evt_dirent->d_name, ".."))
 				goto next_evt;
 
-			snprintf(evt_path, sizeof(evt_path), "%s/id", evt_dirent->d_name);
-			evt_fd = openat(dir_fd, evt_path, O_RDONLY);
-			if (evt_fd < 0)
+			snprintf(buf, sizeof(buf), "%s/id", evt_dirent->d_name);
+			io__init(&id, openat(dir_fd, buf, O_RDONLY), buf, sizeof(buf));
+
+			if (id.fd < 0)
+				goto next_evt;
+
+			if (io__get_dec(&id, &config) < 0) {
+				close(id.fd);
 				goto next_evt;
-			close(evt_fd);
+			}
+			close(id.fd);
 
-			snprintf(evt_path, MAXPATHLEN, "%s:%s",
+			snprintf(buf, sizeof(buf), "%s:%s",
 				 sys_dirent->d_name, evt_dirent->d_name);
+			snprintf(encoding, sizeof(encoding), "tracepoint/config=0x%llx/", config);
 			print_cb->print_event(print_state,
 					/*topic=*/NULL,
-					/*pmu_name=*/NULL,
-					evt_path,
+					/*pmu_name=*/NULL, /* really "tracepoint" */
+					/*event_name=*/buf,
 					/*event_alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/false,
 					"Tracepoint event",
 					/*desc=*/NULL,
 					/*long_desc=*/NULL,
-					/*encoding_desc=*/NULL);
+					encoding);
 next_evt:
 			free(evt_namelist[j]);
 		}
-- 
2.44.0.278.ge034bb2e1d-goog

