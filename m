Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1F6EB7C;
	Fri,  6 Sep 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652231; cv=none; b=hpDebYqHSzE3Ezg6enRYgVK0gFUd45dCbGCujNqNUYks4fFlWyInc3ZidUEXojiBipv5huLko7W6JmRWKRybnvtc82gLhW95zwCYOIZEhl3U3pSBRQzUn+0lQcMkhgUas5ZfqVOs6OEHdkv4jpwo+AfiEhA9gfC72FYUpkwwtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652231; c=relaxed/simple;
	bh=RBOfFtIfaBzbZk1V1Wn7nJAMmGniCI6WDUhM9EGwzuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi7xwf/P2ddmuJ07ZcHA4G8LcEwYLHp/z1Cy+PhXdtrZ4GmTjLF6P1ZWzh1Kb+ZltDzjaozmNAk1+S0F7/kvNkYOd68YU7570TLxDG7ryDHI26vSonrlnifHxdKs+fmVp/i047XCV/kDwPw9GXzFtsEauS9ZoPi1wCIFPOtCDA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCaGpExI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCaGpExI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D80C4CEC7;
	Fri,  6 Sep 2024 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725652231;
	bh=RBOfFtIfaBzbZk1V1Wn7nJAMmGniCI6WDUhM9EGwzuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCaGpExIluIecU8/BLryuZIDkx1qP3Ac7oaspBFM9FmjeiAZ020wQDHGpsQF4RDdx
	 wOlFWAbOqsIfnXCfrQm1yzPGLccfjj50jjxrOj3a8iG7WHSPzfMwRLNd2ofBWrlpqZ
	 ib+hNXGNW/jzIbRHekPeXFmz5SH/aVTJN+YJ/w2rX7Kzp4gzjMZ68kVFQtDJRS8MZA
	 l/1AIq4KmMGexBXxZ4ZhRgl7GRJc8WJLmrMw0w35/bfrY26vcOFwsrlPC4IKAHvv5G
	 3fvVwIgMoUNysRk/SH0cTaGVbCFOL27zwpGxaDo4aYjWQ6aIX8PmuieMj+Q7viRAnB
	 SpQhmx4ZzA+GA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Howard Chu <howardchu95@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 1/2] perf trace augmented_syscalls.bpf: Move the renameat augmenter to renameat2, temporarily
Date: Fri,  6 Sep 2024 16:50:19 -0300
Message-ID: <20240906195020.481841-2-acme@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906195020.481841-1-acme@kernel.org>
References: <20240906195020.481841-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While trying to shape Howard Chu's generic BPF augmenter transition into
the codebase I got stuck with the renameat2 syscall.

Until I noticed that the attempt at reusing augmenters were making it
use the 'openat' syscall augmenter, that collect just one string syscall
arg, for the 'renameat2' syscall, that takes two strings.

So, for the moment, just to help in this transition period, since
'renameat2' is what is used these days in the 'mv' utility, just make
the BPF collector be associated with the more widely used syscall,
hopefully the transition to Howard's generic BPF augmenter will cure
this, so get this out of the way for now!

So now we still have that odd "reuse", but for something we're not
testing so won't get in the way anymore:

  root@number:~# rm -f 987654 ; touch 123456 ; perf trace -vv -e rename* mv 123456 987654 |& grep renameat
  Reusing "openat" BPF sys_enter augmenter for "renameat"
       0.000 ( 0.079 ms): mv/1158612 renameat2(olddfd: CWD, oldname: "123456", newdfd: CWD, newname: "987654", flags: NOREPLACE) = 0
  root@number:~#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 0acbd74e8c760956..0f9bd2690d4e5295 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -260,8 +260,8 @@ int sys_enter_rename(struct syscall_enter_args *args)
 	return augmented__output(args, augmented_args, len);
 }
 
-SEC("tp/syscalls/sys_enter_renameat")
-int sys_enter_renameat(struct syscall_enter_args *args)
+SEC("tp/syscalls/sys_enter_renameat2")
+int sys_enter_renameat2(struct syscall_enter_args *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
-- 
2.46.0

