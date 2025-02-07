Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33781A7264
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738915504; cv=none; b=nlSV/GY8TBVbSw2qRVpaMhTLNfVVJw2z2K0ITcrmYmvU/1JFVQSu3YGA7oJ62Ejde6TywJ/fbEzNz/rZQKWMdqd5MyJn8QD7t0nKXkRxk86rziTj9qHasKSEaXt534hRWsUDx8MnIg448sbWsh/sKSeMi9ZsUBOblweakhvCKs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738915504; c=relaxed/simple;
	bh=BSKBeFyWHOzWBU58Cj1kZacbB3HaPZt/3iFqJPGblTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaougBxP5lE8UjjsHtid/HjNXgbPx27VJxUjENPPWczNJ+SdW4BGILapp7/YqxOHe0OWu+8HNBkY3ZD1j/TFAGXyiLDtwixYRjquKs9C0cJzqsIF0pFfO24O9CXqizU72aJuVYsWYHawyzqbnRLa8ISj2yGfBcJ8zyyFTRIdBno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsS/mngX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsS/mngX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738915501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cdc5LzPg4RkoSPb+OJ+dIV2Ns6AgRXDDbraNaOEpzDk=;
	b=KsS/mngXhJ0FenG62GNM+4Vd0Bke4E0bUzDht/f0ne8rJEpwi3NRs6OcueJBxyWPj9s/AP
	cm6nGMQUDnUhRaY+n4dpkA7rrEdmGMzr1YS7phEbNc/np4O8csoYrkW9df4zal6yG9EjsB
	vLUW8IQRPEDmJtcvVa8m2rrAHJ566bY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487-YQlP7HEwOEm43m-rOBtPDQ-1; Fri,
 07 Feb 2025 03:05:00 -0500
X-MC-Unique: YQlP7HEwOEm43m-rOBtPDQ-1
X-Mimecast-MFC-AGG-ID: YQlP7HEwOEm43m-rOBtPDQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 124251801A38;
	Fri,  7 Feb 2025 08:04:59 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C57718004A7;
	Fri,  7 Feb 2025 08:04:56 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 2/2] perf ftrace latency: allow to hide empty buckets
Date: Fri,  7 Feb 2025 09:04:45 +0100
Message-ID: <20250207080446.77630-2-gmonaco@redhat.com>
In-Reply-To: <20250207080446.77630-1-gmonaco@redhat.com>
References: <20250207080446.77630-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Especially while using several buckets, it isn't uncommon to have some
of them empty and reading the histogram may be a bit more complex:

  # perf ftrace latency -a -T mutex_lock --bucket-range 5 --max-latency 200
  #   DURATION     |  COUNT | GRAPH                                  |
       0 -    5 us |  14816 | ###################################### |
       5 -   10 us |   1228 | ###                                    |
      10 -   15 us |    438 | #                                      |
      15 -   20 us |    106 |                                        |
      20 -   25 us |     21 |                                        |
      25 -   30 us |     11 |                                        |
      30 -   35 us |      1 |                                        |
      35 -   40 us |      2 |                                        |
      40 -   45 us |      4 |                                        |
      45 -   50 us |      0 |                                        |
      50 -   55 us |      1 |                                        |
      55 -   60 us |      0 |                                        |
      60 -   65 us |      1 |                                        |
      65 -   70 us |      1 |                                        |
      70 -   75 us |      1 |                                        |
      75 -   80 us |      2 |                                        |
      80 -   85 us |      0 |                                        |
      85 -   90 us |      1 |                                        |
      90 -   95 us |      0 |                                        |
      95 -  100 us |      1 |                                        |
     100 -  105 us |      0 |                                        |
     105 -  110 us |      0 |                                        |
     110 -  115 us |      0 |                                        |
     115 -  120 us |      0 |                                        |
     120 -  125 us |      1 |                                        |
     125 -  130 us |      0 |                                        |
     130 -  135 us |      0 |                                        |
     135 -  140 us |      1 |                                        |
     140 -  145 us |      0 |                                        |
     145 -  150 us |      0 |                                        |
     150 -  155 us |      0 |                                        |
     155 -  160 us |      0 |                                        |
     160 -  165 us |      0 |                                        |
     165 -  170 us |      0 |                                        |
     170 -  175 us |      0 |                                        |
     175 -  180 us |      0 |                                        |
     180 -  185 us |      0 |                                        |
     185 -  190 us |      0 |                                        |
     190 -  195 us |      0 |                                        |
     195 -  200 us |      0 |                                        |
     200 -  ... us |      2 |                                        |

Allow the optional flag --hide-empty to remove buckets with no element
and produce a more compact graph. This feature could be misleading since
there is no clear indication for missing buckets, for this reason it's
disabled by default.

  # perf ftrace latency -a -T mutex_lock --bucket-range 5 --max-latency --hide-empty 200
  #   DURATION     |  COUNT | GRAPH                                  |
       0 -    5 us |  14816 | ###################################### |
       5 -   10 us |   1228 | ###                                    |
      10 -   15 us |    438 | #                                      |
      15 -   20 us |    106 |                                        |
      20 -   25 us |     21 |                                        |
      25 -   30 us |     11 |                                        |
      30 -   35 us |      1 |                                        |
      35 -   40 us |      2 |                                        |
      40 -   45 us |      4 |                                        |
      50 -   55 us |      1 |                                        |
      60 -   65 us |      1 |                                        |
      65 -   70 us |      1 |                                        |
      70 -   75 us |      1 |                                        |
      75 -   80 us |      2 |                                        |
      85 -   90 us |      1 |                                        |
      95 -  100 us |      1 |                                        |
     120 -  125 us |      1 |                                        |
     135 -  140 us |      1 |                                        |
     200 -  ... us |      2 |                                        |

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/perf/builtin-ftrace.c | 14 +++++++++++---
 tools/perf/util/ftrace.h    |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4f76094ea06d4..7caa18d5ffc38 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -841,14 +841,17 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 
 	bar_len = buckets[0] * bar_total / total;
 
-	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
-	       0, min_latency ?: 1, use_nsec ? "ns" : "us",
-	       buckets[0], bar_len, bar, bar_total - bar_len, "");
+	if (!ftrace->hide_empty || buckets[0])
+		printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
+		       0, min_latency ?: 1, use_nsec ? "ns" : "us",
+		       buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < bucket_num - 1; i++) {
 		unsigned int start, stop;
 		const char *unit = use_nsec ? "ns" : "us";
 
+		if (ftrace->hide_empty && !buckets[i])
+			continue;
 		if (!ftrace->bucket_range) {
 			start = (1 << (i - 1));
 			stop  = 1 << i;
@@ -884,6 +887,8 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	}
 
 	bar_len = buckets[bucket_num - 1] * bar_total / total;
+	if (ftrace->hide_empty && !buckets[bucket_num - 1])
+		goto print_stats;
 	if (!ftrace->bucket_range) {
 		printf("  %4d - %-4s %s", 1, "...", use_nsec ? "ms" : "s ");
 	} else {
@@ -902,6 +907,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	printf(" | %10d | %.*s%*s |\n", buckets[bucket_num - 1],
 	       bar_len, bar, bar_total - bar_len, "");
 
+print_stats:
 	printf("\n# statistics  (in %s)\n", ftrace->use_nsec ? "nsec" : "usec");
 	printf("  total time: %20.0f\n", latency_stats.mean * latency_stats.n);
 	printf("    avg time: %20.0f\n", latency_stats.mean);
@@ -1645,6 +1651,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Minimum latency (1st bucket). Works only with --bucket-range."),
 	OPT_UINTEGER(0, "max-latency", &ftrace.max_latency,
 		    "Maximum latency (last bucket). Works only with --bucket-range."),
+	OPT_BOOLEAN(0, "hide-empty", &ftrace.hide_empty,
+		    "Hide empty buckets in the histogram"),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 395f97b203ead..a9bc47da83a56 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -25,6 +25,7 @@ struct perf_ftrace {
 	unsigned int		min_latency;
 	unsigned int		max_latency;
 	unsigned int		bucket_num;
+	bool			hide_empty;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
-- 
2.48.1

