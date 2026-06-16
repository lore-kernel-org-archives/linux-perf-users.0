Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35731F98C;
	Tue, 16 Jun 2026 01:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572130; cv=none; b=KNY4mIYV5uwFwVlPbUtj9RWhFqnX0C42V2HReQGQMFm6yUNTO9sSCFL31809EGgWN+0gSFiWKFtVLwU86++QK+AlX4Fnm3/wXk5Pif6REbf537FCy66OxaSoqKf7l7x02/wk32PftIq7YWB2jbcJCtq4c+PWhm3z3X2DwcK8Pwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572130; c=relaxed/simple;
	bh=D+951BMiZerWJJkB10MWC9Wo471exaC4XfeTCGrDx+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K8NArJXAqAytn6/jsx3aqqiZA3xPmgIdMSMPVo2S+zUKEEtetc0vZOVmUA+yZsl0FAnaY9Nf5LMwjNQQOjkD1h0hJGwFGXUkAHGUtmdPKUkSSiwOKuN12A/DmSLrlDXjhGChA0Zhp4xgpnEWtmz6y0Xau71JME8rGQbCBFoCOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU6y3hc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU6y3hc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4CA1F000E9;
	Tue, 16 Jun 2026 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781572128;
	bh=AXqFVgFdeOvbBMGAhAKr3rkSEfSBR1qgR6jCIPrYcRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cU6y3hc+LUx0+OOcm5jLmwq8+AFyj+NXF1rLnUBzC9as2hgqXCiDp+c8thuPhX7Zf
	 LkbNDmR/fXYJQA5WVlWbYQL7FXFFLL19dBAKCmGeeoY0QP9dOqcRFK9EOQJ9ofN8My
	 npImrRhPNv9coxbCU3Y0xrPkh41zP9kXaUUPuCZKN4veZSyvT+lhna2P2HU+NOZzZl
	 S8tGhZzVdJO37JtUQ2KSaQUIvEcJBZqOkI58LLCIeG+RTaqjORy1hkddAuJ3CrKCDn
	 Q3p+O0WaGNZ1tfibHkdUhIsjM6mYvZg37KtG90cujmrXw5uAgk1gz+jtQm5KwC/d5p
	 4LwEYenxSwwFA==
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
Date: Mon, 15 Jun 2026 22:08:27 -0300
Message-ID: <20260616010834.37618-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616010834.37618-1-acme@kernel.org>
References: <20260616010834.37618-1-acme@kernel.org>
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

