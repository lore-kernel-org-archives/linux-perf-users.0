Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C44C43334
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Jul 2022 12:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiGNMsr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Jul 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiGNMs2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Jul 2022 08:48:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5385F131
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 05:46:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b11so3176306eju.10
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 05:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jvZurtZKlq4aCcDIj6KW1b11Rl6GOvzgcnfYcBmymiI=;
        b=X/+BtTwhtwx7YRd73pMKOeZBhoEXrgrtuqVcQN0J34oQAYrSfEUOfou3Ksl3MVSsXN
         PZJk4AHoZiPVNO1ygCSSqotQsvPpa6RATUQv78AtY2gbgwDSySpaqaDsKCEo20un7jtm
         S5P3fPS1Ndralh80PbnBNdtn4zSEmh2VCrNeXHjU7g12ZWGzIzB4tynlDe9isa+UmCde
         vB/LToDIYOxwW4iPDUxbzFiZFMHYrEf54Ul0y/sBxOGl+NwMD6k2iT3WVkM77J0iyLby
         LfEWFWM6QLCI76oprwfZrJ/bWC9gX6dmV9yy3ug3yRyQcGtQWAvhBXKso3yDLggnU4HI
         1A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jvZurtZKlq4aCcDIj6KW1b11Rl6GOvzgcnfYcBmymiI=;
        b=bd42KhP51B44TkYuGkJFV8aRbqw0+PocQXLQ6Bi1ZVHUUQ+O1pGF/gGqp+4eucNbdR
         R7piN7F+GXIuwTSMeq2qUtifGcuvsFrmRhbqQO5d/x62ZK5gD9Ney1ONGtIJHsPRpb1O
         2sf1AkoLpAzUvfsUEkFXvwE5rIWcXgiJKgfj8B+UIhYJMxa4M4EPDi3iPv56fVOFHltP
         j2KeyinS+LGR9+8lmdnj6JEY2obAO5JOwsj6k/z6iIV+QQ36yPLUXNQibv6RihgTUjmR
         kP2tPjw+ejY2D9oDiUcSLKUoZ6TeSY4w2BE52fXfswmQ1KcQVSxkFkJjmv/dHf1tTjm+
         +xiQ==
X-Gm-Message-State: AJIora8HagrLulX0Fp285FKfU1dOynhNucD1Pq6h0WWo3iawjyFNIG8Q
        3VazppXDj+YuDWouVF1i/AFbAQ==
X-Google-Smtp-Source: AGRyM1sjcnLAUVfO9UUBCkThTry/i/eoTdA2IjOIuuXxk1IoNFhNjoJmMTL21xR1LOvDGMGHUglXFw==
X-Received: by 2002:a17:907:e90:b0:72b:d0a7:9dd5 with SMTP id ho16-20020a1709070e9000b0072bd0a79dd5mr7887510ejc.18.1657802803696;
        Thu, 14 Jul 2022 05:46:43 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.96.49])
        by smtp.gmail.com with ESMTPSA id uz7-20020a170907118700b0072b6d93b9afsm656288ejb.210.2022.07.14.05.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:46:43 -0700 (PDT)
Date:   Thu, 14 Jul 2022 20:46:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     =?iso-8859-1?Q?Adri=E1n?= Herrera Arcila <adrian.herrera@arm.com>
Cc:     tmricht@linux.ibm.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, James.Clark@arm.com, nd@arm.com
Subject: Re: perf tools: software regression in
 d0a0a511493d269514fcbd852481cdca32c95350
Message-ID: <20220714124638.GB155077@leoy-ThinkPad-X240s>
References: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f15afd38-3628-c57a-0735-1342f379b83c@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrián,

On Wed, Jul 13, 2022 at 08:30:37AM +0100, Adrián Herrera Arcila wrote:

[...]

> I think there are two behaviours that are valuable to maintain to enable two
> uses: (1) if no delay is specified, the program should start after counters
> are enabled, to prevent the unexpected behaviour that Thomas fixed with this
> change; (2) if delay is specified, the program should start before the delay
> is engaged.
> 
> Two possible solutions are: (1) though conditionals; if delay > 0, start the
> workload, then call enable_counters, which will usleep for the delay; if no
> delay, then behaviour as it is in v5.18; (2) replace blocking usleep with
> asynchronous callback, if that exists in Linux, that enables counters after
> the delay.

If we look at other perf sub tools (like 'perf record'), they uses
your mentioned solution (1) to handle the delay and enabling counters,
based on the condition checking for 'stat_config.initial_delay', 'perf
record' enables counters at different time point.

Alternatively, we can start workload based on the condition checking
for 'stat_config.initial_delay', so we can get a below patch, this patch
should can fix the issue, but the change is a bit urgly for me, so
welcome a better fixing; if no, I will send a patch in my tomorrow
morning.

Thanks,
Leo

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d2ecd4d29624..046686a7c8d6 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -970,10 +970,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * Enable counters and exec the command:
 	 */
 	if (forks) {
+		if (stat_config.initial_delay > 0)
+			evlist__start_workload(evsel_list);
+
 		err = enable_counters();
 		if (err)
 			return -1;
-		evlist__start_workload(evsel_list);
+
+		if (stat_config.initial_delay <= 0)
+			evlist__start_workload(evsel_list);
 
 		t0 = rdclock();
 		clock_gettime(CLOCK_MONOTONIC, &ref_time);
