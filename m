Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96C3BB20
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833212; cv=none; b=MnfDtjf1XXaKTqvRXQPv5tJerFuOwjAh1KezoE2utnZqqFKXL4CBFgF9AXjpzfph8l9DoVbs5328YDfVzI0eBZO9ezK6JrYfFx8JYG7UpOUVu9mXOmjFs3Gti3ncnF88q6dTT6/1tPb5E7RE1zhWQxiAZ1xfn/WibXIfUlwOiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833212; c=relaxed/simple;
	bh=tm50rM0/vPAY35AZcNIkh9G+ITQ1yOK+pmrR/wf9O70=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=X+dj9fAqU/20fG0qTU6llvL8653KOB5355w2DCCsdhBO1Qb+YGMklyse2SLHZGpmKWOzUTyx1ti/gUVBHGWvHJn20AC/7zgiX5o3UBrwzMLhAu0AStTB7D27iBr97Q3suyu16RS8D+HLGJZK62RotzDwvZVDoirtJ/jHiLz2rEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXA/O0ag; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXA/O0ag"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so16573186276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 15 May 2024 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833208; x=1716438008; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=sXA/O0agGCg+1UF0X3HIuqhuczwjWjicjB94RD1GtFoRXMM/6rIR8/A3Lg08ST7POc
         n7r6ui04LJHJp2DNfCNJ3U3cCMU2Po2XQz1dXlU6rHY0fH/8IrkOtqTAxTh8R+fx5jEK
         7YZ1+eEufd9ogb8Q/hpn9cEqn5XUftkAu9B271zIw5vIFc9qlG+mhjj3/bc7VTasKhhH
         MELJ6QpT5ioYkF9P/6kpV6k9frLexBxw3qvRu8oZHZkUEjBnDOh3yHfEg3lnoB2KwEEN
         AB1cpWaNHwt+fURgPwJ3ufrD1PV2hWqklx8hkGE85s0bZlBg0x6y9gSLkQGo7VE/QnGF
         Uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833208; x=1716438008;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6nxXyVAqYg+7CILkdLqmh6c58xAPU1gAIUJoi7JwDM=;
        b=gQLQw/u7urQxuhIeIARUZGAbzBR7W/De6ypW+I5j10zDr7879sR06JD40j3f4G7/Kk
         f1EB8f7gBqmgMy2IZru9AkfWp4hgV8MbqVMbebELVW4gCBXYGlv7JoivvcVJr9KVShJN
         ztB7qtGrt6bzODJfNqTip8/k9sxatIO4CMRmTh9i4mYfXxiPRrQM6DQyumoT4dgPa4s3
         CbpByalqRbYT2KY/VVo9rag2ZuXzB3C+ev2YyBLdto7D64dX/0mseloRYBVknGbE6xMN
         krPCyuy/CtH+AH0PgufiEqTnh7YA4mHgkF0BuLgooDVouVeqd8MjuD1a2ipM++OisC8o
         U4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCZ3E8i+1jvYsRXsQcTsYbuR9daDFPFfbM6y/XHQHsHZ3BmgaPafmcDcHZ01qHRIax3ezZPjskc0T6C7lcutLi2b8w9AbAJAvsJM2GbbQZ8A==
X-Gm-Message-State: AOJu0YwJqn0qicY89mHoZP3Iw5+oVtV1RAMyDPQofVpKflfDP+qMfFwx
	PI+9w1ziBK5+6rVnQZ1eBe+F4f1txpxhdSi1KN5hwpD/30hItenqaOPlR8S9oUgsi1tOO4+L9NV
	OMbM/hQ==
X-Google-Smtp-Source: AGHT+IFa1kPJs1KsUvyTEmNoS/ubhW5OW5/ldB9W6PN5lhmb7Eya9ytsv10yFVGmu5YQXG3Ep5oQwmxgecGx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a25:7486:0:b0:de5:2325:72a1 with SMTP id
 3f1490d57ef6-dee4f192850mr4368968276.4.1715833208535; Wed, 15 May 2024
 21:20:08 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:48 -0700
In-Reply-To: <20240516041948.3546553-1-irogers@google.com>
Message-Id: <20240516041948.3546553-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240516041948.3546553-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 3/3] perf top: Allow filters on events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow filters to be added to perf top events. One use is to workaround
issues with:
```
$ perf top --uid="$(id -u)"
```
which tries to scan /proc find processes belonging to the uid and can
fail in such a pid terminates between the scan and the
perf_event_open reporting:
```
Error:
The sys_perf_event_open() syscall returned with 3 (No such process) for event (cycles:P).
/bin/dmesg | grep -i perf may provide additional information.
```
A similar filter:
```
$ perf top -e cycles:P --filter "uid == $(id -u)"
```
doesn't fail this way.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index a754875fa5bb..667e5102075e 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -43,6 +43,10 @@ Default is to monitor all CPUS.
 	encoding with the layout of the event control registers as described
 	by entries in /sys/bus/event_source/devices/cpu/format/*.
 
+--filter=<filter>::
+	Event filter.  This option should follow an event selector (-e). For
+	syntax see linkperf:perf-record[1].
+
 -E <entries>::
 --entries=<entries>::
 	Display this many functions.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1d6aef51c122..e8cbbf10d361 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1055,6 +1055,13 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
+	if (evlist__apply_filters(evlist, &counter)) {
+		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
+			counter->filter ?: "BPF", evsel__name(counter), errno,
+			str_error_r(errno, msg, sizeof(msg)));
+		goto out_err;
+	}
+
 	if (evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
@@ -1462,6 +1469,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &parse_events_option_args, "event",
 		     "event selector. use 'perf list' to list available events",
 		     parse_events_option),
+	OPT_CALLBACK(0, "filter", &top.evlist, "filter",
+		     "event filter", parse_filter),
 	OPT_U64('c', "count", &opts->user_interval, "event period to sample"),
 	OPT_STRING('p', "pid", &target->pid, "pid",
 		    "profile events on existing process id"),
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

