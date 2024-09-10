Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4E188CB1;
	Tue, 10 Sep 2024 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725976656; cv=none; b=s2uG3mCn1w67nRrZvkUlnXER21fXBRgucKmpsMd6OQWbnuoBNfF5VEesDR/bGc6KVA5tL/FK5NZt+hV+a11+kenXwZPTftH8flg5DOFlJXiodby6pQ8bYjzap9L4WXswnnPrCi4VEY8+ku98bWP/+aUY6gnSVY8Bv1zhybyQQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725976656; c=relaxed/simple;
	bh=CS/uR5x5srK92Ah1wOEfhxivT/NoUGUMmFiwz0aJ5bA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rUAJeEATtpqG3rlGKS1gMLncgJ9tHGJDp6CfgAxil9SZAGPDza80lOe4ncF9eVBrCisdH7L5JmfPTXxDqT7Zn74UQqIdX5UHYJ9vx2K0UmrUb3EQmMi53sGK2Nnk4/SDeJpKlvw+Ua/FBV2uX0O/QdhYuKShfPB7XhWx4UlWRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B808ukQh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B808ukQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2795FC4CEC3;
	Tue, 10 Sep 2024 13:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725976654;
	bh=CS/uR5x5srK92Ah1wOEfhxivT/NoUGUMmFiwz0aJ5bA=;
	h=Date:From:To:Cc:Subject:From;
	b=B808ukQhIx6IXbFhE//iVPHXKSAVUkG2cbPZcl89l3C/K6l6m05ibfO4x1+0Tz0rD
	 ZRGXvWXkl2Fhwc0qk+EgRsfUl12t76+hHO4Vsu3wo+px5nT9uGDAnLxXH5FhU2+jBP
	 P0tg1RazLNMbbO/u1X3eJt9O1EEI6y6r6w1F6lbnJYaxWognHrrjcEdlhN/77EZcj5
	 NpFL1gcobgr3CAI1UqgvhXI53wlEk7gS2IxQXOucLfWDpqY6dPVk1u1RshLjrn7WSO
	 7fhAKeHfInduvWaKe2EynLCNh5mwOKQTQ/I662ZVgQq8wHyTuuuGXAj6H7raVnd16q
	 62XNFagk4WOhA==
Date: Tue, 10 Sep 2024 10:57:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Mark the rlim arg in the prlimit64 and
 setrlimit syscalls as coming from user space
Message-ID: <ZuBQI-f8CGpuhIdH@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With that it uses the generic BTF based pretty printer:

  root@number:~# perf trace -e prlimit64
       0.000 ( 0.004 ms): :3417020/3417020 prlimit64(resource: NOFILE, old_rlim: 0x7fb8842fe3b0)      = 0
       0.126 ( 0.003 ms): Chroot Helper/3417022 prlimit64(resource: NOFILE, old_rlim: 0x7fb8842fdfd0) = 0
      12.557 ( 0.005 ms): firefox/3417020 prlimit64(resource: STACK, old_rlim: 0x7ffe9ade1b80)        = 0
      26.640 ( 0.006 ms): MainThread/3417020 prlimit64(resource: STACK, old_rlim: 0x7ffe9ade1780)     = 0
      27.553 ( 0.002 ms): Web Content/3417020 prlimit64(resource: AS, old_rlim: 0x7ffe9ade1660)       = 0
      29.405 ( 0.003 ms): Web Content/3417020 prlimit64(resource: NOFILE, old_rlim: 0x7ffe9ade0c80)   = 0
      30.471 ( 0.002 ms): Web Content/3417020 prlimit64(resource: RTTIME, old_rlim: 0x7ffe9ade1370)   = 0
      30.485 ( 0.001 ms): Web Content/3417020 prlimit64(resource: RTTIME, new_rlim: (struct rlimit64){.rlim_cur = (__u64)50000,.rlim_max = (__u64)200000,}) = 0
      31.779 ( 0.001 ms): Web Content/3417020 prlimit64(resource: STACK, old_rlim: 0x7ffe9ade1670)    = 0
  ^Croot@number:~#

Better than before, still needs improvements in the configurability of
the libbpf BTF dumper to get it to the strace output standard.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d28a56cc171b2b2e..83eb15b72333edd9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1309,7 +1309,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "pread", .alias = "pread64", },
 	{ .name	    = "preadv", .alias = "pread", },
 	{ .name	    = "prlimit64",
-	  .arg = { [1] = STRARRAY(resource, rlimit_resources), }, },
+	  .arg = { [1] = STRARRAY(resource, rlimit_resources),
+		   [2] = { .from_user = true /* new_rlim */, }, }, },
 	{ .name	    = "pwrite", .alias = "pwrite64", },
 	{ .name	    = "readlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
@@ -1352,7 +1353,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "setitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
 	{ .name	    = "setrlimit",
-	  .arg = { [0] = STRARRAY(resource, rlimit_resources), }, },
+	  .arg = { [0] = STRARRAY(resource, rlimit_resources),
+		   [1] = { .from_user = true /* rlim */, }, }, },
 	{ .name	    = "setsockopt",
 	  .arg = { [1] = STRARRAY(level, socket_level), }, },
 	{ .name	    = "socket",
-- 
2.46.0


----- End forwarded message -----
