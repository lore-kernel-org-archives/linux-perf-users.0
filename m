Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418416;
	b=R+8dYPfsTiPoFJSS+bYGzddU+gYasCKNlDKCM+LWZ43ttcSOcAQUywVbdpKqMXm6Cuuj
	 ahtiwvrweAiAtOn92DEFac01SDngDVzj1fwaxpf96lEmSGw6sHLyrFi8aYSe+zH3oaCpM
	 SSjiPcIj6e9j3fvR/5BXGI2WeuO+9ge/0IyGsJFjXGGeuVk5JzzjktCqIAp9QMkBAZVz8
	 RciZ9BoMGpcJB7wku6CLGsr3ikNlWktNRZzKa0DHkDb7bE8HTk6EYr8P8mat2tgaFLxgI
	 Wg9QcHJn6rIBgNDIaiO7Qb4btcuQpuNbYfA1FGmcmQz1c+XeJvSQOWr4H9w3G3uCJpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3HTZdiqnHY4R9o8iTOMUd/fbqdsTCZLUwRTpRhTEHUE=;
	b=099D+qgLVjxH/+1lH21uaF8vIeyJOtMjwc0mWK1l44afJ+yO/HqZ4YyAhwK5cmynWIAk
	 6tl22HPGTYXfDJX0GIeZvsk2WnWauv1Zm5KiqNhVc0A9kMxffJ+af7hhpODxRUfD0jRjG
	 xxx3+B4IcJGkg6feVKixfyFOjiq6DlGdsTIlVwOD08F/AMCcoe/+HQ76MfRwBExSd2lFO
	 NsF/3hvJu2Rbj1wAL34iVD7eh6PRT0JlltkYa6HtURYzI2N14JtQNk+smcVqZhQKY++bp
	 dLoAqDfljwvM10CQ2MAK+guaBsTKX1kRCSl0LQVGaixze/mTLmg2qIym/4UWaNOcVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mp24r9vo;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B2B606A327
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96B2B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mp24r9vo
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b25d977b91so3193087c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418415; x=1796023215; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3HTZdiqnHY4R9o8iTOMUd/fbqdsTCZLUwRTpRhTEHUE=;
        b=mp24r9vo0jt/cMdki5/RTIOdGQiUUt2CuKgBvrN49/qNtWtEcv8XVkQXsKktJoA8y4
         Brpl9arfrYedRUY7KaCVf1R8fB1Jjz50YMBj7N5m49dtbo4zLqQ/EZVjy67I1F5l9YmP
         VW/oN3W9fLUdcPefKnsFBSgF5Hn6fDomoaRNQccMn1i3pevMHrnh9fTKnyo0pc0goKyd
         hN13zg2Nxe1Od9OIhog/qHFIE5uppOX36ZRUbMi40tJoj3tWyEnHxnDwyhI5tm5VyjKi
         6dWaXcY8NgyiRnn3/PVdH6YTEvHuxy7co/j+kkPWmCFpLGELYHmXImwLZLTuOgAM4HqE
         t7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418415; x=1796023215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3HTZdiqnHY4R9o8iTOMUd/fbqdsTCZLUwRTpRhTEHUE=;
        b=UWUCwHU9OnYr7sr7/Y+3AQJrOfxaosOnt73/dwq2L3UjyRjcxChp03BXJS44BfcaSb
         dbgwLvagb0KhLWR+2XdY8qcMeaTJjYNQxDEcRD6sIscL+mR66vh4NjuMHRsaHel9BUcV
         Fgv1DiQc2D7q/ns0lQBOrCfqgaFvNiHk89Fu7XrStjiG/HLHENJxjhi9krfwU4VtiYhT
         z6MV7wkndELJfZns8aYWBguy6ObIitZVT97dvNHuaOKQVZcc/sffb3qGTjKAmtKsd3mY
         /FUTjxZBy3q3bVThPMQWsSvc21AnSuqBGbspJhZs7Opxa7KLtW7OS1vqzg1mVG4ruDZV
         09AQ==
X-Forwarded-Encrypted: i=1; AL+hErG1pSNXaWEGC8m+r0USCVXwGJ3Qsx1T19lr+1kekvtP4db9QXmMngS5sK9QjN8QgFT7hccDMAPSBarhxxGLNChO@vger.kernel.org
X-Gm-Message-State: APuU4Z/sghTODwfl5aB/n8YHS6oaodqxf+bvHnsvZSubo7TpjL8IgsTw
	W9Q7L067gIzT+PokdUDI0chpojipqXIIzHSyew2f6zLrTbyvuiUH/nd5vxnDT97Rg8x7PW+YuFU
	LFEQ9D9FRqg==
X-Received: from dled3-n2.prod.google.com ([2002:a05:701b:42c3:20b0:1b5:25e:958b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3f07:b0:19a:8e3e:530e
 with SMTP id a92af1059eb24-1b5568650c0mr11658374c88.8.1795418414324; Sun, 22
 Nov 2026 23:20:14 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:10 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-11-irogers@google.com>
Subject: [PATCH v1 10/13] perf bpf-filter: Fix bpf_link leak by using PERF_EVENT_IOC_SET_BPF
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In perf_bpf_filter__prepare(), the unpinned filter path attaches
skel->progs.perf_sample_filter to each FD(evsel, x, y) using
bpf_program__attach_perf_event_opts() and ignores the returned
struct bpf_link *, leaking the allocated struct bpf_link_perf and its
BPF_PERF_EVENT link fd.

Furthermore, bpf_program__attach_perf_event_opts() is designed for
callers that transfer ownership of the perf_event fd to the returned
bpf_link: when bpf_link__destroy() is called, bpf_link_perf_detach()
unconditionally disables and closes perf_link->perf_event_fd. Because
evsel->core.fd owns FD(evsel, x, y) and closes them in evlist__close(),
destroying the returned bpf_link would double-close the perf_event file
descriptors.

Fix this by attaching the program directly with
ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd), matching the pinned
filter path right above it in perf_bpf_filter__prepare(). In the
kernel, PERF_EVENT_IOC_SET_BPF takes a reference on the BPF program and
_free_event() -> perf_event_free_bpf_prog() automatically detaches and
releases it when the perf_event fd is closed. This also avoids enabling
the event prematurely, allowing pe_opts (.dont_enable = true) and the
LIBBPF_CURRENT_VERSION_GEQ(1, 7) guard to be dropped.

Before (built with EXTRA_CFLAGS="-fsanitize=address"):
  # perf record -e cycles --filter 'period > 1000' -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data ]

  =================================================================
  ==51328==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 1568 byte(s) in 28 object(s) allocated from:
      #0 0x7ffbe76ef24f in calloc (/lib64/libasan.so.8+0xef24f)
      #1 0x625df7 in bpf_program__attach_perf_event_opts (tools/perf/perf+0x625df7)
      #2 0xbeddc0 in perf_bpf_filter__prepare util/bpf-filter.c:507
      #3 0x8f3def in evlist__apply_filters util/evlist.c:1421
      #4 0x44bbcf in record__open tools/perf/builtin-record.c:1469
      #5 0x453f9e in __cmd_record tools/perf/builtin-record.c:2594
      #6 0x45dadb in cmd_record tools/perf/builtin-record.c:4427
      #7 0x5df56b in run_builtin tools/perf/perf.c:383
      #8 0x5dfa0e in handle_internal_command tools/perf/perf.c:436
      #9 0x5dfddc in run_argv tools/perf/perf.c:480
      #10 0x5e0333 in main tools/perf/perf.c:581

  SUMMARY: AddressSanitizer: 1568 byte(s) leaked in 28 allocation(s).

After (built with EXTRA_CFLAGS="-fsanitize=address"):
  # perf record -e cycles --filter 'period > 1000' -- true
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.024 MB perf.data ]

Reported-by: Namhyung Kim <namhyung@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20261020053226.55936-1-namhyung@kernel.org/
Fixes: 56ec9457a4a2 ("perf bpf filter: Implement event sample filtering")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-filter.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 72e83ac1d6a4..506414e5c407 100644
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -40,6 +40,7 @@
  * The 'dropped' map is to keep how many samples it dropped by the filter and
  * it will be reported as lost samples.
  */
+#include <errno.h>
 #include <stdlib.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -423,16 +424,8 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 {
 	int i, x, y, fd, ret;
 	struct sample_filter_bpf *skel = NULL;
-	struct bpf_program *prog;
-	struct bpf_link *link;
 	struct perf_bpf_filter_entry *entry;
 	bool needs_idx_hash = !target__has_cpu(target);
-#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
-	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts,
-			    .dont_enable = true);
-#else
-	DECLARE_LIBBPF_OPTS(bpf_perf_event_opts, pe_opts);
-#endif
 
 	entry = calloc(MAX_FILTERS, sizeof(*entry));
 	if (entry == NULL)
@@ -501,14 +494,13 @@ int perf_bpf_filter__prepare(struct evsel *evsel, struct target *target)
 		goto err;
 	}
 
-	prog = skel->progs.perf_sample_filter;
+	fd = bpf_program__fd(skel->progs.perf_sample_filter);
 	for (x = 0; x < xyarray__max_x(evsel->core.fd); x++) {
 		for (y = 0; y < xyarray__max_y(evsel->core.fd); y++) {
-			link = bpf_program__attach_perf_event_opts(prog, FD(evsel, x, y),
-								   &pe_opts);
-			if (IS_ERR(link)) {
+			ret = ioctl(FD(evsel, x, y), PERF_EVENT_IOC_SET_BPF, fd);
+			if (ret < 0) {
+				ret = -errno;
 				pr_err("Failed to attach perf sample-filter program\n");
-				ret = PTR_ERR(link);
 				goto err;
 			}
 		}
-- 
2.56.1.750.gf70dc682cf-goog

