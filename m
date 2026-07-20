Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE1444685F
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 22:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587949; cv=none; b=oZBGuS5kQFK4Hh8/00TFk5oFzV03cZGFr7hZgVjiofOeVpfczkMmciRzoAJCeiwYvnsbmtmAhGgu+0rD9pN3p8AxIOlCm+/UXVyvrSRjSl+9CfjC/gSHXFedrnOi2IVsydSnFURTV1hUZ8HoCVwdZ+pd/SWwc8SCixem1ZwKgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587949; c=relaxed/simple;
	bh=3yay0veMsFj7vwcaAhqZB7S78e5bwAhi4kSuw/rHn+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zf1ng47qsfDAduh9/2anfOD+w9FtfNFPwbEgBbjD3o1XarBOZtZLClH8tHdYcbhy/ERicCvm0W8xDJQgRh2Q1ZJGqcEmLNlCRgiK3Uu3OOYchrLr8KaYxQaJhakih4MbLEIApTg4Lscz+IrKo89qZmZIgPWRp5WM8+ycf/YYy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RkrCzEkG; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RkrCzEkG"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e0234967aso280789b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587947; x=1785192747; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHcmZ3r9l7ED3Ld93xhYMri0AgqcafHtnu+fH+/O4JA=;
        b=RkrCzEkGCtfhd3zZwOXDYzhL3llNiS3j1q/O9p90vf/FJMJ0kH577Tzlnu+fGcpisZ
         q0LiLhSZ3AHa3pJKug2Wxj6pw4hzBaeil6J0CNkX21AfVBfn2ihs59Ek5/SWRuE9yx6Y
         RRT12d0e3tR0q8T+TiYzxBB+GiU7kw94HqCLFT1TCG/eKi5PLg+WOn+gvOLB8fygyEcA
         p6JjNMRoJkolv0vqAu76cTxRgLg84noTcvyl5YWHuGvnd8usafe/Lh0/tqj5KhhQ7blY
         bel8s8JCG3iGlMOI0vtgXM3tCt1hbHwP1SbIju8ZqQkzAQeV8XhkmDuNSLTnzBsxZeZC
         aTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587947; x=1785192747;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHcmZ3r9l7ED3Ld93xhYMri0AgqcafHtnu+fH+/O4JA=;
        b=YIdyk54iJWPl1WzjjP8rHeLlqFfe3cbo9ohO5/+1dMHOMuH7YOXfQfkDSCXCz6rMCl
         5XBR214S7zthHDiK/uoUtSwPCiyViEx+Du9ndS8G8rpA+VYHGJs499eMEXEnYBIy/A3Y
         KrHP7tE5WVJsTpaQOmPinx9PgVfIiycVQxYXdchYljfh32NPgt4yCYCuTILYNIBQWWwO
         hSC8Rww4khtmjVftn0HVMzCNtLmv0yPdpRdJTzOy3HkgGkeFb1lU771naobyW0BD/Bl0
         PD2W6o1eDqNeoxiRs3enjqSeIdl5aM0dQ/bJcCVcHN75FPS16RPhtPI4Xz+qz8+sldnn
         34jA==
X-Forwarded-Encrypted: i=1; AHgh+RqqU+b6snxCFSt7p/3x31Pthm+d6uIzBTyZ81n1Qtl3iC7+4gMbS6UPMGZZ6vmGsLlotrlCYEz1qXj3mJQwDf8O@vger.kernel.org
X-Gm-Message-State: AOJu0YwtP7y1airJ9dIfvmvQqRr8LkrT6CeFYgwFAj5yU10Zr+Lls4YU
	sQLdnwVTTPFxFh1miUpzXAI8OPc8rOmrbTx1yhMuu3i3MudBRUhFsLPvyvFEi7hKO/8UFNN9oO0
	d/bhtnIR8EA==
X-Received: from pfblx1.prod.google.com ([2002:a05:6a00:7541:b0:848:2a35:eb83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179c:b0:848:425a:4e31
 with SMTP id d2e1a72fcca58-84c29274827mr16439225b3a.24.1784587946538; Mon, 20
 Jul 2026 15:52:26 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:52:00 -0700
In-Reply-To: <20260720225200.3810501-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com> <20260720225200.3810501-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720225200.3810501-5-irogers@google.com>
Subject: [PATCH v2 4/4] perf synthetic-events: Fix bounds and union member
 access in mmap2 build_id synthesis
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a critical logic bug in perf_event__synthesize_mmap2_build_id() where
the wrong union member structure size and offset boundaries were utilized.
Safely calculate the exact maximum allowed filename length to guarantee
absolute stack and alignment boundaries for ID sample trailers, preventing
-E2BIG overruns on very long filenames while meeting strict standard C
compliance.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 068323b9510d..fb4f736f64c0 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2447,13 +2447,18 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
-	void *array;
+	void *array = &ev;
 	int ret;
+	size_t max_filename_len;
 
-	if (filename_len >= sizeof(ev.mmap2.filename))
-		return -EINVAL;
+	max_filename_len = sizeof(ev) -
+			   (MAX_ID_HDR_ENTRIES * sizeof(__u64)) -
+			   offsetof(struct perf_record_mmap2, filename) - 1;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
+	if (filename_len > max_filename_len)
+		filename_len = max_filename_len;
+
+	ev_len = offsetof(struct perf_record_mmap2, filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
 	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
@@ -2473,16 +2478,15 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 
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

