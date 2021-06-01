Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A0BC47093
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBA1613AB
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 14:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhFAO6p (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhFAO6o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 10:58:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2FC061574
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Jun 2021 07:57:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so2101589pja.2
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Jun 2021 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y8hG5FSgqiGMOcVqCqEOwlereqNOwwJAqT4WXbiJqD8=;
        b=ToW2mEKPjYpiZ3coTlBAjElAf10TJWzS9mC/KmCix5X+8HGKBUEu4wIbcmN5hyIoF8
         ZCn9vvKkg8fWHfLHDQSSGEYaNvIMEJQqngy1b65Rqfiy8oGt5+qQ/RkepfU74nv+KDEk
         XMhYTfL7LcUs+0TSMtxfEN+cYV3AyjtE4wAGM8p0skVLXDXbQylOcXpG4P0a/zfI2nCO
         LMghx66Zf2mOXE+9R57kzRutGJ8cJLm/Mx+q5YQsybLep2QaZDSFXhxJhEEavb5yyj1l
         +i1RVx4oAd6tIAjZpQaXu3AMafQaAgMQ/XTeZTBwmHR5urpQA/WndKJY+oKA/j93Z+Xn
         /VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8hG5FSgqiGMOcVqCqEOwlereqNOwwJAqT4WXbiJqD8=;
        b=UfFw8jaHW/0eKMtLUIKTFQrJ3RmDLpEDQ+yppOyvOJwgjFdXzgv7x67aYGdGg3pXi3
         t1/uVppuCq3j6o/ZbjkDyH+w/BhZLGX8MvHWVvq0Y4qmfOJuvr+nwHucNXs26gjTglHk
         H/HkwfMkrle1saYeFDbDcvPd7Y4W8rSA/fXK0QI5Wxvi4iw3x/J+rBTQbrz6ZIRHQ55N
         TP8hU3lVHtAk1xK8cddBeqY91nzef/iI58aBRpbPzkYhD66yTs31Xucn4Mn7K6aOWi2P
         ktNqg4oUTdBtKY9zmskgnrHtEKTeK0qpQIXQjBk7Xd//DtoQ5uK41eZOblMkPbsn9jir
         GvmA==
X-Gm-Message-State: AOAM530nZvEFzq/FWqJfHSK8jKD5GV2s9MokAAQck3dpuYtbhIPX2FRe
        kvtY4oTUyf4qIYdsRpKiTnqzrw==
X-Google-Smtp-Source: ABdhPJzEts9R19AI12770iw1ZWLp3GZjZ4fVGrjEqOXk0XpTzXmgtGdhSpoCzDGd8+XRSTh19Jrqkg==
X-Received: by 2002:a17:902:be0d:b029:f9:c913:821f with SMTP id r13-20020a170902be0db02900f9c913821fmr26473481pls.2.1622559421899;
        Tue, 01 Jun 2021 07:57:01 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id p1sm13354049pfp.137.2021.06.01.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:57:01 -0700 (PDT)
Date:   Tue, 1 Jun 2021 22:56:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with
 load-acquire and store-release
Message-ID: <20210601145656.GA10272@leoy-ThinkPad-X240s>
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
 <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
 <YLX7OhK37QmfeOwu@hirez.programming.kicks-ass.net>
 <4af1a96d-e03c-f1b4-ebce-ca869318c8cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4af1a96d-e03c-f1b4-ebce-ca869318c8cf@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 01, 2021 at 12:45:16PM +0300, Adrian Hunter wrote:
> On 1/06/21 12:17 pm, Peter Zijlstra wrote:
> > On Tue, Jun 01, 2021 at 12:07:31PM +0300, Adrian Hunter wrote:
> >> __sync_xxx_compare_and_swap is out-of-date now. This page:
> >>
> >> https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins
> >>
> >> recommends '__atomic' builtins instead.
> > 
> > perf doesn't seem to use that.
> 
> I guess we could drop support for the compat case; add validation:
> 
> "Error, 32-bit perf cannot record AUX area traces from a 64-bit kernel.
> Please use a 64-bit version of perf instead."

Not sure what's a good method to detect the compat case.  I can think
out to use below conditions to check the compat case:

  if ((sizeof(unsigned long) == 4) &&
      (machine__is(machine, "x86_64") || machine__is(machine, "arm64") ||
       machine__is(machine, "aarch64")))  {

       pr_warn("Error, 32-bit perf cannot record from a 64-bit kernel.\n"
               "Please use a 64-bit version of perf instead.\n");
       return -ENOTSUP;
  }

Just want to check if any better to detect compat case in perf?

Thanks for suggestions,
Leo

> >> Since atomics are needed only for the "compat" case (i.e. 32-bit perf with 64-bit kernel)
> >> you could try to find an elegant way to check for a 64-bit kernel, and avoid the atomics
> >> for a 32-bit perf with 32-bit kernel.
> > 
> > Most 32bit archs cannot do 64bit atomics. I suppose the only reason this
> > doesn't explode is because the aux stuff isn't supported on many
> > architectures?
> > 
> 
> Yes but presumably the race itself is unlikely since the upper byte changes only once every 4GiB.
> 
