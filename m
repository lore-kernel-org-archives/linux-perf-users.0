Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEFC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 16:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358248AbhK1QD0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:03:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352864AbhK1QB0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638115089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oUkv4nUiQ3mkbfdCluK09ueedbskIKmpMx99orQD+k0=;
        b=CqnAig/WSfM5Pr5QKr2EyNa58HcXV5x/EFcY/pHq9UwxnzxHRZb0FSlymQ4jEj6MUuF7He
        XwgEGXA/oc88DsiJjMXJtzKGjE/wWT2+sO1pr9d9VeV+84a7T2UNI5tK9EgkP02pIcQtKO
        27KNs8psWSeLu1LU7Kfm1nMepvzK0tI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-mbucFCDsOPyuWq_XmN7mTw-1; Sun, 28 Nov 2021 10:58:08 -0500
X-MC-Unique: mbucFCDsOPyuWq_XmN7mTw-1
Received: by mail-wm1-f69.google.com with SMTP id p12-20020a05600c1d8c00b0033a22e48203so8999493wms.6
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 07:58:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oUkv4nUiQ3mkbfdCluK09ueedbskIKmpMx99orQD+k0=;
        b=pt3x6jLUyQqUHGDb+9WJ9xYG7UnUP9/CWuEnFSrOHMBJ040FGwrTeZvxxdBUlnsegE
         t33k8iQP77MUXhHkGFTY50AV7oKHovXnVHwsNcDrOnC6o8rSFCJp7/klhYZLpGxUfT7/
         Gk3vEdkRshAlJAUoehQ9n/JwILMbbCImTQciFZ1pN7bMlLKbYzARQaADFaxMG+xbM9N8
         ugc0Dm/OJmfCOipGm2ARkmlfTggh7J+WQV3lzN/EnoFyr46gd3N7l2ffAQ/zb4btL1Yg
         U0oV8pH77XwbSCfaLBhw9sNTsgsevBkfDSiqYMB5VG/C0j+IkbFpMsAivzcKyBnRzaY2
         tWUQ==
X-Gm-Message-State: AOAM532boeUythEtxw2FUgt2AnHiiySzv2nXh4OtzribS7egvI7sBTbs
        /Ou7bkeKNRhpXh4MygYp0ZxCPvOrMcMPh+aUa37ayZe1OW5/fBTeLmFQ2mIJiTidkqgBYwxtFHB
        8zSdnkXOxGETx5lar6ZSln4Q1G6MbXw==
X-Received: by 2002:adf:f352:: with SMTP id e18mr28448057wrp.39.1638115087237;
        Sun, 28 Nov 2021 07:58:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkxnCSub6fUdntBZoh1lxeWIT1SoiIYoj3yADzcyG0D5WPoPX50FTR+Dg4LDbksCWZf//MKg==
X-Received: by 2002:adf:f352:: with SMTP id e18mr28448033wrp.39.1638115087047;
        Sun, 28 Nov 2021 07:58:07 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o4sm19983401wmq.31.2021.11.28.07.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 07:58:06 -0800 (PST)
Date:   Sun, 28 Nov 2021 16:58:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     irogers@google.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf machine: Free machine__findnew_dso
Message-ID: <YaOnDKwNuk/quLBJ@krava>
References: <20211119042607.48924-1-sohaib.amhmd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119042607.48924-1-sohaib.amhmd@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 19, 2021 at 06:26:04AM +0200, Sohaib Mohamed wrote:
> ASan reports memory leaks while running:
> 
> $ rm perf.data*
> $ perf report
> 
> This patch adds the missing dso__put.
> 
> Fixes: 8c7f1bb37b29 ("perf machine: Move kernel mmap name into struct
> machine")
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fb8496df8432..826be7a12da1 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1742,6 +1742,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
>  			 */
>  			dso__load(kernel, machine__kernel_map(machine));
>  		}
> +
> +		dso__put(kernel);

nice catch, after machine__findnew_dso we need to do that

but there's also dso search before we call machine__findnew_dso,
that can find dso, so I wonder we need to add change below as well

thanks,
jirka


---
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 826be7a12da1..cd9bdf723aba 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1700,7 +1700,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 				continue;
 
 
-			kernel = dso;
+			kernel = dso__get(dso);
 			break;
 		}
 

