Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D7CEB64DD
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Aug 2023 16:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbjHCQ5o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Aug 2023 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjHCQ5X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Aug 2023 12:57:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98BA468E
        for <linux-perf-users@vger.kernel.org>; Thu,  3 Aug 2023 09:56:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-687087d8ddaso1032549b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Aug 2023 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691081802; x=1691686602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF5iQrEfo52tfmrVUbalVYIcokRwhlgV2+zRKbvqOFM=;
        b=FrQWtB+LlhO/fGuTpdFj6X8T+njpablkd6BqGtaQR6dU38C6ib70qfD5cOKM0sX8tP
         vkketG1Y4QqHDnyjw/NLGu27ETnP1jjudf6MS2rwBqyJCj8mzCXttCu2aRnHiG3ZV4Sj
         7UVQCowmLE2Tb6DiXLQbqq4l9EXCWAmSyBpXatwDfx7ccyMjHgjQ6hjxxn8TXOqqSo6A
         IyZuP5InSMYiJ/S+pycG9WtBMJMcumI0juhxgPHZn9dOMyu4a6o7FvTP5WXItmmMX2Hb
         ooIq0SZ703AEx+lDABnzxXaxQYHXSVC9Xof1INO3nklrmJnTTFYe78XfC14S61AFZsI7
         vRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081802; x=1691686602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF5iQrEfo52tfmrVUbalVYIcokRwhlgV2+zRKbvqOFM=;
        b=IKtlPWwhlaxBOD6r7oKn9DhLsrp9gyMYSoBwFIzntwO/3C6LHiLetnP3UD47XY5/JN
         NWU1yErTQVNsyZI9mK2DvKNJFhZ3d5tb0YXxacwpnLgH/CLsom1Z9K3OnmUJ5nBekt5s
         QHPhhkXajGJJ1i/n0ukxj1kacCy85vyTaCFKuGdbSVuivvYlQLSACGhs8COAZgSo3A1O
         eQvys9YotzQxO6/qzLmhmpcl2zaM48+qQZOX6Q5x8Vy/VA2Zm5R7Km9jkb0edUm6IRqz
         C69dezn5f1TkkFu27y6FqRUZagQnOe8NroMrR8MTaqophKWvEbYf/KTppFJ2PNKcxA3s
         bpsw==
X-Gm-Message-State: ABy/qLZsS6wwfCWK+IN+QHJWYyNceXgaGtz3dR7XZOkd0c6rAC723k2A
        erE5DduTt0IQc3WRRgKtlBepkg==
X-Google-Smtp-Source: APBJJlFo80PDH4xMdM5+Al+USUFkGWPutqXeBsPA9BpTVp0jH2AaGJhVIQUSn5ubrf3ontdYMnP5nw==
X-Received: by 2002:a05:6a00:18a5:b0:686:24e1:d12e with SMTP id x37-20020a056a0018a500b0068624e1d12emr23614520pfh.30.1691081802601;
        Thu, 03 Aug 2023 09:56:42 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7900d000000b006871859d9a1sm99853pfo.7.2023.08.03.09.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:56:42 -0700 (PDT)
Date:   Fri, 4 Aug 2023 00:56:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf doc: Document ring buffer mechanism
Message-ID: <20230803165636.GB1783639@leoy-huanghe.lan>
References: <20230803035037.1750340-1-leo.yan@linaro.org>
 <87v8dw6vp1.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8dw6vp1.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jon,

On Thu, Aug 03, 2023 at 08:34:50AM -0600, Jonathan Corbet wrote:
> Leo Yan <leo.yan@linaro.org> writes:
> 
> > In the Linux perf tool, the ring buffer serves not only as a medium for
> > transferring PMU event data but also as a vital mechanism for hardware
> > tracing using technologies like Intel PT and Arm CoreSight, etc.
> >
> > Consequently, the ring buffer mechanism plays a crucial role by ensuring
> > high throughput for data transfer between the kernel and user space
> > while avoiding excessive overhead caused by the ring buffer itself.
> >
> > This commit documents the ring buffer mechanism in detail.  It provides
> > an in-depth explanation of the implementation of both the generic ring
> > buffer and the AUX ring buffer.  Additionally, it covers how these ring
> > buffers support various tracing modes and explains the synchronization
> > with memory barriers.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> 
> So this seems like good material from a very brief scan.  I do have to
> ask, though: why is it not in RST, and why not put it into the
> user-space API book?

This documentation is Perf related topic, so my instinct is to place
it into the folder tools/perf/Documentation/.

Strictly to say, the doc doesn't give formal introduction for the
user-space APIs.  Given perf ring buffer is a mechanism for exchanging
data between the kernel and user space, I am open for placing it in the
folder Documentation/userspace-api/.

I would like get opinions from the perf maintainers if possible, if we
have agreenment I am glad to convert it to RST format.

Thanks,
Leo
