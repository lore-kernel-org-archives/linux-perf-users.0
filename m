Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE42135C9
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Feb 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593077; cv=none; b=CHfcWncJhzPOoTRc6YE6TAGYNPzivY6+gLPFEk8IXZQeAOB1wsEOP90aZXMAjgdwymrg1WXDcQZGmO8xKop4PJjD5GWZB3xsr2qnPWTFw8D7sxoXgG1U5kc47xf6uz5EForbNy+Aktz55qmGoqbt2qR5lcjzYKEOLWAoxoARHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593077; c=relaxed/simple;
	bh=EttioCEzotPWFiddBHkBE0AJBG8efcrrqir3XlI9I80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OMdX2V402uB0a3r/uJpvJdwwR0EZx2W+ysDDWBgADoHfpBpxKkTkIZAb44jw/avcg9oGP17rDTfie4wNRlXl1Wn95Ct3L0FlSurt0BVvmRgN/HmiWP/J1E5HJO9EeueRfiJUAyJwO7wlDPPJqUy9DZgHRGj+bfz+xoc0Gz8SOl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxLniWZr; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxLniWZr"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so4937727a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Feb 2025 06:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593074; x=1739197874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mES9zlK4q0Abt8GXLMsE8pcYClHIX0RrLwiPkvwA/U=;
        b=KxLniWZrBoo0FvxeamVlwzdrJcXlxl4A+wbmol7cevn/lrZKhGxRc93vW/7CqMvB8y
         69MMpv9HJFsVkWvuaA5AYS5OiK0SO9oRj/HuGYArwnVPL9+c46vg+NB9n3py+tLapcz7
         Hn4X0NTZAct0drrK42OCvLFWfWyvbHmXrVN2xEIXmYu4JT9zK2GNuxZJedTLeI8lYjjl
         GUaiumEh07QeJjgV4+HBkj0P5q2PRPSatz/Z0M1XcTcZ9YUKL4WL9DAV4rBpAyFgo9Ri
         N7otZdTDh2PLOVbWq9SavLV+CCJsMr6UlwuaAw5AyRG7456547DiUwH+oKHYpM0fBu03
         KArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593074; x=1739197874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mES9zlK4q0Abt8GXLMsE8pcYClHIX0RrLwiPkvwA/U=;
        b=EHw6pH/EmnwAv/sX8fFRSf63UkUDr3TjNG5Wh0yRJMK8J4KwmW+GI+L0EZwTHJRxU9
         YjdhL6sCwWsV74Aykca5JkROxOyggTvtHEtwz239uedT+MT8q3XKdt5wgSsyMKO6pjLl
         Rk6OSMAs1Fu4wmQ6/8ty/RTVCDDC64nLR1qKockl+FF2cneawEve6R2SvY/6x1J8eYKi
         2EWxqhXx9qcQJFg2cDbp9wjxeRvHBJ/ZvWJRmwQ7t+IXV5eqMX7pbrC8tNpB4X3IJzQ7
         2Q9fPWI6SPZSP7OUbU9b0On2Q9YTN3OExAuRAx1U1w05aay7kdIOeWrqsn/yctZy9NDS
         gPtg==
X-Gm-Message-State: AOJu0YySYgCEYVeB/7rXzZFsJtp7gMCOsaoDaukebRI5FfOA46B8615s
	LD8UK24rlT3/PZO96AoU0vM5i72fSv+yB35QK1Z15OWsgM+76oGIHWmtqzuhJDtJtR7BPVPZ/FJ
	pI6qdoQ==
X-Google-Smtp-Source: AGHT+IFHlozdtzdCWr/JRUBb7etoKnJONrLXtKahYOJJ3ROKGWKULjKgfoWFsTwMTnLMVx+9PlGk2NwRLpCJ
X-Received: from edbfe11.prod.google.com ([2002:a05:6402:390b:b0:5dc:a49d:b83f])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:d09:b0:5d3:d4cf:fea0
 with SMTP id 4fb4d7f45d1cf-5dc5efebdedmr20280930a12.21.1738593074141; Mon, 03
 Feb 2025 06:31:14 -0800 (PST)
Date: Mon,  3 Feb 2025 15:30:38 +0100
In-Reply-To: <cover.1738592865.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <6b1197cf7daac315b998e8c96042822b56d4bd25.1738592865.git.dvyukov@google.com>
Subject: [PATCH v3 3/8] perf report: Switch filtered from u8 to u16
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

We already have all u8 bits taken, adding one more filter leads to unpleasant
failure mode, where code compiles w/o warnings, but the last filters silently
don't work. Add a typedef and switch to u16.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/util/addr_location.h | 3 ++-
 tools/perf/util/hist.c          | 2 +-
 tools/perf/util/hist.h          | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/addr_location.h b/tools/perf/util/addr_location.h
index 36aaa45445f24..f83d74e370b2f 100644
--- a/tools/perf/util/addr_location.h
+++ b/tools/perf/util/addr_location.h
@@ -3,6 +3,7 @@
 #define __PERF_ADDR_LOCATION 1
 
 #include <linux/types.h>
+#include "hist.h"
 
 struct thread;
 struct maps;
@@ -17,7 +18,7 @@ struct addr_location {
 	const char    *srcline;
 	u64	      addr;
 	char	      level;
-	u8	      filtered;
+	filter_mask_t filtered;
 	u8	      cpumode;
 	s32	      cpu;
 	s32	      socket;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index cafd693568189..6b8f8da8d3b66 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -585,7 +585,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 	return he;
 }
 
-static u8 symbol__parent_filter(const struct symbol *parent)
+static filter_mask_t symbol__parent_filter(const struct symbol *parent)
 {
 	if (symbol_conf.exclude_other && parent == NULL)
 		return 1 << HIST_FILTER__PARENT;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index a6e662d77dc24..4035106a74087 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -33,6 +33,8 @@ enum hist_filter {
 	HIST_FILTER__C2C,
 };
 
+typedef u16 filter_mask_t;
+
 enum hist_column {
 	HISTC_SYMBOL,
 	HISTC_TIME,
@@ -244,7 +246,7 @@ struct hist_entry {
 	bool			leaf;
 
 	char			level;
-	u8			filtered;
+	filter_mask_t		filtered;
 
 	u16			callchain_size;
 	union {
-- 
2.48.1.362.g079036d154-goog

