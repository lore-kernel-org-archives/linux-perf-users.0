Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E81A0BDE;
	Mon, 30 Sep 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727708; cv=none; b=S7ZzFFLOnPbsOZC810fE4Jdcn9yu/epRgvqxxBHkAMORNSDJtGaQhkOMB74SLdWVPOBdv0moX6eRU/aoNj6tvfDq/+0pNI4MSbL1ZLkS6jmROFoZc5YQAtR+j4I8N6Vl6ExG/x3ckNL7VxW83Vj3vcUMJC0FLkRtwhYiHg538jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727708; c=relaxed/simple;
	bh=qL+zDrPOeARyYptdCUBJLN6gmu7mt5g02CXoCsQWow4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdYq2/QJlbs+bOLY+XVxi2yEW8YsiXJe/X0y7KSXywuPnqx9cFsqhwFP4+KJzPjt0C9W5tGExOYz9K37SouhEcPrGLrP8JWSVso++jvweg+aUyHAQ/zmYFir0onqg2xcSc1iaYNebQEEEGrlXYUz6ECPXqPmjq0O1rNonjvsYRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msTFRaYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msTFRaYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D7C4CED1;
	Mon, 30 Sep 2024 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727727708;
	bh=qL+zDrPOeARyYptdCUBJLN6gmu7mt5g02CXoCsQWow4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msTFRaYpK4R5/3CsELEtq35fFehnOfXzLR2hYXtW00/F+PeIxunGSrF3C7x68Am7g
	 Dv/u8WTPHC/CtZoJb4azZpZdHuUsB6tG7p/F7UUO6BH7whqU1jlsX/n2jfANPE8IVo
	 gAhD+hGf199MNGmtt7+kacC4f6WGhsGmsKA/fFrDgjKpeAKi9kKPKphZc+3zpo19Xp
	 J8pIEBypGqZbJhomp8FVoy3OaGal6kw6NNKty7ucHuwA4dh3CEX5ORByeEp9os0q6s
	 IgeqvTbiLDZqW9K7p4yypffFfg1y3V2RkYwtw+D4KUjszlGVFOPZhc6gaGmLtI92RL
	 JjLPwJDLj+6mw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] tools check_headers.sh: Add check variant that excludes some hunks
Date: Mon, 30 Sep 2024 17:21:35 -0300
Message-ID: <20240930202136.16904-2-acme@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202136.16904-1-acme@kernel.org>
References: <20240930202136.16904-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With 6d74e1e371d43a7b ("tools/lib/list_sort: remove redundant code for
cond_resched handling") we end up with a multi-line variation in the
merge_final() implementation, one that the simple line based exceptions
we had so far can't cope.

Thus this check has been failing:

  Warning: Kernel ABI header differences:
    diff -u tools/lib/list_sort.c lib/list_sort.c

So add a new check routine that uses grep -vf to exclude some hunks that
we store in the tools/perf/check-header_ignore_hunks/ directory.

This first patch is just the new check routine, the next one will use it
to check lib/list_sort.c.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 714c78e5da07c163..55aba47e5aec9292 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -136,6 +136,30 @@ beauty_check () {
   check_2 "tools/perf/trace/beauty/$file" "$file" "$@"
 }
 
+check_ignore_some_hunks () {
+  orig_file="$1"
+  tools_file="tools/$orig_file"
+  hunks_to_ignore="tools/perf/check-header_ignore_hunks/$orig_file"
+
+  if [ ! -f "$hunks_to_ignore" ]; then
+    echo "$hunks_to_ignore not found. Skipping $orig_file check."
+    FAILURES+=(
+      "$tools_file $orig_file"
+    )
+    return
+  fi
+
+  cmd="diff -u \"$tools_file\" \"$orig_file\" | grep -vf \"$hunks_to_ignore\" | wc -l | grep -qw 0"
+
+  if [ -f "$orig_file" ] && ! eval "$cmd"
+  then
+    FAILURES+=(
+      "$tools_file $orig_file"
+    )
+  fi
+}
+
+
 # Check if we have the kernel headers (tools/perf/../../include), else
 # we're probably on a detached tarball, so no point in trying to check
 # differences.
-- 
2.46.0

