Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B53C0A05;
	Tue, 16 Jun 2026 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576850; cv=none; b=luA76JRS0uMOHsXQE9YKu/N2QI9lsB6ZK/Mn5lORIjgdIdv9kTC6VVFmN2an/cWUrOTafkARAyCgVYseHkvE9/GTffaivKbGXfsCuWx2kUAcGvxVfxy8RbBPy24shJGu4CPzy5e7Nw2KZI29OFeUxBvMHojV+L/Xma0D3Joy7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576850; c=relaxed/simple;
	bh=RVGBcO29wgKJ4yfBeZ2A2bjxMjP2UrpR7h5Kt/VICis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7meYE4k7KOjNy3LrnYCVxSX5FYLMJAP/wFCs34owGi6pypNTWxSFsypecuTqlPPDTp763BF0vHXVjxGUnaiLbzt82nTEJ3JMENkq7rUdMmpdTz1VHdvLcvKNHr71Umtub2g5p7wGZJditYMTulM/GWC59tJSeuE3wZYY+HwGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdT+23Y0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdT+23Y0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAA21F000E9;
	Tue, 16 Jun 2026 02:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576848;
	bh=/s1fLeEhbdKCUY+af/w62lZXukqf8aMeTrgtihW+DmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WdT+23Y0clAvYAcV1DIzrolwR/5v6l4Ix5OuZgjdetrqmwZsRx+6fQyIDZylRQN5a
	 H/62PrqOChfb+SYmWMgu7nra+g6g4HcCUchj6thLaDwGy7cIWrARZovvS/s01iNgHa
	 wydC0U3qkq3/NYbSfG/ODkkracxw5R8GYGi5Fy/O9qhztxQPxxHdnRVR5RZw/K6xzI
	 tuRNRP+5Xr2Q7po01i/aCWn4GhiVmHA3fKOATmDKO9GfU94Sm3IvgJN+hFKPFjGNNs
	 Vegb9mrqSBp5TlKXzAyKGDAtjq60rJX+x0hcI0GnWRBdvGteM7qxstG+ifPH6FPsi5
	 K7OJlRGnHq8Tg==
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
Date: Mon, 15 Jun 2026 23:27:08 -0300
Message-ID: <20260616022715.5739-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616022715.5739-1-acme@kernel.org>
References: <20260616022715.5739-1-acme@kernel.org>
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

