Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C930BF7D;
	Fri, 30 Jan 2026 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760750; cv=none; b=J/TzNJH490+GiwN+6JNDueD5s6a3I/uFdWqkL0M9W78PyyIwC+tNjzzOZLfflSYMUfCxLzbsMLsFlImGe5J4L6dWdefbz4k1N24umud5JISE7vZltIC38RlsPwGoVwAxWYIZr37V9P5sTzPEqqXGjwOlVe517Z1iCwzu2fVywKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760750; c=relaxed/simple;
	bh=Vhq+a2UVJKeuCAqKKXVd7GtYXPof3EWmspb1D3V//1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHIrkmY27fkJ/SkB9fDzm3kRUkBzHzF41pcwRACcTVjIqbt8FUNDA+JXPJ8BeJFIQk9pkI0huhih2fPdiiFoCTi5K3uyDv5+3ypSo2OcupveV9saXAjFqYELO96O9gN52uicjftCRr/h9TPOAI8Wm8tEcxbqQCf4g0sjY52479s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTKyvvTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTKyvvTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF0EC4CEF7;
	Fri, 30 Jan 2026 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769760750;
	bh=Vhq+a2UVJKeuCAqKKXVd7GtYXPof3EWmspb1D3V//1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTKyvvTStQs+1NCjS9AP20fDYDPtcAr73LlfgHoth7zXk1La6MVENzB4gIWJBapwP
	 jgzU1XCkmK42BYpg03zbhTPtHdGpMcElkjNHsy38NpWOVbItwY9O8cfuy/NTGoVZtK
	 Iv06o6fnqtnS8YSa0ruuA8OvX13ta1tFcH6u4zwLIVunjMH5svhAGQFqg+g9bRIaqW
	 hyfAUniUQ3iTQv9II/UeC1LqxuKzm004aUTqG5w7PX/8PXUZU4vIFJksIx9llRkIRo
	 YE+b2ClmftURhFYm04tEroeCFiHcs7ZLnAtyRx8l0MziiBhEWSub+7k6fhuo8LQpYE
	 qatUtRsSgh8gQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next 1/2] bpf: Allow sleepable programs to use tail calls
Date: Fri, 30 Jan 2026 09:12:07 +0100
Message-ID: <20260130081208.1130204-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130081208.1130204-1-jolsa@kernel.org>
References: <20260130081208.1130204-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing sleepable programs to use tail calls.

Making sure we can't mix sleepable and non-sleepable bpf programs
in tail call map (BPF_MAP_TYPE_PROG_ARRAY) and allowing it to be
used in sleepable programs.

Sleepable programs can be preempted and sleep which might bring
new source of race conditions, but both direct and indirect tail
calls should not be affected.

Direct tail calls work by patching direct jump to callee into bpf
caller program, so no problem there. We atomically switch from nop
to jump instruction.

Indirect tail call reads the callee from the map and then jumps to
it. The callee bpf program can't disappear (be released) from the
caller, because it is executed under rcu lock (rcu_read_lock_trace).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/core.c     | 4 +++-
 kernel/bpf/verifier.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5524f9429e76..3b0ceb759075 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -287,6 +287,7 @@ struct bpf_map_owner {
 	enum bpf_prog_type type;
 	bool jited;
 	bool xdp_has_frags;
+	bool sleepable;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
 	enum bpf_attach_type expected_attach_type;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e0b8a8a5aaa9..5ebece600aeb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2401,6 +2401,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->type  = prog_type;
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
+		map->owner->sleepable = fp->sleepable;
 		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
@@ -2412,7 +2413,8 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 	} else {
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
-		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		      map->owner->xdp_has_frags == aux->xdp_has_frags &&
+		      map->owner->sleepable == fp->sleepable;
 		if (ret &&
 		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
 		    map->owner->expected_attach_type != fp->expected_attach_type)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7ff8394e0da..f185ebc6748d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21386,6 +21386,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
 		case BPF_MAP_TYPE_INSN_ARRAY:
+		case BPF_MAP_TYPE_PROG_ARRAY:
 			break;
 		default:
 			verbose(env,
-- 
2.52.0

