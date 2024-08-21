Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309A917D34D;
	Wed, 21 Aug 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282791; cv=none; b=N2+dr05gOBY+8h/UNbxtt6IZNJ2ynbqhiyU9m3wMqpSEQmnbCRupeG56qTrIoaKuWPjOQkKt11/Pq94kGVSlYXdK2ovZKfg2glvm/1ZxqG5v5wyLzPcALsu0dANJDJ1+/uj8jEdGw9Pox518q2Zlv9cvdS5hzsfwQHebQ7gxT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282791; c=relaxed/simple;
	bh=ZD3V5lXq0dOiGJvgR0GfD0Lbx8AsI7ZEokMA4pOyCHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDvpG5E7mK9b24fZipTdWYVPqLE0Bjp06rSqsQ1BPqVPcUZkzveLPEVhV9IIpzIepFQllEHpblZ9wKYwcJMwFkR0/iXtGfhJqh3S0VreKmLZy1Z787Orf6/miNRxjMn1QiP96VSMKC44LSw644IaNNAzPoBO+6Vt6aJqrQHWgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAVrUch2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAVrUch2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2ACC4AF14;
	Wed, 21 Aug 2024 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724282791;
	bh=ZD3V5lXq0dOiGJvgR0GfD0Lbx8AsI7ZEokMA4pOyCHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAVrUch2Fqsfz8I3jbRqpS8X+sVyMhOsJ+gNz4skgX9xQNR9U5QNr9MpB8dx2TM64
	 k/Du8Xja5mumKbFF27vjPmogCJmsI3fhgy5dG8HqBF3t49rZJZUQlxNsJQQS/Cjo2c
	 yCG2DGFbooURURIcvjJm4ySKiQImdstVPx0JGZYRIrjUJu2Jq4NnUvbGpOMeVT2BZP
	 3LEJHQs+PbDEBCpYml5zBIqK6QlTk+CVOfGpcthMm+BsOonQk4ieue17EKJhpcNmEN
	 CT6Xe2/9I98B6fG3B9v9YsNcK2QnS4BXsHBJYelnPELofIm9X7Yc+doxrzwyApGP45
	 gIj37G2YulwpQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 3/4] perf annotate-data: Update stack slot for the store
Date: Wed, 21 Aug 2024 16:26:27 -0700
Message-ID: <20240821232628.353177-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240821232628.353177-1-namhyung@kernel.org>
References: <20240821232628.353177-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When checking the match variable at the target instruction, it might not
have any information if it's a first write to a stack slot.  In this
case it could spill a register value into the stack so the type info is
in the source operand.

But currently it's hard to get the operand from the checking function.
Let's process the instruction and retry to get the type info from the
stack if there's no information already.

This is an example of __tcp_transmit_skb().  The instructions are

  <__tcp_transmit_skb>:
   0: nopl   0x0(%rax, %rax, 1)
   5: push   %rbp
   6: mov    %rsp, %rbp
   9: push   %r15
   b: push   %r14
   d: push   %r13
   f: push   %r12
  11: push   %rbx
  12: sub    $0x98, %rsp
  19: mov    %r8d, -0xa8(%rbp)
  ...

It cannot find any variable at -0xa8(%rbp) at this point.
  -----------------------------------------------------------
  find data type for -0xa8(reg6) at __tcp_transmit_skb+0x19
  CU for net/ipv4/tcp_output.c (die:0x817f543)
  frame base: cfa=0 fbreg=6
  scope: [1/1] (die:81aac3e)
  bb: [0 - 19]
  var [0] -0x98(stack) type='struct tcp_out_options' size=0x28 (die:0x81af3df)
  var [5] reg8 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg2 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg1 type='int' size=0x4 (die:0x818059e)
  var [5] reg4 type='struct sk_buff*' size=0x8 (die:0x8181360)
  var [5] reg5 type='struct sock*' size=0x8 (die:0x8181a0c)
  chk [19] reg6 offset=-0xa8 ok=0 kind=0 fbreg : no type information
  no type information

And it was able to find the type after processing the 'mov' instruction.
  -----------------------------------------------------------
  find data type for -0xa8(reg6) at __tcp_transmit_skb+0x19
  CU for net/ipv4/tcp_output.c (die:0x817f543)
  frame base: cfa=0 fbreg=6
  scope: [1/1] (die:81aac3e)
  bb: [0 - 19]
  var [0] -0x98(stack) type='struct tcp_out_options' size=0x28 (die:0x81af3df)
  var [5] reg8 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg2 type='unsigned int' size=0x4 (die:0x8180ed6)
  var [5] reg1 type='int' size=0x4 (die:0x818059e)
  var [5] reg4 type='struct sk_buff*' size=0x8 (die:0x8181360)
  var [5] reg5 type='struct sock*' size=0x8 (die:0x8181a0c)
  chk [19] reg6 offset=-0xa8 ok=0 kind=0 fbreg : retry                    <<<--- here
  mov [19] reg8 -> -0xa8(stack) type='unsigned int' size=0x4 (die:0x8180ed6)
  chk [19] reg6 offset=-0xa8 ok=0 kind=0 fbreg : Good!
  found by insn track: -0xa8(reg6) type-offset=0
  final result:  type='unsigned int' size=0x4 (die:0x8180ed6)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index cedfe6edcd45..b33089caccbc 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -955,19 +955,22 @@ static void setup_stack_canary(struct data_loc_info *dloc)
 static enum type_match_result check_matching_type(struct type_state *state,
 						  struct data_loc_info *dloc,
 						  Dwarf_Die *cu_die,
+						  struct disasm_line *dl,
 						  Dwarf_Die *type_die)
 {
 	Dwarf_Word size;
-	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
+	u32 insn_offset = dl->al.offset;
 	int reg = dloc->op->reg1;
 	int offset = dloc->op->offset;
 	const char *offset_sign = "";
+	bool retry = true;
 
 	if (offset < 0) {
 		offset = -offset;
 		offset_sign = "-";
 	}
 
+again:
 	pr_debug_dtp("chk [%x] reg%d offset=%s%#x ok=%d kind=%d ",
 		     insn_offset, reg, offset_sign, offset,
 		     state->regs[reg].ok, state->regs[reg].kind);
@@ -1079,8 +1082,17 @@ static enum type_match_result check_matching_type(struct type_state *state,
 		pr_debug_dtp("fbreg");
 
 		stack = find_stack_state(state, dloc->type_offset);
-		if (stack == NULL)
+		if (stack == NULL) {
+			if (retry) {
+				pr_debug_dtp(" : retry\n");
+				retry = false;
+
+				/* update type info it's the first store to the stack */
+				update_insn_state(state, dloc, cu_die, dl);
+				goto again;
+			}
 			return PERF_TMR_NO_TYPE;
+		}
 
 		if (stack->kind == TSR_KIND_CANARY) {
 			setup_stack_canary(dloc);
@@ -1111,8 +1123,17 @@ static enum type_match_result check_matching_type(struct type_state *state,
 			return PERF_TMR_NO_TYPE;
 
 		stack = find_stack_state(state, dloc->type_offset - fboff);
-		if (stack == NULL)
+		if (stack == NULL) {
+			if (retry) {
+				pr_debug_dtp(" : retry\n");
+				retry = false;
+
+				/* update type info it's the first store to the stack */
+				update_insn_state(state, dloc, cu_die, dl);
+				goto again;
+			}
 			return PERF_TMR_NO_TYPE;
+		}
 
 		if (stack->kind == TSR_KIND_CANARY) {
 			setup_stack_canary(dloc);
@@ -1202,7 +1223,7 @@ static enum type_match_result find_data_type_insn(struct data_loc_info *dloc,
 
 			if (this_ip == dloc->ip) {
 				ret = check_matching_type(&state, dloc,
-							  cu_die, type_die);
+							  cu_die, dl, type_die);
 				pr_debug_dtp(" : %s\n", match_result_str(ret));
 				goto out;
 			}
-- 
2.46.0.184.g6999bdac58-goog

