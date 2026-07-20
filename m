Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3D466B72
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784570125; cv=none; b=uL/OKgJ4S3+dVxBuUmhzsbrLid/hcLUgmzOsZCmUTY21F6/iF5tB4Lah4Sh29fHVB+OWFvUmI08oiO4SBzvuT0VKkamPfiTqtl4XJYK16bCgUN+WGb/IsRkHoCRqpR3vl1jOmKAxFGnH6KG8t1Btc9Lijbcaz5nz+QYY1eBG1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784570125; c=relaxed/simple;
	bh=vVq/yAqli/Ps3YNknNL7qI/CsWifMu7Da0GMqyVVBFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Vet5OL+BcWXPjN/tKFdmcYp32FzKJgvoRLY7zq4qM10yEgEDIFpSZ0i2ELMyB+hDMDAFMp+Y8X7EQoFMrsQc0dN43blImx2InNo4Lw7RGO0KJD9+Wzi8F6DptDmEwMTS7Pvskn4+Oy/yq5DkCCwjf7nNVUcSk4LOH7CP4aejCbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2iBx5Ql; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2iBx5Ql"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b13so712631a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784570119; x=1785174919; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XH5gGKH7ZMsz/ICb8uMDOlGzTuN7H6pnWfYS/BF91AI=;
        b=O2iBx5QlfsA/W5FkaklzhFHWPMqq/SlnQOwBku0TcXZp36zVpvitgqOS7fw2Y62hbj
         WYM8VVRDZzmSWyaEkgQLqNaFdF3e4KpzPKHy3s2FKg8rLPTy7MCbRI/5+PRMKeW4aUFO
         JX2EYljOA8YxFQlk2B+E5yHFZKTI1o2xQtA+yGa5djGV+W+korCPzOhpEdJd3KcF5NFh
         xhrBTzRFXGh/US0/E5kfBYeOhL5zRiXmjlJh9iaz+dWfkzv1yg54QAPpfhot8FiGqCXy
         Q51FZFS10o9CTzlvmkmDb87HZtrVxPzFigTmtQCkpFi1DyuOE+0tflqM9cjj7L4Jo2uq
         udEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784570119; x=1785174919;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XH5gGKH7ZMsz/ICb8uMDOlGzTuN7H6pnWfYS/BF91AI=;
        b=M5fMBnXVDdXc6qOIq9CZHyXb8b/icTAYc6gWP2TbCSWP5DArx3GjhGHZHHYLDAqpn/
         abFIjFww34t+c1kJ3HOvuE/tZrjp8EEw/bt04ZGjIH9flMvkwi5BaDB5EQN0woAtD6c5
         lyDtAdXSpjIIY87sPKcw1Eppmea4j4luqnS0ITdUrCjDumSC5ZXFMoe4VjJHvSWH2j5M
         tzYfiaV2xRZlWZ2RakPpUlsZXZ7AN9d9MntvVUC3xJ38sKHBgDFwS2JI0nGf4dbMmV9T
         o11MQzmzDKq645gBBtvPnm7+F3Ww8v73CeQgZ8HMC2ZGvUdhhhi3aGYXy+zZmpISyyqK
         c7Og==
X-Forwarded-Encrypted: i=1; AHgh+RqjH4fGmQo395Vc/L8Xa3oQPpssdZJhlCWm2iI70+vcmo1EtIbesJi3xzNqNV40XZuutc2EMlkI16iWV6+ej+Su@vger.kernel.org
X-Gm-Message-State: AOJu0YyGp5rLUNNpJD1zIzEeaqfhWmHSnL5ka0UHVER9KZL70VcvdjUe
	TiUrS6SM/RVbpBBlcODptQU4+sYAduFh7Ln9xVf+MRbng770u+BrA+Lo0EI9V3VWaYxjOS//Kk/
	XGN1PZ3QBoA==
X-Received: from dlj39.prod.google.com ([2002:a05:7022:527:b0:13c:e616:911a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b786:b0:3c3:8c91:5da0
 with SMTP id adf61e73a8af0-3c3ad793aacmr16123503637.15.1784570119323; Mon, 20
 Jul 2026 10:55:19 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:54:55 -0700
In-Reply-To: <20260720175455.3645946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720175455.3645946-5-irogers@google.com>
Subject: [PATCH v1 4/4] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix a critical logic bug in perf_event__synthesize_mmap2_build_id() where
the wrong union member structure size and offset boundaries were utilized.
Safely calculate and clamp maximum filename length to guarantee absolute
stack boundary protections for ID sample trailers, and remove void-pointer
arithmetic to meet strict standard C compliance.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index aab958cb3bc5..cb5b659822f5 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2441,13 +2441,16 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = sizeof(ev.mmap2.filename) - (MAX_ID_HDR_ENTRIES * sizeof(__u64));
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2467,16 +2470,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
 	ev.mmap2.build_id_size = bid->size;
 	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
-		ev.build_id.size = sizeof(ev.mmap2.build_id);
+		ev.mmap2.build_id_size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
 	ev.mmap2.flags = flags;
 
-	memcpy(ev.mmap2.filename, filename, min(strlen(filename), sizeof(ev.mmap.filename)));
+	strlcpy(ev.mmap2.filename, filename, filename_len + 1);
 
-	array = &ev;
-	array += ev.header.size;
+	array = (void *)((char *)&ev + ev.header.size);
 	ret = perf_event__synthesize_id_sample(array, sample_type, sample);
 	if (ret < 0)
 		return ret;
-- 
2.55.0.229.g6434b31f56-goog

