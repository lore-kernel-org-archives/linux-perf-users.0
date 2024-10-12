Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D556F2E0;
	Sat, 12 Oct 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747885; cv=none; b=thDQyL2v3ZmN2RnASGH7wS0yoXh0hWoG+MM5caaYKWDxYrlZ55okwBO6/qHy51shM6yhT2CjEPHEDXgGynGDMsDmtC3LvRFD7ePhm41Q27VFEYHpjLn/a4U0GUsN8fOngVqriLp24/yLnHxhgoh/LitOCOFLGvVOlc21Kwl1df4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747885; c=relaxed/simple;
	bh=uv1AweUXlmSPy9svOaCmEUKMG+vGN4Omv0xBK6O4UNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=owiFThr4RAaWjbGFcPsZwuEpkQob7D4QEzDR6ZkUXfwRgve7Nf35km2T44hMpmVLj3bTdYJrjvaHSsrz0ngF29zSIEVbifrUTzDEyt2A26HGe4ne5iO7drYv1Jb392TdKYHjEHcoi4D48zvfxJMKm3QCfMiWNf0kLe7g/XhWHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F39E11063;
	Sat, 12 Oct 2024 08:45:12 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFFE93F58B;
	Sat, 12 Oct 2024 08:44:41 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 3/3] perf probe: Improve log for long event name failure
Date: Sat, 12 Oct 2024 16:44:28 +0100
Message-Id: <20241012154428.888373-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012154428.888373-1-leo.yan@arm.com>
References: <20241012154428.888373-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a symbol name is longer than the maximum event length (64 bytes), the
perf tool reports error:

  # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
    snprintf() failed: -7; the event name nbase='this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)' is too long
    Error: Failed to add events.

An information is missed in the log that the symbol name and the event
name can be set separately. Especially, this is recommended for adding
probe for a long symbol.

This commit refines the log for reminding event syntax.

After:

  # perf probe -x test_cpp_mangle --add "this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
    snprintf() failed: -7; the event name is too long (>= 64 bytes)
      Try to set event with syntax "[GROUP:]EVENT=this_is_a_very_very_long_print_data_abcdefghijklmnopqrstuvwxyz(int)"
      Error: Failed to add events.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/probe-event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 224ec6818803..441daf4fb321 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2760,7 +2760,9 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
 	/* Try no suffix number */
 	ret = e_snprintf(buf, len, "%s%s", nbase, ret_event ? "__return" : "");
 	if (ret < 0) {
-		pr_warning("snprintf() failed: %d; the event name nbase='%s' is too long\n", ret, nbase);
+		pr_warning("snprintf() failed: %d; the event name is too long (>= %d bytes)\n"
+			   "  Try to set event with syntax \"[GROUP:]EVENT=%s\"\n",
+			   ret, MAX_EVENT_NAME_LEN, nbase);
 		goto out;
 	}
 	if (!strlist__has_entry(namelist, buf))
-- 
2.25.1

