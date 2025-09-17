Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A22853EF
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758139105; cv=none; b=nSw95Rfrm6PJPTuKMVerIDYEhLk2ARrkQ/LAggkCjQ5SZV75qYCMJbrMAZfOyXdO7YsMdFZibhz8JX19gQ1K/AF3b+c1+DZGLEOvqckknuUUmemmUJm7V/rhi7ao2HrFatuDndBuG9TGrfUCZQAqJV7Feu9aNfs5VVytaLUISHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758139105; c=relaxed/simple;
	bh=/F58P/YxjYrKoka+7vu+bHrQcwHs2hOyARDQ5uPmEic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GDPmE+9io3VMN1isnneI/+j4hqT5Y0LUQCdKaj2X0n0n3Reivf8YiWKMK231j96E4hM3p/H2vndi+m9ZJjgbq/jHf3VvzUKhJaNFyGpH77njdPVM42zG5TJhHk/zMg1JWKlMlbJ59Giup6HC17MYMW+rpI7JvAZ9WM9XjlWyhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JbsR2oR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JbsR2oR"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-731572565c3so3011577b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758139102; x=1758743902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWTEtgPxSrBsYU6g+cDk31HXjxfCjijkteP7xD/xTbc=;
        b=2JbsR2oRp2w/JP0bucN5N+OM5jwZr6ctySyksWldznRdxDkds+yDBn1xxlHh0fHjl+
         uFpetk/a4EYDslynmtpsTTliDDYqznZ5nzlI0CRIJOVd+Oes8452cprxmDab8WnEYA07
         zoSiDcSfZLCoG+ShwwoX/ELy6jrzIpYKpZWqmuiFvRM3ymq6NF2fwlL6ACQ0kb2Vd3Ao
         Gv5LSBu8TA76ARL0qkbLPgcwZIq36/5hxVpE2QLTFX0VE8Ni/Cv2p77USamXGR6PGt+2
         CeX2L6OITfgrTGQF0yoqn/kbcn5ErPCK1ZVSEcti+YBuOZTaw/dk3MVDO+Tmf7aONTeL
         xNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758139102; x=1758743902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWTEtgPxSrBsYU6g+cDk31HXjxfCjijkteP7xD/xTbc=;
        b=P+ILBscp2m8prCluGKZsyAN0ttpOaDk98o7WBbapRHOJdPGVoarygSRI2ylkyvdxNA
         xqtRO4KnYxYzrB6tdDqi5R/UPfRYJr57IXQ5wjncElmoVxyrf6nCSpzvI6YhCesR2gCk
         3h0vezAmILqOIiDlkjjH9eo7gewzLA5dnNj/hHEoBYqxHSZpN/6NC0eE2lQlGkFr1piV
         Wa9SQVXFJ8NMwJwkNM898mid/Ac/7m/2XJQlAwJ9j88W822Z4MgCCZLjGrkEHFKfIvYw
         SxqPXPBLDmiOz5Vrprq+ZL6tfS+K2ygw00z4TXtTnKKxVF3NL4ce7IBfF/wyYHLfYBIn
         WQUw==
X-Forwarded-Encrypted: i=1; AJvYcCXhtaD1U6dVV48ho7srAJ4zHHNBK8C3H4b9QbcL0JWgoybRLxXEQIJN/jvEZQ3g7a7p0MB5gQ1LhG/eegL6mfdx@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyIgd75k7lwIVltTLR17Fvf79XpJuCpVt4mLQKl3wpNkJcqQ5
	wXN2TXBbSjexfR4UZ6Gg0d9o1bmanMH2cRz8mgg9ye8z1OdRfiAXHftSsf0pklQR3bkcLhocJRD
	G7sbnO8/5TQ==
X-Google-Smtp-Source: AGHT+IG08BhZhawfTdGuzjbiqhrvEhyIzX6FKnBqwOT1ntDkoB5dGR4kb9fm9mCJPrVKQHGeFQAz3moO6Y+J
X-Received: from ybbgo2.prod.google.com ([2002:a05:6902:4202:b0:ea4:16f0:d3f6])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:120f:b0:e96:f587:cb21
 with SMTP id 3f1490d57ef6-ea5c044ce30mr2422450276.27.1758139102335; Wed, 17
 Sep 2025 12:58:22 -0700 (PDT)
Date: Wed, 17 Sep 2025 19:58:08 +0000
In-Reply-To: <20250917195808.2514277-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250917195808.2514277-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250917195808.2514277-11-zecheng@google.com>
Subject: [PATCH v3 10/10] perf dwarf-aux: Support DW_OP_piece expressions
From: Zecheng Li <zecheng@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Support variables split across multiple registers or stack locations by
handling DW_OP_piece in DWARF expressions. This enables correct matching
of such variables by iterating over all pieces in the expression.

There are two cases for matching memory access on the target register:

1. Accessing a struct member:
   - The type is the original variable's type.
   - The offset is the sum of the piece's offset and the operand's
     offset.

2. Dereferencing a member:
   - The type is the member of the original variable (the member must be
     a pointer).
   - The size must match the piece size.
   - The access offset is the operand's offset.

This change improves support for piece-wise variable locations in DWARF
expressions.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 tools/perf/util/dwarf-aux.c | 244 +++++++++++++++++++++++++++---------
 1 file changed, 187 insertions(+), 57 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b2189de07daf..aae15a2cb7d0 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1390,21 +1390,44 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     s64 addr_offset, s64 addr_type, bool is_pointer)
+					s64 addr_offset, s64 addr_type, s64 piece_offset,
+					s64 piece_size, bool is_pointer)
 {
-	Dwarf_Word size;
+	Dwarf_Word size = 0;
 	s64 offset = addr_offset - addr_type;
 
-	if (offset < 0)
+	if (piece_size == 0 || offset < 0)
 		return false;
 
+	if (piece_size > 0 && !is_pointer) {
+		offset += piece_offset;
+		size = piece_offset + piece_size;
+	}
+
 	if (__die_get_real_type(die_mem, &data->type) == NULL)
 		return false;
 
-	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
-		/* Get the target type of the pointer */
-		if (__die_get_real_type(&data->type, &data->type) == NULL)
-			return false;
+	if (is_pointer) {
+		if (piece_size < 0 && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
+			/* Get the target type of the pointer */
+			if (__die_get_real_type(&data->type, &data->type) == NULL)
+				return false;
+		}
+
+		if (piece_size > 0) {
+			Dwarf_Die member_die;
+
+			if (die_get_member_type(&data->type, piece_offset, &member_die) == NULL)
+				return false;
+
+			if (dwarf_aggregate_size(&member_die, &size) < 0)
+				return false;
+
+			if (size == (u64)piece_size &&
+			    dwarf_tag(&data->type) == DW_TAG_pointer_type)
+				if (__die_get_real_type(&member_die, &data->type) == NULL)
+					return false;
+		}
 	}
 
 	if (offset == 0) {
@@ -1413,7 +1436,7 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 		return true;
 	}
 
-	if (dwarf_aggregate_size(&data->type, &size) < 0)
+	if (size == 0 && dwarf_aggregate_size(&data->type, &size) < 0)
 		return false;
 
 	if ((u64)offset >= size)
@@ -1452,6 +1475,67 @@ static bool is_breg_access_indirect(Dwarf_Op *ops, size_t nops)
 	return false;
 }
 
+struct op_piece_iter {
+	/* Pointer to the beginning of the op array */
+	Dwarf_Op *ops;
+	size_t nops;
+	/* The index where the next search will begin */
+	size_t current_idx;
+	size_t next_offset;
+
+	/* Pointer to the start of the current piece's ops */
+	Dwarf_Op *piece_ops;
+	/* The number of ops in the current piece */
+	size_t num_piece_ops;
+	size_t piece_offset;
+};
+
+static void op_piece_iter_init(struct op_piece_iter *it, Dwarf_Op *ops, size_t nops)
+{
+	it->ops = ops;
+	it->nops = nops;
+	it->current_idx = 0;
+	it->next_offset = 0;
+	it->piece_ops = NULL;
+	it->num_piece_ops = 0;
+	it->piece_offset = 0;
+}
+
+/* Finds the next non-empty piece segment. */
+static bool op_piece_iter_next(struct op_piece_iter *it)
+{
+	/* Loop until a non-empty piece is found */
+	while (it->current_idx < it->nops) {
+		size_t start;
+		size_t end;
+
+		start = it->current_idx;
+		end = start;
+
+		while (end < it->nops && it->ops[end].atom != DW_OP_piece)
+			end++;
+
+		/* The number of ops in this segment, including DW_OP_piece */
+		it->num_piece_ops = min(end - start + 1, it->nops - start);
+		it->piece_ops = &it->ops[start];
+		it->piece_offset = it->next_offset;
+
+		it->current_idx = end;
+		if (it->current_idx < it->nops) {
+			const Dwarf_Op *piece_op = &it->ops[it->current_idx];
+			size_t piece_size = (size_t)piece_op->number;
+
+			it->next_offset += piece_size;
+			it->current_idx++;
+		}
+
+		if (end > start)
+			return true;
+	}
+
+	return false;
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1470,48 +1554,65 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		return DIE_FIND_CB_SIBLING;
 
 	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		struct op_piece_iter piece_iter;
 		/* Assuming the location list is sorted by address */
 		if (end <= data->pc)
 			continue;
 		if (start > data->pc)
 			break;
 
-		/* Local variables accessed using frame base register */
-		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
-		    check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->offset, ops->number,
-				     is_breg_access_indirect(ops, nops)))
-			return DIE_FIND_CB_END;
+		op_piece_iter_init(&piece_iter, ops, nops);
+		while (op_piece_iter_next(&piece_iter)) {
+			Dwarf_Op *pops = piece_iter.piece_ops;
+			size_t pnops = piece_iter.num_piece_ops;
+			size_t piece_offset = piece_iter.piece_offset;
+			int piece_size = -1;
+			bool is_pointer = true;
+			int access_offset = data->offset;
 
-		/* Only match with a simple case */
-		if (data->reg < DWARF_OP_DIRECT_REGS) {
-			/* pointer variables saved in a register 0 to 31 */
-			if (ops->atom == (DW_OP_reg0 + data->reg) &&
-			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, 0,
-					     /*is_pointer=*/true))
-				return DIE_FIND_CB_END;
+			if (pops[pnops - 1].atom == DW_OP_piece)
+				piece_size = (int)pops[pnops - 1].number;
 
-			/* variables accessed by a register + offset */
-			if (ops->atom == (DW_OP_breg0 + data->reg) &&
-			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number,
-					     is_breg_access_indirect(ops, nops)))
-				return DIE_FIND_CB_END;
-		} else {
-			/* pointer variables saved in a register 32 or above */
-			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
-			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, 0,
-					     /*is_pointer=*/true))
-				return DIE_FIND_CB_END;
+			if (!check_allowed_ops(pops, pnops))
+				continue;
 
-			/* variables accessed by a register + offset */
-			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
-			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number2,
-					     is_breg_access_indirect(ops, nops)))
+			if ((data->is_fbreg && pops->atom == DW_OP_fbreg) ||
+			    (pops->atom == DW_OP_breg0 + data->reg) ||
+			    (pops->atom == DW_OP_bregx && data->reg == pops->number))
+				is_pointer = is_breg_access_indirect(pops, pnops);
+
+			/* Local variables accessed using frame base register */
+			if (data->is_fbreg && pops->atom == DW_OP_fbreg &&
+				match_var_offset(die_mem, data, access_offset,
+					pops->number, piece_offset, piece_size, is_pointer))
 				return DIE_FIND_CB_END;
+
+			/* Only match with a simple case */
+			if (data->reg < DWARF_OP_DIRECT_REGS) {
+				/* pointer variables saved in a register 0 to 31 */
+				if (pops->atom == (DW_OP_reg0 + data->reg) &&
+					match_var_offset(die_mem, data, access_offset,
+					    0, piece_offset, piece_size, is_pointer))
+					return DIE_FIND_CB_END;
+
+				/* variables accessed by a register + offset */
+				if (pops->atom == (DW_OP_breg0 + data->reg) &&
+					match_var_offset(die_mem, data, access_offset,
+					    pops->number, piece_offset, piece_size, is_pointer))
+					return DIE_FIND_CB_END;
+			} else {
+				/* pointer variables saved in a register 32 or above */
+				if (pops->atom == DW_OP_regx && pops->number == data->reg &&
+					match_var_offset(die_mem, data, access_offset,
+					    0, piece_offset, piece_size, is_pointer))
+					return DIE_FIND_CB_END;
+
+				/* variables accessed by a register + offset */
+				if (pops->atom == DW_OP_bregx && data->reg == pops->number &&
+					match_var_offset(die_mem, data, access_offset,
+					    pops->number2, piece_offset, piece_size, is_pointer))
+					return DIE_FIND_CB_END;
+			}
 		}
 	}
 	return DIE_FIND_CB_SIBLING;
@@ -1572,7 +1673,7 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number,
+		    match_var_offset(die_mem, data, data->addr, ops->number, 0, -1,
 				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
@@ -1613,6 +1714,7 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	Dwarf_Op *ops;
 	size_t nops;
 	struct die_var_type *vt;
+	struct op_piece_iter piece_iter;
 
 	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
 		return DIE_FIND_CB_SIBLING;
@@ -1634,25 +1736,53 @@ static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 	if (__die_get_real_type(die_mem, &type_die) == NULL)
 		return DIE_FIND_CB_SIBLING;
 
-	vt = malloc(sizeof(*vt));
-	if (vt == NULL)
-		return DIE_FIND_CB_END;
+	op_piece_iter_init(&piece_iter, ops, nops);
+	while (op_piece_iter_next(&piece_iter)) {
+		Dwarf_Op *pops = piece_iter.ops;
+		size_t pnops = piece_iter.num_piece_ops;
+		size_t piece_offset = piece_iter.piece_offset;
+		size_t offset = offset_from_dwarf_op(pops);
+		s64 piece_size = -1;
+		/* Usually a register holds the value of the variable */
+		bool is_reg_var_addr = false;
+
+		if (((pops->atom >= DW_OP_breg0 && pops->atom <= DW_OP_breg31) ||
+		      pops->atom == DW_OP_bregx || pops->atom == DW_OP_fbreg) &&
+		      !is_breg_access_indirect(pops, pnops))
+			/* The register holds the address of the variable. */
+			is_reg_var_addr = true;
+
+		if (pops[pnops - 1].atom == DW_OP_piece)
+			piece_size = (s64)pops[pnops - 1].number;
+
+		if (piece_size > 0) {
+			if (!is_reg_var_addr) {
+				size_t size;
+
+				if (die_get_member_type(&type_die, piece_offset, &type_die) == NULL)
+					continue;
 
-	/* Usually a register holds the value of a variable */
-	vt->is_reg_var_addr = false;
+				if (dwarf_aggregate_size(&type_die, &size) < 0)
+					continue;
 
-	if (((ops->atom >= DW_OP_breg0 && ops->atom <= DW_OP_breg31) ||
-	      ops->atom == DW_OP_bregx || ops->atom == DW_OP_fbreg) &&
-	      !is_breg_access_indirect(ops, nops))
-		/* The register contains an address of the variable. */
-		vt->is_reg_var_addr = true;
+				if (size != (u64)piece_size)
+					continue;
+			} else
+				offset += piece_offset;
+		}
 
-	vt->die_off = dwarf_dieoffset(&type_die);
-	vt->addr = start;
-	vt->reg = reg_from_dwarf_op(ops);
-	vt->offset = offset_from_dwarf_op(ops);
-	vt->next = *var_types;
-	*var_types = vt;
+		vt = malloc(sizeof(*vt));
+		if (vt == NULL)
+			return DIE_FIND_CB_END;
+
+		vt->is_reg_var_addr = is_reg_var_addr;
+		vt->die_off = dwarf_dieoffset(&type_die);
+		vt->addr = start;
+		vt->reg = reg_from_dwarf_op(pops);
+		vt->offset = offset;
+		vt->next = *var_types;
+		*var_types = vt;
+	}
 
 	return DIE_FIND_CB_SIBLING;
 }
-- 
2.51.0.384.g4c02a37b29-goog

