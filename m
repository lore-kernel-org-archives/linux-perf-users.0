Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E848E37E5D9;
	Sun, 26 Jul 2026 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109247; cv=none; b=FMhCX4/bqJdFtHeTgshRoWauq/ylGiR5mYPEakS4GHsUV4CueQq6mfmiCpgIzItbF3w7dkJ4Vlq5Nt7Z2iDPdq9B8eVN3hk2WHn+4m9hdU/q8zsIq1x6kPPt+S43JwB6sNmF5w6qrwx01C/0yKArWpK4T5TQuPy9nvKsVirvJ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109247; c=relaxed/simple;
	bh=LAHtLektIKA8XpdBPQNUgnNs3KrlQSijNrias/e7bTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKHWDbL3a2R1aMbKTw68J6zncjNAO8HTTMyO2+0mIBHL9z9crGoK+bUHhydjTNiRXciEge7j57/R121Tfas+4mQxaBfY/LgOeCwYW2BKDzQSNGIJAUYzHdxNiY+XY35HmIuqAY9BvBccE2AaVf4RIZw1EXGUaXqqasbR/nQf0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLQ7Yg4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLQ7Yg4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32F91F000E9;
	Sun, 26 Jul 2026 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109245;
	bh=OrM5ln6FqFE9sB3lHmsKn1EcIM+CoGNOrcyTrZsiOKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLQ7Yg4ECcKEpZvEP3esDC8PdQ9ZdlDCUC8ZfRWcOompX+6gmT/HJLW+rncKFbwwe
	 6QwebpHX/nGqG2ge5khQa4Pdv045W84+Q/24H2MpGRpUkiqWfNhX3p5wYFr1Gd+f2i
	 jEFiKVIGx1WYOeiuBL5UfHrYsSFEyL5GGJbLQHm00Z2qo4VEZjZQFM9r6Qzue9on5l
	 iT0pHnNA2Ku+h0mUO27cSWxNlofStraqNT2sKH1KURvOj3cldoFCbJOj51EIAz7GeX
	 ukAUFVV+dIDczjABUCNTB1IsFC6mGzyT4ujGns3/SFdNQdedM87LHKYz/Qs/Kh58Th
	 Tuh+VFPgHQHrg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
Subject: [PATCH 8/8] perf machine: Check snprintf truncation for guest kallsyms path
Date: Sun, 26 Jul 2026 20:40:14 -0300
Message-ID: <20260726234014.63111-9-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machines__create_guest_kernel_maps() builds the guest kallsyms path
with snprintf() without checking the return value.  A truncated path
could pass the access() check if a prefix directory happens to contain
a file named "kallsyms", leading to the wrong file being used for
symbol resolution.

Check for truncation and skip the directory.

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 48c4b963e8097f4a..f86b3b7df742e0c1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1269,9 +1269,14 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 				free(namelist[i]);
 				continue;
 			}
-			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
-				 symbol_conf.guestmount,
-				 namelist[i]->d_name);
+			if (snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
+				     symbol_conf.guestmount,
+				     namelist[i]->d_name) >= (int)sizeof(path)) {
+				pr_debug("Guest kallsyms path too long for %s. Skipping.\n",
+					 namelist[i]->d_name);
+				free(namelist[i]);
+				continue;
+			}
 			if (access(path, R_OK)) {
 				pr_debug("Can't access file %s\n", path);
 				free(namelist[i]);
-- 
2.55.0

