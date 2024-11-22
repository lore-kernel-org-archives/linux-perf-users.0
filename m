Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87E31632FB;
	Fri, 22 Nov 2024 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732250331; cv=none; b=oT3lf4MKHxQ4eU93DL2RtYD+K6/+DINWpkOmeH73Z2PlC02dLOZGRZijYvg5jxozsoDPMv25x1Xy0upsfQYK4asx3dRkZBUyyG2+6rbszV3WkbdRmf+lbc8u8n9kpsD70Iirl1mKrId/QEzDmT7dJ0qGAzytYGEKuH01bTBLKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732250331; c=relaxed/simple;
	bh=8CnrooDgL1ZMe4pHFbOHuSGnNr0AfwT8FADkckYog48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOVM613htvNE3uD7Ghdh4fUec15UYDSdVhyM9lNRCTQQEriRJI0QaWTwhJA0SDTKAv3+qbiJOYjfwtji9UxVH0vbH4c9KZYU0gQOMhliVEachlErsfHMDMoCtwMKxdV9lHJ9XBtZJV0NsnEf3TtS8/K2Mepel4DccDqwmzNLcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZmOn/ho; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZmOn/ho"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724d8422dbaso951546b3a.0;
        Thu, 21 Nov 2024 20:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732250329; x=1732855129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngRoEqDR4XbeZwV1sZ8tw8Ja26BhVSigArtxA/HtW1w=;
        b=cZmOn/hohAdhxrucD++hOo8mD+DUaeeaNm67JFNKbywOj8pr9OG0yJsuK5BlIN4h+T
         Bm3w4ydTqOm1adtRLZF0NoOi43EJszNI0xb2szZ1yTUrQQzc7qx7KzpvCFQ1jPHWM6vo
         8SGWqvP7syEuKpptMI9loS+J87nqLSyGpcaSZVQGIGAQtzgQLPn2MFke8riRRkD5upEN
         4h3x/VSXd/+auG3Q5jDHUl51yU4T9LCsLe9YXybNagodWjvQekJ8RIEv80K9PFJy3DQG
         pYnuNO9D/zIkIaZ1VsTOZ+9vBByflK5RqU0hzPp4KJ65zUriSTuSp9Fgcr63RbZ/hMAF
         eAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732250329; x=1732855129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngRoEqDR4XbeZwV1sZ8tw8Ja26BhVSigArtxA/HtW1w=;
        b=FzPLy9wRjrCbwz1XH0NF0Tm0GDV2XGrpNF+bqWnMgS2tXzhvbBPPOj+Mbl445Vdwrn
         CrtCLRfRCEhWqqvgptuaq7B3Yz8/9yacZTwaogrxIVGhZ9OPsQoBjF7VhXyZEFYuyMZl
         wzmlKytwORLb32EM2qUnILNnjQ5ERAgvV9nbTiKv6iQ7rl5S353eWhNHXK/7y2lHd6c+
         ZMxgew9F4nU7TizmR4W++m939HEja4EASaM1riUqbSZSkZLeesFmOhqLndOlg6OVTSrf
         B1HVqKdsIxZnhBYSy2KEzSZFVAN2kdGN4ij5V9Y7C44oZiDxSb3D9hGXbGs6aClmyJk0
         yOWg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOr3htT1lYUNvLQuk+gqgI8BObtYWnB9Z89R7VAC1tJ23KKu8EhlEBWqCnjHDw/DWy+2XaSlJuc6uxU8=@vger.kernel.org, AJvYcCXL1rweDdVgmk+FWdmApvoOhS40+fd8MhZG3vmmn8eNuTPT6HnK9se2x1z7T/9l+SldRGEUeaBjEYLcY3G8hwpIHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNscc06jS7r+AlmHxRCFsa2A18RmLO40LeFzJczpQR/ykIIIAu
	cQEvgOioU8oLd/TYoka1DdiUwG+QxekVgqdgtbyg43IuhM3nvYBr
X-Gm-Gg: ASbGncsSWEsL71MMkX4v3kq8suvt+Mhle8RqMrEVjrZI73QbUHyqRXbyV0w/jC2U469
	D72klXBhpbo+Pjm+nxjx2KAZcllCoMJZXvmoJbQlwgwyfZbKqQj9MJ04UIJ1ZCvquOOz09OYyc8
	YwNBiEmStaxQfskPQXV3XI9uYtWJ6IH0dnM3N1iokn1iRKFFGAxWYfvvXJ6FGf9GkLLqOJNIXb0
	xMbzHzoa3DNnONXHcsEokfOploxQ+XcP2BLStv88sIP/YTQ0ThgSsddewAtKmkCnV/z/2kJNZYL
	aNHjYNvGcco=
X-Google-Smtp-Source: AGHT+IGUJVNevOHmCq5izMnWCtT+ya85fS4XC0LBW5jLDC+Qk8qHUmwDXHw8nC/ldOc7aphiyEoITg==
X-Received: by 2002:a17:903:18f:b0:20e:55b0:35f2 with SMTP id d9443c01a7336-2129f217e22mr25592125ad.1.1732250329050;
        Thu, 21 Nov 2024 20:38:49 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1544bsm6638135ad.193.2024.11.21.20.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 20:38:48 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 03/10] perf record --off-cpu: Parse off-cpu event
Date: Thu, 21 Nov 2024 20:38:33 -0800
Message-ID: <20241122043840.217453-4-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122043840.217453-1-howardchu95@gmail.com>
References: <20241122043840.217453-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse the off-cpu event using parse_event(), as bpf-output.

no-inherit should be set to 1, here's the reason:

We update the BPF perf_event map for direct off-cpu sample dumping (in
following patches), it executes as follows:

bpf_map_update_value()
 bpf_fd_array_map_update_elem()
  perf_event_fd_array_get_ptr()
   perf_event_read_local()

In perf_event_read_local(), there is:

int perf_event_read_local(struct perf_event *event, u64 *value,
			  u64 *enabled, u64 *running)
{
...
	/*
	 * It must not be an event with inherit set, we cannot read
	 * all child counters from atomic context.
	 */
	if (event->attr.inherit) {
		ret = -EOPNOTSUPP;
		goto out;
	}

Which means no-inherit has to be true for updating the BPF perf_event
map.

Moreover, for bpf-output events, we primarily want a system-wide event
instead of a per-task event.

The reason is that in BPF's bpf_perf_event_output(), BPF uses the CPU
index to retrieve the perf_event file descriptor it outputs to.

Making a bpf-output event system-wide naturally satisfies this
requirement by mapping CPU appropriately.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-4-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_off_cpu.c | 33 +++++++++++----------------------
 tools/perf/util/evsel.c       |  4 +++-
 2 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index a590a8ac1f9d..9275b022b2ea 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -38,32 +38,21 @@ union off_cpu_data {
 
 static int off_cpu_config(struct evlist *evlist)
 {
+	char off_cpu_event[64];
 	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type	= PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_BPF_OUTPUT,
-		.size	= sizeof(attr), /* to capture ABI version */
-	};
-	char *evname = strdup(OFFCPU_EVENT);
-
-	if (evname == NULL)
-		return -ENOMEM;
 
-	evsel = evsel__new(&attr);
-	if (!evsel) {
-		free(evname);
-		return -ENOMEM;
+	scnprintf(off_cpu_event, sizeof(off_cpu_event), "bpf-output/name=%s/", OFFCPU_EVENT);
+	if (parse_event(evlist, off_cpu_event)) {
+		pr_err("Failed to open off-cpu event\n");
+		return -1;
 	}
 
-	evsel->core.attr.freq = 1;
-	evsel->core.attr.sample_period = 1;
-	/* off-cpu analysis depends on stack trace */
-	evsel->core.attr.sample_type = PERF_SAMPLE_CALLCHAIN;
-
-	evlist__add(evlist, evsel);
-
-	free(evsel->name);
-	evsel->name = evname;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_offcpu_event(evsel)) {
+			evsel->core.system_wide = true;
+			break;
+		}
+	}
 
 	return 0;
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 8d0308f62484..d7a68d450080 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1473,8 +1473,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (evsel__is_dummy_event(evsel))
 		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 
-	if (evsel__is_offcpu_event(evsel))
+	if (evsel__is_offcpu_event(evsel)) {
 		evsel->core.attr.sample_type &= OFFCPU_SAMPLE_TYPES;
+		attr->inherit = 0;
+	}
 
 	arch__post_evsel_config(evsel, attr);
 }
-- 
2.43.0

