Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADD3ACA5B;
	Sun, 30 Aug 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100039; cv=none; b=AbrbSMcN+p+0nKExuDhyHLy7FHWQ/nDYkZ4j4nO4VzCUnoxPbuZ/ANC78IvKNCb7TCxT0ZNV6yFkgCDZDRi5hFZ9lN9G+sUB4u62hWZ+2p5xJILBHJk/M2Nvg6eA7vHy/unaviFcrU5du3d2CLWFenoamioeh3cTfeCVzpKk6P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100039; c=relaxed/simple;
	bh=ouE9AveMLlWzv7he3F5tT++ZlRtfK3KrkNhcLkulLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij4UqL5B2DWbPR71emo1I6CTrcaUHiJ19PZLiNJGY71N3V7/bB7lXoiFV5Y5J1hFmvbWTA72KEIYKG92/SvYm61oq0yD27pOA3Z6ynBRy06g7O3DIra6NVCp79Wd5vdRsuQv38fFTwdZLx04E18+JBVDIVVkRMqnJMn9lwzw6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKlRxB8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKlRxB8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F211F000E9;
	Sun, 30 Aug 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100038;
	bh=6Uw1979BY0tVfocwE8FbKM68uB9O85yQuz7r3bgNDRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DKlRxB8n6Csv46WinzO+GhzdeBTAVil0+axwrWfF0Xxb8oaKtmx9CAyHc2/ibFFn/
	 sKTtV52jUFbEFaD9WU+5GyPLgAQpTFD9o1D/FqZDUO56fhuglrWqqQ7gT0/V//0lgG
	 lXN9vE4sBtyTIjvcBH2c/oKzTFdbA9gr+OkR6KHkFiHoF1YEtAAUqPu0MCZf+Y9pLs
	 U3QvV1ftwReGNEmFMI/bgrZ/oZ54dd1knd+I14uq/LfcTI6WCkImIb7bV9XS3OV4Wu
	 ymnUON9gk2D0MjFTedlxusf5YzM9XyBgW94oF6/DMlCNE1J3oX3E7J1/+gxFcwXej3
	 YKnqZVr5iD7Og==
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
Subject: [PATCH v14 02/14] tracing/probes: Fix BTF kflag check for anonymous struct member access
Date: Sun, 30 Aug 2026 23:27:13 +0900
Message-ID: <178810003326.64882.5820404025124695636.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178810001186.64882.2161016469449127450.stgit@devnote2>
References: <178810001186.64882.2161016469449127450.stgit@devnote2>
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

btf_find_struct_member() traverses into nested anonymous structures and
unions to find a struct member. However, get_bitoffset_of_field() in
trace_probe.c checked btf_type_kflag(type) using the outer parent type
instead of the actual anonymous structure/union that directly contains
the found member.

If the parent structure and anonymous structure have mismatched kflags
(e.g., the parent has kflag=0 while the anonymous structure has kflag=1
because it contains bitfields), the bitfield size encoded in the upper
8 bits of member->offset is erroneously treated as part of the byte/bit
offset, corrupting the resolved offset and failing to set last_bitsize.
Similarly, btf_find_struct_member() pushed anonymous member offsets
onto anon_stack without masking BTF_MEMBER_BIT_OFFSET() when kflag is set.

To fix this problem, update btf_find_struct_member() to return actual
containing structure/union type via member_type, and use it for
btf_type_kflag() in get_bitoffset_of_field().

Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v14:
 - Newly added.
---
 kernel/trace/trace_btf.c   |   11 +++++++++--
 kernel/trace/trace_btf.h   |    3 ++-
 kernel/trace/trace_probe.c |   15 ++++++++-------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..7d93be2872ff 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -70,7 +70,8 @@ struct btf_anon_stack {
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
-						u32 *anon_offset)
+						u32 *anon_offset,
+						const struct btf_type **member_type)
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
@@ -91,17 +92,23 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	for_each_member(i, type, member) {
 		if (!member->name_off) {
 			/* Anonymous union/struct: push it for later use */
+			u32 m_off = btf_type_kflag(type) ?
+				BTF_MEMBER_BIT_OFFSET(member->offset) :
+				member->offset;
+
 			if (btf_type_skip_modifiers(btf, member->type, &tid) &&
 			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
 				anon_stack[top++].offset =
-					cur_offset + member->offset;
+					cur_offset + m_off;
 			}
 		} else {
 			name = btf_name_by_offset(btf, member->name_off);
 			if (name && !strcmp(member_name, name)) {
 				if (anon_offset)
 					*anon_offset = cur_offset;
+				if (member_type)
+					*member_type = type;
 				goto out;
 			}
 		}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6..4bd26bceae23 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -8,4 +8,5 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
-						u32 *anon_offset);
+						u32 *anon_offset,
+						const struct btf_type **member_type);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index c4163904ba74..908b4b6bc2df 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -625,6 +625,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 {
 	const struct btf_type *type = *ptype;
 	const struct btf_member *field;
+	const struct btf_type *mtype;
 	struct btf *btf = ctx_btf(ctx);
 	char *fieldname = *pfieldname;
 	int bitoffs = 0;
@@ -640,7 +641,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 
 		anon_offs = 0;
 		field = btf_find_struct_member(btf, type, fieldname,
-						&anon_offs);
+						&anon_offs, &mtype);
 		if (IS_ERR(field)) {
 			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
 			return PTR_ERR(field);
@@ -653,7 +654,7 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 		bitoffs += anon_offs;
 
 		/* Accumulate the bit-offsets of the dot-connected fields */
-		if (btf_type_kflag(type)) {
+		if (btf_type_kflag(mtype)) {
 			bitoffs += BTF_MEMBER_BIT_OFFSET(field->offset);
 			ctx->last_bitsize = BTF_MEMBER_BITFIELD_SIZE(field->offset);
 		} else {
@@ -661,11 +662,11 @@ static int get_bitoffset_of_field(char **pfieldname, const struct btf_type **pty
 			ctx->last_bitsize = 0;
 		}
 
-			type = btf_type_skip_modifiers(btf, field->type, NULL);
-			if (!type) {
-				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
-				return -EINVAL;
-			}
+		type = btf_type_skip_modifiers(btf, field->type, NULL);
+		if (!type) {
+			trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+			return -EINVAL;
+		}
 
 		if (next)
 			ctx->offset += next - fieldname;

