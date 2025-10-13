Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20222D3749
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379384; cv=none; b=ctaaH8gQtrGKoqFT4g/R71CijRfkGb30OwOLZohalJ4U+DsW37+8RtZhoLQCtQLLZoiYTXqfW/2b+dm2ffOhIASkrsrdmNQtftrYgtNDurAMi9tPQGYsg2ZbKjUBvyVKUA/9+IfRsul98wbpQQJ0I2wJSCuWvEp0P7vuP7bgW14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379384; c=relaxed/simple;
	bh=TW2+el9yNuk9f/3nbdJrFQ3CeLiqhnujDCbN9J71ZbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KxjU1lEcGVDlYVmpx//FiKS8/Qbml4f7Bg4D5abXaSO7Zwss+jUUDh6Xl4GnZt3eYYWLC2/j0QlhJQFPbpl+1sfKuHhz0TzD0iq1/YGZ/3CM0bAq/fcJCfHig/MVKAST4Wq5HqnOyJpluXPtOQzAMz/I5vlGzZ6oL5Dj6LqBXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UaUWoCi; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UaUWoCi"
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-63807df7926so8542127d50.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760379381; x=1760984181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=htIExVjnWIYNSVX11cfBQU24Fufomr+QvCn5zD7R72g=;
        b=1UaUWoCi4Fy/Dkls13cIC2cTskV6XljXsPtkm/H7UKPDwfblLlqQKO4XYsbgjm2R/O
         jbciNxt52l/OcghwhAhhPD5x3ClUPllmu03CAt/yNjR1668wdDtk/bXOI1+r6IZ2Jt5C
         W8vt5/drmPg9WHIAg0BGTtmhlEoJQtNNx4xn0a+May0aKL+Xekd4zRMmyrk/pL1kikR5
         vxWihq/KLyFi8fSYThW567tGyo1Em6+lp5kwUNH7FhzGOkc6h4CtNCHtgpAxnRd9KNr5
         4bTYcjWUSOhcwQRPVnMelinEzHz7q8wPVP8t888nlwi2ff+W1Y/EJaLiOo+Bhccat89q
         jKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379381; x=1760984181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htIExVjnWIYNSVX11cfBQU24Fufomr+QvCn5zD7R72g=;
        b=L6vIafDeWwR+CqulbgCZBz7N3y7U8N3gZ6xEhHyUYr+1O5hXp6q/HO3yCC11wYdBQC
         L8p6nGMU/8qZPeKKOO1sK5ECgLjbT3ugMXBjI7WHy9gvEUof5scMTNsfrLo8MaZIqqAr
         q9tITCWmURUug12f1UDZa65UhKA/Rp2pZPsuu7Fk0r/EAUy4DRIRt0mCqHTkYgKeaPIk
         wbUJkseNW70NDKbauVfC5s6Ncm5QGn9UeA/GeEtHlODZlvftDBkGwQ9i/qqmki7OhdKm
         YXb8scwv5ihfG9232DJpWa72yQFO9buX9Wi+q5PswQRrcMVsol4DSYClLOxNo2m+XS19
         JWDw==
X-Forwarded-Encrypted: i=1; AJvYcCUuD6Us2fR+tu9fYFGkqVxm0IKYKxqLjQM6ySCDo7rum25yqB+Os92ASLFVqwrDj0Elcj99Kc0B8Q6GJht8UYYN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+w39Q3G+1Wi1AEt49YvAokgBJHfahJXsGyF4WNd/YfDewYMvj
	4S8f9u0Umqlr+oAvuTRAI/r8EPKyGQ3vropne9dUg3PUuvlLVESKgxOCL1Fo0YsUTLDe3TDYZVN
	3tGkHrI3dZA==
X-Google-Smtp-Source: AGHT+IEsnXhMlX9BpnaaungUNiYI9un/3vKd7EaW3I1cjNyt2UVnhfya7NNwTDiFZpEnDvq5ofL5Juc8ja0s
X-Received: from ybbew5.prod.google.com ([2002:a05:6902:2985:b0:eb3:7397:f4b])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1583:20b0:63c:f5a7:3d1
 with SMTP id 956f58d0204a3-63cf5a70abdmr6881943d50.61.1760379381367; Mon, 13
 Oct 2025 11:16:21 -0700 (PDT)
Date: Mon, 13 Oct 2025 18:16:01 +0000
In-Reply-To: <20251013181607.2745653-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013181607.2745653-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251013181607.2745653-5-zecheng@google.com>
Subject: [PATCH v4 4/9] perf annotate: Save pointer offset in stack state
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

The tracked pointer offset was not being preserved in the stack state,
which could lead to incorrect type analysis. This change adds a
ptr_offset field to the type_state_stack struct and passes it to
set_stack_state and findnew_stack_state to ensure the offset is
preserved after the pointer is loaded from a stack location. It improves
the type annotation coverage and quality.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/arch/x86/annotate/instructions.c |  6 +++---
 tools/perf/util/annotate-data.c             | 12 +++++++-----
 tools/perf/util/annotate-data.h             |  7 +++++--
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index def7729a394c..0c87e42ca3dc 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -541,7 +541,7 @@ static void update_insn_state_x86(struct type_state *state,
 			} else if (!stack->compound) {
 				tsr->type = stack->type;
 				tsr->kind = stack->kind;
-				tsr->offset = 0;
+				tsr->offset = stack->ptr_offset;
 				tsr->ok = true;
 			} else if (die_get_member_type(&stack->type,
 						       offset - stack->offset,
@@ -724,10 +724,10 @@ static void update_insn_state_x86(struct type_state *state,
 				 */
 				if (!stack->compound)
 					set_stack_state(stack, offset, tsr->kind,
-							&tsr->type);
+							&tsr->type, tsr->offset);
 			} else {
 				findnew_stack_state(state, offset, tsr->kind,
-						    &tsr->type);
+						    &tsr->type, tsr->offset);
 			}
 
 			if (dst->reg1 == fbreg) {
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4204a7956ee5..e183c6104d59 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -577,7 +577,7 @@ struct type_state_stack *find_stack_state(struct type_state *state,
 }
 
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-			    Dwarf_Die *type_die)
+			    Dwarf_Die *type_die, int ptr_offset)
 {
 	int tag;
 	Dwarf_Word size;
@@ -592,6 +592,7 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	stack->type = *type_die;
 	stack->size = size;
 	stack->offset = offset;
+	stack->ptr_offset = ptr_offset;
 	stack->kind = kind;
 
 	if (kind == TSR_KIND_POINTER) {
@@ -614,18 +615,19 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						    int offset, u8 kind,
-						    Dwarf_Die *type_die)
+						    Dwarf_Die *type_die,
+						    int ptr_offset)
 {
 	struct type_state_stack *stack = find_stack_state(state, offset);
 
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset);
 		return stack;
 	}
 
 	stack = malloc(sizeof(*stack));
 	if (stack) {
-		set_stack_state(stack, offset, kind, type_die);
+		set_stack_state(stack, offset, kind, type_die, ptr_offset);
 		list_add(&stack->list, &state->stack_vars);
 	}
 	return stack;
@@ -895,7 +897,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
 				continue;
 
 			findnew_stack_state(state, offset, TSR_KIND_TYPE,
-					    &mem_die);
+					    &mem_die, /*ptr_offset=*/0);
 
 			if (var->reg == state->stack_reg) {
 				pr_debug_dtp("var [%"PRIx64"] %#x(reg%d)",
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 14655b76db65..869307c7f130 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -191,6 +191,8 @@ struct type_state_stack {
 	struct list_head list;
 	Dwarf_Die type;
 	int offset;
+	/* pointer offset, saves tsr->offset on the stack state */
+	int ptr_offset;
 	int size;
 	bool compound;
 	u8 kind;
@@ -247,9 +249,10 @@ int annotated_data_type__get_member_name(struct annotated_data_type *adt,
 bool has_reg_type(struct type_state *state, int reg);
 struct type_state_stack *findnew_stack_state(struct type_state *state,
 						int offset, u8 kind,
-						Dwarf_Die *type_die);
+						Dwarf_Die *type_die,
+						int ptr_offset);
 void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
-				Dwarf_Die *type_die);
+				Dwarf_Die *type_die, int ptr_offset);
 struct type_state_stack *find_stack_state(struct type_state *state,
 						int offset);
 bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
-- 
2.51.0.788.g6d19910ace-goog

