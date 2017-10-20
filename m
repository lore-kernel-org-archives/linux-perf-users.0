From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v6 1/6] perf report: properly handle branch count in
 match_chain
Date: Fri, 20 Oct 2017 12:22:22 -0300
Message-ID: <20171020152222.GE30002@kernel.org>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <20171018185350.14893-2-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751473AbdJTPW1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Oct 2017 11:22:27 -0400
Content-Disposition: inline
In-Reply-To: <20171018185350.14893-2-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Em Wed, Oct 18, 2017 at 08:53:45PM +0200, Milian Wolff escreveu:
> Some of the code paths I introduced before returned too early
> without running the code to handle a node's branch count.
> By refactoring match_chain to only have one exit point, this
> can be remedied.
> +	case CCKEY_FUNCTION:
> +		if (node->sym && cnode->ms.sym) {
> +			/*
> +			 * Compare inlined frames based on their symbol name
> +			 * because different inlined frames will have the same
> +			 * symbol start. Otherwise do a faster comparison based
> +			 * on the symbol start address.
> +			 */
> +			if (cnode->ms.sym->inlined || node->sym->inlined)
> +				match = match_chain_strings(cnode->ms.sym->name,
> +							    node->sym->name);
> +			else
> +				match = match_address_dso(cnode->ms.map->dso,
> +							  cnode->ms.sym->start,
> +							  node->map->dso,
> +							  node->sym->start);
> +			if (match != MATCH_ERROR)
> +				break;
> +		}
>  		/* otherwise fall-back to IP-based comparison below */
> +		__fallthrough;

If we take this __falltrough because cnode->sym or cnode->ms.sym is
NULL, then cnode->ms.map may be NULL if we got a sample for which we
somehow couldn't find a map.

And we don't really need to deal with DSOs, just with MAPs, to go from
relative to absolute when we _have_ a symbol resolved, cnode->ip and
node->ip are already absolute.

> +	case CCKEY_ADDRESS:
> +	default:
> +		match = match_address_dso(cnode->ms.map->dso, cnode->ip,
> +					  node->map->dso, node->ip);

Ok, below is this patch updated on top of my previous patch, please take
a look, I'll be adding all this to my tmp.perf/core branch, holler if
you disagree on moving it to perf/core, which I'd like to do soon.

- Arnaldo


commit ab950c4f4a262af1afd8cfb02c0f71acfc4eafe9
Author: Milian Wolff <milian.wolff@kdab.com>
Date:   Fri Oct 20 12:14:47 2017 -0300

    perf report: Properly handle branch count in match_chain()
    
    Some of the code paths I introduced before returned too early without
    running the code to handle a node's branch count.  By refactoring
    match_chain to only have one exit point, this can be remedied.
    
    Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    [ Fixed up wrt always using absolute addresses ]
    Link: http://lkml.kernel.org/r/20171018185350.14893-2-milian.wolff@kdab.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1ac3f4a5afab..eac1c9bc9d5b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -666,79 +666,88 @@ static enum match_result match_chain_strings(const char *left,
 	return ret;
 }
 
+static enum match_result match_chain_addresses(u64 left_ip, u64 right_ip)
+{
+	if (left_ip == right_ip)
+               return MATCH_EQ;
+       else if (left_ip < right_ip)
+               return MATCH_LT;
+       else
+               return MATCH_GT;
+}
+
 static enum match_result match_chain(struct callchain_cursor_node *node,
 				     struct callchain_list *cnode)
 {
-	struct symbol *sym = node->sym;
-	u64 left, right;
-
-	if (callchain_param.key == CCKEY_SRCLINE) {
-		enum match_result match = match_chain_strings(cnode->srcline,
-							      node->srcline);
-
-		/* if no srcline is available, fallback to symbol name */
-		if (match == MATCH_ERROR && cnode->ms.sym && node->sym)
-			match = match_chain_strings(cnode->ms.sym->name,
-						    node->sym->name);
+	enum match_result match = MATCH_ERROR;
 
+	switch (callchain_param.key) {
+	case CCKEY_SRCLINE:
+		match = match_chain_strings(cnode->srcline, node->srcline);
 		if (match != MATCH_ERROR)
-			return match;
+			break;
+		/* otherwise fall-back to symbol-based comparison below */
+		__fallthrough;
+	case CCKEY_FUNCTION:
+		if (node->sym && cnode->ms.sym) {
+			/*
+			 * Compare inlined frames based on their symbol name
+			 * because different inlined frames will have the same
+			 * symbol start. Otherwise do a faster comparison based
+			 * on the symbol start address.
+			 */
+			if (cnode->ms.sym->inlined || node->sym->inlined) {
+				match = match_chain_strings(cnode->ms.sym->name,
+							    node->sym->name);
+				if (match != MATCH_ERROR)
+					break;
+			} else {
+				u64 left = cnode->ms.map->unmap_ip(cnode->ms.map, cnode->ms.sym->start),
+				    right = node->map->unmap_ip(node->map, node->sym->start);
 
+				match = match_chain_addresses(left, right);
+				break;
+			}
+		}
 		/* otherwise fall-back to IP-based comparison below */
+		__fallthrough;
+	case CCKEY_ADDRESS:
+	default:
+		match = match_chain_addresses(cnode->ip, node->ip);
+		break;
 	}
 
-	if (cnode->ms.sym && sym && callchain_param.key == CCKEY_FUNCTION) {
-		/*
-		 * Compare inlined frames based on their symbol name because
-		 * different inlined frames will have the same symbol start
-		 */
-		if (cnode->ms.sym->inlined || node->sym->inlined)
-			return match_chain_strings(cnode->ms.sym->name,
-						   node->sym->name);
-
-		left = cnode->ms.map->unmap_ip(cnode->ms.map, cnode->ms.sym->start);
-		right = node->map->unmap_ip(node->map, sym->start);
-	} else {
-		left = cnode->ip;
-		right = node->ip;
-	}
-
-	if (left == right) {
-		if (node->branch) {
-			cnode->branch_count++;
+	if (match == MATCH_EQ && node->branch) {
+		cnode->branch_count++;
 
-			if (node->branch_from) {
-				/*
-				 * It's "to" of a branch
-				 */
-				cnode->brtype_stat.branch_to = true;
+		if (node->branch_from) {
+			/*
+			 * It's "to" of a branch
+			 */
+			cnode->brtype_stat.branch_to = true;
 
-				if (node->branch_flags.predicted)
-					cnode->predicted_count++;
+			if (node->branch_flags.predicted)
+				cnode->predicted_count++;
 
-				if (node->branch_flags.abort)
-					cnode->abort_count++;
+			if (node->branch_flags.abort)
+				cnode->abort_count++;
 
-				branch_type_count(&cnode->brtype_stat,
-						  &node->branch_flags,
-						  node->branch_from,
-						  node->ip);
-			} else {
-				/*
-				 * It's "from" of a branch
-				 */
-				cnode->brtype_stat.branch_to = false;
-				cnode->cycles_count +=
-					node->branch_flags.cycles;
-				cnode->iter_count += node->nr_loop_iter;
-				cnode->iter_cycles += node->iter_cycles;
-			}
+			branch_type_count(&cnode->brtype_stat,
+					  &node->branch_flags,
+					  node->branch_from,
+					  node->ip);
+		} else {
+			/*
+			 * It's "from" of a branch
+			 */
+			cnode->brtype_stat.branch_to = false;
+			cnode->cycles_count += node->branch_flags.cycles;
+			cnode->iter_count += node->nr_loop_iter;
+			cnode->iter_cycles += node->iter_cycles;
 		}
-
-		return MATCH_EQ;
 	}
 
-	return left > right ? MATCH_GT : MATCH_LT;
+	return match;
 }
 
 /*
