Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC6212EF5;
	Thu,  7 Nov 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991173; cv=none; b=clM6jE+s+Jz7x6JtAozx8qBos3AA+kIoZbVkHsTu1fsG+7XU7LoMwdjfr16zNVPtm+m5hX/Qlo7XY88LsWHplyaZth0awwUocGVJfkGpEqyXLVAqbFZ9zIFyfsSXdH9z5MFFVwSO1iPPJhIOFKvaAIRvoMnJmKNpU5XD/+/TkA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991173; c=relaxed/simple;
	bh=KSH4WAzi4UEuFjxwQ20KJeJtd2CrJXRhr/o51tJNrLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpSGV1RqaEAapm3MoCHLhDogL4nYq7sOlU/mLZTfl60Po9gsEYrLcjdOmLedNLJPSoKFmLG/HwhDYsjD1Nxiq6WXFJWbuOc7Y6/H7ljjYs6ltgQbeGmctyw5JLxXuWBm8e3f7ON5CBDUGh7laRVhCrEym+QdTHqVGIgyhxlo6v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqT+4XAA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqT+4XAA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C80BC4CECC;
	Thu,  7 Nov 2024 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991172;
	bh=KSH4WAzi4UEuFjxwQ20KJeJtd2CrJXRhr/o51tJNrLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SqT+4XAAeduKqeKXvHV6YMVSAVOthWXEoLRmGcuJSYN5E4IB2JOqtfH3HoXCiOeQU
	 j//mKeNMPumQg1X2ko9lJroRUQinq8U/4Q47due2cpYEvPV5VXlD9wmKrIqlO8QrID
	 ZKFrjDj+5jJhJfdm7+j3DctITpmnNX8QZ1dMboOlSE+eg/Gc9OXzPBdXMxiU44trJw
	 yQIVtKt6imP5XFVQArPWeNqBUosn2crQw98zEieeembwtiCXSxxAbl28XVc1iDYBFo
	 L1qIGuL7yqebeUXhemOHhWYryUljGsmd+L0Non8A5OQF6jOwpA1DDCTTtvqZO8fSit
	 dMs+/KERYhuvw==
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
Subject: [PATCH v2 5/6] perf-probe: Introduce quotation marks support
Date: Thu,  7 Nov 2024 23:52:49 +0900
Message-ID:  <173099116941.2431889.11609129616090100386.stgit@mhiramat.roam.corp.google.com>
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

In non-C languages, it is possible to have ':' in the function names.
It is possible to escape it with backslashes, but if there are too many
backslashes, it is annoying.
This introduce quotation marks (`"` or `'`) support.

For example, without quotes, we have to pass it as below

$ perf probe -x cro3 -L "cro3\:\:cmd\:\:servo\:\:run_show"
<run_show@/work/cro3/src/cmd/servo.rs:0>
      0  fn run_show(args: &ArgsShow) -> Result<()> {
      1      let list = ServoList::discover()?;
      2      let s = list.find_by_serial(&args.servo)?;
      3      if args.json {
      4          println!("{s}");

With quotes, we can more naturally write the function name as below;

$ ./perf probe -x cro3 -L \"cro3::cmd::servo::run_show\"
<run_show@/work/cro3/src/cmd/servo.rs:0>
      0  fn run_show(args: &ArgsShow) -> Result<()> {
      1      let list = ServoList::discover()?;
      2      let s = list.find_by_serial(&args.servo)?;
      3      if args.json {
      4          println!("{s}");

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - split str*_esq() functions from this patch.
  - update for the changes in previous patches.
---
 tools/perf/util/probe-event.c |   75 ++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 777ef00f0d3f..31e257c84cd1 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1076,6 +1076,7 @@ static int __show_line_range(struct line_range *lr, const char *module,
 
 	ret = debuginfo__find_line_range(dinfo, lr);
 	if (!ret) {	/* Not found, retry with an alternative */
+		pr_debug2("Failed to find line range in debuginfo. Fallback to alternative\n");
 		ret = get_alternative_line_range(dinfo, lr, module, user);
 		if (!ret)
 			ret = debuginfo__find_line_range(dinfo, lr);
@@ -1359,30 +1360,37 @@ static bool is_c_func_name(const char *name)
  *         FNC[@SRC][:SLN[+NUM|-ELN]]
  *
  * FNC@SRC accepts `FNC@*` which forcibly specify FNC as function name.
+ * SRC and FUNC can be quoted by double/single quotes.
  */
 int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
-	char *range, *file, *name = strdup(arg);
+	char *buf = strdup(arg);
+	char *p;
 	int err;
 
-	if (!name)
+	if (!buf)
 		return -ENOMEM;
 
 	lr->start = 0;
 	lr->end = INT_MAX;
 
-	range = strpbrk_esc(name, ":");
-	if (range) {
-		*range++ = '\0';
+	p = strpbrk_esq(buf, ":");
+	if (p) {
+		if (p == buf) {
+			semantic_error("No file/function name in '%s'.\n", p);
+			err = -EINVAL;
+			goto err;
+		}
+		*(p++) = '\0';
 
-		err = parse_line_num(&range, &lr->start, "start line");
+		err = parse_line_num(&p, &lr->start, "start line");
 		if (err)
 			goto err;
 
-		if (*range == '+' || *range == '-') {
-			const char c = *range++;
+		if (*p == '+' || *p == '-') {
+			const char c = *(p++);
 
-			err = parse_line_num(&range, &lr->end, "end line");
+			err = parse_line_num(&p, &lr->end, "end line");
 			if (err)
 				goto err;
 
@@ -1406,42 +1414,41 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 				       " than end line.\n");
 			goto err;
 		}
-		if (*range != '\0') {
-			semantic_error("Tailing with invalid str '%s'.\n", range);
+		if (*p != '\0') {
+			semantic_error("Tailing with invalid str '%s'.\n", p);
 			goto err;
 		}
 	}
 
-	file = strpbrk_esc(name, "@");
-	if (file) {
-		*file++ = '\0';
-		if (strcmp(file, "*")) {
-			lr->file = strdup_esc(file);
+	p = strpbrk_esq(buf, "@");
+	if (p) {
+		*p++ = '\0';
+		if (strcmp(p, "*")) {
+			lr->file = strdup_esq(p);
 			if (lr->file == NULL) {
 				err = -ENOMEM;
 				goto err;
 			}
 		}
-		if (*name != '\0')
-			lr->function = name;
+		if (*buf != '\0')
+			lr->function = strdup_esq(buf);
 		if (!lr->function && !lr->file) {
 			semantic_error("Only '@*' is not allowed.\n");
 			err = -EINVAL;
 			goto err;
 		}
-	} else if (strpbrk_esc(name, "/."))
-		lr->file = name;
-	else if (is_c_func_name(name))/* We reuse it for checking funcname */
-		lr->function = name;
+	} else if (strpbrk_esq(buf, "/."))
+		lr->file = strdup_esq(buf);
+	else if (is_c_func_name(buf))/* We reuse it for checking funcname */
+		lr->function = strdup_esq(buf);
 	else {	/* Invalid name */
-		semantic_error("'%s' is not a valid function name.\n", name);
+		semantic_error("'%s' is not a valid function name.\n", buf);
 		err = -EINVAL;
 		goto err;
 	}
 
-	return 0;
 err:
-	free(name);
+	free(buf);
 	return err;
 }
 
@@ -1449,19 +1456,19 @@ static int parse_perf_probe_event_name(char **arg, struct perf_probe_event *pev)
 {
 	char *ptr;
 
-	ptr = strpbrk_esc(*arg, ":");
+	ptr = strpbrk_esq(*arg, ":");
 	if (ptr) {
 		*ptr = '\0';
 		if (!pev->sdt && !is_c_func_name(*arg))
 			goto ng_name;
-		pev->group = strdup_esc(*arg);
+		pev->group = strdup_esq(*arg);
 		if (!pev->group)
 			return -ENOMEM;
 		*arg = ptr + 1;
 	} else
 		pev->group = NULL;
 
-	pev->event = strdup_esc(*arg);
+	pev->event = strdup_esq(*arg);
 	if (pev->event == NULL)
 		return -ENOMEM;
 
@@ -1500,7 +1507,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 			arg++;
 	}
 
-	ptr = strpbrk_esc(arg, ";=@+%");
+	ptr = strpbrk_esq(arg, ";=@+%");
 	if (pev->sdt) {
 		if (ptr) {
 			if (*ptr != '@') {
@@ -1514,7 +1521,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 				pev->target = build_id_cache__origname(tmp);
 				free(tmp);
 			} else
-				pev->target = strdup_esc(ptr + 1);
+				pev->target = strdup_esq(ptr + 1);
 			if (!pev->target)
 				return -ENOMEM;
 			*ptr = '\0';
@@ -1555,7 +1562,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 			file_spec = true;
 	}
 
-	ptr = strpbrk_esc(arg, ";:+@%");
+	ptr = strpbrk_esq(arg, ";:+@%");
 	if (ptr) {
 		nc = *ptr;
 		*ptr++ = '\0';
@@ -1564,7 +1571,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 	if (arg[0] == '\0')
 		tmp = NULL;
 	else {
-		tmp = strdup_esc(arg);
+		tmp = strdup_esq(arg);
 		if (tmp == NULL)
 			return -ENOMEM;
 	}
@@ -1602,7 +1609,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 				return -ENOMEM;
 			break;
 		}
-		ptr = strpbrk_esc(arg, ";:+@%");
+		ptr = strpbrk_esq(arg, ";:+@%");
 		if (ptr) {
 			nc = *ptr;
 			*ptr++ = '\0';
@@ -1631,7 +1638,7 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 			}
 			if (!strcmp(arg, "*"))
 				break;
-			pp->file = strdup_esc(arg);
+			pp->file = strdup_esq(arg);
 			if (pp->file == NULL)
 				return -ENOMEM;
 			break;

