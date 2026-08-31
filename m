Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAF351C344;
	Mon, 31 Aug 2026 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188831; cv=none; b=UQznydkOCDBplMiV7fp/MaTFGZpOZRb0eASGq8HEYzz3Od2Dz+TZtXtp1NInmXvPqjfaHJBiGv53fFSvjmpJYzJsilMz/XqVXbjeFIWeMrUVnjqwrCkpi7SLTsSwDUoKwXLj+rrJbLAiyMvJvQFcLxx+RZ6/zyHYgCCu0865Wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188831; c=relaxed/simple;
	bh=rgDuU0AxZCm/YmkzKNVYkCg5+1yHtRKo7oF/2daa9Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFztvZumxBUtCayi3Xb76ExhX1seIHGfsIoD4JEq5BGNkKSADwXB+0JyMFZzNUDsn4h7jkilGxttOBTBCwADkk5QjzjHYukOqE+speakynOUDSA4gU4V0Xd43ZKrrAfBwnBeFMtfZRcHuKL2E0VU7IgKzxGtXQzuTR/jWxT6BKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=firstfloor.org; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Received: from firstfloor.org (c-73-11-123-161.hsd1.or.comcast.net [73.11.123.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 3CA4D5F577;
	Mon, 31 Aug 2026 17:07:06 +0200 (CEST)
Received: by firstfloor.org (Postfix, from userid 1000)
	id ECFD3162259; Mon, 31 Aug 2026 08:07:02 -0700 (PDT)
From: Andi Kleen <ak@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	tglx@kernel.org,
	x86@kernel.org,
	jolsa@kernel.org,
	linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	Andi Kleen <ak@kernel.org>
Subject: [RFC v1 01/19] uprobes: guard trace cleanup against error pointers
Date: Mon, 31 Aug 2026 08:04:37 -0700
Message-ID: <20260831150651.1134594-2-ak@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831150651.1134594-1-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko pointed out the some of the scope cleanups for free_uprobe
could get an error pointer. Handle this case in free_uprobe
to prevent a crash.

On the other hand the macro doesn't need the guard because
free_uprobe itself already does the check.

Assisted-by: omp:gpt-5.6-luna sashiko
Signed-off-by: Andi Kleen <ak@kernel.org>
---
 kernel/trace/trace_uprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 861d857adadb..22cc3c8181b8 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -368,7 +368,7 @@ alloc_trace_uprobe(const char *group, const char *event, int nargs, bool is_ret)
 
 static void free_trace_uprobe(struct trace_uprobe *tu)
 {
-	if (!tu)
+	if (IS_ERR_OR_NULL(tu))
 		return;
 
 	path_put(&tu->path);
@@ -533,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	return ret;
 }
 
-DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
+DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, free_trace_uprobe(_T))
 
 /*
  * Argument syntax:
-- 
2.54.0

