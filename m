Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFB633E3
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799262; cv=none; b=ZIiKRO4X2SK/CzrMd9CPuvYOh25qsoi0Om60BV/0kNztKWzjmGgVl19yO7Yo0uSpTLejT41iMgwp8Gdw+DXTZYtojt7J8HwAH9Wu4wROUIx7wxJpCLoYCydbPPe7ZBSe7HOMqc5u2quBZDgfRbVO2fbUEyoAeXZ21ncbYWYh8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799262; c=relaxed/simple;
	bh=zZMAjPThw9neF0rFKQqn5K77WjJlmrho8flUA6F99+Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I0qu1IoLJF/kJOghFT73sWV+IhpqjdUqXDX1SOiux4xAPZ6R+qvgyKCLtPdFUIyERL0m8DvZHTLOj0ea0SaH0x5br3wRF2CY3KrCWl/yvi5o/eCP4LbJUd5G6zZu4nqtmcXf6AueQzLkoJQRbUdnlGXqBYWrl9zI5dccDw7kQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYRHK63R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYRHK63R"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60996cdc37cso10466067b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 00:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799260; x=1710404060; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=BYRHK63RP4iEjgw5fUXil9DDxdKWSfYJqDDcov8gzNVivZjvbda9dIE6NrhqX3PeeB
         6gasiYLcUz9Q/anqInlPqhfC8PRUNdb3nd0PuMxUodYcL9oHuRiU17S1x/8Od6dlGOx6
         c1R1aj/XzEzwaCaYEt7jyc+6wM03Fl/HhF28Z8phECgQHZ4yqKPaz+O4+tjkxXwsIJHR
         49MRVC8tlIhjKbGmjs/JOKFCBnfasXrJMKfNwcQ1crC3QE1Lt5jvYigGgR9rfECM5Ab0
         /Bt3WaCV2NS7Mc21+SD//DWK4DkwW/ZPHVPvrlvx1JbmKjuTjHgVYq9Ipgg1dKxE2KyN
         8sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799260; x=1710404060;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0YwbzbP5FZTLjIONNJPfeJ1/VNBa3uXm6yCLCKpsEw=;
        b=FDuu/m/7ePbtDceBErXJy+L5sVprrmqjxtE4ejt3kx4dIyzzvFt2tQsXM3zUTuxBnc
         ofXV6ixPsxW6DqNMPOriyMBuQls36cT2LowyWRh4rhUl3UJFc/+B4WUCTCmDa7JAaYf5
         AngrkouE+xYFChqxG2zHJoX1vBEs3ZqXBfx6gkZTs5tBRzs7h6cFFnCrPZkG0WatUQPs
         TcUnM3+za09BZxT/8V+dHg6dNs6peGc7sI00vnXqgTbgGWC5E0qLMpWzUbtcRAXkisW9
         r9uR56o1tENDPY+kSFaewK6tv4VrQejdVW35j9kLdmo1KYvHISHjSpqWCRlQRcMjlTfZ
         VEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZxjchD/LjpyYA1NrHa49v/jBx/0B9y82U8/ZSxlPvxi7hl4WFRxT6IOruiLWZVW/E1helEy/o/oQvYyW5dHWtXqVPYnW668YQhZlOhmasDA==
X-Gm-Message-State: AOJu0Yz65qpRA5Ljz0T43ERGrJ9iO+2iZbMFc0jz2qxK0he8mkC4lMJf
	hKYJZQk18O2dfqSFoLvAXR+4q871RfJTM6+CfxviO2UBq1CtkqPLG9BShLKCShUE0POdNg3W1iX
	zEt0+Ew==
X-Google-Smtp-Source: AGHT+IHUjqbaae93241ZToWGQ/CaSL/ooYK0+SAO3P8QmIpGQlqCu+pyhfF1o4RBXwSJe+EksnwY+jpP+3Rs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:690c:c10:b0:608:398c:33bf with SMTP id
 cl16-20020a05690c0c1000b00608398c33bfmr3734617ywb.8.1709799260073; Thu, 07
 Mar 2024 00:14:20 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:06 -0800
In-Reply-To: <20240307081412.3933750-1-irogers@google.com>
Message-Id: <20240307081412.3933750-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307081412.3933750-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 1/6] perf list: Add tracepoint encoding to detailed output
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

