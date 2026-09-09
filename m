Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D64633D4E8
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 02:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922249; cv=none; b=rVIKCS2dWUmwAMe5GGPpAcFZ0i8Pz7y22rw3bHEZe1W4VN8iUzw30wYEGkkpDMkb0Prp8Nc2n/yfr7Ssz4SloBCgxZZ7h0A5Ih0LlPDeZmTlHeZQTgBfZ2yCSl/EhjUuhxDFsJHn8BsdC1AvolMBg6PyZhugTFtc0thhP5yCLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922249; c=relaxed/simple;
	bh=Jor5oXgeuFFmM9DJt4tFFBEGt97G7Zs2U7XOztWKBic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nR6wyUtSrNn65CbuopUJLgxXxh8mC9uV0TjzKUe2YrtAdKK+CX77dZS8y62+ADrygIf6r29iDXuN4TLmtNkh8/mJxCcOobzjxINySAeM7F8w7mSfTW6ce9KLFv0LlEcJt15ni39X+DVdHwEgfZWfDsgEEy1UVyRgS+keFRxLXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9o/zsnR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9o/zsnR"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-855a66e5b5dso43784777b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 19:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788922243; x=1789527043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNYcnB2WxFeBr7ZY16EYpHfgp99fE4ngetuj/d9sZ7o=;
        b=U9o/zsnRIS7SCjOq/dpU1KRO2hr+5piGvO0oW4quatlg0WoaZNSjB6jbJbMkyFvEPO
         9Ei6X+NA2mxXRxSWpN6HTh0oTI0Rw3sDt7/ixBiOweL6yNx/nfR5cYy64JKg7Qh/8mvp
         CeOhBozaaDiw7OFFjBczgmhQXS4F1v98YkvtPEqaH1PvsJiLJ39TAYMJf5FbDTnt6eK9
         TIoQOo9MWh/+I/4LqJacEgYY/O5mmhg4hG3ytrhP18+oGV/TyEhEJFU3b4qkDDwxHx5y
         yVuW+6epVw+L1x2MGa1ycGMwjwyreU1uQMMzTTn1zRswR8p/VjLR3qm/vx4jH+3Fbrgk
         7JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788922243; x=1789527043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNYcnB2WxFeBr7ZY16EYpHfgp99fE4ngetuj/d9sZ7o=;
        b=gN+mc7fzVNh8zBJE1twNOnezmTALBJiEfVs6rqh2wr06ZE740l+66YgArwHxqbJ9Cq
         43JOxu7QLKpdnOPT8T16RdnLGyAEDZpkOLPpqKpoDcTNhqHesbAf7IF9JjLnFu/upNoK
         6JpqdJ19ktfQt1O+hHZa17vUZVVjtjZk8jHZAhfZQXe6SQ/o8Btz1wdO6XaYZpiWmwJE
         93BPViv+xj+FM7Jp3AyMpumE6URHPtZkmUQ/SZU/aK0CihnGrYVlGc0tQvWvx4rVZSQX
         bnLurfX2GEruigaLXTf9m/vCtagCyeMhjXEDGM/mRVwPuy3a4WACZm5EqSPR7kiY/OK+
         gm1A==
X-Forwarded-Encrypted: i=1; AKwUvBxJhmtZBo4B5NWLcpU0ApAoa00PYn4vWKZ26vPysxbmWUcVlxp4NKysbZ2dak08PnMIwgrTcF5IaECS2raCkYNI@vger.kernel.org
X-Gm-Message-State: AFuF++kCHL84zjd/jqdnzEOyqeVuWtVNGfU8zCc3UmaPgYjRfNSkmqfF
	o6/J5Z0gTFeUj61RmwViWStM7j92EVAwuaVc1TnS4dOCUyPuyNNBuO5G
X-Gm-Gg: AYBFou32VKf9qJVQJTKnM3QNISMUWZrM4jCnDgUUT8xuIx8XrsJi+cQ/4nSmohb2eWI
	MHyoGys632YgAjMdgGDzlmokck0b/Kz8Y3Y9e237cNoPsoPa3ANvWm1wF/38NKZmQaR3wk08mju
	RJxWM6Gjj/Q7S863mfFveQnkpFN8a6OYQ4RJKZVHUx5cVmWEHohpBm0jc1U/D4pdAd9J9gPGqww
	2mOoQeKk662qE9NIgN9ZtwbTRBG1PZ55UDd9D4W05n2TbjoM94HaTivpNNhgC3QIbgdEbhG6pls
	vCCXCYMOP7hPW+oV+MH+GfO0gZuVOsgwW2c2NvbuVqexNQKhmK4AGGyLZrsxSq8e1psYz3X/U/P
	Ny1Bf0mQHTZmkm8f2p40OW9da61NBzwPaHIASJDKDB0RtL8FEjsbfWas7mjUDopqAIwcJfDQmTu
	I942ivsNqYSmNsTgDwpU/d5aHAGKAXOT5aM5rXmbA8DLNbXg14+a/wWdzRKOCN/22eF+n4Qd8=
X-Received: by 2002:a05:690c:e653:b0:836:ec3d:b5e6 with SMTP id 00721157ae682-8712a9ea11amr97294587b3.28.1788922242884;
        Tue, 08 Sep 2026 19:50:42 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714bb0efc1sm103407387b3.45.2026.09.08.19.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 19:50:40 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
Date: Tue, 08 Sep 2026 22:50:36 -0400
Subject: [PATCH v8 3/3] perf tools gtk: fix two hierarchy-view stack buffer
 overflows
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-perf-gtk2-v8-3-e90d5d155f0d@gmail.com>
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
In-Reply-To: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=Jor5oXgeuFFmM9DJt4tFFBEGt97G7Zs2U7XOztWKBic=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLIWnKxMDHS7uH7V3Gqnmbe1LwVavFsj+GfHV9aCnjWXG
 +e6dfmqdXxkYRDjYpgppsgSt16RZVbbjqU+p6V/wcxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkCGjlE8RE6PQSOzuLg0tUg3raDIIS+/JLEkMz+vWC+/IDWvIL1ALy0zrSQjI7+oOBVohF5eaom
 pq6ObkaGBiaWjhZmThaOpibOzk6GTm6Ojs6uTkaW5iYGzpaOJq6U5AxenAMw1ClUM/4MN5pnu/S
 1V3LnqF5eIYq2KutSc1vjI+uUNL3qezz6l28Pw38lhY5d11J8G+SKz04vtF2v/NFzoL9z6bc+51
 tJlj/z42QA=
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

That same loop also saves bf/size at the top of each iteration but
only restored hpp->buf/hpp->size to them before recursing into
non-leaf children. Leaf entries left the buffer state advanced from
the format loop, so the next sibling in the traversal inherited a
shrunk hpp->size and an already-advanced hpp->buf, eventually running
hpp->size down to 0 and pointing bf past the end of the stack buffer
for the strim(bf) call.

Fix the header builder by tracking the write offset and using
scnprintf() for each append, same pattern already used elsewhere in
this file. Fix the entry loop by clamping the amount passed to
advance_hpp() to what's actually left in the buffer, and by restoring
hpp->buf/hpp->size unconditionally after formatting each entry instead
of only before recursing.

Both bugs predate the perf GTK UI's move to GTK 4; neither function is
touched by that port.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 tools/perf/ui/gtk/hists.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 716dcf02bd0e..80df3fec8ea1 100644
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
@@ -457,15 +457,26 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
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
 
-		if (!he->leaf) {
-			hpp->buf = bf;
-			hpp->size = size;
+		hpp->buf = bf;
+		hpp->size = size;
 
+		if (!he->leaf) {
 			perf_gtk__add_hierarchy_entries(hists, &he->hroot_out,
 							store, &iter, hpp,
 							min_pcnt);
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

