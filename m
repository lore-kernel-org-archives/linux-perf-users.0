Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC3358367;
	Mon, 15 Jun 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559433; cv=none; b=JGBsBXvL178s8ETVaM6mzlN+jlVXg3gMvFCncC6D5/e6fmyAePlE+mc/8swu4gHc5HilppbaF/QFgDCHObpFtMQ7sKhrVfW7BLrNONHlLC1G8Qqt1h+9ABXYXXl1ZGK02iP9GjHM8MTigeHNeWfRCmn3AmAdl/vk/XKD5CmkPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559433; c=relaxed/simple;
	bh=2gKseSF4cqPlZO4s6Gg3jNAhU2lz/g6pc58kaKDO0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mixdZ6vA/UHx6o+ZHqzzHijYD7JT6y6rzhLLdWInrvtmyXeuKCHma2U8JvDmvwo69N/o79Ci1PiTf9ZRCTmlspkAoKJ9Cs04VeMufpvp3m0dV6egnU15mOIf1lgsO9Pz6R74nWPZYOPfu9q81KPB8gJV6HkjSj/3WgJ0iJVfCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f791FrhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f791FrhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E126B1F000E9;
	Mon, 15 Jun 2026 21:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781559432;
	bh=7duyD0OYxB69I7KGQOFcyyHodAqqfDzYOr3MNZQgVpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f791FrhJjpz3RMBihY3QWmirHcsLOHg54TU11A1WLpj64QGNLPVXYsGmFDsJ3UBD+
	 JHx2rC4udRRsjQ+MRkiHvBx5vTiVnlnjW9sI2NC7EOXe9Yljzp7XEiwC+LU1kuRmZX
	 Bv9crr1JI6KpV05KrF52PIBzpBmBK86kJfKMspd5eNT7rTYras4FdCNS2AzqK+Iwv5
	 Pse70pL56IFy7GE6ftVNdq5jdUXUORIuLcNwgqEMD/PR6Q3edRWbyP1yv+XqHizkBJ
	 +7kDqhmEn/jeJ2nVUHOefVGF+Q+uwaK73RzarJIvKarPADRYc8CQYV6tayN+IRkiTO
	 MoJFKmumn8f0Q==
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
Date: Mon, 15 Jun 2026 18:36:50 -0300
Message-ID: <20260615213657.35776-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615213657.35776-1-acme@kernel.org>
References: <20260615213657.35776-1-acme@kernel.org>
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
index 7cf20ace3dbb5e55..fb960fda55f4f2ee 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -334,7 +334,7 @@ struct machine *machines__findnew(struct machines *machines, pid_t pid)
 	if ((pid != HOST_KERNEL_ID) &&
 	    (pid != DEFAULT_GUEST_KERNEL_ID) &&
 	    (symbol_conf.guestmount)) {
-		sprintf(path, "%s/%d", symbol_conf.guestmount, pid);
+		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);
 		if (access(path, R_OK)) {
 			static struct strlist *seen;
 
@@ -1261,9 +1261,9 @@ int machines__create_guest_kernel_maps(struct machines *machines)
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

