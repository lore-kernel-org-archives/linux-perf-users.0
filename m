Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43B25A642;
	Wed, 18 Mar 2026 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858962; cv=none; b=r2JuZ2qpfHP39Agk6PPM6xPifPiZDeix1BNU/OXuRNxWTL8ADLfszMJMbEzPp6mLC5ypk1q2eYb+DicKVvRxDjAI/XKa7MKEMXc6yWLL1V0aV3YG5IXVfbZCIsc00BwV9xfOCCUUS+pscpZoXVoqfPSsDIa4lAp5C87zts8N6Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858962; c=relaxed/simple;
	bh=mccp+sFUj4Y5DYO32/dfBE70yAE0cK9YdPDuifH5nHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P5mZUNhj871en+cL1qFIo5EbHSS6gQd8ctx85GdU9LwxHGazyl0/b0Y/67BLroTOQgsgUgDeo2khLtx1+I7Thn/L2bOsdspSenCsrkmQ+Dcw4yb3+9UFT9KYTVCk01IuM6h+yvI3GSEC03KhnhYDih8ENl4ls+htUgLGZBBC2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqlOBC7H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqlOBC7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B925C19421;
	Wed, 18 Mar 2026 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773858962;
	bh=mccp+sFUj4Y5DYO32/dfBE70yAE0cK9YdPDuifH5nHc=;
	h=Date:From:To:Cc:Subject:From;
	b=mqlOBC7HqtrvvHdZqcxIMhM/LIlKs5kCH60vH2JVfvMu1pDF458Cx2kPjdZtD0Gal
	 2ClgPHifnyniZSsLmkQdg1BFmycWCzgYBiQ0lgp1C52wPopWp5bbJ73/E9pVOfB1e6
	 9fT7V2PMwPJEyKrkypa3gjxXWMuUP7zdN66S/7IR4LWj7ITun5WzxfUR+lrhZbvJzg
	 vQKvQGkWcwbW0fRtA+eTS1yFpEx5AywZxAIEy1h3KrCgJG6XCiIGuW3F/MardbFX+v
	 dXezppIm2Qq16vM6ke3RYf8FeXd7x3CUp/VPJmQy2e23+VPkzKUSFViCFlU04XuRBo
	 R7/13p/maz6Iw==
Date: Wed, 18 Mar 2026 15:35:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 fyi] tools headers: Syncronize linux/build_bug.h with the
 kernel sources
Message-ID: <abrwjt_R2X8r7Bbm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes in:

  6ffd853b0b10e1e2 ("build_bug.h: correct function parameters names in kernel-doc")

That just add some comments, addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/linux/build_bug.h include/linux/build_bug.h

Please take a look at tools/include/uapi/README for further info on this
synchronization process.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/build_bug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/build_bug.h b/include/linux/build_bug.h
index d3dc5dc5f916ff4e..2cfbb4c65c784ad8 100644
--- a/include/linux/build_bug.h
+++ b/include/linux/build_bug.h
@@ -32,8 +32,7 @@
 /**
  * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
  *		      error message.
- * @cond: the condition which the compiler should know is false.
- * @msg: build-time error message
+ * @condition: the condition which the compiler should know is false.
  *
  * See BUILD_BUG_ON for description.
  */
@@ -61,7 +60,6 @@
 
 /**
  * static_assert - check integer constant expression at build time
- * @expr: expression to be checked
  *
  * static_assert() is a wrapper for the C11 _Static_assert, with a
  * little macro magic to make the message optional (defaulting to the
-- 
2.53.0

