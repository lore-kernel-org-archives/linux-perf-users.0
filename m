Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7AEC43334
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Jun 2022 20:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbiFQUL2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Jun 2022 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244439AbiFQULZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Jun 2022 16:11:25 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FE421276
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:11:22 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d23so3937270qke.0
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jun 2022 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5rlwEuaaxo2GmABtFmb86pra51ZtJdGFDNYMQBKtQiQ=;
        b=Amwtt37q0TAHLJo9OWoQ57m7cwEXUUlK9BNAjiGkATrr0ZnlYY/ZIWZXz5jhtubAwa
         ay6UvC5d7ucVemSZiVy72V4TFB4Hq7QzSsFxWzYE4hbfGxR6ASD5Oyt1WOrmnI/c3ZIn
         Lg+U0tl3lBi62sVy4m1xiSvrEv4rzBYDpz9hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5rlwEuaaxo2GmABtFmb86pra51ZtJdGFDNYMQBKtQiQ=;
        b=HVZyreh3eH1Rnqd5AZjD6BhlVQofpPKwwzf/SoLE++GUOFYtVRRo0sn7PNaLvxgh86
         1O9AKR3n/Dg7b9BZ7BY65QKRsqQNf6ayZd6sQa9kGLGfvbJIYPYL6+s2N5zZOVYonryR
         FIqQYWSWKuD2l1vFWGu3q32r+D92bDAiX5NI9vu4V8G9Bl4w4zFDAae79vL9gaWftd5k
         3Y0BKXj+xtY2DTB0bs7/xKw6KMr8ZpV++iMYCnT6OY3NR9j92DTQMl/xNykmbKsIXCUX
         a+a4mfdQzAzmrazNX2JCoNg7RJyepTuPohQLyQTZ3+AKAcWGEpG/SQD0zpXRViGJrh57
         IDcg==
X-Gm-Message-State: AJIora/9BVTlhR0DwTWtBQlrPkrZdbfCjVRVvd0UkJvx10UzvZgur0ub
        NrPjVb5TrS3Dc9eE/XshWB2A2g==
X-Google-Smtp-Source: AGRyM1tCJS31ETIPRbVR9J9Z+Pn7k5BuwKPDGFgxLIQ6d78ANXt8jtThPMTD0zCl4YXlFh97x7Vebg==
X-Received: by 2002:a05:620a:4048:b0:6a7:7cb2:f48 with SMTP id i8-20020a05620a404800b006a77cb20f48mr8587526qko.578.1655496681451;
        Fri, 17 Jun 2022 13:11:21 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id o12-20020a05620a2a0c00b006a726b03ad1sm5404695qkp.52.2022.06.17.13.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:11:20 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 17 Jun 2022 16:11:19 -0400 (EDT)
To:     Rob Herring <robh@kernel.org>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [perf] why is /proc/sys/kernel/perf_user_access ARM64 only?
In-Reply-To: <CAL_JsqL+0z1vc+T+9m-faoM-4W=x=7-UBu5=S-QGjTwU2biGNw@mail.gmail.com>
Message-ID: <d4b3f6e2-46f7-7921-17ab-d249f5047a8@maine.edu>
References: <30d95df2-c3b-b3e3-d65e-c6be0355fb1@maine.edu> <CAL_JsqL+0z1vc+T+9m-faoM-4W=x=7-UBu5=S-QGjTwU2biGNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 15 Jun 2022, Rob Herring wrote:

> On Wed, Jun 15, 2022 at 11:57 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
> > It turns out ARM64 has added a custom
> >         "/proc/sys/kernel/perf_user_access"
> > to control rdpmc access, but only on ARM64.
> >         e2012600810c9ded81f6f63a8d04781be3c300ad
> >
> > Why is this ARM64-only?  Why isn't this generic perf infrastructure?
> 
> Adding it on x86 would break users at least if default off.

Well in theory the file could have been added on x86 but default to on.
Some of the low-level perf feature detection is bad enough as is, without
having architecture-dependent proc files to worry about too.

> > How is this different from the existing
> >         /sys/bus/event_source/devices/cpu/rdpmc
> > tooling?
> 
> big.LITTLE

interesting.  I wonder how x86 Alder Lake deals with things.

In any case I guess it's really too late to do anything about this.  I 
should check to make sure the manpage gets updated.

Vince
