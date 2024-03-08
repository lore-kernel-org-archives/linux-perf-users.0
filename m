Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C2715AF
	for <linux-perf-users@vger.kernel.org>; Fri,  8 Mar 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857179; cv=none; b=AGie5ScwDhW+493C5XPMqn0nyXqDJXl9mf6NaxmEJyFUHE/RN5lOxj/SdJVUXCELhgyVZTDxgUHL5fXrR76vv7NpkBZ4yhM5E8mUmbRx5b4lzmcEoB7MMOkqSIgSFHqPCSt3e9/tBcGHWKOVfaccSg+tFQJvBeC9Xx6qCqMLzGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857179; c=relaxed/simple;
	bh=zZMAjPThw9neF0rFKQqn5K77WjJlmrho8flUA6F99+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JDe9clJrDOREHs1lc0oHaisaHiXGWJ3v2b+I4PABK48PEGisedXrnKUJZF67epilR/aUeq6GnAEtB6oIpkorgyah6sZ+fO2WEHLI4CoN3bJGZyday6zkPwJjDry4kv/cTwi2WLW9jAJ3f4wzCpNDRCdGj9yNwHZ3BLA3EQT99yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWXayoKd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWXayoKd"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609f015e386so24351897b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 16:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709857177; x=1710461977; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=qWXayoKdTeesK4Ggz9BGqb7sQUzY/KYFBduc8RV6Xhi5O61XnGIl4dCwBPlu3jMUPV
         ZRycLGMauA2Qcu1ao/h+jcLzVXjHXZRsIHyR4hpHUhaE74WpYPWvVhb4kUPcelRuKZP6
         ND7Tu3XvYBfKbcsav5aPIW4yovybRPTCyjZl++apiy9fRjmuPPWDUEYBG9vh2TuQUibD
         6bUo4eZ2A3ZyGLG8U/9rYDv9rcdeHq/f0BjuLUkN3iQ/CMfYSTi5pbafI2yVmJeCNDqL
         8lLiIB0oTdJ3Znj0CXihyrq1hBaNTJpip6RaNsZWE4EkdDSdPqRVsfYDsFfsgsmmHiz8
         1jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857177; x=1710461977;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=dmgOV8VaKmbP34C/WpIu+VyX/WuonBhriFZYeCPeYd4oPHunsgW8Y0mxQNm7wllMEr
         7YCr61ONLZPVN0aVJo2cROWbmDsvkIyWLxDT20vxnTDmWujSAgzB2UEJlDmSA0WB6YCN
         4cSz70B8jpPEbPDZ4NCpaqQkraxQGTehGxiIR//LkAAwcKEsVQgv4oywf9GRBIEaJqrE
         2Af+/oOg1cq7yIvc0TeXSex1MdMYQZmzYivH1qGH857lu5CmkSpt6mRlQ/15JF0le29+
         NM7BCAip5ucEpdJ4sB4kb61TSdXcCK21Q6Hc2xrxZiASSl+fL0/7owVnJFeWendoc3a7
         x7SA==
X-Forwarded-Encrypted: i=1; AJvYcCWyyNn4U/N8BSOSFHPI+6TnUE8HMjhVDeFMhfHVAvW4aoPsjnwXgCnVtPyzDY08B1hEbfFH66+kJbVIybbuX2pPSA9iRKjjiRHpp6D95OkNuw==
X-Gm-Message-State: AOJu0Yzcwp0lCN9Mdnnq0mVODbc4YxOicwsegSD+Lmbgs6N7BNc88OHi
	c71EQTjVzNafBHpyfd9Drz//hc7hQvPZwEMpAybw/IyPiec/ylxJgZyQOvAlfIrOkusBpV4pThK
	PpvSbSg==
X-Google-Smtp-Source: AGHT+IF3uvvL8v3YXnycSlKL1hADHqP6bRku2AAjc2ekmiQGbnnZpULdhDJ78tmMqT1EyVuNR20TuMp+kotJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:218f:92ee:d543:c1a2])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c1:b0:dc7:4b9:fbc6 with SMTP id
 w1-20020a05690210c100b00dc704b9fbc6mr4903613ybu.10.1709857177330; Thu, 07 Mar
 2024 16:19:37 -0800 (PST)
Date: Thu,  7 Mar 2024 16:19:10 -0800
In-Reply-To: <20240308001915.4060155-1-irogers@google.com>
Message-Id: <20240308001915.4060155-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240308001915.4060155-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 1/6] perf list: Add tracepoint encoding to detailed output
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

