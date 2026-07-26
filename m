Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F637A839;
	Sun, 26 Jul 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109240; cv=none; b=WrO7Fwdt+1fLZvD1iS3SRx4QDjM2j1kzvlxaQ2I3XyTVEa/7m2tv6adNrWVH6Ja59eQczb71gA9u1F1UjgiAU+ct9AiEmbpD5Yyg+J8iKlTDyfyizOaoYtAItv4wALzxuGJUMSE1a8vBSp1e3r4QMp3TmPwRxqXtqdPYDlRYyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109240; c=relaxed/simple;
	bh=lbyJsiQJGx4me0u+KZsKLexHGCnAwuHi3BZFnn+/y2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovSe+gZLZS5RAOJsSQz0wRHsB/Zl3jCROGUYPzImjGTM1hmfUOv8ggiBxJAljcm4OP14RAiHfG+46qVgdVq07bI18e6zrNLewbSKMrXL5ofv/p3v71ftrBRx/LBT+CrbVn4YlultiLhMq8fiXq5fV9jWpg0OqZznsqEPPGqthyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0oWRyQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0oWRyQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E311F000E9;
	Sun, 26 Jul 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109239;
	bh=DCUV+6Q8/lKkSU+cwx/yfOl4ZDL0agOPyBwzyHEvM2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0oWRyQKRlHg91/Dy0rTchkwS9M+XSozv3I0pMyKSocR9AiwhrTnK2fEHe35QZuue
	 voWFLMAbzs0UbgIrW7p/HSyr8Zi87dOhk4Zi3907RmD3ApInOB+GMm6SnMwG2SzJlF
	 44MS55hCdmnTNgCRy01kgWd+ZkjN6vf6LpUMsvdQPd7yMntV4PRcF0EQhaJQedhbGn
	 5UvyXm6Tu7XQ++jJCioZ9UXdySLI1b32y7Em2BB3USYm9ydfRWr99LTyYNSTqsHzRG
	 dJ/xaPnZPs5JjzH4XSpMTJVy9v2mdIjQXdqJaYbokVqg4glWlW4HXGb/zx/zOcalj0
	 G7H758q9/w+yA==
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
Subject: [PATCH 6/8] perf machine: Reset errno before strtol in guest kernel map creation
Date: Sun, 26 Jul 2026 20:40:12 -0300
Message-ID: <20260726234014.63111-7-acme@kernel.org>
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

machines__create_guest_kernel_maps() checks errno == ERANGE after
strtol() to detect overflow, but does not clear errno first.  A stale
ERANGE from an earlier library call (e.g. scandir internals) causes
valid numeric directory names to be incorrectly skipped.

Set errno = 0 before strtol() so only the current conversion can
trigger the ERANGE check.

Fixes: a1645ce12adb ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 83d38637afe34fc9..1700130adedb3a89 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1258,6 +1258,7 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 				/* Filter out . and .. */
 				continue;
 			}
+			errno = 0;
 			pid = (pid_t)strtol(namelist[i]->d_name, &endp, 10);
 			if ((*endp != '\0') ||
 			    (endp == namelist[i]->d_name) ||
-- 
2.55.0

