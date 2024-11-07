Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B0212EF0;
	Thu,  7 Nov 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991164; cv=none; b=ovwqj3Z/71Dg99ThZZbf8il0mYUgj5lecYbJ5vlG2uIrxFd8amDoXSmW8LFlr8Dxf//I8TeT7gnAu8ZJw+Em7uC1AxWEfT3Cjg+7bmqqQBhhdRk2JLIo2zi/hD1ajPW1H1wrgg9TEU+nbSnQvVGDAkhMexX+hisWdwU/JftQ7y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991164; c=relaxed/simple;
	bh=S3f5Wa2BEYIJpOYrj4xkQRdAC5fv4qqAL3qZ1pqT/cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwIiQkv8hPc0DsOcYtRZE9A3A58gL716ur+la7xncp2xQRD+MMixYb0F7lxasPXhAxxHd76XN3Mz+XBP4chMLeNC9/zMZrIGfGGWaCrk39DfwQf74tyhEv04r86/XQp9Jp7MuZaQ//1GUk/v0VtxeS7HbBL/zNnmDwld7QMhT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL4qUNJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL4qUNJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FDEC4CECC;
	Thu,  7 Nov 2024 14:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991164;
	bh=S3f5Wa2BEYIJpOYrj4xkQRdAC5fv4qqAL3qZ1pqT/cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cL4qUNJ6ggDmh29MS7eR5CaG553gnBInVDfTlxp0GiqAbum/TMY7hDyImoMj5GS/r
	 weI8+0zlknS4S5s5bHyrQhLNmAFKPhhgfQtAPhL73k+3n0YdITizx3IvLZo6sjGsx6
	 701HGpAcWIV1iDzh9Fkqh8gFx/f8N00qYuOs+ES76SDHFnJOfOk2evmGsY8LmkcZm0
	 bwZWiUFkih02llu558Z6SEoudUy/4sXBAoRPbBlTREW6+EsgbOjoB9jaPjSEu6qqp+
	 RK/5XR3dx1P8xPQEQLo1pniELyoN1nXK3aIrMLuu3xqgIP60p3bEcaZrG2ldpNgZ8I
	 t4wdkeqD2+HEw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] perf: Add strpbrk_esq() and strdup_esq() for escape and quote
Date: Thu,  7 Nov 2024 23:52:40 +0900
Message-ID:  <173099116045.2431889.15772916605719019533.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To:  <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
References:  <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

strpbrk_esq() and strdup_esq() are new variants for strpbrk() and
strdup() which handles escaped characters and quoted strings.

- strpbrk_esq() searches specified set of characters but ignores the
  escaped characters and quoted strings.
  e.g. strpbrk_esq("'quote\d' \queue quiz", "qd") returns "quiz".

- strdup_esq() duplicates string but removes backslash and quotes which
  is used for quotation. It also keeps the string (including backslash)
  in the quoted part.
  e.g. strdup_esq("'quote\d' \queue quiz") returns "quote\d queue quiz".

The (single, double) quotes in the quoted part should be escaped by
backslash. In this case, strdup_esq() removes that backslash.
The same quotes must be paired. If you use double quotation, you need
to use the double quotation to close the quoted part.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Added new patch.
---
 tools/perf/util/string.c  |  100 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/string2.h |    2 +
 2 files changed, 102 insertions(+)

diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 116a642ad99d..308fc7ec88cc 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -263,6 +263,34 @@ char *strpbrk_esc(char *str, const char *stopset)
 	return ptr;
 }
 
+/* Like strpbrk_esc(), but not break if it is quoted with single/double quotes */
+char *strpbrk_esq(char *str, const char *stopset)
+{
+	char *_stopset = NULL;
+	char *ptr;
+	const char *squote = "'";
+	const char *dquote = "\"";
+
+	if (asprintf(&_stopset, "%s%c%c", stopset, *squote, *dquote) < 0)
+		return NULL;
+
+	do {
+		ptr = strpbrk_esc(str, _stopset);
+		if (!ptr)
+			break;
+		if (*ptr == *squote)
+			ptr = strpbrk_esc(ptr + 1, squote);
+		else if (*ptr == *dquote)
+			ptr = strpbrk_esc(ptr + 1, dquote);
+		else
+			break;
+		str = ptr + 1;
+	} while (ptr);
+
+	free(_stopset);
+	return ptr;
+}
+
 /* Like strdup, but do not copy a single backslash */
 char *strdup_esc(const char *str)
 {
@@ -293,6 +321,78 @@ char *strdup_esc(const char *str)
 	return ret;
 }
 
+/* Remove backslash right before quote and return next quote address. */
+static char *remove_consumed_esc(char *str, int len, int quote)
+{
+	char *ptr = str, *end = str + len;
+
+	while (*ptr != quote && ptr < end) {
+		if (*ptr == '\\' && *(ptr + 1) == quote) {
+			memmove(ptr, ptr + 1, end - (ptr + 1));
+			/* now *ptr is `quote`. */
+			end--;
+		}
+		ptr++;
+	}
+
+	return *ptr == quote ? ptr : NULL;
+}
+
+/*
+ * Like strdup_esc, but keep quoted string as it is (and single backslash
+ * before quote is removed). If there is no closed quote, return NULL.
+ */
+char *strdup_esq(const char *str)
+{
+	char *d, *ret;
+
+	/* If there is no quote, return normal strdup_esc() */
+	d = strpbrk_esc((char *)str, "\"'");
+	if (!d)
+		return strdup_esc(str);
+
+	ret = strdup(str);
+	if (!ret)
+		return NULL;
+
+	d = ret;
+	do {
+		d = strpbrk(d, "\\\"\'");
+		if (!d)
+			break;
+
+		if (*d == '"' || *d == '\'') {
+			/* This is non-escaped quote */
+			int quote = *d;
+			int len = strlen(d + 1) + 1;
+
+			/*
+			 * Remove the start quote and remove consumed escape (backslash
+			 * before quote) and remove the end quote. If there is no end
+			 * quote, it is the input error.
+			 */
+			memmove(d, d + 1, len);
+			d = remove_consumed_esc(d, len, quote);
+			if (!d)
+				goto error;
+			memmove(d, d + 1, strlen(d + 1) + 1);
+		}
+		if (*d == '\\') {
+			memmove(d, d + 1, strlen(d + 1) + 1);
+			if (*d == '\\') {
+				/* double backslash -- keep the second one. */
+				d++;
+			}
+		}
+	} while (*d != '\0');
+
+	return ret;
+
+error:
+	free(ret);
+	return NULL;
+}
+
 unsigned int hex(char c)
 {
 	if (c >= '0' && c <= '9')
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 52cb8ba057c7..4c8bff47cfd3 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -37,6 +37,8 @@ char *asprintf__tp_filter_pids(size_t npids, pid_t *pids);
 
 char *strpbrk_esc(char *str, const char *stopset);
 char *strdup_esc(const char *str);
+char *strpbrk_esq(char *str, const char *stopset);
+char *strdup_esq(const char *str);
 
 unsigned int hex(char c);
 char *strreplace_chars(char needle, const char *haystack, const char *replace);

