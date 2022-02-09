Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B5AC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Feb 2022 15:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiBIPKT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 9 Feb 2022 10:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBIPKS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 9 Feb 2022 10:10:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB902C06157B
        for <linux-perf-users@vger.kernel.org>; Wed,  9 Feb 2022 07:10:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1861236wmb.0
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Feb 2022 07:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lbuxU+q6IvlaNAUhRygjhk70VPxWftteQE/uuzTpFno=;
        b=EGDybcFLZacQNuwUNyk/q2Rr2t4VILMI+m22W5mJhKDDUmHOTTFZOHU9XrauzV0mvA
         7XWRi/tCaqFxUaJQLrZNevh1iYZ5ImsQvtjUc3VTY2QM/4s6GVDegQcUAgCeQZTWQugO
         1zI+2/J6BcOmMi5f1DSwTux7B8mwv3v4s+whl43glsbwsCgkefYP29+vFQ8+X1CrQ2lx
         lHDITasuxDfy8A+wa+u8eyh02Wh/RKm+POXyF22a4AH8SZr4H6BZv0OZ1k8+3cf6fAcE
         fBCgz0ItC24hBMhGjydUU+VzuP4KSS4BBiit6U9C5FXxxiK4QESlTRAvabfxOOYzQHGj
         Z9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbuxU+q6IvlaNAUhRygjhk70VPxWftteQE/uuzTpFno=;
        b=jmJziW782qxIJLGNrIls0p5NFJ+uZwtlNsFmcHxJRGU/Obj5Q8p5+T9QW8QZmFZ4+Z
         AgSKI2ilV0x1uSpKXQny4Ff+SEeHIMojixpPwWWCb8xARWn2qtAW5nexWiIr+I2nVi5O
         v+D5hAw1LFeieMiBaB/Hg3Foe+fde7cpEQ8xPsdFz2pHehz+tSJus3PR6zFuPcOFfirX
         kwhYzqpF0O42RiF9i1uthNwKnBHEQJAQpQ+RYKF+pXIMvrmaLJuF44yWcyI0xMuCnaAm
         DHkg4I0ylnQXULMr7fRSPODaFgyHzXJrHSgwQn7RWutCxm1Cxo4gOD4EO9MJSDLLA+Er
         xYHg==
X-Gm-Message-State: AOAM533xg122Ou47OsISwWomn07xgZychwAwddgDreJjumlncNJlkB8c
        k2flig/R02d0yaJlXlftDKM=
X-Google-Smtp-Source: ABdhPJxcOBysSaELekuC/vi15nOoN1KE4eEwu+HeF3wFxB2HBYlX9DtbbfJddm/QGkitxeg9SbVFlg==
X-Received: by 2002:a05:600c:644:: with SMTP id p4mr2940617wmm.34.1644419419720;
        Wed, 09 Feb 2022 07:10:19 -0800 (PST)
Received: from krava ([2a00:102a:5010:3235:47fb:6193:ef68:761d])
        by smtp.gmail.com with ESMTPSA id n14sm16398700wri.80.2022.02.09.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:10:19 -0800 (PST)
Date:   Wed, 9 Feb 2022 16:09:46 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kim.phillips@amd.com, linux-perf-users@vger.kernel.org
Subject: Re: [bug report] perf env: Add perf_env__cpuid,
 perf_env__{nr_}pmu_mappings
Message-ID: <YgPZOiExIZzgw/PH@krava>
References: <20220208112239.GA18799@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208112239.GA18799@kili>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 08, 2022 at 02:22:39PM +0300, Dan Carpenter wrote:
> Hello Kim Phillips,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 9fe8895a27a8: "perf env: Add perf_env__cpuid,
> perf_env__{nr_}pmu_mappings" from Aug 17, 2021, leads to the
> following Smatch complaint:
> 
>     ./tools/perf/util/env.c:476 perf_env__nr_pmu_mappings()
>     error: we previously assumed 'env' could be null (see line 470)
> 
> ./tools/perf/util/env.c
>    469	
>    470		if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
>                      ^^^
> Checks for NULL
> 
>    471			status = perf_env__read_pmu_mappings(env);
>    472			if (status)
>    473				return 0;
>    474		}
>    475	
>    476		return env->nr_pmu_mappings;
>                        ^^^^
> Unchecked dereference
> 
>    477	}
> 
> regards,
> dan carpenter

I think we need to bail out for !env

jirka


---
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 579e44c59914..bc30d8cd2790 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -467,7 +467,10 @@ int perf_env__nr_pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->nr_pmu_mappings) { /* Assume local operation */
+	if (!env)
+		return 0;
+
+	if (!env->nr_pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return 0;
@@ -480,7 +483,10 @@ const char *perf_env__pmu_mappings(struct perf_env *env)
 {
 	int status;
 
-	if (!env || !env->pmu_mappings) { /* Assume local operation */
+	if (!env)
+		return NULL;
+
+	if (!env->pmu_mappings) { /* Assume local operation */
 		status = perf_env__read_pmu_mappings(env);
 		if (status)
 			return NULL;
