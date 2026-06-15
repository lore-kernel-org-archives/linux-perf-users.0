Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230703B7747;
	Mon, 15 Jun 2026 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562786; cv=none; b=u5kEUme/Mp+txuo9BNAcS1Dfa+jh76aJlUFSUIeXPN4gihwxy5JGChsMScUju/bGzMkL5TSkxnQUm9ZyA5iyxeNEjPWS0rcoUx7mV4T2khWrrejyRBWz9B4y5qXifZXxHbIYcqlc6bO9GMUXUUvhvjqNKx5VYK9WVPm0MAlVbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562786; c=relaxed/simple;
	bh=D+951BMiZerWJJkB10MWC9Wo471exaC4XfeTCGrDx+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3vOQzDCnxfqzdIvzYSxibQM+uC1qgfK4g3xUvjUdzJa6yrWR5d7IhvhEUtTsRlQDv3CdihCPpwlEviP3egIedFDf4H8ujzuiSHvuuPlliPdk4uF+mbjo4vnkU7ifACyT96YESqPrtimrPhm9UF9NE+RwVvN1/HjHsXVNt0EWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNaxaN8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNaxaN8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5D1F000E9;
	Mon, 15 Jun 2026 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562784;
	bh=AXqFVgFdeOvbBMGAhAKr3rkSEfSBR1qgR6jCIPrYcRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNaxaN8NHrg3JDfGSsEYSYVBwETtfkEwVF+ggnv5Tc6T3WjibG4eHR5lUepAQkMMe
	 xe5OhApPnJk367aa7VzFFk+2QJVmI4NR0ZryzVb1/c2mIjJi9lgmrEOe+swNBRh4q3
	 SHE+JawTXC1NaXXAURtWX0mdAEf1iTHplQElD1oUDKBs8tZVjRWU2tBO6ZCeEe5n+c
	 gkbNKF9+Ld7lCK0W4SKr4N9N+2+dh8PD/qG5G+VfGygXfGrVTvrNeEYx+zjg44u9is
	 St1ktAo6QBHT5wKDkzU12jOEVQyBBO3fBaBIEFI4UiLwlr/UHu1Zu9aDC5+OmUA/+g
	 1nqwCGa6pYYlQ==
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
	"Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 2/9] perf machine: Use snprintf() for guestmount path construction
Date: Mon, 15 Jun 2026 19:32:42 -0300
Message-ID: <20260615223249.36598-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615223249.36598-1-acme@kernel.org>
References: <20260615223249.36598-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machines__findnew(), machines__create_guest_kernel_maps(), and
get_kernel_version() use sprintf() to build paths by prepending
symbol_conf.guestmount or root_dir.  All write into PATH_MAX stack
buffers, but guestmount comes from user configuration and is not
length-checked.  A guestmount path at or near PATH_MAX causes a
stack buffer overflow — and a truncated root_dir propagated to
get_kernel_version() would overflow its own version[PATH_MAX] buffer
when "/proc/version" is appended.

Switch to snprintf() with sizeof() to prevent overflow.  The
subsequent access()/fopen() calls will fail on a truncated path.

Fixes: a1645ce12adb6c9c ("perf: 'perf kvm' tool for monitoring guest performance from host")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Zhang, Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 9329d319bd033699..0d2ebf6a84bcf880 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -333,7 +333,7 @@ struct machine *machines__findnew(struct machines *machines, pid_t pid)
 	if ((pid != HOST_KERNEL_ID) &&
 	    (pid != DEFAULT_GUEST_KERNEL_ID) &&
 	    (symbol_conf.guestmount)) {
-		sprintf(path, "%s/%d", symbol_conf.guestmount, pid);
+		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);
 		if (access(path, R_OK)) {
 			static struct strlist *seen;
 
@@ -1260,9 +1260,9 @@ int machines__create_guest_kernel_maps(struct machines *machines)
 					 namelist[i]->d_name);
 				continue;
 			}
-			sprintf(path, "%s/%s/proc/kallsyms",
-				symbol_conf.guestmount,
-				namelist[i]->d_name);
+			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
+				 symbol_conf.guestmount,
+				 namelist[i]->d_name);
 			ret = access(path, R_OK);
 			if (ret) {
 				pr_debug("Can't access file %s\n", path);
-- 
2.54.0

