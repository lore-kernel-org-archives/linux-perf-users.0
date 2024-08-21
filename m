Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A6185B5B;
	Wed, 21 Aug 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223250; cv=none; b=iTNOlG6Ulhwf2fAybq06GEZ89kjXwbtBpi/xuM9iZCNgNvlsRkCNW3GdS2mzeCtgw7aknje9XLNYQbymeBXJH0WIrcCRIK03fRZXQp+6gEKXsn5l/TFvtpdy7cYI2Jbfk8kqQ3eJLGU7vSz0CnaAbKBAN7DevcyrSXBA5IH9g3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223250; c=relaxed/simple;
	bh=40JIck12LRZQFAYFdd1yRRPbX0IsQ0JHeE3vUXaJ+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+FAk5XQn/xFehPUmR65MpXbx9DMzD/rCxZfsgPcK8vbnISipOYyCy6tSoPIWcEXvoGI6wOOvIumzu7iUxziZOQOsSAkw7+wMwVc2ZB6o1OCacyrAsuZvW00qC/7m61Vu2Ft0bFu7sWfGR2LAp8aCIHquG5ylRJhEgkQ6wJRzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNJsNBTt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNJsNBTt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE900C4AF12;
	Wed, 21 Aug 2024 06:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724223250;
	bh=40JIck12LRZQFAYFdd1yRRPbX0IsQ0JHeE3vUXaJ+UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNJsNBTtg1ljBcl476Z9uKy3Wc91dezhc6hiCCL6GiMSf3n8jcdRrFaVt6uHGLbVl
	 4nuD5Jeuvm7u/krDxks7JvFJStaSGzX5Jd8MMlV7AIEzu73rdMC1tIPcSLJGLDnvoe
	 uVC0/Srsn0uE1k7iNw1e4FyRUy4Vo81YFEbnroGbvU73YN6Q1tRLgL+3hiINYG4Q3R
	 e6YjCFCgpNlSJFaZfAvkb8q38ly9kfBlmEFdotP6FzWOtniyZ0WRiiPKAmueAn/+Oi
	 z0sqtlfS14wZtpR8C4dKSVZ7pWNZaR4DrCkO0wNYDbJ8yqXx7YvLM30NmBLJ4kgy9k
	 cpL5/mD2jzBqw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 2/3] perf annotate-data: Prefer struct/union over base type
Date: Tue, 20 Aug 2024 23:54:07 -0700
Message-ID: <20240821065408.285548-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821065408.285548-1-namhyung@kernel.org>
References: <20240821065408.285548-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes a compound type can have a single field and the size is the
same as the base type.  But it's still preferred as struct or union
could carry more information than the base type.

Also put a slight priority on the typedef for the same reason.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 25105b3b9a13..d3db945afac9 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -382,6 +382,13 @@ static bool is_pointer_type(Dwarf_Die *type_die)
 	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
 }
 
+static bool is_compound_type(Dwarf_Die *type_die)
+{
+	int tag = dwarf_tag(type_die);
+
+	return tag == DW_TAG_structure_type || tag == DW_TAG_union_type;
+}
+
 /* returns if Type B has better information than Type A */
 static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
 {
@@ -411,7 +418,18 @@ static bool is_better_type(Dwarf_Die *type_a, Dwarf_Die *type_b)
 	    dwarf_aggregate_size(type_b, &size_b) < 0)
 		return false;
 
-	return size_a < size_b;
+	if (size_a != size_b)
+		return size_a < size_b;
+
+	/* struct or union is preferred */
+	if (is_compound_type(type_a) != is_compound_type(type_b))
+		return is_compound_type(type_b);
+
+	/* typedef is preferred */
+	if (dwarf_tag(type_b) == DW_TAG_typedef)
+		return true;
+
+	return false;
 }
 
 /* The type info will be saved in @type_die */
-- 
2.46.0.184.g6999bdac58-goog

