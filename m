Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D53212D31;
	Thu,  7 Nov 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991155; cv=none; b=dxSjhfEfADrZ4YyFOnosOYui8v8FuyuwWSVSKU257KpNJjLG3N2R8PB3dRRF/BMgmxN08wzGfx3phVqQCZuz4JtCs+5E7TN6RqxOnGNf8lZRcumbostJbtGOb/F48tXlXRVy7tM32NKOA5NKdUiGiiujOIT6+8wuz41kYlnRR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991155; c=relaxed/simple;
	bh=BvEaGbKvMA4VXey4QzVmBrEbnIqbTzoxmJ27zc63m2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Afk/M7zH2mq97YbnAT842VpWuK42atRX1cYzazLxDgiBa+mE5moQZHQAoVrNk0pXXb94eLjrFKQ+6ukHxPeH9CZ4GX4Glq7zqlOvPinYBzAlnXEpm5WLhS0DN+kyKxAybmf/zsS5rXtclvPUJchnz8lZXgUJUvmxPXP6g/6K7aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHqXc8TV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHqXc8TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E334C4CECC;
	Thu,  7 Nov 2024 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991155;
	bh=BvEaGbKvMA4VXey4QzVmBrEbnIqbTzoxmJ27zc63m2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHqXc8TVMXEgSTmI9AlU8fQfuotOEczC+pllvZXkaq6iM5z11L0g7Whb83b/gXknk
	 ywB+1mp4tGVwvO1juDqebbXBmUHiuP6bmVWUWKwtL2g6PlT7PZj/fZKoqQp10GnqYo
	 6NdPdXQlz3gBeXPphremfHbxKHd3z/ZdX0pJesgi+CFqvv6T4Bx7XPferSH1Mz8U6z
	 /VkPx44orrf42qcClvQ3DCSitB3wqtEzuRsIMOhMgLgjJw17srJcaSfPVSRsp7lIPG
	 EjgXrSWTjW1szNtlFjiLKznhvV7FHZQiVjch3deczDBghsp8w+ccUU2F8YYkNdx3ZF
	 ekya7H3HWTWDw==
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
Subject: [PATCH v2 3/6] perf-probe: Accept FUNC@* to specify function name explicitly
Date: Thu,  7 Nov 2024 23:52:31 +0900
Message-ID:  <173099115149.2431889.13682110856853358354.stgit@mhiramat.roam.corp.google.com>
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

In Golang, the function name will have the '.', and perf probe
misinterpret it is a file name. To mitigate this situation, introduce
`function@*` so that user can explicitly specify that is a function
name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Added new patch.
---
 tools/perf/util/probe-event.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index edc205e4b0ee..777ef00f0d3f 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1357,6 +1357,8 @@ static bool is_c_func_name(const char *name)
  *
  *         SRC[:SLN[+NUM|-ELN]]
  *         FNC[@SRC][:SLN[+NUM|-ELN]]
+ *
+ * FNC@SRC accepts `FNC@*` which forcibly specify FNC as function name.
  */
 int parse_line_range_desc(const char *arg, struct line_range *lr)
 {
@@ -1412,13 +1414,21 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 
 	file = strpbrk_esc(name, "@");
 	if (file) {
-		*file = '\0';
-		lr->file = strdup(++file);
-		if (lr->file == NULL) {
-			err = -ENOMEM;
+		*file++ = '\0';
+		if (strcmp(file, "*")) {
+			lr->file = strdup_esc(file);
+			if (lr->file == NULL) {
+				err = -ENOMEM;
+				goto err;
+			}
+		}
+		if (*name != '\0')
+			lr->function = name;
+		if (!lr->function && !lr->file) {
+			semantic_error("Only '@*' is not allowed.\n");
+			err = -EINVAL;
 			goto err;
 		}
-		lr->function = name;
 	} else if (strpbrk_esc(name, "/."))
 		lr->file = name;
 	else if (is_c_func_name(name))/* We reuse it for checking funcname */
@@ -1619,6 +1629,8 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
 				semantic_error("SRC@SRC is not allowed.\n");
 				return -EINVAL;
 			}
+			if (!strcmp(arg, "*"))
+				break;
 			pp->file = strdup_esc(arg);
 			if (pp->file == NULL)
 				return -ENOMEM;

