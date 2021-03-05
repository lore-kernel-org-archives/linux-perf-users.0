Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEA1C433DB
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7AE65015
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 Mar 2021 14:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCEOHl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 09:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhCEOHW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 Mar 2021 09:07:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9578C061756
        for <linux-perf-users@vger.kernel.org>; Fri,  5 Mar 2021 06:07:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s7so1474981plg.5
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Mar 2021 06:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PT9PK36ObrQr9//SU0lxgY9J+kF6C3dPo2qmCBBOlVk=;
        b=uNPHX/l6xQbnXouz0S4XfU5LMli0cqwBipfoJGcWIiM0DgcC9n+2TXW5yeftKuAtt7
         dSoc9pGSt1fyNYGdRMY/V3vnsBSGUUWrXjxfeGs6Ualtgw6sBjVwrMCDujWHcHqG/pWO
         rDcWNFuwJA+ATb9kxD+0+w/2gt7U0anELN5GgvrKnu7U86azgEShRHwekQqAFUb5aYOv
         rct3q3o60R5lk8uziXejkx5wS4zMa4dlll5b5+CSYMklQqTUVVrFf+TkvhozLSdrEHGk
         nirXyNdWFaxuNj7oI8QJBKRPlJeuRG1AKR3VDEh5Aym+FwSjLEokiiye3i/p4PzrKkuq
         T3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PT9PK36ObrQr9//SU0lxgY9J+kF6C3dPo2qmCBBOlVk=;
        b=I0w6t7Wv5asPgKoiGoYxcm3R8AofCbij9kyC1QFz1LpofTlBvNEeDRZhlEvHXdt9rv
         MclUihEAJYApdqw/4QvbRy8ydwBNKJiW2JlzBMpsrHqU1+bNsURzYqubfPyTTTk3t/Tu
         OupI16Xy2eKzGwJeoOnbOGTdqvwwRkIOgvIbYE9HkSwfIwGJGPKONUURDIT5krn9FfZ+
         iA3iLKXOCvwF/Aj3UfnF/JLP7RENlbGrFBHN1rM54bkaW4JPPZJQDZ0bCeHGEZ81lWJZ
         uATjjWguSwLNcddQsErbZxixBFGduVYiakdMxCqr/aoMO2yuwlauVkFcLBX0aF2loCro
         bRPA==
X-Gm-Message-State: AOAM5321SaVI0PYyLLI/qfC3QnY28nP1Ov4/+0fx1/UF7rf+/Qi0OQYt
        TIs5HQMtwl0z3cUoowW5bU2PZg==
X-Google-Smtp-Source: ABdhPJy5//VO/8Vfs/NB2ARUfpki8M8a4onatEXzJRKkH/yd5M7BoQU8IL3MJ6ddXmFZpNIpJ6ti+Q==
X-Received: by 2002:a17:90b:4b0e:: with SMTP id lx14mr10299701pjb.147.1614953241253;
        Fri, 05 Mar 2021 06:07:21 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.136.125.226])
        by smtp.gmail.com with ESMTPSA id p20sm2694925pgb.62.2021.03.05.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 06:07:20 -0800 (PST)
Date:   Fri, 5 Mar 2021 22:07:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Alexandre Truong <alexandre.truong@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>, James Clark <james.clark@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
Subject: Re: [PATCH RESEND WITH CCs v3 3/4] perf tools: enable
 dwarf_callchain_users on aarch64
Message-ID: <20210305140714.GB5478@leoy-ThinkPad-X240s>
References: <20210304163255.10363-1-alexandre.truong@arm.com>
 <20210304163255.10363-3-alexandre.truong@arm.com>
 <20210305115120.GA5478@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305115120.GA5478@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Mar 05, 2021 at 07:51:20PM +0800, Leo Yan wrote:

[...]

> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index 2a845d6cac09..93661a3eaeb1 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -405,6 +405,10 @@ static int report__setup_sample_type(struct report *rep)
> >  
> >  	callchain_param_setup(sample_type);
> >  
> > +	if (callchain_param.record_mode == CALLCHAIN_FP &&
> > +			strncmp(rep->session->header.env.arch, "aarch64", 7) == 0)
> > +		dwarf_callchain_users = true;
> > +
> 
> I don't have knowledge for dwarf or FP.
> 
> This patch is suspicious for me that since it only fixes the issue for
> "perf report" command, but it cannot support "perf script".
> 
> I did a quick testing for "perf script" command with the test code from
> patch 04, seems to me it cannot fix the fp omitting issue for
> "perf script" command:
> 
>   arm64_fp_test 11211  2282.355095:     176307 cycles: 
>               aaaac2e40740 f2+0x10 (/root/arm64_fp_test)
>               aaaac2e4061c main+0xc (/root/arm64_fp_test)
>               ffff961fbd24 __libc_start_main+0xe4 (/usr/lib/aarch64-linux-gnu/libc-2.28.so)
>               aaaac2e4065c _start+0x34 (/root/arm64_fp_test)
> 
> Could you check for this?  Thanks!

Maybe we can consolidate the setting for the global variable
"dwarf_callchain_users" with below change; this can help us to cover
the tools for most cases.  I used the below change to replact patch
03, "perf report" and "perf script" both can work well with it.

Please note, if you want to move forward with this way, it's better to
use a saperate patch for firstly refactoring the function
script__setup_sample_type() by using the general API
callchain_param_setup() to replace the duplicate code pieces for
callchain parameter setting up.

After that, you could apply the reset change for adding new parameter
"arch" for the function script__setup_sample_type().


diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2a845d6cac09..ca2e8c9096ea 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1090,7 +1090,8 @@ static int process_attr(struct perf_tool *tool __maybe_unused,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type,
+			      perf_env__arch((*pevlist)->env));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5915f19cee55..c49212c135b2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2250,7 +2250,8 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type,
+			      perf_env__arch((*pevlist)->env));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
@@ -3309,16 +3310,8 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
-		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		    (sample_type & PERF_SAMPLE_STACK_USER)) {
-			callchain_param.record_mode = CALLCHAIN_DWARF;
-			dwarf_callchain_users = true;
-		} else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
-			callchain_param.record_mode = CALLCHAIN_LBR;
-		else
-			callchain_param.record_mode = CALLCHAIN_FP;
-	}
+	callchain_param_setup(sample_type,
+			      perf_env__arch(session->machines.host.env));
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1b60985690bb..d9766b54cd1a 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1600,7 +1600,7 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 		map__zput(node->ms.map);
 }
 
-void callchain_param_setup(u64 sample_type)
+void callchain_param_setup(u64 sample_type, const char *arch)
 {
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -1612,6 +1612,14 @@ void callchain_param_setup(u64 sample_type)
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
+
+	/*
+	 * Fixup for arm64 due to the frame pointer was omitted for the
+	 * caller of the leaf frame.
+	 */
+	if (callchain_param.record_mode == CALLCHAIN_FP &&
+	    strncmp(arch, "arm64", 6) == 0)
+		dwarf_callchain_users = true;
 }
 
 static bool chain_match(struct callchain_list *base_chain,
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 77fba053c677..d95615daed73 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -300,7 +300,7 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
-void callchain_param_setup(u64 sample_type);
+void callchain_param_setup(u64 sample_type, const char *arch);
 
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
