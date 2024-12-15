Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3371C54AB;
	Sun, 15 Dec 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734286373; cv=none; b=QymenCDDz6ci/2vtmPHw2WgaENmGTyJFIfIzeULRyXJikqFufF/AVSqR3kWaK2yQNuPjxYrNmWaRKC03ESvCqWprj6eBcE+g6ceelhfDQ+gxuJIe9UX6Y3o4SinaPqW19Zq6h6JL49NSTYzSB37GueAfyPkHMAWeF2YhZ/nXRXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734286373; c=relaxed/simple;
	bh=7G9PrbUr4aNDwPyTVcy7eS9sbDpQA/EppNJB+9esUwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1eyzVhL76h7zJmc8mKVN9GI7q3Oc9edpYnHP8Fq629Sv3BUcPFxD2DrwrntWVOuDljDlTQpYUPcx22gJzUkFAb7P8y4r472q/KLe7zKpG5SFW4b+hcIFgPB9DeoVF9BaiDspGv7KqY7itzUA4iHQAKp7S8UzAEacf6SYwKpXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTEZV3Xh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTEZV3Xh"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so2796277b3a.3;
        Sun, 15 Dec 2024 10:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734286371; x=1734891171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGmz2xOkFY8ET+RhhuhkkszvozZPVmg0sg4UI4nprWU=;
        b=KTEZV3Xh2OHMKO6gpmu5wKzl9z/xhxwahOHlWmwqaXi1XbWU6zBAX4MIX1c0hj3soR
         McisNiXMExFbB4tHm7sR7nrfVPxFBhhpVOOqegfiVPR4ykUmAe8TJiV+hyNZqF7BFqKe
         fTSWucgkc/VLOTj6V+eaGZWncxdDUrNVSpVPzllAMNt3ZRnmpGcPzoZ33WpIweks4QzZ
         L49w5A0LCNqhNWRBxOoo9UuEMAnhyxxBmsHuldqcRxjHhx4UyOycB0bkfES5Vr7iMhvJ
         grutr3qTs5T4thDs/2WHjqYSD9L6nyfKdZj8152x93rXsbCgyKSB1CyLwt4827OH84qs
         b8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734286371; x=1734891171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGmz2xOkFY8ET+RhhuhkkszvozZPVmg0sg4UI4nprWU=;
        b=aImsR2hCE5uKvGainIInSexQbDTG0kpRk/9hHUqE1MibAX4NCTkO9sACjnoxAtK3xg
         Bcp7yj54wETqGUpt0uC31V6e1afX9YfrrVyl2V/xm3zl5rS3o7O2aYHSv3Y/+1wgEREv
         ZPb9Ct9VNHJ0Wzxqll+lsoTXybodXf1Wg7hv+NjxVqOZ9WByvBXEKNtMLLPQVEeKknMl
         UHmP+s/tzfBBvV5Id7j4AfT7v/w82NiHu1ITABv7QMog+uJnEdo+kyScBfLt6ww+/t5n
         /+KuYvqU4gBhWulhkARhnJMbjPdVmtebBvXyJbcCUFoBHr2ZVgwvxbNrYe7y3hrjBWii
         j5iw==
X-Forwarded-Encrypted: i=1; AJvYcCVaSTfKqzy+MWlb1/6NnHgxzPtF8DVgdPhkvL6+DB6/9E1B4gqa59hQoIL35osAeEN2OkP2ZCqCOO2+XhU=@vger.kernel.org, AJvYcCXDbbfndKhcMsq9BF+wdxgwCVBi4+KU5NPrAYhAoPjjp67OV5WiAJgW8HXLh4qNgCI33xFq5uVUe/OmjcrGjhcaoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlzrSo0ZuSDWdO+bBN79VneJHx2O9X0QZHqPOOcUdUzMGMxUby
	3zQfXBmWs5vLg+IH8cu555xYCtDY4AZDBNv+SctPyijo6vsdbkaP
X-Gm-Gg: ASbGnctDANkuP6mrBbI/ljbqNknpaGRaJiJNXNAsqjObbeSYDQ5ve+QFWORsTUnlfFV
	uG9yoO51mboJKnGDzjHCtqb0eEsBk0WrNINAjfuoArrz2NjwJ635fVeam5SbiEZQUXWa9zgZxPG
	Jj3xdBKryJXF/THtmFFbb3asYQ7OOrdyklx+sznmStQx0qVaI61iZa6rJ/NDGfaNM4VPR+Cem22
	yM51l2k1DdHTeiKWhZmKjW51FLtMlxFYHceOe+7VblrmxBzY2BnLZus1G7SHE1M6WZNATreysCi
	6djvHkzWkJqL
X-Google-Smtp-Source: AGHT+IFHPDLKnXBjm1jwBun1/mtzQW/FIV7eGg7vpemqQ8OsUQ6MbQdVX3YTSUGCBgme0B1tNyjiuQ==
X-Received: by 2002:a05:6a20:a104:b0:1e0:d123:7166 with SMTP id adf61e73a8af0-1e1dfd97ac7mr14511653637.14.1734286370853;
        Sun, 15 Dec 2024 10:12:50 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm2808120a12.16.2024.12.15.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 10:12:50 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v14 09/10] perf record --off-cpu: Add --off-cpu-thresh option
Date: Sun, 15 Dec 2024 10:12:19 -0800
Message-ID: <20241215181220.754822-10-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215181220.754822-1-howardchu95@gmail.com>
References: <20241215181220.754822-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify the threshold for dumping offcpu samples with --off-cpu-thresh,
the unit is milliseconds. Default value is 500ms.

Example:

  perf record --off-cpu --off-cpu-thresh 824

The example above collects off-cpu samples where the off-cpu time is
longer than 824ms

Suggested-by: Ian Rogers <irogers@google.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-2-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  9 ++++++++
 tools/perf/builtin-record.c              | 26 ++++++++++++++++++++++++
 tools/perf/util/bpf_off_cpu.c            |  3 +++
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  2 +-
 tools/perf/util/off_cpu.h                |  1 +
 tools/perf/util/record.h                 |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 242223240a08..f3ac4c739d5f 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -829,6 +829,15 @@ filtered through the mask provided by -C option.
 	only, as of now.  So the applications built without the frame
 	pointer might see bogus addresses.
 
+	off-cpu profiling consists two types of samples: direct samples, which
+	share the same behavior as regular samples, and the accumulated
+	samples, stored in BPF stack trace map, presented after all the regular
+	samples.
+
+--off-cpu-thresh::
+	Once a task's off-cpu time reaches this threshold (in milliseconds), it
+	generates a direct off-cpu sample. The default is 500ms.
+
 --setup-filter=<action>::
 	Prepare BPF filter to be used by regular users.  The action should be
 	either "pin" or "unpin".  The filter can be used after it's pinned.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0b637cea4850..dca343b78825 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3147,6 +3147,28 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+static int record__parse_off_cpu_thresh(const struct option *opt,
+					const char *str,
+					int unset __maybe_unused)
+{
+	struct record_opts *opts = opt->value;
+	char *endptr;
+	u64 off_cpu_thresh_ms;
+
+	if (!str)
+		return -EINVAL;
+
+	off_cpu_thresh_ms = strtoull(str, &endptr, 10);
+
+	/* the threshold isn't string "0", yet strtoull() returns 0, parsing failed */
+	if (*endptr || (off_cpu_thresh_ms == 0 && strcmp(str, "0")))
+		return -EINVAL;
+	else
+		opts->off_cpu_thresh_ns = off_cpu_thresh_ms * NSEC_PER_MSEC;
+
+	return 0;
+}
+
 void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
 {
 }
@@ -3340,6 +3362,7 @@ static struct record record = {
 		.ctl_fd              = -1,
 		.ctl_fd_ack          = -1,
 		.synth               = PERF_SYNTH_ALL,
+		.off_cpu_thresh_ns   = OFFCPU_THRESH,
 	},
 };
 
@@ -3562,6 +3585,9 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "off-cpu", &record.off_cpu, "Enable off-cpu analysis"),
 	OPT_STRING(0, "setup-filter", &record.filter_action, "pin|unpin",
 		   "BPF filter action"),
+	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
+		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
+		     record__parse_off_cpu_thresh),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 2e7e4ae43ffc..188cbb051470 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -14,6 +14,7 @@
 #include "util/strlist.h"
 #include <bpf/bpf.h>
 #include <internal/xyarray.h>
+#include <linux/time64.h>
 
 #include "bpf_skel/off_cpu.skel.h"
 
@@ -286,6 +287,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
+	skel->bss->offcpu_thresh_ns = opts->off_cpu_thresh_ns;
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 77fdc9e81db3..aae63d999abb 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -123,7 +123,7 @@ const volatile bool uses_cgroup_v1 = false;
 
 int perf_subsys_id = -1;
 
-__u64 offcpu_thresh_ns = 500000000ull;
+__u64 offcpu_thresh_ns;
 
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index 2a4b7f9b2c4c..64bf763ddf50 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -16,6 +16,7 @@ struct record_opts;
 			      PERF_SAMPLE_PERIOD | PERF_SAMPLE_RAW | \
 			      PERF_SAMPLE_CGROUP)
 
+#define OFFCPU_THRESH 500000000ULL
 
 #ifdef HAVE_BPF_SKEL
 int off_cpu_prepare(struct evlist *evlist, struct target *target,
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..c82db4833b0a 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	int	      synth;
 	int	      threads_spec;
 	const char    *threads_user_spec;
+	u64	      off_cpu_thresh_ns;
 };
 
 extern const char * const *record_usage;
-- 
2.43.0

