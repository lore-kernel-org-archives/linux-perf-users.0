Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582374;
	b=narLwtx4PfLcqTO3BLZSkHSi2VEVMkiVu/p7+Dz8TiPxMc3p0De6gsIXxNpS/nMSg3ql
	 1+P/Voy99WAI++v8xk5IdgSNkb6yIcixU/crV3O+bL4HXvighIM5wY4OSqoXKAcTFDVtA
	 MNLS65Mg1z5Mu3nrnG2OUDhhbIq2rmrJrvyPFk4yGOazBa2fJ5yd9bzLTlN9St3tUH9xh
	 zh5PW08q0nsAgJemcUWy7bXQp4V7FJgCvi40t+Cz+o0kRILs+LjGkBeTzxWBhjXApgJ9y
	 xBFoQpAbRPgZGjzAtsZDUY+hcWe5+kEDMidL3gL8tZsICkPDo+vT6kJDsombq2w9snA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4vU6M4P5Sa676sVogFD3r4qx1VA2Cf96SPI3paFqJME=;
	b=GNjA3Q/efdDdj9HmyJQrveecJsk/Y0IYXyDxpjJkCmc/klEIXwuxO/cHo5elqe5UQ+FV
	 eQg0RyUPXHe9kY51oh8fql64vDuN/VyOy+3FMdh34RtVJbip0gSG1fIZ5+tNv5cvQakl4
	 ZvloygAw+Onyfsd2mp5T1q6HwL5/4gizZ/lGBnifb+UE4I+rT3Wep8zNu5Vd3DKHCie50
	 nQVu7ts+ATbiQibXh0VC7GDPwphLd2qVTkiMBzCXveFKbJ8OPF+Bto/UmdwAcFEML6iZl
	 sDbr9Z5inU8q+TFXZ6noXdZMsQuXb8XDEK4JjxPziwrvIhQ5St0b5bHmmNpraGxD92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD50z9TH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CAC606A331;
	Fri, 13 Nov 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BD50z9TH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D403B1F00929;
	Fri, 13 Nov 2026 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582374;
	bh=4vU6M4P5Sa676sVogFD3r4qx1VA2Cf96SPI3paFqJME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BD50z9THPGvlt6ktv6Egakvn96VkH/A461GwnqTcKj1xXteFfYIS7tKH1M5i5ViLk
	 +Dzqye+TnI4ygLHtVQthxm3Aq8QTLyS5C4K6dcvdxLRyp4BkWs6SapSi5JquY8d6wA
	 CINC2WMUrk8hy4s9LbxShty954zxeAlS1cygePIbiXTCyeI6CneWFot8TEhwk/2eLH
	 aVUo/Xf3kGeWCHz6wToOslDmR6TZAdIA6q0JcFzaqlog7VQc5wab9ps0AXf4ngU3Pm
	 xwRIixp1FBQ3DPd4aZnL7ICp8JsGEGDr4pvgX1X5lU0AsdNyK+oJTkW848YpbL/1T1
	 85+tjafrb0C8A==
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
Subject: [PATCH v1 04/12] perf annotate-data: Count flexible array accesses for the whole struct
Date: Fri, 13 Nov 2026 12:05:45 -0300
Message-ID: <20261113150555.1163049-5-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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
struct with a flexible array extends the union too.

Extend tests/shell/data_type_flex_array.sh to check that the accesses
count for the struct in the percent, samples and period columns.

Fixes: aaca646915a1bb53 ("perf annotate-data: Adjust type offset for flex-array")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/tests/shell/data_type_flex_array.sh  | 40 ++++++++++++++++++-
 tools/perf/util/annotate-data.c               | 24 ++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

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
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index dd9c1d7b2da8be8a..7fae186ffd76b533 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -2233,6 +2233,25 @@ static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_s
 		color_fprintf(stdout, color, " %7.2f", percent);
 }
 
+/*
+ * A flexible array member is resolved past the end of its parent, so the
+ * parent's samples are not bounded by its size.
+ */
+static int member_extent(struct annotated_member *member)
+{
+	struct annotated_member *child;
+	int end = member->offset + member->size;
+
+	list_for_each_entry(child, &member->children, node) {
+		int child_end = member_extent(child);
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
+	int end = member_extent(member);
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
-- 
2.56.0

