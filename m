Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600D6C64ED6
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Feb 2023 08:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjB1Iwj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Feb 2023 03:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjB1IwE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Feb 2023 03:52:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1123D17CC2
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:51:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so8810349pja.5
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Feb 2023 00:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DT1kTlRkpOvzUrpehXB4L+ZBQg4AVY3DSAFM0E9WnMo=;
        b=JgVXOKueiGhuI8TWecNTKpDvXL45OziMa/uV+4scmyPZZZHsPXMImaLR2QlF3tGVW1
         VOvweFMRl8VkRRA7FhV7wVu/9nfcrKV/zoy4gL8N3RicHA3RxVmz+NHfZSjaJDw7aPW1
         cRRNDFHj0LUnEExQL1+a+goEStRj0avc/2c5h3efHIhHL0O2Co6Ym4pWjkmYD4hDolEX
         +Qxpt3Z6FXtRYsVyPV+fUP4g/7G1QapigSOOZPXe2N8YgXzDgf/GBByMUU05Ubx6UMoQ
         uP9Z1GAFrnqPHphdnH5+HKVCMUrUeRZbEwXg4hTaSx/z6XtYbWLWYUOXAJE/keX6Tze8
         b8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DT1kTlRkpOvzUrpehXB4L+ZBQg4AVY3DSAFM0E9WnMo=;
        b=sCm+INRFnHnFiKKl8AEqIQB/74qctQwKYt66wHsLat+iZC2s6nHdyhul21eoUX1bz7
         ncryEvE0wou24uh1P5duU8lMxn3hezCQYCW1K2WLz+GsOfnwkVaWQ5qinif0rdVGsTx5
         wHFoU4C7dpgp3rHzVUNSwr3Q/Kcx9xfvD+12vZrxFlxy8Gqqof2M4TxwRb5roOjAjSfm
         88JQS1w1zKzwwTW5zbKIFH+9QmoNas0FPLqs8/tQ9nGW0Uoz4Cmmz/ssmSthky0D46BB
         hf7ZWnZqmd0vfHPMMP060H3IGMfnLmGfTk14zCpwjq7ePsY1LhMFmHhSg3NXM9na20ed
         /Z1w==
X-Gm-Message-State: AO0yUKXNMqy7y8ndYvsG4fmSYb3LLYQUyhCs/ijBAcnDFRKpOBky4Ce8
        1hh7yd2opTXj8MpH3u5RPVsN8A==
X-Google-Smtp-Source: AK7set//aJ/+ZilVjgBJf2ou2e2xLsStkIHj5RNIfSCb2QhTI7EWTtk1ZRIopm0fLLfY7J6iReY3VQ==
X-Received: by 2002:a05:6a21:32a5:b0:cc:9b29:f61d with SMTP id yt37-20020a056a2132a500b000cc9b29f61dmr3189697pzb.6.1677574314396;
        Tue, 28 Feb 2023 00:51:54 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048225.netvigator.com. [58.152.48.225])
        by smtp.gmail.com with ESMTPSA id j8-20020a636e08000000b004fc1e4751d5sm5187185pgc.35.2023.02.28.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 00:51:54 -0800 (PST)
Date:   Tue, 28 Feb 2023 16:51:49 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] perf kvm: Support histograms and TUI mode
Message-ID: <Y/3ApYi3GLCVGEZr@leoy-yangtze.lan>
References: <20230226042053.1492409-1-leo.yan@linaro.org>
 <Y/0jPa9xu371PtRS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/0jPa9xu371PtRS@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Mon, Feb 27, 2023 at 06:40:13PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > And I verified the '--stdio' mode and confirmed it has the same result
> > with before applying this series.
> 
> Can you provide precise instructions for all the steps involved? from
> 'perf kvm record', I'm trying here with a simple 'perf kvm record' and
> then starting vm and having trouble.

Below are steps for verification this patch set.

In a terminal, I launch a KVM virtual machine with qemu command; I
downloaded an Ubuntu iso file [1] ahead and used it as the file system
image (or you could use any distro's iso file as file system image):

  $ qemu-system-x86_64 -M pc -enable-kvm -cpu host -m 4096 -hda ubuntu-22.04-desktop-amd64.iso

Then in another terminal, I can use below commands to capture KVM trace
data and report the result:

  # cd linux/tools/perf
  # ./perf kvm stat record
  # ./perf kvm stat report          => Output in TUI mode
  # ./perf kvm stat report --stdio  => Output in stdio mode

Note, I have sent out the patch set v2 to fix a potential building
failure in patch 13.  Please work on the new patch set [2].

Thanks,
Leo

[1] https://releases.ubuntu.com/22.04/ubuntu-22.04.2-desktop-amd64.iso
[2] https://lore.kernel.org/lkml/20230228084147.106167-1-leo.yan@linaro.org/
