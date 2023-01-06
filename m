Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA78C3DA7A
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Jan 2023 05:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjAFFXH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Jan 2023 00:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFFXF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Jan 2023 00:23:05 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4526ADB4
        for <linux-perf-users@vger.kernel.org>; Thu,  5 Jan 2023 21:23:03 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so617387plb.13
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jan 2023 21:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s510Ri0bpj6MRrxB+NkrHnD638XbzzgZK7rV92PYJQk=;
        b=Qb6aV/v7ht9Uq50FJw2ijYjRkjbcVZ5gvdov0NjR0JaXETGujWNSiBHbMkyYJn7g2L
         nlY2NZmaI1ZZy0ofWmbeZG3Dq8v89YKwAXHxM9Z5gEV2Ee1587S29P6aNDiALs7pVcIg
         08teIDXjJb2KnNzHuyu9odZbdCAaiT1QX/ya5CXEz7M2twPUfl3fmObwuhDccLyBv4Df
         T+9S2M8IDcwQ7sqxNFRXAq0wtWOLWOYf7FaF38oA0PvgcG2k4Lji56+c+pjM6Fs9AGjl
         FKuUeqjS1aZCJjnoowlaIMSaud7d0QTIZeGF6LT1UQmaf4Ukzedyw2aQjatH6BkZNtyz
         bTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s510Ri0bpj6MRrxB+NkrHnD638XbzzgZK7rV92PYJQk=;
        b=nMKg9H0mT44UhV82gqW5NLe60zusZChvfv8OYM45HJYF0Q3yUAeZJIIGxTk1zlIQBX
         wnDd0USJk6+jLdhe2TrKzr3F3SF/cbNN7URnQpvyBZuVgrIEAw6kcuOxrUNgzPfVQMoj
         hB+FjRfgYtEbbg723G+XOW53raAxOnAlykvAW/Zzh8hy5pjpQysddqIZL9EiahZqqFcd
         0Os3SCyKtlhh3q+B3nM7F716Z3LDqFOVbBEGdksoA7n1ZmJwH+STg1A8wuXl26R3E4Do
         HkDXRvTDfH/nrjQZSwEhFy8S1kCnYlJR50CCyovvkje/hjRL0TjHkiR6z9hgyaxNdbR5
         y5OQ==
X-Gm-Message-State: AFqh2krJ0HKMJr94Qj/mDz/lxac5LJZZo9zY1/VF/EnWjMX5Hvl+0eIT
        wMLUmuw8yF9eolCEPbWrBoz2VrA6CJSXXcdGmTkeSjvZ
X-Google-Smtp-Source: AMrXdXsCZtCyhulW4Xt3pCGXHcia41p58jmzNXQeZtgEefqg2+ADTuYtTA50e2YhJT32DgxMHCJJNQ==
X-Received: by 2002:a17:902:be05:b0:192:a4e5:ac5f with SMTP id r5-20020a170902be0500b00192a4e5ac5fmr27686177pls.61.1672982582913;
        Thu, 05 Jan 2023 21:23:02 -0800 (PST)
Received: from leoy-yangtze.lan ([152.70.116.104])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902ea0c00b00189bf5dc96dsm27027226plg.230.2023.01.05.21.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 21:23:02 -0800 (PST)
Date:   Fri, 6 Jan 2023 13:22:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [BUG] perf kmem: Broken because of missing tracepoints
Message-ID: <Y7ewMG+0YKp9pgud@leoy-yangtze.lan>
References: <b5f82509-41d7-7598-6ec2-fcfa74c7ddaa@amd.com>
 <Y7b6cmRE/+5HJLCa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7b6cmRE/+5HJLCa@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ravi, Arnaldo,

On Thu, Jan 05, 2023 at 01:27:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jan 05, 2023 at 07:03:25PM +0530, Ravi Bangoria escreveu:
> > Hello,
> > 
> > Two tracepoints, kmem:kmalloc_node and kmem:kmem_cache_alloc_node used by perf-
> > kmem tool were removed from kernel by commit 11e9734bcb6a7 ("mm/slab_common:
> > unify NUMA and UMA version of tracepoints"). This causes issue while running
> > perf kmem on latest kernel:
> > 
> >   $ sudo ./perf kmem record
> >   event syntax error: 'kmem:kmalloc_node'
> >                        \___ unknown tracepoint
> > 
> >   $ sudo ./perf kmem record
> >   event syntax error: 'kmem:kmem_cache_alloc_node'
> >                        \___ unknown tracepoint
> > 
> > Haven't got a chance to debug further. Anyone aware of this?
> 
> I didn't notice this so far, would be good to have a fix soon.

I looked a bit for the issue, so wrote a fix and verified on my
Arm64 machine.  Please let me know if this works for you or not,
thanks!

From b7d26f5543401924ae4ad93daeba66cd7d58eb39 Mon Sep 17 00:00:00 2001
From: Leo Yan <leo.yan@linaro.org>
Date: Fri, 6 Jan 2023 11:16:27 +0800
Subject: [PATCH] perf kmem: Fix tracepoints breakage

Commit 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of
tracepoints") removed tracepoints 'kmalloc_node' and
'kmem_cache_alloc_node'; the tracepoints 'kmalloc'
and 'kmem_cache_alloc' add an extra field 'node' to present the
memory node to be allocated and replace the two removed tracepoints
respectively.

The commit introduces ABI breakage, both for the dropped tracepoints and
for the updated tracepoints.

To fix this issue, perf tool removes the support for the tracepoints
'kmalloc_node' and 'kmem_cache_alloc_node'; for the two updated
tracepoints this patch reads out the new field 'node', if its value is
NUMA_NO_NODE (-1), we doesn't take it as a cross memory allocation.

Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
Fixes: 11e9734bcb6a ("mm/slab_common: unify NUMA and UMA version of tracepoints")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-kmem.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index e20656c431a4..c97ec38db521 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -26,6 +26,7 @@
 #include "util/string2.h"
 
 #include <linux/kernel.h>
+#include <linux/numa.h>
 #include <linux/rbtree.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -176,6 +177,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 		      call_site = evsel__intval(evsel, sample, "call_site");
 	int bytes_req = evsel__intval(evsel, sample, "bytes_req"),
 	    bytes_alloc = evsel__intval(evsel, sample, "bytes_alloc");
+	int node1, node2;
 
 	if (insert_alloc_stat(call_site, ptr, bytes_req, bytes_alloc, sample->cpu) ||
 	    insert_caller_stat(call_site, bytes_req, bytes_alloc))
@@ -185,22 +187,18 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
 	total_allocated += bytes_alloc;
 
 	nr_allocs++;
-	return 0;
-}
 
-static int evsel__process_alloc_node_event(struct evsel *evsel, struct perf_sample *sample)
-{
-	int ret = evsel__process_alloc_event(evsel, sample);
+	node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
+	node2 = evsel__intval(evsel, sample, "node");
 
-	if (!ret) {
-		int node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu}),
-		    node2 = evsel__intval(evsel, sample, "node");
-
-		if (node1 != node2)
-			nr_cross_allocs++;
-	}
+	/*
+	 * If the field "node" is NUMA_NO_NODE (-1), we don't take it
+	 * as a cross allocation.
+	 */
+	if ((node2 != NUMA_NO_NODE) && (node1 != node2))
+		nr_cross_allocs++;
 
-	return ret;
+	return 0;
 }
 
 static int ptr_cmp(void *, void *);
@@ -1369,8 +1367,6 @@ static int __cmd_kmem(struct perf_session *session)
 		/* slab allocator */
 		{ "kmem:kmalloc",		evsel__process_alloc_event, },
 		{ "kmem:kmem_cache_alloc",	evsel__process_alloc_event, },
-		{ "kmem:kmalloc_node",		evsel__process_alloc_node_event, },
-		{ "kmem:kmem_cache_alloc_node", evsel__process_alloc_node_event, },
 		{ "kmem:kfree",			evsel__process_free_event, },
 		{ "kmem:kmem_cache_free",	evsel__process_free_event, },
 		/* page allocator */
@@ -1831,10 +1827,8 @@ static int __cmd_record(int argc, const char **argv)
 	};
 	const char * const slab_events[] = {
 	"-e", "kmem:kmalloc",
-	"-e", "kmem:kmalloc_node",
 	"-e", "kmem:kfree",
 	"-e", "kmem:kmem_cache_alloc",
-	"-e", "kmem:kmem_cache_alloc_node",
 	"-e", "kmem:kmem_cache_free",
 	};
 	const char * const page_events[] = {
-- 
2.34.1

