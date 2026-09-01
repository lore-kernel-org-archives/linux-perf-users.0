Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FA3839B8;
	Tue,  1 Sep 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272504; cv=none; b=hoAa+NLXPyVmNXV4Wr1X86+FcE0BLkcM/GGoITzAjMnc2nhjd6UuZUVwyQpCNR0l8iFS4AxYm7E8uQ+42VFZge1baAm0/To0VIot72YfQHmuJFWox9m0aNa3vXYmF421d1ey1FDAYRUHCqixUDHBPHp1DqOCS9XTxRArAnCcKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272504; c=relaxed/simple;
	bh=0VJbYk95hqb2RJMnHeFsM0o8Xpi+Qg3RyKqte29gyRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iqPUPODfTxiIZ+CoxKXOk19W/DPJbHzBYjS0w8A4uwhPxbe/g657v+/Wq2Bu3NLoAECMmfe/7RlOR5DbdkWMPhY02GEimDQpzy+Ggp1n7ywXa/yBe0e5ReYcnem6gA7v0KJLIfD1bwvxJ8/RG4kBXgc6n9BiFvDyY9mIujgaiaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbIG6yx0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbIG6yx0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BF71F000E9;
	Tue,  1 Sep 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272503;
	bh=nzdGXIZl7GaCZWCVfOEL58DKl2VbcTdF/XvyWbO/X5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RbIG6yx0xgUIQoyAXtfEMOkT3oEVhSC8EgLrbLfaW+M7O2fR4ZNyq+M9yjSQcj/Lc
	 Q6atV6NjeJ/WjcTmHiL0DtP7de1ZUqbpsv1EvRkb6D7YjQfPlXyR9YZa6YzOhCJ5It
	 ZeU1sG+vcLjhA7mjHRG4ni7Ez9+uCXkEIN/UBEC/Yhj4IizzUJUd/dSqzQm0AQr0X2
	 Zg0yym+WXxT5C62evyrbFrpE1A0ZLfNJFs++AHeQGY+uFuyuF+SuwNCtqOeX4QwoAP
	 jHVtqPbP0lpIZ8Co5BNbeqmRuzddPE11WgqSTCP1AHr3ey1Azwgxa3uIRMr8F9jTGe
	 QKPOaz+pLWK9w==
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
Subject: [PATCH v3 1/3] tracing/probes: Fix anon_stack check for unnamed bitfields in btf_find_struct_member
Date: Tue,  1 Sep 2026 23:21:37 +0900
Message-ID: <178827249775.123716.7813217688423513612.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178827248631.123716.2627172171811720261.stgit@devnote2>
References: <178827248631.123716.2627172171811720261.stgit@devnote2>
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
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260830143859.D56991F00A3D@smtp.kernel.org/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
---
 Changes in v2:
  - added tags.
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

