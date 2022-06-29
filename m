Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05C9C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiF2Jol (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiF2Jol (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 05:44:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7653BBF1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 02:44:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e2so21410617edv.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 02:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hXJgZ9nduLWFDBYx8hDlEyCn02+1AjkOyRRtyDkn4u0=;
        b=NbD1opmreI3bmIMizLHfw7KENDJjW6ovxOvABB0/j6LTzxJ15LJmOK6GV/yeJ+cAYY
         yRuPKhS2xffDYQBDGynyhy4iKgoQmCZ1Awlq8Kbdib5iJcKvoc3l3QbXNNWoq+njXyAS
         XBW3LsT4JnmTHwtWfrExToF1PWz2pg9VqIpx+lZiq42wY74OEJixyCoCDLPf3wen2LDd
         4kaqrYyqWtUn5QkIJGvtzAqAQV4ep7ezeospR0stz3RX+SpbNUN0edYyBRGvcKsDUUZi
         5OY7MSBVqGmfs8QsKyY/jOWcMsDNF4LIyjFOq842TPJ4x0iwVdFwmLYqn/4uRF85v0fT
         rd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hXJgZ9nduLWFDBYx8hDlEyCn02+1AjkOyRRtyDkn4u0=;
        b=QnR2ejOJuS1EQVoulw85jYLRtAF5P/kOtF8Wjaj6BtvtxpkU1BrvmvkYWLdbOkIk+u
         UmjNkyJTFDan95fy4ohAjoH2QIW8cFUBh7G/t6jjjxlocOYh+RlL/A5n6PyJSdrj/7yO
         Kged8NmFdCJnn/sCBrt4ldLIG3/2psQIFaKcdQB1y31fyFD0sRhUScsIt89LrOyuHJc1
         rTTVrp+pTuVf2eoI6fLdqIfaiDrJp2ukTkrOq1qR9jp4n945Jn0Cgaf/YGd+ScXBSaBi
         JDyQx9u1aYExcq2aLIxYH19Uz4JB8Pl3j3dQyEI0MVJInFJ73WrkpW7BBQaFcUZAM9IF
         nClg==
X-Gm-Message-State: AJIora8NOQYa8PMnSpb1SucAuEcJOlYqtVltAOcYgGGfya+L0sJa6kLJ
        ovOrNStlYC3hg9Urwj8pf9ISMCpH2OQRtMqh
X-Google-Smtp-Source: AGRyM1sh+8rYHuWi79p5ZpZ0LAeoxzjKb+F1YZsIVVng90FnoTYX1Hy9866IY8GnpGt47UAzsrxMAQ==
X-Received: by 2002:a05:6402:2554:b0:435:a3fb:9ab4 with SMTP id l20-20020a056402255400b00435a3fb9ab4mr2994471edb.5.1656495878841;
        Wed, 29 Jun 2022 02:44:38 -0700 (PDT)
Received: from krava (net-109-116-206-47.cust.vodafonedsl.it. [109.116.206.47])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0042a2d9af0f8sm10813525edc.79.2022.06.29.02.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:44:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 29 Jun 2022 11:44:36 +0200
To:     Emil Berg <emil.berg@ericsson.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Possible overwriting of errno
Message-ID: <YrwfBPMR+2kZFgHH@krava>
References: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM8PR07MB7666EEF15D803DAFB5A8284D98BB9@AM8PR07MB7666.eurprd07.prod.outlook.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 29, 2022 at 05:31:42AM +0000, Emil Berg wrote:
> Hi!
> 
> I'm getting the error "Failed to start threads: File exists" from perf, probably EEXIST.
> 
> I just want to discuss the changes to tools/perf/builtin-record.c made Feb 10 2022 with:
> perf record: Start threads in the beginning of trace streaming
> SHA: 3217e9fecf118d5dcabdd68d91e0c6afcb4c3e1b
> 
> At line 2014 pthread_create() is run and on line 2017 strerror(errno) is printed. Between line 2014 and 2017 record__terminate_thread() is run.
> 
> I just think record__terminate_thread() run in-between looks like it may overwrite errno, thus messing up the error message. To be clear I think the error message should come from failure of thread creation and not from failure of thread termination. Can someone enlighten me here?
> 
> if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
>     for (tt = 1; tt < t; tt++)
>         record__terminate_thread(&thread_data[t]);
>     pr_err("Failed to start threads: %s\n", strerror(errno));
> 
> /Emil Berg

yea, seems wrong.. could you try patch below?

thanks,
jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cf5c5379ceaa..158bb0f293d2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2103,11 +2103,11 @@ static int record__start_threads(struct record *rec)
 					    MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
 					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
 #endif
-		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
+		ret = pthread_create(&handle, &attrs, record__thread, &thread_data[t]);
+		if (ret) {
 			for (tt = 1; tt < t; tt++)
 				record__terminate_thread(&thread_data[t]);
-			pr_err("Failed to start threads: %s\n", strerror(errno));
-			ret = -1;
+			pr_err("Failed to start threads: %s\n", strerror(ret));
 			goto out_err;
 		}
 
