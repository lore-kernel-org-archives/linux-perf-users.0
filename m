Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9543C279B
	for <linux-perf-users@vger.kernel.org>; Sun,  6 Sep 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725597; cv=none; b=gK98+esen+cZPS67EdGGa+dJgEil+gp1ei1cjBed3YVbCn2LQ3pv/pogovPZ7UjoIOh5DO5hedynXYANP/Glk6K5uVsZjRwuXZUhOwF6yiVR+KVVOV1qImhv7yR0Wl0aqZckvGkWc8XgdxF2r9jCEdUSPgkBCfDjvWGVFIv6jVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725597; c=relaxed/simple;
	bh=K6kuH+Dj0+XisIC13wTxUfbDdeE5RtZ218RXYIIuE2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0Jo80TZ70AeieJzP3Hwt8129Uvv6lUnv8r/jxGFqCj4Sha2iPzg7+T2BwGdCQyiRHcqpuZaHbmrIZMCnhm8HZjLhKPECO6GnPu6IxfV2MhJfY62uFkv7YwNVxEOGy9Oz5BMCNIkuUsQgZmmTCWAIlncmX3zU0JIXou2HtInjUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXke/h8o; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXke/h8o"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-855a66e5b5dso21615037b3.0
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788725595; x=1789330395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzIpQApcA3/Eb7xwHfs/OS4Wgv+5Bf6h3+3Q0Q0xTMc=;
        b=gXke/h8o3cFXFGl4Ei7eVDXedpnfRc7FYcE9RB2qETkz0LlKKE0J8NE7XDkDYYvnKp
         RSEP5zjAlZV7zDCgh79J4lkLcpShSA0q+OEMJtCTfYuAq0EPBTFHDQ9NeSXPI3o50qBq
         6/BYcnCEXwzIxPkzs8qCmcEko7IVlXstr3Hro616MLtSFFZnr0i+blnbwCTBZBwGWl2y
         Du8Su1ENZ6UbUJ3CXAxnESI716Xt+m6FywR/spB8FGQPLnVx2hK6EzlrA4pI5VYVdcOR
         6ofA23VZD5jfY3nZPhPt9e2YziBWtNybu/fK+mse/6QXCiaOgvSDKLFpW2qJ39VxWmuR
         U1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788725595; x=1789330395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzIpQApcA3/Eb7xwHfs/OS4Wgv+5Bf6h3+3Q0Q0xTMc=;
        b=DEi6rDTavKfGyDbKf/PH4FETBrmmoHmHkwsvqd4Uy1VFeMxfaz5VribFja8/g3ZHbg
         BKM+OXqfq440dVm7P6gxY7sH1xHFMntEIT2y3E/x3ZErYena8MYwoW0yPwmeVdq7mtm6
         FcyxW4cy6yOLpIJ2iGPBFDlKV/xa9owGIMoJhMsZKXGUu3GYxEASShvT84NbTwgj2RnR
         WCioa2YdWP7gE1oIWKOcB8hcFHckYZuHlmC9abIqw8U6HYqlP+gD792Txle8ZKckRI1N
         FS2H+dVJvbbg4xygS9Pq8hMCfWCJfzHZuLy2U8DfkSA6xeQWKv5Af2ahAjTj4wORQogD
         zcTA==
X-Forwarded-Encrypted: i=1; AKwUvBxmUoG79NQm7rHZ/ICW4VzJAKBH4Ug+srKnBJ9AfvgCX6zZEAV0kIVx9Ni7Uk2RoOrG1NeIA/UTGEUVHcSU8H3K@vger.kernel.org
X-Gm-Message-State: AFuF++nD9CpN6hRrJGU1rDFHEXVWS29JzofKkWlxkcPveG+NBmcRxMj6
	3wgYOJUqbB8NwvUEjpNKiH7EJDrNFxm2D4Zt8a6inK7oQVFG4JP+NDGw
X-Gm-Gg: AYBFou1L7oiS73zml+J2JimB3bz1Y8S1BIIIGT8LM+CyG2jIPDIrGplWZGiSmtPct6T
	m2ASADozhp2GzIXWOC+7OoFPMJAOVCUq7ZUR+a8STE9vlNsOB0hcj1koWJSvTw6ykMCmSGQQuOB
	U5obz9yJXRk7CZUxmFG2p1h1daGzdL0NW27YIAwa6Jwbh8xqQdhzQ1bgnYIVjskaS4suQ1wm1/n
	KorLRb1MDQPbVd/mKN4U1xKJJyu6ljpfWRp0b0z9DXqbfvvCkeaHMQij1jFI9hAlYz9JYr7nVUr
	vlC4ORBjva2YAqQCnX0lnodx1L88CUNiuf/nxEyttUIYXdXlx5ycXlwfDId7my+OMMtRZvNmFAf
	szdlo8FcvSGrroQnjkJE2TUtFgVWECkoSrHB65y/SJ8x3u35AwFPVLlIVQD5x0GyhG9qzbqvejz
	BgyQNmVvzpaumhiwwWRD5xuOQI+t9JKhryJ2JxLeydWleXWqfgJyymoS2rBGQN
X-Received: by 2002:a05:690c:38d:b0:862:65f4:c8c2 with SMTP id 00721157ae682-8712938ccd8mr90053377b3.21.1788725594025;
        Sun, 06 Sep 2026 13:13:14 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c454esm60255047b3.7.2026.09.06.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 13:13:13 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 06 Sep 2026 16:13:08 -0400
Subject: [PATCH v7 3/3] perf tools gtk: fix two hierarchy-view stack buffer
 overflows
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-perf-gtk2-v7-3-1ece839fbca0@gmail.com>
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
In-Reply-To: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 bpf@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=K6kuH+Dj0+XisIC13wTxUfbDdeE5RtZ218RXYIIuE2s=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLLmngx8m1IRfd4v51mJ4Jvgrxn9sZztu6fU73z98Y6R9
 941OXFvOz6yMIhxMcwUU2SJW6/IMqttx1Kf09K/YOawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyBDxygeIqfHoJFZXFyaWqSbVlDkkJdfkliSmZ9XrJdfkJpXkF6gl5aZVpKRkV9UnAo0Qi8vtcT
 U1dHNyNDAxNLRwszJwtHUxNnZydDJzdHR2dXJyNLcxMDZ0tHE1dKcgYtTAOaaT/MZGXbd4l391/
 tB5HKeiaqp2p5XN4Z92cq1g0Nj/opdzBfLSmQZGV5IPZz2bu3fiskqeaqbIrz/pl2KMAlXi97G5
 P0ifb1xJScA
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

perf_gtk__show_hierarchy() builds a merged column header for the
hierarchy view with unbounded strcat() calls into a 512-byte stack
buffer. The pieces being appended come from tracepoint field names and
sort-key headers in perf.data, so a file with enough dynamic sort keys
or long enough field names overflows the buffer.

perf_gtk__add_hierarchy_entries() has a related bug in the loop that
formats each entry's value columns. fmt->entry()/fmt->color() return
via scnprintf(), so ret is clamped to at most hpp->size - 1, but
advance_hpp(hpp, ret + 2) doesn't clamp: when ret hits that maximum,
ret + 2 exceeds hpp->size by one, and hpp->size (size_t) underflows to
roughly SIZE_MAX. The next iteration's fmt->entry() then writes into
the caller's stack buffer using that bogus size, a second overflow.

Fix the header builder by tracking the write offset and using
scnprintf() for each append, same pattern already used elsewhere in
this file. Fix the entry loop by clamping the amount passed to
advance_hpp() to what's actually left in the buffer.

Both bugs predate the perf GTK UI's move to GTK 4; neither function is
touched by that port.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/ui/gtk/hists.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 716dcf02bd0e..342d4c3fecb0 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -449,7 +449,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 		bf = hpp->buf;
 		size = hpp->size;
 		perf_hpp_list__for_each_format(he->hpp_list, fmt) {
-			int ret;
+			int ret, inc;
 
 			if (fmt->color)
 				ret = fmt->color(fmt, hpp, he);
@@ -457,7 +457,18 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 				ret = fmt->entry(fmt, hpp, he);
 
 			snprintf(hpp->buf + ret, hpp->size - ret, "  ");
-			advance_hpp(hpp, ret + 2);
+			/*
+			 * ret can be as large as hpp->size - 1, so ret + 2
+			 * can exceed hpp->size. advance_hpp() doesn't clamp,
+			 * so passing that through would underflow the
+			 * size_t hpp->size and let a later fmt->entry() in
+			 * this loop write past the end of the caller's
+			 * stack buffer.
+			 */
+			inc = ret + 2;
+			if (inc > (int)hpp->size)
+				inc = hpp->size;
+			advance_hpp(hpp, inc);
 		}
 
 		gtk_tree_store_set(store, &iter, col_idx, strim(bf), -1);
@@ -505,6 +516,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	GtkWidget *view;
 	int col_idx;
 	int nr_cols = 0;
+	int ret;
 	char s[512];
 	char buf[512];
 	bool first_node, first_col;
@@ -541,9 +553,10 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 	/* construct merged column header since sort keys share single column */
 	buf[0] = '\0';
 	first_node = true;
+	ret = 0;
 	list_for_each_entry_continue(fmt_node, &hists->hpp_formats, list) {
 		if (!first_node)
-			strcat(buf, " / ");
+			ret += scnprintf(buf + ret, sizeof(buf) - ret, " / ");
 		first_node = false;
 
 		first_col = true;
@@ -552,11 +565,11 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 				continue;
 
 			if (!first_col)
-				strcat(buf, "+");
+				ret += scnprintf(buf + ret, sizeof(buf) - ret, "+");
 			first_col = false;
 
 			fmt->header(fmt, &hpp, hists, 0, NULL);
-			strcat(buf, strim(hpp.buf));
+			ret += scnprintf(buf + ret, sizeof(buf) - ret, "%s", strim(hpp.buf));
 		}
 	}
 

-- 
2.54.0

