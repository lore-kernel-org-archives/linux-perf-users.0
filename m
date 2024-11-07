Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A9212EF7;
	Thu,  7 Nov 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991146; cv=none; b=WZ2449U54SCIOn7lc3tFmxTKYU74C1C/5CL10Pghxcgk1LUtok+EIYqKWuO7tw2li9fcRFWSSLIcM8I/pZsvNcxMgJJn/A6g0KdsGJckAhx2jTfYDogRds6ZDQeQi8MhiQoQw5J/nlOusBZKJf3+4JG67uYJyuZ0vgoBTtSxBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991146; c=relaxed/simple;
	bh=R1SFzj/BMW6nwC7W6jz7Tajr09BNZ4XHK+JOMxdxMUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=om1nSKD/ONav9dZPjfU95Z6Soo0q5Gji1I4/xWO/c2KQ6kS5Zhxgoam6akFZFgHNYzh6rhsodWh8UnCXk7vgk6sTtNhjwgmj0w2NREywckBtMIgUHFr8AnYH1XAkGKyQDMZJ9+QZYe5rD0IvAu3FGt9+y6SwmUKdeJ7K9SKcwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSq0+A1z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSq0+A1z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DC5C4CECC;
	Thu,  7 Nov 2024 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991146;
	bh=R1SFzj/BMW6nwC7W6jz7Tajr09BNZ4XHK+JOMxdxMUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSq0+A1zFKKET+q9tjS3hyGD/TS7X67ZaeJJMZADclmN8Bpanh2fmlzTfAaa9ZGpd
	 KITxN7wANokZwM8ATyQyUpUW/1fHEyq9ixzMPUY1/sccTCOCAZhBGT9qlf2zZQ7vlk
	 QmU+RBsDZZifzTMJjgAxChLO6mZo/Bgsa6DrMHv7or77nvld2BSYiec4hVIuLYgm/t
	 SlSmbGxI/Hgiu07KVDyhEbaNuXp6AAP6bt4j0chGqWG3XIcXN5eRYTumNS0NkjZTel
	 fNSCX5bDbNFnSoBaNmAknCobYVHE/bgJMUl0ZRhFoYi/Ky//rIjceLnxB5XeSjakdU
	 wY2hSuviHnW+Q==
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
Subject: [PATCH v2 2/6] perf-probe: Fix to ignore escaped characters in --lines option
Date: Thu,  7 Nov 2024 23:52:22 +0900
Message-ID:  <173099114272.2431889.4820591557298941207.stgit@mhiramat.roam.corp.google.com>
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

Use strbprk_esc() and strdup_esc() to ignore escaped characters in
--lines option. This has been done for other options, but only --lines
option doesn't.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/probe-event.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6bfe7ead3681..edc205e4b0ee 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1369,7 +1369,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 	lr->start = 0;
 	lr->end = INT_MAX;
 
-	range = strchr(name, ':');
+	range = strpbrk_esc(name, ":");
 	if (range) {
 		*range++ = '\0';
 
@@ -1410,7 +1410,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 		}
 	}
 
-	file = strchr(name, '@');
+	file = strpbrk_esc(name, "@");
 	if (file) {
 		*file = '\0';
 		lr->file = strdup(++file);
@@ -1419,7 +1419,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
 			goto err;
 		}
 		lr->function = name;
-	} else if (strchr(name, '/') || strchr(name, '.'))
+	} else if (strpbrk_esc(name, "/."))
 		lr->file = name;
 	else if (is_c_func_name(name))/* We reuse it for checking funcname */
 		lr->function = name;

