Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743D3191A5
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882360; cv=none; b=HP2FJ8HByhEUd4aK8d++1AIsLUAzjUr19svWNHeb7rpE6TMqUiUjgALjXTJhG2h/Vu1ht2pElcp1sQH+nYCnnbBfH8jiQs2diLk22NivErvovMXVKUEgszcv4Uwur1Cj5hTL22/Szybtcc0gIy2vncwK6CqQg2uHcZcTIxXtK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882360; c=relaxed/simple;
	bh=2xd40pG/HaU0jYGvWRoxt8l7PoBOLNqGg/PcgsLxwto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwykD2kwmbDx/OGgwaM5bIasGB6vpGZq3bpACGEgqOBHM5FBK6aJwsfuYHictkfNZErW1ZfS2zKnt2+2vrrdaTI2jVYB4u85KaGFmKDSA71JT5u7+Y19EQChSOlV46VQuSIpvtHBT5nqxNBy6o0naE0eOXP80ZnP8iefFpE+5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrRShKJB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrRShKJB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5905545eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777882358; x=1778487158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xMBI5RZgAEel/veWskGaZ9afVt4imTDF2xTiQxdH38Q=;
        b=vrRShKJBC6jO9QF4F5dvgIAfF4gdeDBAu8rvYz9OqUNUTUVsdG5gIfNnDs21lyg30x
         O1Wz/5efJW62OOvB+g4TAWh6/GXLDrfpEFOCPHP1STZ6I46Jqawzux0qrQaC1hTQxd3/
         u09LHLZyK2LBIANLcLyR4uWEhKgIHVdm7rHEinEkWYK0oQdOvJ/nVcSFTYYkOe1lS/Iz
         w1iOHrjWVQczVToSHP7zfVdf2G4Wv1X68Xt4tSaloL0AjgtG/RfpqsrfkU8RAqe5xtEH
         lc6N67I6bOL9UEc6/6I1zGELfiULLl3IqunP581oqe2ni6UrcasX8KDpt5MwKEbP4O/u
         WjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882358; x=1778487158;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMBI5RZgAEel/veWskGaZ9afVt4imTDF2xTiQxdH38Q=;
        b=jLwwVV9/rBlZiBNdNf5GYxA+j/uzxXludzlxIwFsNqP5Si8PtBrBfGRim9cEwRCJR2
         QCPMcoPEWyReTW9duOHgyRbmHMMZ2C7Fg4eLh3esXFXSaOU9b9f2zMT6sSfp9AK03WXF
         FsM3mVKXTkFqRZfdBA/Imx1iVgoWoujo69LhZGhFoFKfktB2mu641kV2TGUFHPZ/P/Fh
         zX/md7R1AI0tsk+mhkF+91jmMec+3vWvODnBxdPv3sDapRyStbv5YiLhIt58Yw9NKG4h
         xEEeWPhJfDkARgT02gO015uzYFZRXosah2sfiJKAxVpHuPnnffETjZf46vjrX9JAiMlw
         S7Qw==
X-Forwarded-Encrypted: i=1; AFNElJ8NDJijONcxoWTBgQi4w+gLLwCFwSXaBhnExTq59R7k1y82oAhkIrLUPxxnrReQzETmN6FBi2kkY0OelHvJGU5q@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgWWJXlLheir/sv0zFFx8H9UV4gA6OtqpyetvjKekc14UIba9
	uSpnVhKls8+yWvcHxRicK+rM+0UuVqakUp8KYcdS0p9KZXuIx9WGGlHJMk3YMYW86Ma2cBkudox
	Ep5ykYVaM4w==
X-Received: from dlii2.prod.google.com ([2002:a05:7022:4182:b0:12a:7dc7:7b04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a:b0:12d:ce34:3fa0
 with SMTP id a92af1059eb24-12dfd856b43mr3879918c88.32.1777882358198; Mon, 04
 May 2026 01:12:38 -0700 (PDT)
Date: Mon,  4 May 2026 01:12:21 -0700
In-Reply-To: <20260504081227.2203848-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260503171032.1559338-1-irogers@google.com> <20260504081227.2203848-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504081227.2203848-4-irogers@google.com>
Subject: [PATCH v5 3/9] perf srcline: Introduce inline_node__clear_frames()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zecheng Li <zli94@ncsu.edu>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce inline_node__clear_frames() to clean up partial allocations.
This is a prerequisite for error handling in libdw inline unwinding.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v5:
 - Split from original Patch 3/6 into its own commit.
---
 tools/perf/util/srcline.c | 9 ++++++++-
 tools/perf/util/srcline.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index db164d258163..62884428fb5a 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -429,10 +429,13 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 	return addr2inlines(dso_name, addr, dso, sym);
 }
 
-void inline_node__delete(struct inline_node *node)
+void inline_node__clear_frames(struct inline_node *node)
 {
 	struct inline_list *ilist, *tmp;
 
+	if (node == NULL)
+		return;
+
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
 		zfree_srcline(&ilist->srcline);
@@ -441,7 +444,11 @@ void inline_node__delete(struct inline_node *node)
 			symbol__delete(ilist->symbol);
 		free(ilist);
 	}
+}
 
+void inline_node__delete(struct inline_node *node)
+{
+	inline_node__clear_frames(node);
 	free(node);
 }
 
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 7c37b3bf9ce7..1018cbc886d6 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -47,6 +47,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 					    struct symbol *sym);
 /* free resources associated to the inline node list */
 void inline_node__delete(struct inline_node *node);
+void inline_node__clear_frames(struct inline_node *node);
 
 /* insert the inline node list into the DSO, which will take ownership */
 void inlines__tree_insert(struct rb_root_cached *tree,
-- 
2.54.0.545.g6539524ca2-goog

