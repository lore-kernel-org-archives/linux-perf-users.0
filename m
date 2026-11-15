Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794706883;
	b=pglmTuJ6gtLfhF+qkkAE9T11gE9UgK7w+B/M2UlPSt8zfmQux9BU/SNXBS6CpU6SyVOp
	 rOzD/AHyySxmBxgBUUTXkrc2XRRpvE+PuuY5tyVEtzSKGWHa3KygcSYwAX809kkloYH60
	 cd1rF+0VOuuUwn/zMn+S3hmWfRZG8oVeRI/VkWYg7KCFJkEj1x0Zgy3ROeaBVTICFc7RU
	 n23BX+4ylSI8jAY0RgcxoQn2ry8OthhQu2cABohN9nee0JB4zemmiOwZFK7UYWtWlc/WN
	 TC6ralJe0XQv6yki0KjvplymfEZwhJP1oFVjYlcz/v+9OfoK794AY2vyD5p4I4qQA2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794706883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ox+9ZjRT0CDrtpAPKb+sJGuFxKMXhRSi/nO5sGHs0wU=;
	b=gVVFXpb65dakOAFgR6yUWofEshInvHEUp5NbFGDeTWZgzW49v1S2yYrRi2+wmd9AAt5z
	 T/viMm2YvNI3CdTuiidLjcgIF6nKrMDcZxdxCDSyzRO99Pt4FM1/G5JAZNSxLkGK88Q+e
	 9uGDI0ZWMGB8MKw7GLspgR0XkkZEtmz0RjZXQxxftrYNLidXFJkfBv85ubTNM27/SosME
	 maO0w8OG5x6VNxGLM1AcnaQQhAgYn8y5qmn78/RyZQtCAJ0ROUHnmkvh9tsZt2Hg0t2uN
	 WDYg2teg3EsHY1jeYOzJI9dYU3PiPV0FrdAnD+wY8lpJOoZGat+4zQfVAPtp3XBXiqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs4tKyVD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953EF606A8A5;
	Sun, 15 Nov 2026 01:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vs4tKyVD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EFF1F000CD;
	Sun, 15 Nov 2026 01:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794706883;
	bh=Ox+9ZjRT0CDrtpAPKb+sJGuFxKMXhRSi/nO5sGHs0wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vs4tKyVDQ2blbj0yatwUI2EMAzK+tXFwxjn1j0gLpIDqbmhxQsFPmZAcViPMtTgOu
	 DmOxj9o+tc+AWJ1p8LsFfSE9yI+Nyr1P7+cTKou6dEs6e8+e8uZcwkFxlvH8olFFvF
	 Qr/1h4M0dYfCFOvuU2nVM+ey9Uok8iaZto6sgR2QKjolZ4WqIc890J5MCLB1oyuXQp
	 t1+oVIJLt4X5UPAhbX+V4r/QxBBe0uu7DK3T2YNDjUGjYV+yKrO3CVstnJ/0nz156D
	 JAR5T9UwSHm0G9KqL39qvAs6qY5rgM3MInK+TiZW0zsszHToF0++w8O173r6qWSGUv
	 8TeF+/GxGN4SA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 05/12] perf annotate-data: Count flexible array accesses for the whole struct
Date: Sat, 14 Nov 2026 22:40:53 -0300
Message-ID: <20261115014102.2879372-6-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115014102.2879372-1-acme@kernel.org>
References: <20261115014102.2879372-1-acme@kernel.org>
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

The per-member percentage sums the histogram entries in the member's
own [offset, offset + size) range.  A flexible array member is resolved
past the end of its struct, so the struct row only covered its declared
size and showed 0.00% while the member row showed 100.00% and the
header said N samples.

Take a member's extent as the end of its last child as well, so the
struct counts what was resolved past it.  Union members all start at
offset 0, so a plain union keeps its size; a member that is itself a
struct with a flexible array extends the union too.  The TUI browser
accounts the members the same way, use the extent there as well.

Extend tests/shell/data_type_flex_array.sh to check that the accesses
count for the struct in the percent, samples and period columns.

Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex-array")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/data_type_flex_array.sh  | 40 ++++++++++++++++++-
 tools/perf/ui/browsers/annotate-data.c        |  7 ++--
 tools/perf/util/annotate-data.c               | 24 ++++++++++-
 tools/perf/util/annotate-data.h               |  8 ++++
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
index 8d6b277991aea96e..c8e8ccd130abd771 100755
--- a/tools/perf/tests/shell/data_type_flex_array.sh
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -66,5 +66,43 @@ if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
 	exit 1
 fi
 
-echo "flexible array member resolved"
+# The accesses to the flexible array are resolved past the end of the
+# struct: they must count for the struct, not only for the member.
+if ! perf annotate --data-type -i "$perfdata" --stdio > "$perfout" 2>/dev/null; then
+	echo "FAIL: perf annotate --data-type"
+	cleanup
+	exit 1
+fi
+
+if ! awk '
+	$1 + 0 == 100.00 && /struct flex/ { struct_ok = 1 }
+	$1 + 0 == 100.00 && /char\[\]/ && /data;/ { data_ok = 1 }
+	$1 + 0 == 0.00 && /int/ && /len;/ { len_ok = 1 }
+	END { exit !(struct_ok && data_ok && len_ok) }
+' <(sed -n "/^Annotate type: 'struct flex' in/,/^Annotate type: /p" "$perfout"); then
+	echo "FAIL: --data-type does not count the flexible array accesses"
+	cleanup
+	exit 1
+fi
+
+# Same with the samples and period columns, the other two display modes.
+for mode in --show-nr-samples --show-total-period; do
+	if ! perf annotate --data-type -i "$perfdata" --stdio "$mode" > "$perfout" 2>/dev/null; then
+		echo "FAIL: perf annotate --data-type $mode"
+		cleanup
+		exit 1
+	fi
+
+	if ! awk '
+		$1 + 0 > 0 && /struct flex/ { total = $1 + 0 }
+		/char\[\]/ && /data;/ { data = $1 + 0 }
+		END { exit !(total > 0 && total == data) }
+	' <(sed -n "/^Annotate type: 'struct flex' in/,/^Annotate type: /p" "$perfout"); then
+		echo "FAIL: --data-type $mode does not count the flexible array accesses"
+		cleanup
+		exit 1
+	fi
+done
+
+echo "flexible array member resolved and counted"
 cleanup
diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index 0f778788df4a934b..e4047e97e8a943a4 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -53,12 +53,11 @@ static int get_member_overhead(struct annotated_data_type *adt,
 			       struct evsel *leader)
 {
 	struct annotated_member *member = entry->data;
-	int i, k;
+	int i, k, end = annotated_member__extent(member);
 
-	for (i = 0; i < member->size; i++) {
+	for (i = member->offset; i < end; i++) {
 		struct type_hist *h;
 		struct evsel *evsel;
-		int offset = member->offset + i;
 
 		k = 0;
 		for_each_group_evsel(evsel, leader) {
@@ -69,7 +68,7 @@ static int get_member_overhead(struct annotated_data_type *adt,
 				continue;
 
 			h = &adt->histograms[evsel->core.idx];
-			if (hashmap__find(&h->samples, offset, &hist))
+			if (hashmap__find(&h->samples, i, &hist))
 				update_hist_entry(&entry->hists[k], hist);
 			k++;
 		}
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index d8d00646ef63b30f..a74f894cbda70f5d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2237,6 +2237,25 @@ static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_s
 		color_fprintf(stdout, color, " %7.2f", percent);
 }
 
+/*
+ * A flexible array member is resolved past the end of its parent, so the
+ * parent's samples are not bounded by its size.
+ */
+int annotated_member__extent(struct annotated_member *member)
+{
+	struct annotated_member *child;
+	int end = member->offset + member->size;
+
+	list_for_each_entry(child, &member->children, node) {
+		int child_end = annotated_member__extent(child);
+
+		if (child_end > end)
+			end = child_end;
+	}
+
+	return end;
+}
+
 static void print_annotated_data_type(struct annotated_data_type *mem_type,
 				      struct annotated_member *member,
 				      struct evsel *evsel, int indent)
@@ -2244,6 +2263,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	struct annotated_member *child;
 	struct type_hist *h;
 	int i, nr_events = 0, samples = 0;
+	int end = annotated_member__extent(member);
 	u64 period = 0;
 	int width = symbol_conf.show_total_period ? 11 : 7;
 	struct evsel *pos;
@@ -2257,10 +2277,10 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 
 		samples = 0;
 		period = 0;
-		for (i = 0; i < member->size; i++) {
+		for (i = member->offset; i < end; i++) {
 			struct type_hist_entry *entry;
 
-			if (!hashmap__find(&h->samples, member->offset + i, &entry))
+			if (!hashmap__find(&h->samples, i, &entry))
 				continue;
 
 			samples += entry->nr_samples;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 184262c7356213fa..6e0d410929651426 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -260,6 +260,9 @@ void global_var_type__tree_delete(struct rb_root *root);
 /* Print data type annotation (including members) on stdout */
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+/* End offset of a member, including a flexible array's children */
+int annotated_member__extent(struct annotated_member *member);
+
 /* Get name of member field at the given offset in the data type */
 int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 					 char *buf, size_t sz, int member_offset);
@@ -316,6 +319,11 @@ static inline int hist_entry__annotate_data_tty(struct hist_entry *he __maybe_un
 	return -1;
 }
 
+static inline int annotated_member__extent(struct annotated_member *member)
+{
+	return member->offset + member->size;
+}
+
 static inline int annotated_data_type__get_member_name(struct annotated_data_type *adt __maybe_unused,
 						       char *buf __maybe_unused,
 						       size_t sz __maybe_unused,
-- 
2.56.0

