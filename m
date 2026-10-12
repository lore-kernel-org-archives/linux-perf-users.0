Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98773EE1D4
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 23:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848865; cv=none; b=bbD+GIoH7dfmXf01Vm4c3S23Gb5WRx76dWv/kT0fM7FrBzJmUGqDfmV5fQMxip5cikc6hZZpwX6OXftmyro/ErGhd7Sk9Vk2LH/cS0wRJhDk79dHep+nGZpvQNCoQaDVBDJ8xyguqQOlhGy87S/+uO8edkQQKF7C1ZtOlhlZEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848865; c=relaxed/simple;
	bh=QguaASFUO2aw1KOSSgWHH+HSVj3OseDyRM7YwYY3OFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HluHnIh60xY2Cd3SHeLki4CUdmc++Y1+LSB8oPKBW9mdZgPSgHtFYL84K5Ww3S7DxT7YYnqoKrN7qS/9T1YtC1e+SXZWUbYGoP1IUPk4lScN4gwRIbBht7OchzTKaxgVQBy9aSEfABApbEM9bH0F0c/fyEuOfJkVWJ8saXOne9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEMHGY2S; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEMHGY2S"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso4836722eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791848863; x=1792453663; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8XQLOjyCIFsHIwQ+tJEqae2K2wv7Ao8AsE+mH76B20=;
        b=LEMHGY2SZkk4/6xDrhp/Dwhnwly3Q2uSdH61jT7KXDaWshEPlRxcHKGCYLxR76W2k/
         Coe/HtZMrhxm2MePY7bEeo4W/fyNk5UuGhsfUS6Uy7NXAgfLpSmMjEnRxrlAEKBgHPsf
         j49LsH8LbivAcp1yl8bkp8n2aD4GFeOc6PgdqSDP+8FvcKWHStLYPfxO1JhkFlaq6wja
         2DlQPrgoLwlR0MDgVEVfxSOOVaIxDgdq7ASRZQDSJ+UUyjW2IaCRtXcNDpAT4GNerGb5
         LktqF1J26psY4NJo3IzhdfuBnuCYa5FRKLOlHBwW9CXOTHR2yEMaEAOiOCoC4Z6lC4u6
         D2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791848863; x=1792453663;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8XQLOjyCIFsHIwQ+tJEqae2K2wv7Ao8AsE+mH76B20=;
        b=GLGpAQVhQg+t8HePr9k+yW7PBrmeE+jqh2fULn7OyhRb5eoHICKgdgBKzOaqTvuJgI
         MBmQbu52HNN8/h6o9DFsFdWVf3itu4UInA3GYxEuuv/b7s9+RjPbhA7FG/OKcrgEA68k
         tQvWuDNgMiIMfM+/87LLMLu7+65j6m4NwhT5mjzyxZZCWGSEwdfBL3x9YuO3BLeWPf3O
         ZhL9P9TiPeuPE0E2/lt2TgI7YHZawgCtUG8YpY5o47xAtbHZWbuDEru/WNZgs83CEHKs
         Fmt1m3cWZQl+2oX0QjbrKY5wRmYYoX6GmVrV0EBRUEmhUSqxUliE4M332xWzZjyDnzJy
         Vhcg==
X-Forwarded-Encrypted: i=1; AKwUvBxeD9otgH8SeS/gx1gsFPaXasMxZVcAcUI9bTdYDTgI6ap2jqm81l4PwDTrJU5S2PygeZDoI7RRDVRp07mdSc27@vger.kernel.org
X-Gm-Message-State: AFq9FYKc/S9XeHM9n39qZ/00ATkJmXqKM2cb7tlQ/5caEu2HgYUvrHiI
	fbkTQHjQbKffLgkXoIq3TmdxAGGDMvjSpG67n9ZXGIT/9csPV1tiCF6Ppi9N7c3JQk0mn6Jrtrz
	h9XseFdbzCQ==
X-Received: from dycnm20.prod.google.com ([2002:a05:7300:d194:b0:358:2c8e:30e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:4196:20b0:35b:af:a075
 with SMTP id 5a478bee46e88-35b00afb749mr5306042eec.22.1791848862496; Mon, 12
 Oct 2026 16:47:42 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:47:24 -0700
In-Reply-To: <20261012234724.721224-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929025345.88829-1-irogers@google.com> <20261012234724.721224-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012234724.721224-4-irogers@google.com>
Subject: [PATCH v4 3/3] perf test: Avoid stack trace noise in verbose=1
 failure snippets
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When a test fails with a signal or times out, child_test_sig_handler()
appends '---- unexpected signal (<sig>) ----' followed by a multi-line
stack trace ('    #0 ...' through '_start').

In verbose=1 mode, print_test_failure_snippet() selects up to
failure_snippet_lines (10) lines:
- Pass 1 selects lines matching failure keywords plus their immediate
  next line ('    #0 ... in child_test_sig_handler').
- Pass 2 fills the remaining quota by scanning backwards from the end
  of the output buffer, which consumes the remaining lines on outermost
  stack frames ('handle_internal_command', 'run_argv', 'main',
  '__libc_start_main', '_start') and hides the trailing test output
  showing where the test had run to.

Improve print_test_failure_snippet() by:
- Skipping blank lines and stack trace lines ('    #<digit>...') when
  selecting context in Pass 1 and when scanning backwards from the end
  in Pass 2, with a Pass 3 fallback from the top of the buffer if quota
  still remains.
- Prioritizing the non-blank line immediately preceding
  '---- unexpected signal' so there is no '...' gap before the signal
  message.
- Only printing '...' between selected lines when at least one non-blank
  line was omitted between them.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 101 +++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d0c2783cb312..b95e9704b79f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -774,6 +774,47 @@ static void print_line_highlighted(FILE *fp, const char *line, size_t len)
 }
 
 
+static bool is_blank_line(const char *line, size_t len)
+{
+	for (size_t i = 0; i < len; i++) {
+		if (!isspace((unsigned char)line[i]))
+			return false;
+	}
+	return true;
+}
+
+static bool is_stack_line(const char *line, size_t len)
+{
+	size_t i = 0;
+
+	while (i < len && isspace((unsigned char)line[i]))
+		i++;
+	return i + 1 < len && line[i] == '#' && isdigit((unsigned char)line[i + 1]);
+}
+
+static bool is_ignorable_snippet_line(const char *line, size_t len)
+{
+	return is_blank_line(line, len) || is_stack_line(line, len);
+}
+
+static bool has_non_blank_between(const char **lines, const size_t *line_lens,
+				  size_t start, size_t end)
+{
+	for (size_t j = start + 1; j < end; j++) {
+		if (!is_blank_line(lines[j], line_lens[j]))
+			return true;
+	}
+	return false;
+}
+
+static void pick_snippet_line(bool *pick, size_t idx, unsigned int *picked_count)
+{
+	if (!pick[idx] && *picked_count < failure_snippet_lines) {
+		pick[idx] = true;
+		(*picked_count)++;
+	}
+}
+
 static void print_test_failure_snippet(FILE *fp, const char *buf)
 {
 	size_t num_lines = 0;
@@ -844,43 +885,63 @@ static void print_test_failure_snippet(FILE *fp, const char *buf)
 	}
 
 	/* Pass 0: Always pick the very first line */
-	if (num_lines > 0 && picked_count < failure_snippet_lines) {
-		pick[0] = true;
-		picked_count++;
-	}
+	if (num_lines > 0)
+		pick_snippet_line(pick, 0, &picked_count);
 
 	/* Pass 1: Pick lines with failure keywords from start (Highest Priority) */
 	for (i = 0; i < num_lines && picked_count < failure_snippet_lines; i++) {
 		size_t dummy;
 
-		if (find_next_keyword(lines[i], line_lens[i], &dummy)) {
-			if (!pick[i]) {
-				pick[i] = true;
-				picked_count++;
-			}
-			/* Prioritize getting the immediate next line for context */
-			if (i + 1 < num_lines && !pick[i + 1] &&
-			    picked_count < failure_snippet_lines) {
-				pick[i + 1] = true;
-				picked_count++;
+		if (is_ignorable_snippet_line(lines[i], line_lens[i]))
+			continue;
+		if (!find_next_keyword(lines[i], line_lens[i], &dummy))
+			continue;
+
+		pick_snippet_line(pick, i, &picked_count);
+		/*
+		 * For unexpected signals, prioritize the preceding non-blank
+		 * line showing where the test had run to before the signal.
+		 */
+		if (!strncmp(lines[i], "---- unexpected signal", 22)) {
+			size_t j = i;
+
+			while (j > 0) {
+				j--;
+				if (!is_ignorable_snippet_line(lines[j], line_lens[j])) {
+					pick_snippet_line(pick, j, &picked_count);
+					break;
+				}
 			}
 		}
+		/* Prioritize getting the immediate next line for context */
+		if (i + 1 < num_lines &&
+		    !is_ignorable_snippet_line(lines[i + 1], line_lens[i + 1]))
+			pick_snippet_line(pick, i + 1, &picked_count);
 	}
 
-	/* Pass 2: Fill remaining quota from the end backwards */
+	/*
+	 * Pass 2: Fill remaining quota from the end backwards, skipping blank
+	 * and stack trace lines so trailing test progress is shown instead of
+	 * outermost stack frames like main/_start.
+	 */
 	i = num_lines;
 	while (i > 0 && picked_count < failure_snippet_lines) {
 		i--;
-		if (!pick[i]) {
-			pick[i] = true;
-			picked_count++;
-		}
+		if (!is_ignorable_snippet_line(lines[i], line_lens[i]))
+			pick_snippet_line(pick, i, &picked_count);
+	}
+
+	/* Pass 3: Fallback to top stack frames if quota remains */
+	for (i = 0; i < num_lines && picked_count < failure_snippet_lines; i++) {
+		if (!is_blank_line(lines[i], line_lens[i]))
+			pick_snippet_line(pick, i, &picked_count);
 	}
 
 	for (i = 0; i < num_lines; i++) {
 		if (!pick[i])
 			continue;
-		if (last_printed != -1 && (int)i > last_printed + 1) {
+		if (last_printed != -1 &&
+		    has_non_blank_between(lines, line_lens, last_printed, i)) {
 			if (perf_use_color_default)
 				fprintf(fp, "%s...%s\n", PERF_COLOR_BLUE, PERF_COLOR_RESET);
 			else
-- 
2.56.0.385.gd3acb90ef8-goog

