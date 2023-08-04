Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E267C001DE
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Aug 2023 09:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHDJOP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Aug 2023 05:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHDJNs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Aug 2023 05:13:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF266A7A
        for <linux-perf-users@vger.kernel.org>; Fri,  4 Aug 2023 02:10:34 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68783b2e40bso1321609b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Aug 2023 02:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691140233; x=1691745033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIgVcI/DAV+syZCzOifgnr1978K5ZgzsoAA4MZTsdr8=;
        b=gfsJb+lP9iAhBqFb5nmJR6SFpsVvn9z6Qoa51edQoEd6CqKZdUnmyFX+sXP7iaW0Wn
         aTqtp/hlkscVLQGHgh7Rou5pcYN3z9T1dJ8USTpCMhj1hSAKSiM2x1bFdiu9T90IiwHi
         a/8ABoUc/gyiOntvYldRd82s9cLH4+JwXGlce7bknV93L0ruhwipZLpRuA3W5AP02aj4
         0FuH1qObKYzEc0IBBqas8YjEBr1BtU6+dc170qqINX5kJhlP5wggAjyDbggxK3b8gG/7
         aUebgtHN7zEKzom7WkL45iuRRh//yiq6zJzjR+zg64QQB211uhgWG6Z1oC17YUkIwUBS
         6AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691140233; x=1691745033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIgVcI/DAV+syZCzOifgnr1978K5ZgzsoAA4MZTsdr8=;
        b=heKkSGq8Xx9VcY6eMLp0mgXAS9XmkUf1rX7WTb0+kMD8Z6MJfwS7JwoaQlWnL8JIX5
         re+SuUcovXjewgTTj5B0/uWdMz4cUOSni/v48dlFZnm83SCa/MjAxLUDz5cXK7dTrQL9
         osfOE1+D26jPbUrOhk/8w/fT4Tuwr3UsQvyztdga3X/BtpPksjjylt0Je463N+AGDOzD
         oDp5fiIxP94h4Oc7P8/X5Q8kfijk7DCfsWv/v1o08akBWhrFNlRN3ef77/ybZzWdlc23
         sK6SOBzZCXnVrO6WrNhSgbK6S74PoKUeKlCs37gA+0bwuAfRLFGC9E69PXIuzh/VSRIB
         vc5Q==
X-Gm-Message-State: AOJu0Yww526OBt/lrP9zA959FTm5ST3jGE82hjXV/88fr+BCGR+1mI/c
        zSNWerFlX8A3Jj3kELLec/ftXQ==
X-Google-Smtp-Source: AGHT+IGQTzI2vosQeS/05F0bAnTIYQcz2dkP7E+eYl2x2kSGbAeqf2u97F51YVcj5qeB9WSEEZid6Q==
X-Received: by 2002:a05:6a20:3d82:b0:12b:1686:3012 with SMTP id s2-20020a056a203d8200b0012b16863012mr986031pzi.3.1691140233508;
        Fri, 04 Aug 2023 02:10:33 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id x19-20020a170902ea9300b001b1c4d875f5sm1254478plb.44.2023.08.04.02.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:10:33 -0700 (PDT)
Date:   Fri, 4 Aug 2023 17:10:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <20230804091027.GC589820@leoy-yangtze.lan>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <87v8dw6vp1.fsf@meer.lwn.net>
 <20230803165636.GB1783639@leoy-huanghe.lan>
 <ZMwTyVKPn0cRewEc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwTyVKPn0cRewEc@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 03, 2023 at 05:53:29PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Aug 04, 2023 at 12:56:36AM +0800, Leo Yan escreveu:
> > Hi Jon,
> > 
> > On Thu, Aug 03, 2023 at 08:34:50AM -0600, Jonathan Corbet wrote:
> > > Leo Yan <leo.yan@linaro.org> writes:
> > > 
> > > > In the Linux perf tool, the ring buffer serves not only as a medium for
> > > > transferring PMU event data but also as a vital mechanism for hardware
> > > > tracing using technologies like Intel PT and Arm CoreSight, etc.
> > > >
> > > > Consequently, the ring buffer mechanism plays a crucial role by ensuring
> > > > high throughput for data transfer between the kernel and user space
> > > > while avoiding excessive overhead caused by the ring buffer itself.
> > > >
> > > > This commit documents the ring buffer mechanism in detail.  It provides
> > > > an in-depth explanation of the implementation of both the generic ring
> > > > buffer and the AUX ring buffer.  Additionally, it covers how these ring
> > > > buffers support various tracing modes and explains the synchronization
> > > > with memory barriers.
> > > >
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > 
> > > So this seems like good material from a very brief scan.  I do have to
> > > ask, though: why is it not in RST, and why not put it into the
> > > user-space API book?
> > 
> > This documentation is Perf related topic, so my instinct is to place
> > it into the folder tools/perf/Documentation/.
> > 
> > Strictly to say, the doc doesn't give formal introduction for the
> > user-space APIs.  Given perf ring buffer is a mechanism for exchanging
> > data between the kernel and user space, I am open for placing it in the
> > folder Documentation/userspace-api/.
> > 
> > I would like get opinions from the perf maintainers if possible, if we
> > have agreenment I am glad to convert it to RST format.
> 
> Yeah, I agree with Jon.

Okay, I will spin a new patch based on this discussion.

Thanks for confirmation.

Leo
