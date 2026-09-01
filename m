Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684738D3FD;
	Tue,  1 Sep 2026 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272516; cv=none; b=eZptBCv0+YRbSpliCQRPi5dhhm3rO0V2GGHcf9GMf7UALG7fecOC14c5wp1AbyODEDsvMRLxkYVEPuWCMHTjgKljZTvHWcAW98k64yii0cP+/w5TVoLtFfDwZspGau9IIOHrqkTIjKE4NQIjKjazj44kL3RL+GT6D2wNC8ZJG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272516; c=relaxed/simple;
	bh=bcWdDeucekjH4dtjZhbljTqEFVKo/EJ3rtaOnEaeSi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSJq7nfcqlKFfS6mSkL0R6ajRlFq6u7sXKkEq4yp/F09G3mK7dC0xDbJ/u+JC2vxbRlGIxv5Lfo2r3lZYzt/oaHVOPl/BATM1fWdXZgNEsn+OBuvFSzsDmwzkPA5hLPFQdgriwr0cgGhQ+s3UX2yC06miz5YTECV3SDETCMaguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNFQu6Nh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNFQu6Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DAC1F000E9;
	Tue,  1 Sep 2026 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272514;
	bh=N1RSqeA8oOvxj7Rd5uHkQcz2LL1Drv5deATg5L0dJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNFQu6Nhsybjei7NcY/opgtj12UuxiPq5oyQO3hj2C3TavGsZEmyr1uzIF0kvc0UF
	 JTAfDEhhJ72hDZZQvhQj0nlelzIX04Ufad8SbaYL5e2NnCWWGmnish1sbYGchv43+c
	 Xt9XeGeFpzPdwFMNUBqaJFAZ2lwzlir32e9xXyKzE4O5DuxTBU8szllNqn2ay2k8yg
	 GTSvkx/EGwYUxy1ZVKTSUi3T9QTSATIQYHjPTTzP8MrlDnkGzBPXMX6wzD99EPrWMR
	 rbAg5FYIvzpjtdX3WpmqakpIlamMwu8fxAvVRWhxdQmxZHKOpSeckYDDs+C1vcLM4U
	 TnNc30Iuvkm/Q==
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
Subject: [PATCH v3 2/3] tracing/probes: Fix BTF kflag check for anonymous struct member access
Date: Tue,  1 Sep 2026 23:21:49 +0900
Message-ID: <178827250904.123716.17452648791331881284.stgit@devnote2>
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
containing structure/union type via member_type, use appropriate
__btf_member_bit_offset() to get bit offset, and use member_type for
btf_type_kflag() in get_bitoffset_of_field().

Fixes: c440adfbe302 ("tracing/probes: Support BTF based data structure field access")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260822095110.0772E1F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v3:
  - Remove indent cleanup part since that is a cleanup and no need
    to be backported.
 Changes in v2:
  - remove unneeded NULL initializer for mtype, it should be set if
    btf_find_struct_member() succeeds.
  - Add reported-by from Sashiko.
 This is separated from wprobe patch series v14.
 - https://lore.kernel.org/all/178810003326.64882.5820404025124695636.stgit@devnote2/
---
 kernel/trace/trace_btf.c   |   19 +++++++++++--------
 kernel/trace/trace_btf.h   |    3 ++-
 kernel/trace/trace_probe.c |    5 +++--
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index d3ba356d5503..ee7a04886bf6 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -61,16 +61,17 @@ struct btf_anon_stack {
 
 /*
  * Find a member of data structure/union by name and return it.
- * Return NULL if not found, or -EINVAL if parameter is invalid.
- * If the member is an member of anonymous union/structure, the offset
- * of that anonymous union/structure is stored into @anon_offset. Caller
- * can calculate the correct offset from the root data structure by
- * adding anon_offset to the member's offset.
+ * Return NULL if not found, or ERR_PTR(-EINVAL) if parameter is invalid.
+ * If the member is a member of an anonymous union/structure, the bit offset
+ * of that anonymous union/structure is stored into @anon_offset.
+ * If @member_type is non-NULL, the actual containing structure/union type
+ * of the found member is stored into @member_type.
  */
 const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
-						u32 *anon_offset)
+						u32 *anon_offset,
+						const struct btf_type **member_type)
 {
 	struct btf_anon_stack *anon_stack;
 	const struct btf_member *member;
@@ -94,14 +95,16 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 			if (mtype && btf_type_is_struct(mtype) &&
 			    top < BTF_ANON_STACK_MAX) {
 				anon_stack[top].tid = tid;
-				anon_stack[top++].offset =
-					cur_offset + member->offset;
+				anon_stack[top++].offset = cur_offset +
+					__btf_member_bit_offset(type, member);
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
index c4163904ba74..144e790077c6 100644
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

