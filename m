Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600548;
	b=XLr6LVwvllq75P/4zdUbsvu093uzpMfqDUy/jjJZkHS+dThbfX8hX+aPnNvXZ/pnb8uT
	 M75R2XCTHSjHkdoliVR9YZWl8twpSYRZ6RQOp1WKn0ubqPvsSSTuZxJLRSzxAqcMcj9JS
	 ADBUOO7txahepFNYQ+H6mOKkCCc/zAM7g9TIUXu3o9WtpS3eF0nMYmCfiL26Mz99SVFhk
	 KxnSf8YD4Yko2KEt/drZHKfPLzUBEnE1CpWowXx7qFjcz1RKceRL9Mu+MImxTIAAXPv6h
	 sLjRgezSAqbI2YAwcSaT0/hFR5MFsBHLJ7iWOn009v+sYlchUHn642OGPQrFlT8oPwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9XnJm6/6KJWaq14AYIOl9jYncGfifJKN6eWUIVG/F+0=;
	b=1NmGDcrxjGyd2Dak/tajwwhGU7OBooqrYALJaF5BbpwNWYRhHsAzBYJzHBcbgmc7srot
	 6PK39ishfO/lnnGaTcpI3YKPUjqlyNcnve7amQnXxkCQOlSOWCKbdYx0AEN6jyHIFdza6
	 3FMpI2xZLgq3x/SRZBv1hBi2pjP83+7A4NW+mVAAd52IXZF8uaQGcBpx4MgMsm9ISTHfv
	 nbdlX1URQiJfZ6TVW2uBPguu+SgKZDm3xAckBg/qpefaY6kO+GlVd6sce92DOCQM8UBjx
	 1dOjuYfsTkbb9VIICpgawf/Bi0ACfwuo5Kf9jviIG6+hkXW/3OyhTbBanS6MlrrIu2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjNIx314;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE82606A8B8;
	Fri, 13 Nov 2026 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjNIx314
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7A91F000C4;
	Fri, 13 Nov 2026 20:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600548;
	bh=9XnJm6/6KJWaq14AYIOl9jYncGfifJKN6eWUIVG/F+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jjNIx314tbWRNtylkIO9Y9Uc0EFGtAze3dlVqlk+buXBotMDk74UJ4w+76ur4QoUV
	 z/+TwfpzIY7fMZKbwACnxcFf4Otl5kD5gsAn6TxjuWCmbj+DGog9R/z7jWxV7XT7ag
	 UsccY0vHLz0LhQJUnCHoe/nIh6EWLg0g8R89qKFMEUrr8q0PlM3lJ6Q4czS4WYSAXQ
	 u7ZpfJY8pY61XFfEn5aNIob7rpOACxnQ4Zn57HgH//TOS8luNKDe/TvnFcbSXSfTu6
	 pVIH4EPZTODCKs9/7Rgu+MIS5WgV2ZMxJgwvVfNrWKlCyC9m6sfDWCy2+jKukIwZiq
	 rwfTQBZdhmtRQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 04/11] perf annotate-data: Count flexible array accesses for the whole struct
Date: Fri, 13 Nov 2026 17:08:42 -0300
Message-ID: <20261113200850.2803460-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113200850.2803460-1-acme@kernel.org>
References: <20261113200850.2803460-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/util/annotate-data.h               |  3 ++
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/data_type_flex_array.sh b/tools/perf/tests/shell/data_type_flex_array.sh
index 983cde2b3c7d2b29..7a7a782320afee23 100755
--- a/tools/perf/tests/shell/data_type_flex_array.sh
+++ b/tools/perf/tests/shell/data_type_flex_array.sh
@@ -100,5 +100,43 @@ if ! grep -Fq "# data-type: struct flex +0x4 (data)" "$perfout"; then
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
index 0f778788df4a934b..0e1e06acf2b231a7 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -53,12 +53,11 @@ static int get_member_overhead(struct annotated_data_type *adt,
 			       struct evsel *leader)
 {
 	struct annotated_member *member = entry->data;
-	int i, k;
+	int i, k, end = annotated_member_extent(member);
 
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
index dd9c1d7b2da8be8a..75a0906b4df0b9e2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2233,6 +2233,25 @@ static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_s
 		color_fprintf(stdout, color, " %7.2f", percent);
 }
 
+/*
+ * A flexible array member is resolved past the end of its parent, so the
+ * parent's samples are not bounded by its size.
+ */
+int annotated_member_extent(struct annotated_member *member)
+{
+	struct annotated_member *child;
+	int end = member->offset + member->size;
+
+	list_for_each_entry(child, &member->children, node) {
+		int child_end = annotated_member_extent(child);
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
@@ -2240,6 +2259,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	struct annotated_member *child;
 	struct type_hist *h;
 	int i, nr_events = 0, samples = 0;
+	int end = annotated_member_extent(member);
 	u64 period = 0;
 	int width = symbol_conf.show_total_period ? 11 : 7;
 	struct evsel *pos;
@@ -2253,10 +2273,10 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 
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
index 184262c7356213fa..880b11849a9329c7 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -260,6 +260,9 @@ void global_var_type__tree_delete(struct rb_root *root);
 /* Print data type annotation (including members) on stdout */
 int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
 
+/* End offset of a member, including a flexible array's children */
+int annotated_member_extent(struct annotated_member *member);
+
 /* Get name of member field at the given offset in the data type */
 int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 					 char *buf, size_t sz, int member_offset);
-- 
2.56.0

