Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.94.104
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258131;
	b=mcX+Gmn+A268TtEkS3yGzSkhhg8cjeAJinvB3sdatbAwnCaPijkMV4k9G/ZpvikSVuh/
	 aAe3o3yAQz0O/ytKewHr8WvoymxEplmr3tbsfrpQlHIgpAFoFVyHnt77ZB7juzGEtQW40
	 pkA/mDeLdkKVJwCWMaLHAPsvQMBYaJjQRRLFrLrQrB7JVqodQKUFg81XrS/878rCJn54i
	 VIjjl5FCCPkXAyLLhdBYa3+rtG+sY+eCnsXGYkN0J1UqhMH59QDpJBv/KaNOQy5g5xc85
	 0WulzrpT/V5Cxc8sc4+G7y9nQyknwuuZVKW5WH5cY3/yo2CdqDvzv28352aNVCp7mcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258131;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=i1yhE13PCUGATnwhT2+T7QHgUCbjLY1crWmjP7UMPFU=;
	b=GhANo7Mhe7oCArjTKBVmRqk8eHcrJ4+Daz0ulAceK+WZCk6WRhtC4axmx4MmTUlZblHE
	 DAAFF9/fUf191PbdQZjLjv75wxvqtVyIEU+ytBcmjymy21eEM8t8cNR8BOMr+F9paqLEu
	 Nr1vIy3sXLEa7Eemzs4Unt1i4HoyP+odE0tjIoNI07rU9qp3o0EZ7qazfdabJm67GF16h
	 0xCtt7eIZmsSyAlTzDSPmECgl+EO3Sf+ILIKyj9NW4QL7rdCZDZ+FpmQKR9XtsYv6EZ0v
	 5bps2EOEAQ2KpF7DH6ihiBh139qQZtrnxgl75TZB9tT/TURpkiysaHBdxRfCe5eilVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.94.104
Received: from dggmsgout13.his.huawei.com (dggmsgout13.his.huawei.com [124.71.94.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31E606A32D;
	Thu, 29 Oct 2026 07:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C31E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jFb8m4tJPz1rqlk;
	Thu, 29 Oct 2026 15:15:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 9827440576;
	Thu, 29 Oct 2026 15:15:19 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgA3i9CA8uJqfGTrCA--.58022S2;
	Thu, 29 Oct 2026 15:15:19 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] perf annotate-data: Show event name in the data-type title
Date: Thu, 29 Oct 2026 07:15:10 +0000
Message-Id: <20261029071510.460873-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3i9CA8uJqfGTrCA--.58022S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr15XFWruFWDJr1rAFyrZwb_yoW7JryDpF
	1DGryxJr45Jryaqw13Jr4UWFyFqw1xJ3WUGr4ktryjvF42gr1kJF17Xw1FyrWrGr1DCr1a
	qrn8Kr1UK3ykGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082
	I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRNksq3UUUUU=
	=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The same data type can be annotated for multiple sampling events, in
which case the data-type header is printed once per event.  But the
header only shows the type name and the sample count, so several
identical-looking headers are emitted and the user cannot tell which
event each of them corresponds to. E.g.

  $ perf annotate --data-type=page --stdio --itrace=f
  Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
  ============================================================================
   Percent     offset       size  field
    100.00          0       0x40  struct page      {
      9.95          0        0x8      long unsigned int   flags;

  Annotate type: 'struct page' in [kernel.kallsyms] (59480 samples):
  ============================================================================
   Percent     offset       size  field
    100.00          0       0x40  struct page      {
     10.15          0        0x8      long unsigned int   flags;

Add the event name to the data-type title in both the TUI browser and
the stdio output, so each header can be attributed to its event.  For
group events, use evsel__group_desc() to print the group description
instead of the leader's name, so the whole group is identified.

While at it, size the underline in the stdio output dynamically based
on the length of the header line instead of using a fixed-width string,
so it keeps matching the header as the text grows.

Result:

  $ perf annotate --data-type=page --stdio --itrace=f
  Annotate type: 'struct page' in [kernel.kallsyms] for l1d-miss (59208 samples):
  ===============================================================================
   Percent     offset       size  field
    100.00          0       0x40  struct page      {
      9.95          0        0x8      long unsigned int   flags;

  Annotate type: 'struct page' in [kernel.kallsyms] for l1d-access (59480 samples):
  =================================================================================
   Percent     offset       size  field
    100.00          0       0x40  struct page      {
     10.15          0        0x8      long unsigned int   flags;

Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 tools/perf/ui/browsers/annotate-data.c | 14 +++++++++++---
 tools/perf/util/annotate-data.c        | 15 ++++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index a15608f6ee53..0f778788df4a 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -340,11 +340,19 @@ static int browser__show(struct ui_browser *uib)
 	struct hist_entry *he = uib->priv;
 	struct annotated_data_type *adt = he->mem_type;
 	struct annotated_data_browser *browser = get_browser(uib);
+	struct evsel *evsel = hists_to_evsel(he->hists);
 	const char *help = "Press 'h' for help on key bindings";
-	char title[256];
+	const char *evsel_name = evsel__name(evsel);
+	char buf[512];
+	char title[sizeof(buf) + 256];
+
+	if (evsel__is_group_event(evsel)) {
+		evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel_name = buf;
+	}
 
-	snprintf(title, sizeof(title), "Annotate type: '%s' (%d samples)",
-		 adt->self.type_name, he->stat.nr_events);
+	snprintf(title, sizeof(title), "Annotate type: '%s' for %s (%d samples)",
+		 adt->self.type_name, evsel_name, he->stat.nr_events);
 
 	if (ui_browser__show(uib, title, help) < 0)
 		return -1;
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b3de1ca688a2..25e3169ea8ad 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2149,16 +2149,23 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 	int nr_samples = he->stat.nr_events;
 	int width = 7;
 	const char *val_hdr = "Percent";
+	const char *evsel_name = evsel__name(evsel);
+	char buf[512];
+	int len;
 
 	if (evsel__is_group_event(evsel)) {
 		struct hist_entry *pair;
 
 		list_for_each_entry(pair, &he->pairs.head, pairs.node)
 			nr_samples += pair->stat.nr_events;
+
+		evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel_name = buf;
 	}
 
-	printf("Annotate type: '%s' in %s (%d samples):\n",
-	       he->mem_type->self.type_name, dso__name(dso), nr_samples);
+	len = printf("Annotate type: '%s' in %s for %s (%d samples):\n",
+		     he->mem_type->self.type_name, dso__name(dso), evsel_name,
+		     nr_samples);
 
 	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
@@ -2183,7 +2190,9 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 		val_hdr = "Samples";
 	}
 
-	printf("============================================================================\n");
+	while (len-- > 1)
+		putchar('=');
+	putchar('\n');
 	printf("%*s %10s %10s  %s\n", (width + 1) * nr_members, val_hdr,
 	       "offset", "size", "field");
 }

base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
-- 
2.34.1

