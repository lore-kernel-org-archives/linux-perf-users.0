Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F581BA275;
	Wed, 11 Sep 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085685; cv=none; b=Svb3L0bgJu1TbVjVgairFdKzp4d/wJVkKYnAE6/AIQYdoR8/qq1p+hKzlo0mFRjmnLz2OpO8ahMoTBuQl2fg45/u9uODKTtoEWrkXD3P5hBtUM+yW6jCc8FfZISU+AQbdd+TT8VpvGRb8y8LzimB/C1yJ/9+QxYqMjfImNsk0dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085685; c=relaxed/simple;
	bh=1wHqUFFiMad7Gas+MgBorKqaEVUuQRiUtgil0RdFmeI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eyGDzZtcQKEg60ZcJzw3e1GrD8XCaherKuUSIurNyR4mz3h69C15CR9Sp7eSHqa4sWoZ64w9Lwv44/+OnDCfeJm+gmDSmkihSX/mJZLm9jmLj95qSZw9XtmQWsY8wEmmd9MB2gx27k4666nDqGQwIn1vbBLJWu+yPTAiVG9f7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGxBeDRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGxBeDRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06088C4CEC0;
	Wed, 11 Sep 2024 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085685;
	bh=1wHqUFFiMad7Gas+MgBorKqaEVUuQRiUtgil0RdFmeI=;
	h=Date:From:To:Cc:Subject:From;
	b=BGxBeDRbwmygMO2Je+ZeCTdZUJiA0nBYQE52POglqJssa0MXINrcsmHki4+sHBnVf
	 Ix7UKOIFoBVRTBYaNrFqp3cLMRqXABNrDRWN0WUluo4/t9wX5cxHXpXu49tvjqetub
	 fUFpkAJTGAilTIYk5RMwM6dgSkWtG0b6avTctHUVR7ZWSIVS3sM6fbn1cYoUl/l/k9
	 0lDtHNiwDELgpzZk+C7L+zUvR0OCogk0rKizkw19ezwehs3G8hTbkvJ52L7tqb1LGi
	 uw0a6HaCHsTPdU4YpTSYwaZ5ac3px+dR3alBYUHSD+EEdghRmJ9k6oHl6esk4dOFkm
	 3B32yV5ow/pAQ==
Date: Wed, 11 Sep 2024 17:14:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Mark the 'head' arg in the set_robust_list
 syscall as coming from user space
Message-ID: <ZuH6MquMraBvODRp@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With that it uses the generic BTF based pretty printer:

This one we need to think about, not being acquainted with this syscall,
should we _traverse_ that list somehow? Would that be useful?

  root@number:~# perf trace -e set_robust_list sleep 1
       0.000 ( 0.004 ms): sleep/1206493 set_robust_list(head: (struct robust_list_head){.list = (struct robust_list){.next = (struct robust_list *)0x7f48a9a02a20,},.futex_offset = (long int)-32,}, len: 24) =
  root@number:~#

strace prints the default integer args:

  root@number:~# strace -e set_robust_list sleep 1
  set_robust_list(0x7efd99559a20, 24)     = 0
  +++ exited with 0 +++
  root@number:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 27084ae38bc480c9..f6e8475290739a10 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1351,6 +1351,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "sendto",
 	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
 		   [4] = SCA_SOCKADDR_FROM_USER(addr), }, },
+	{ .name	    = "set_robust_list",	    .errpid = true,
+	  .arg = { [0] = { .from_user = true /* head */, }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
 	{ .name	    = "setitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
-- 
2.46.0

