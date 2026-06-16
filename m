Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49423655E0;
	Tue, 16 Jun 2026 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781638251; cv=none; b=Gu+Q5Bl0VVW3L5pT7z5xSNG1MBXNd6iIRJ8Z076LA8RxtIgTUZi764lQ5SQw8gLJt07RZTIjrZMnrze8VUtyA4NL+2GQrWZxM7PgBfgqbUfoEDhUYGbYDnF8/FdLUEGn8KACtk6IhK6RYNxGu7VX6MC40C4At1eWzTwg2PQTxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781638251; c=relaxed/simple;
	bh=RVGBcO29wgKJ4yfBeZ2A2bjxMjP2UrpR7h5Kt/VICis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL575QUJD4/lKAFB1Dbqp68AHCEd5T8dgOGD6OoPd7CXRsq9rnYf30F8EyL0/+Az8OEhQuhKwTkx/DDp1G3v2IXvIRM+NsP4piL3FAZiiTF69SNhEDCrskDcrzIspSobev1oQQ0hSCLkpnN6s1xWn9Lt5qW5lpg2u44m62kmcek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/UjFpgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/UjFpgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E051F000E9;
	Tue, 16 Jun 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781638250;
	bh=/s1fLeEhbdKCUY+af/w62lZXukqf8aMeTrgtihW+DmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/UjFpgvbWpNdz5Cca9MM53PCUtIxlViirNxPyq7/KfVRlGTli7GctF7I0iViwl+N
	 1VoDvtLw7qK/cmgeIfZ3z9nGjBIVPDD+RPDpDSEMNTOWldzPc2X+VAt4VH4AQxyHhG
	 eYjQiehDPeFhk9G4D8ujV78L2MDBKGwsmtQH6mE3PQKiASP023O9ghVbRka/9Laub1
	 a1JZu84zI5bRDDpvEf9Vnhp0kuxqtaCcKC2WBG0ov3mFxo/EDgnlK5X+JqZyQzhshR
	 bIc5I5ayqance/BV8BGOVqzzGPc2qTCmmogQr3wfx0QzzBzPcBHkgOpEQzS5aXsaaF
	 Tgbsz8VtI9PoQ==
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
Date: Tue, 16 Jun 2026 16:30:26 -0300
Message-ID: <20260616193033.10035-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616193033.10035-1-acme@kernel.org>
References: <20260616193033.10035-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machines__findnew() and machines__create_guest_kernel_maps() use
sprintf() to build paths by prepending symbol_conf.guestmount.
Both write into PATH_MAX stack buffers, but guestmount comes from
user configuration and is not length-checked.  A guestmount path
at or near PATH_MAX causes a stack buffer overflow.

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

