Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB4443E52
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147661; cv=none; b=GpFsDpSJHVJLttdxklPAoVDhgkRLDPxi0ZWhzi2Liwxe7jLOF/EdsHMjPm4tGeueYcBu00QKq168Qlja/KpniQpfjgMUILVxCFQQqxe1+qR2tXjKpiZV8jGPIge/gMiiV5EQlPFnpmufWU7w1cOIpGtQFzAeaZt5n5weniqNR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147661; c=relaxed/simple;
	bh=EiRm2DH268TnCKvfI9DUZ7whv7X6RJy/wJDSopSl0ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=daMue/st3BBrQ0wOO6FbJWAmqm4lfR4T1wgqsfFNQ9+Qh1qzWDGcYL6MQW2K6759nP9iKgpPiRV+Wef0jp31Co5p8GdjLddrp8NcRvcCdrw6q7OKBbcTXYzRBTUvBOFIeTr/gxxBdTTYoEkteDk/8aqYC+297t8iAjPV4c0dd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyWXBcrM; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyWXBcrM"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-331b2ec616fso2390197eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147659; x=1790752459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yo0H4ETGVUkK9yLMjrNccVJ0N31e67zNNSIX4uaHhQk=;
        b=eyWXBcrMcrN71zGriDld1u5ko2VJNy9PYVPMIBoiNHouImIOZBfiJI+ozS4sp/zAq+
         Bo5hHOUBwqwUtKn9NFhgC5nkFlDBKEyWka256nY6hDz4eWU8wnYucVM/6b7zzkp/UyJ8
         JO1FSWqQDMPEwZP+AAGTYfEXZHUYT5mkXbBZu9jGZqZBwZ+F2eAHY49mxOWTIMeZzKAS
         WOBv7nytGfctbWncI04vkHZNZSbXTpPU3j+IN74tPGNMrT1KXXVNFFAIVEhyGVTOZukx
         PN+PSA3AHlBriUMDxxwGvSIxr5dR/O8ojc5TyMwXGmO2deuTAqyI2jIpcg0bqAlazWiy
         HTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147659; x=1790752459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yo0H4ETGVUkK9yLMjrNccVJ0N31e67zNNSIX4uaHhQk=;
        b=IJ3k++CIpi/FVMPVl2R5NMh3x7cRAPhJW0KWlQYpUymVxlqHwzZqDdxxTS/dvh2oQH
         zjHRvDBbKhEqgBiwYC3jsZw7eLEhFngH+e3KZpp1CBmMgG9K20B8KDllbDQoUkixZDRm
         Yf+ecPUcMDcwNRV5QINXh2Vmla32BftsPQVAtVZJ8tlmmiM1eASBhTRi+oXozU6xLJfF
         rNuFCSez6Xq9zQxO5dTFsDeVUlwxLvtJzrIXlJ/7zmTD6URMpITZ1IEjxShxTg6RXXM6
         bgJae+9Lc7s4jP41fC7gh1n466QLKaTwyDzeGC/AJZ6MkR8PoVahZk7cU7+nd7SgvQIN
         QjHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZa+58rrizU3wHsuB0qumIPPYLSkLDq6OPusCy6HVQG+2QJq+WVB9H/I6YOwafBjHBcBXADCep/eKr7TQSnb+G@vger.kernel.org
X-Gm-Message-State: AFuF++ljvjLgUhBEBA/WMcHwV0bS9BxAO/zhpys8XpffJhmzDhQmbZRQ
	zNpb/oJZKhPhpyQtd+ueoqOHeUU4uj44F/mAJaM9iJ/l2eLtspyhbp0RQQtk28l0JB4/7JpGZTm
	bJyAbF4ZAMg==
X-Received: from dldyr1-n2.prod.google.com ([2002:a05:701b:4501:20b0:144:c737:6f14])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4282:10b0:144:f4a0:a399
 with SMTP id a92af1059eb24-144f91685bfmr2048914c88.1.1790147658536; Wed, 23
 Sep 2026 00:14:18 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:43 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <4add8796a95e7cabee2a8094d6babdb39290bfe8.1790145937.git.irogers@google.com>
Subject: [PATCH v5 03/23] perf trace: Include the headers declaring pid_t,
 strcmp and assert
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

trace_augment.h uses pid_t in the augmented_syscalls__set_filter_pids()
prototype and in the !HAVE_BPF_SKEL stub. bpf_trace_augment.c calls
strcmp() in augmented_syscalls__find_by_title() and assert() in
augmented_syscalls__create_bpf_output(), but neither pulls in the header
that declares what it uses. Both happen to build today only because
something else in the include chain drags <sys/types.h>, <string.h> and
<assert.h> in first, which is not guaranteed and does not hold on libcs
such as musl that keep the POSIX namespaces strictly separated.

Include <sys/types.h>, <string.h> and <assert.h> explicitly.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_trace_augment.c | 2 ++
 tools/perf/util/trace_augment.h     | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_trace_augment.c
index a9cf2a77ded1..ebb26225fb04 100644
--- a/tools/perf/util/bpf_trace_augment.c
+++ b/tools/perf/util/bpf_trace_augment.c
@@ -1,5 +1,7 @@
+#include <assert.h>
 #include <bpf/libbpf.h>
 #include <internal/xyarray.h>
+#include <string.h>
 
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #include "debug.h"
diff --git a/tools/perf/util/trace_augment.h b/tools/perf/util/trace_augment.h
index 4f729bc67753..a1cd9a5e0213 100644
--- a/tools/perf/util/trace_augment.h
+++ b/tools/perf/util/trace_augment.h
@@ -2,6 +2,7 @@
 #define TRACE_AUGMENT_H
 
 #include <linux/compiler.h>
+#include <sys/types.h>
 
 struct bpf_program;
 struct evlist;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

