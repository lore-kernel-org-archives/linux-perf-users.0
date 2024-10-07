Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F191D88A2;
	Mon,  7 Oct 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310302; cv=none; b=uVWt4nk3IqukWUS0IW8CJyjPv5VvFwhADn8nZTU1xSmKiNVihhgMcqAZ1ZmgfjMatHJPgYRkIhWhQkbZ0h7eTsBQ982mY2J+R5wCIK2f2W+U0FXeV3/nZDI0mSJPi0pzO5rnRa0CybMoVlXlobrL/KMOfIoxR54BsaWgA4SAouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310302; c=relaxed/simple;
	bh=bTqJlxMu8UAh36R1oSXfPxrxzREjS1ZfQMC89zv8lVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw9Jkxke2WLTCdLAT9U1Y0BRLunjAzkFbv0xYdAiJRqzDGV8fjv3X+zE9wZfsGfWUALds69z51tKAFdK31CvvP5XOudzoD3tZplHYTfLthQi8QYxQ97aNxLhRULjKrQ2bYV4ylMhHezTrZvOTiCwEudfPU9J3/2+PssuVDkKa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C68C1FEC;
	Mon,  7 Oct 2024 07:12:09 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A0543F64C;
	Mon,  7 Oct 2024 07:11:38 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Dima Kogan <dima@secretsauce.net>,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/3] perf probe: Generate hash event for long symbol
Date: Mon,  7 Oct 2024 15:11:16 +0100
Message-Id: <20241007141116.882450-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007141116.882450-1-leo.yan@arm.com>
References: <20241007141116.882450-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a symbol name is longer than the maximum event length (64 bytes),
generate an new event name with below combination:

  TruncatedSymbol + '_' + HashString + '__return' + '\0'
    `> 46B        + 1B  +   8B       +    8B      + 1B   = 64 Bytes.

With this change, a probe can be injected for long symbol.

Before:

  # nm test_cpp_mangle | grep -E "print_data|Point"
  0000000000000cac t _GLOBAL__sub_I__Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi
  0000000000000b50 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzR5Point
  0000000000000b14 T _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi

  # perf probe -x test_cpp_mangle --add \
        "_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"
  snprintf() failed: -7; the event name nbase='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long
  Error: Failed to add events.

After:

  # perf probe -x test_cpp_mangle --add \
	"_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi"

  Probe event='_Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi' is too long (>= 64 bytes).
  Generate hashed event name='_Z62this_is_a_very_very_long_print_data_abcdef_91f40679'

  Added new event:
    probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679
    (on _Z62this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyzi in /mnt/test_cpp_mangle)

  You can now use it in all perf tools, such as:

      perf record -e probe_test_cpp_mangle: _Z62this_is_a_very_very_long_print_data_abcdef_91f40679 -aR sleep 1

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 42 ++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 71acea07cb46..bacd29b95c75 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2837,6 +2837,32 @@ static void warn_uprobe_event_compat(struct probe_trace_event *tev)
 /* Defined in kernel/trace/trace.h */
 #define MAX_EVENT_NAME_LEN	64
 
+static char *probe_trace_event__hash_event(const char *event)
+{
+	char *str = NULL;
+	size_t hash;
+
+	str = malloc(MAX_EVENT_NAME_LEN);
+	if (!str)
+		return NULL;
+
+	hash = str_hash(event);
+
+	/*
+	 * Reserve characters for the "__return" suffix for the return probe.
+	 * Thus the string buffer (64 bytes) are used for:
+	 *   Truncated event:  46 bytes
+	 *   '_'            :   1 byte
+	 *   hash string    :   8 bytes
+	 *   reserved       :   8 bytes (for suffix "__return")
+	 *   '\0'           :   1 byte
+	 */
+	strncpy(str, event, 46);
+	/* '_' + hash string + '\0' */
+	snprintf(str + 46, 10, "_%lx", hash);
+	return str;
+}
+
 /* Set new name from original perf_probe_event and namelist */
 static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       struct perf_probe_event *pev,
@@ -2844,7 +2870,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 				       bool allow_suffix)
 {
 	const char *event, *group;
-	char *buf;
+	char *buf, *hash_event = NULL;
 	int ret;
 
 	buf = malloc(MAX_EVENT_NAME_LEN);
@@ -2864,6 +2890,19 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 			event = pev->point.function;
 		else
 			event = tev->point.realname;
+
+		if (strlen(event) >= MAX_EVENT_NAME_LEN) {
+			pr_warning("Probe event='%s' is too long (>= %d bytes).\n",
+				   event, MAX_EVENT_NAME_LEN);
+
+			hash_event = probe_trace_event__hash_event(event);
+			if (!hash_event) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			pr_warning("Generate hashed event name='%s'\n", hash_event);
+			event = hash_event;
+		}
 	}
 	if (pev->group && !pev->sdt)
 		group = pev->group;
@@ -2903,6 +2942,7 @@ static int probe_trace_event__set_name(struct probe_trace_event *tev,
 		strlist__add(namelist, event);
 
 out:
+	free(hash_event);
 	free(buf);
 	return ret < 0 ? ret : 0;
 }
-- 
2.34.1

