Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376CFC07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D88613AB
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 08:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbhGNIit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 04:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238482AbhGNIit (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 04:38:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D43B16115A;
        Wed, 14 Jul 2021 08:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626251758;
        bh=HDymZW8IKRKt/jb2rj2qbgVXui81unjwJTpptk8kJ7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RB/QPHzlz7sU+FJoEw2Rl9ORqYNYDU0ByM2fH+ZDN8PFpW72iGwx2iJTvk34xXdDK
         4afkxT3NphonGmGcHZDxnWFZ4lKMQboC5f7pX9/gFmeZdoaXOYj1L75Q0sxdjkFEFQ
         VcH5G+mYU4/gBv5D1pr9vF10r0Hn6jAwiGok9NiDCzN/SpQbBq6mnLsA/qvXhiy+Gg
         l+xcAQNJMAH9+OoQyRKGxGjRtUi2zYRqBteaHq/g1Rbu2Nct06EorWxVIS/0uehre2
         Xt4WnHe29rmSkUuhrgDndDxPRvg0wkqqITtZmFIA4OrmUMBFVir8u54QK5+2e1TzzH
         jgjRxZ6A3X7SA==
Date:   Wed, 14 Jul 2021 17:35:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <fche@redhat.com>, <ravi.bangoria@linux.ibm.com>,
        <yao.jin@linux.intel.com>, <srikar@linux.vnet.ibm.com>,
        <Jianlin.Lv@arm.com>, <lihuafei1@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf probe: Fix add event failed when 32-bit perf
 running in 64-bit kernel
Message-Id: <20210714173553.944cef13897dfe1bea7b8d78@kernel.org>
In-Reply-To: <20210714065432.188061-1-yangjihong1@huawei.com>
References: <20210714065432.188061-1-yangjihong1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Yang,

On Wed, 14 Jul 2021 14:54:32 +0800
Yang Jihong <yangjihong1@huawei.com> wrote:

> The "address" member  of "struct probe_trace_point" uses long data type.
> If kernel is 64-bit and perf program is 32-bit, size of "address" variable is
> 32 bits. As a result, upper 32 bits of address read from kernel are truncated,
> An error occurs during address comparison in kprobe_warn_out_range function.

Good catch!
I didn't imagine that such a use case. But that is important because perf
probe can be used for cross-arch probe definition too.

> 
> Before:
> 
>   # perf probe -a schedule
>   schedule is out of .text, skip it.
>     Error: Failed to add events.
> 
> Solution:
>   Change data type of "address" variable to u64 and change corresponding
> address printing and value assignment.

OK, as far as I can see, the other parts of the perf also uses u64 for
"address" storing variables. (e.g. symbols, maps etc.)

> 
> After:
> 
>   # perf.new.new probe -a schedule
>   Added new event:
>     probe:schedule       (on schedule)
> 
>   You can now use it in all perf tools, such as:
> 
>           perf record -e probe:schedule -aR sleep 1
> 
>   # perf probe -l
>     probe:schedule       (on schedule)

I think you missed one thing here.
Usually, this shows the filename and line number of schedule().

Could you try below diff?

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7d2ba8419b0c..609ca1671501 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -113,14 +113,14 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
  *
  * Find a line number and file name for @addr in @cu_die.
  */
-int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
-		    const char **fname, int *lineno)
+int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
+		     const char **fname, int *lineno)
 {
 	Dwarf_Line *line;
 	Dwarf_Die die_mem;
 	Dwarf_Addr faddr;
 
-	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
+	if (die_find_realfunc(cu_die, addr, &die_mem)
 	    && die_entrypc(&die_mem, &faddr) == 0 &&
 	    faddr == addr) {
 		*fname = dwarf_decl_file(&die_mem);
@@ -128,7 +128,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
 		goto out;
 	}
 
-	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
+	line = cu_getsrc_die(cu_die, addr);
 	if (line && dwarf_lineno(line, lineno) == 0) {
 		*fname = dwarf_linesrc(line, NULL, NULL);
 		if (!*fname)
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index cb99646843a9..7ee0fa19b5c4 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -19,7 +19,7 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
 const char *cu_get_comp_dir(Dwarf_Die *cu_die);
 
 /* Get a line number and file name for given address */
-int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
+int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
 		     const char **fname, int *lineno);
 
 /* Walk on functions at given address */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 8ba01bbdf05c..50d861a80f57 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1727,7 +1727,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 	}
 
 	/* Find a corresponding line (filename and lineno) */
-	cu_find_lineinfo(&cudie, addr, &fname, &lineno);
+	cu_find_lineinfo(&cudie, (Dwarf_Addr)addr, &fname, &lineno);
 	/* Don't care whether it failed or not */
 
 	/* Find a corresponding function (name, baseline and baseaddr) */
@@ -1828,8 +1828,7 @@ static int line_range_add_line(const char *src, unsigned int lineno,
 }
 
 static int line_range_walk_cb(const char *fname, int lineno,
-			      Dwarf_Addr addr __maybe_unused,
-			      void *data)
+			      Dwarf_Addr addr, void *data)
 {
 	struct line_finder *lf = data;
 	const char *__fname;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
