Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E3255F57;
	Sun, 22 Mar 2026 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215404; cv=none; b=jprvQyVZID/wWy4BbtOj0GMU04ggVBAF6dN73JPYCKt2LK//CxDI69Tsauemnd+ZVmzWztpl/sAMOqI1tIkkV5mrJ87R1hlHD/2I/zJHIqf4Ku+LiN1vRgDvC6I8wAXsyIb7QoK/5oSZymrqnXmr0BHlap9baktKTZjVhTlf10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215404; c=relaxed/simple;
	bh=NQPTjGxhgcVx8uDbjD1P4wcD5MoIXaE3LMa5x57YS/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GqeBbWIpPWsREi7jH1pPtIJwL7IGsZ07XaMUwCVK4E0LJRrUwih36bko99W8NL7ojuPDBYqb+tje8MRNCmrfRZ1CLFxI0aLHznxD0e3/5ercmDfB2b5N83AEzAjXy0svBmKiS1LAsZ7ps5EvNKj1x0kaCjbzJIe1IClY0HXhkPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihBGdyFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihBGdyFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B9CC19424;
	Sun, 22 Mar 2026 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774215403;
	bh=NQPTjGxhgcVx8uDbjD1P4wcD5MoIXaE3LMa5x57YS/I=;
	h=Date:From:To:Cc:Subject:From;
	b=ihBGdyFhL2pfUXwRHjE+i3i/0ciJ7ZAFznk9+nQU4WuMqmcF9Meq0NmOdBfCqCCDx
	 8DF6LFeMKeGQ8BN+X1EK/GeXb3ojnf5r6iGK5upeubEzDlpwGCyiyPEnOpGAAPbirF
	 nDBCcXB4weis1DinWhIL0a6Xq5IDmeOzN261ADtG4IjTJZjsTxeLqelpy2EkRDG9Bc
	 7HREW4j3Q4UjdT3Gsck55xWk/CI3NqcBDm119LSSKsXhV5bj2ttdsWQa+CBButUxza
	 6J4aN0Ee+HvidytPgjZtDZeOkXT3Gv18jYAQiPFqbM8AfFs7HsZ67QbKA1Tl9YkmN4
	 WOqB5fCQqJ5tQ==
Date: Sun, 22 Mar 2026 18:36:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ian Rogers <irogers@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1 fyi v2] tools headers: Synchronize linux/build_bug.h with
 the kernel sources
Message-ID: <acBg6E0CNGNz8vFu@x1>
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
Cc: Ian Rogers <irogers@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---

v2: Fix summary typo and update the tools copy, not the original, as
spotted by Ian Rogers.

---
 tools/include/linux/build_bug.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/build_bug.h b/tools/include/linux/build_bug.h
index ab2aa97bd8ce441d..406923bd4846c37f 100644
--- a/tools/include/linux/build_bug.h
+++ b/tools/include/linux/build_bug.h
@@ -32,7 +32,8 @@
 /**
  * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
  *		      error message.
- * @condition: the condition which the compiler should know is false.
+ * @cond: the condition which the compiler should know is false.
+ * @msg: build-time error message
  *
  * See BUILD_BUG_ON for description.
  */
@@ -60,6 +61,7 @@
 
 /**
  * static_assert - check integer constant expression at build time
+ * @expr: expression to be checked
  *
  * static_assert() is a wrapper for the C11 _Static_assert, with a
  * little macro magic to make the message optional (defaulting to the
-- 
2.53.0

