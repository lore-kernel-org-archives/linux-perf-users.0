Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FC2DC350;
	Mon, 31 Aug 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188772; cv=none; b=RliIYyxMoEcsxgruDOglyroZqQQ3m+2BhDG0qWv4ZT42MchAyiPJrFqA1VYs5MC1HqW1tkpiFrZ+USxQNXPhzpuMv+nw9nLihgBxTrl70JTarTW32IsU+oXa+R5zMJs+xYKMtuRQSYwYI5LJ2MxVAoIebm4LumDbemPGWqQUfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188772; c=relaxed/simple;
	bh=fdxL3/nrOfNKfBh5WixTsa1QP78CyHXEXKRDMHrhFyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NX24CqNv5HE2tYaejUBWjkmXF9A2BUjcvkqj0VMlVW4sbVjkisCbTspgLRNEtbLyg0uF7b73a3kEC0NsGOLq6ZIXvE63ywgkcwJu+i6WH9ZcJv1uVTH2vXQQuQkvQ0aTIw+dl7iols4es6iM8lonJ+IJq2gRXzOzaWB+ok3QkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEZdCdNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEZdCdNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2C1F000E9;
	Mon, 31 Aug 2026 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788188770;
	bh=kLPL7I20R8rtDA3Pf0Fn/tayK+z7L1PaWVETTPzhf/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NEZdCdNC+HjgR+zwFDjVw4xmBMyez86tDoHl3yd0ZQbcz6LybEz+4ET4kA78EBz7d
	 p6UUreyKNOMS/tTN6cvNOHY4z6j1k9n3R7HmfBX/cpnBV5/nfzosqNYNAFBYdy/t7g
	 igXt3UhgiCBIPv9wTWpEteyDAS23Gs6HaCVkHgFsxOLYO0Dt6F0Oda3pnXSemn4Rt3
	 wmch3Ur0yt3JRsGIyYHTIQFkB7gGlLXqKmuswC9mnwUIWorwkaE8e+4uZX2CWj56d6
	 Fq39ynBOZKTcAF+yl6MKmSwWBDWeBegsaoL5yOpJVkoAh5DT7Xy0CdYt/GAY9sAhQ9
	 WvYc+SGaWhxHg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
Date: Tue,  1 Sep 2026 00:06:05 +0900
Message-ID: <178818876548.104360.13229872396750615226.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178818875393.104360.1469039168635349344.stgit@devnote2>
References: <178818875393.104360.1469039168635349344.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

btf_find_struct_member() traverses into nested anonymous structures
and unions by pushing members with !member->name_off onto anon_stack.
However, it does not consider the unnamed bitfields (e.g. `int : 5`
or `unsigned int : 0`) which also have member->name_off == 0.

If such an unnamed bitfield is pushed to anon_stack, the
btf_find_struct_member() return an error even if there are other
valid entries in anon_stack.

To fix this, only push unnamed struct/union members to anon_stack.
Also move the btf_type_is_struct() check to the entry of this function
because now it is sure only struct/union are pushed to anon_stack.

Fixes: 302db0f5b3d8 ("tracing/probes: Add a function to search a member of a struct/union")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_btf.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..d3ba356d5503 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -74,24 +74,24 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
+	const struct btf_type *mtype;
 	u32 tid, cur_offset = 0;
 	const char *name;
 	int i, top = 0;
 
+	if (!btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
+
 	anon_stack = kzalloc_objs(*anon_stack, BTF_ANON_STACK_MAX);
 	if (!anon_stack)
 		return ERR_PTR(-ENOMEM);
 
 retry:
-	if (!btf_type_is_struct(type)) {
-		member = ERR_PTR(-EINVAL);
-		goto out;
-	}
-
 	for_each_member(i, type, member) {
 		if (!member->name_off) {
 			/* Anonymous union/struct: push it for later use */
-			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
+			mtype = btf_type_skip_modifiers(btf, member->type, &tid);
+			if (mtype && btf_type_is_struct(mtype) &&
 			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
 				anon_stack[top++].offset =

