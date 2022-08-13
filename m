Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B0C19F2D
	for <linux-perf-users@archiver.kernel.org>; Sat, 13 Aug 2022 14:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbiHMORr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Aug 2022 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiHMORq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Aug 2022 10:17:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116841C902
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Aug 2022 07:17:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r69so3045019pgr.2
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Aug 2022 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+E0k8hootfoswIfOh4pYh7kOzDD2ZwZBXauTpEBfTNY=;
        b=PckzpwNDmR1DPo9Tpu8HXT3zfLGDm/6xPpFz292MntKjHxmXhueXCyOCsfLR1/UCTp
         7PFJC1waq+WOLonucIStJGiwR9/MjuvG5PXxN6gJGZTe667GwG31fovL4+zOab40bmnt
         0EyJPyXbwOfGlLW1SNy/OkfrFYszG4MqPf/vjvF8xELi2knDZxJuzbbo4Un/ZYAHePQE
         14jEioSIZMQSk7WLOeYXIUQlwKFhUGPz3iDaDywHYIo2Lgl14zmE5mkumy/agVh4LsfE
         Q8c8jYl6p2pMhRwiuUmOpf/b4yV03vzDaH81aQu9j0ItEuEZQQOW1d5Spr0RUe48aZ9h
         H9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+E0k8hootfoswIfOh4pYh7kOzDD2ZwZBXauTpEBfTNY=;
        b=fksdggVxDWrb+RxwsskmarXVNUsDUHxtNVNSsgdjcjApwKvI+qIXdCyYMo28SQeT5K
         G8FqZzPmzD9HXB+1cBQx28UuPv4Q0nZ2QRrEpB3mjsyG29wQtGuf4kBQbjBpIxbPs6Rj
         uUXQ9jUn7vNYuXV1GxxSrTp/3U+x5yzdOA3daxb1Y3Nq4+v68U4XgL3op4khAm/3EQXf
         GsAKOkUGsCFusicaCVwLd/a6GXy64km154NI01y92+97y2hYgkQ0ySaApNCMIz+JfLJy
         d7qK/0qGCB31UYC0Gf8c2SmuSngyupGJcd8bfbqwpRWzFxZcEW7W/GzCGYgQMyUYwo3F
         cWXA==
X-Gm-Message-State: ACgBeo1Qyj2GCQAiyHS9V0+GcvgFkYc5jp1lQUHMJoC37S0ZNznmdIKv
        MwiebI2TIELG4IrZN4w7+uZSdw==
X-Google-Smtp-Source: AA6agR6YNktXnQb8y//5O6cLR57gk7hHZamYnXgwIbZ7rcEmRfRZk3gLbXljY1sGNWjqR5W1QNxqYA==
X-Received: by 2002:a63:c1f:0:b0:41a:9b73:a89e with SMTP id b31-20020a630c1f000000b0041a9b73a89emr6897036pgl.342.1660400264394;
        Sat, 13 Aug 2022 07:17:44 -0700 (PDT)
Received: from leoy-huanghe.lan (n058152048222.netvigator.com. [58.152.48.222])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0016d2db82962sm3808367plg.16.2022.08.13.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 07:17:43 -0700 (PDT)
Date:   Sat, 13 Aug 2022 22:17:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     carsten.haitzler@foss.arm.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 00/14] perf: test: Add trace data quality tests for
 CoreSight
Message-ID: <20220813141739.GB687527@leoy-huanghe.lan>
References: <20220812121641.336465-1-carsten.haitzler@foss.arm.com>
 <Yvaj2ukXV+SLIBR0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvaj2ukXV+SLIBR0@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 12, 2022 at 04:02:50PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 12, 2022 at 01:16:27PM +0100, carsten.haitzler@foss.arm.com escreveu:
> > From: Carsten Haitzler <carsten.haitzler@arm.com>
> > 
> > This is a prelude to adding more tests to shell tests and in order to
> > support putting those tests into subdirectories, I need to change the
> > test code that scans/finds and runs them.
> > 
> > To support subdirs I have to recurse so it's time to refactor the code to
> > allow this and centralize the shell script finding into one location and
> > only one single scan that builds a list of all the found tests in memory
> > instead of it being duplicated in 3 places.
> > 
> > This code also optimizes things like knowing the max width of desciption
> > strings (as we can do that while we scan instead of a whole new pass
> > of opening files). It also more cleanly filters scripts to see only
> > *.sh files thus skipping random other files in directories like *~
> > backup files, other random junk/data files that may appear and the
> > scripts must be executable to make the cut (this ensures the script
> > lib dir is not seen as scripts to run). This avoids perf test running
> > previous older versions of test scripts that are editor backup files
> > as well as skipping perf.data files that may appear and so on.
> > 
> > Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> 
> Leo, can you please check if your previous Reviewed-by tags stand for
> this new version?

Yeah, after applied this patch series on the repo:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git, branch perf/core;
it has merging conflict for the patch 03 "perf test: Add build infra for perf
test tools for CoreSight tests".  It's good to rebase this patch set on the
latest perf/core branch.

I compared patch set v5 and v7, confirmed the my comments have been addressed
in v7.  Carsten also has updated patches' author address, it is same with the
address used in SoB, this is the right thing to do (Sorry I missed that).

I tested this patch set on my Juno board and observed a regression related with
CTI driver, the regression is not relevant with this patch set, I have
reported it on CoreSight mailing list.  This will be investigated separatly.

When played these test cases, I observed a failure for below case; but when I
re-run the case again and it passed.

  # ./perf test -v 78
   78: CoreSight / Thread Loop 10 Threads - Check TID                  :
  --- start ---
  test child forked, pid 6233
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.380 MB ./perf-thread_loop-check-tid-10th.data ]
  Thread IDs  6242 6242 6242 6242 6242 6242 6242 6242 not found in perf AUX data
  test child finished with -1
  ---- end ----
  CoreSight / Thread Loop 10 Threads - Check TID: FAILED!

You could see the perf data file is abnormally small (0.380 MiB), it should be
an issue for perf cs-etm record.  I don't think this is an issue for the test
case itself, we need to look at this issue later.

So with fixing the merging conflict:

Tested-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>

These test cases are for trace data quality, I'd like wait a bit for Mike's
green light since he has much better understanding.

Thanks,
Leo
