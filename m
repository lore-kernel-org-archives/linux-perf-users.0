Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B6EE49AF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 02:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjHWCiv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjHWCit (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 22:38:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2712E51
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 19:38:46 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bca857accbso4011197a34.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692758326; x=1693363126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTuoNAPJjhEfJo2OfKuB84Fta+CXlvmq3TsH4v0Gc3g=;
        b=jyddBpA6JF26tJElQM9u56fmP7n8yWWcXgzfN5Thy8dDv+owhfZa1KkDLVu2fycyF0
         PEqSfqxoFUa8npK0jl2U0vF6NaC4rDusoXZFImuIw5m1S2EokaY38+a4LbpzYCEfD6w4
         arE2N/NQlSdBHW6P85jX8+G64byXCcHiMmI26IgemCS63nrpcIKKbg/dxxAgPWOK0H1y
         0GkSuc/UxgOuJRJGw0jH79dqqDmzESN8DSRTd+Tq5aFgdsUb6IhXaU5/Wsnq3qAIYY9d
         Y/RiI+iTfofSF44eT1866KFDqzwenU/5ervB/1czBJF0+WNnUku5eiMoR46vDIj7CQHX
         kn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692758326; x=1693363126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTuoNAPJjhEfJo2OfKuB84Fta+CXlvmq3TsH4v0Gc3g=;
        b=DthYl2XGl21NI1oSmuoBQPKcADpl+ge2x2mYKDu7NVXAK89bci8TyTcmEC98SyLvHp
         K60nBwXPM/oqeZ5iwXFy7Yc7Dyapb/+bmM1/v19gJ+cOQTVw4tIHjRF7mfg1faw80jeu
         TsS/zcAh0jm+2yku018MSAWTYuBjAu6qmFFP1IKYUvlJsa3jbVh/GP4P2GT7Lj/PFtWB
         SEn//pzVdHTvmzHBv1tjkNait+Uiwn43ErVEGnbyX+tYmJwJI8oLtzGxxnyPeg4JmT8H
         lXTuO5gtKT+ohhYDZx1HjmKz7tdqiDxJlZjwnRn0UuG3iXwCgMOL4Z4Bs9UTj7iW/3vW
         gdbw==
X-Gm-Message-State: AOJu0Yx5THFg+Bkm0dcRZvwryQtcwJ73r+DSxJPUdvbPvN/hBhplNiEN
        2ckQKz2gVNEztSfD4Lq0drbwBw==
X-Google-Smtp-Source: AGHT+IGAdnKYLSqSf7A7lfSdx8pKYq98ovZ5cGgI4uVrvPU+aL9l1OQxSIoesF3LdJdnmRB5C0GKdQ==
X-Received: by 2002:a9d:694e:0:b0:6b9:5734:135f with SMTP id p14-20020a9d694e000000b006b95734135fmr12642626oto.28.1692758325869;
        Tue, 22 Aug 2023 19:38:45 -0700 (PDT)
Received: from leoy-huanghe.lan ([94.177.131.100])
        by smtp.gmail.com with ESMTPSA id y8-20020a63b508000000b0056a36ac322dsm5837038pge.4.2023.08.22.19.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 19:38:45 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:38:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: userspace-api: Document perf ring
 buffer mechanism
Message-ID: <20230823023838.GF57731@leoy-huanghe.lan>
References: <20230819093340.265817-1-leo.yan@linaro.org>
 <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

On Tue, Aug 22, 2023 at 05:43:25PM -0700, Namhyung Kim wrote:

[...]

> > +2.3.2 Writing samples into buffer
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Ring buffers are mapped as read-write mode or read-only mode, which is
> > +used for a normal ring buffer and an overwritable ring buffer
> > +respectively.
> > +
> > +The ring buffer in the read-write mode is mapped with the property
> > +``PROT_READ | PROT_WRITE``.  With the write permission, the perf tool
> > +updates the ``data_tail`` to indicate the data start position.  Combining
> > +with the head pointer ``data_head``, which works as the end position of
> > +the current data, the perf tool can easily know where read out the data
> > +from.
> > +
> > +Alternatively, in the read-only mode, only the kernel keeps to update
> > +the ``data_head`` while the user space cannot access the ``data_tail`` due
> > +to the mapping property ``PROT_READ``.
> > +
> > +Why ring buffers are mapped with above two different modes?  Here the
> > +write direction matters.  The forward writing starts to save data from
> > +the beginning of the ring buffer and wrap around when overflow, which is
> > +used with the read-write mode in the normal ring buffer.  When the
> > +consumer doesn't keep up with the producer, it would lose some data, the
> > +kernel keeps how many records it lost and generates the
> > +``PERF_RECORD_LOST`` records in the next time when it finds a space in the
> > +ring buffer.
> 
> Thanks for the update.  It's unclear to me if all 4 combination of
> (rw, ro) x (fwd, bwd) are possible (yes!).  The rw mode and back-
> ward is also possible but just not used for perf tool.

I can add a matrix for the combinations:

  The combination is supported in perf tool:

  ---+------------+-----------
     |  Forward   | Backward
  ---+------------+-----------
  rw |  Yes       |   No
  ---+------------+-----------
  ro |  X         |   Yes
  ---+------------+-----------

  Yes: is supported
  No: is not supported
  X: is not feasible

> And I think the description below in this section shows kernel
> internals too much.  Name of kernel functions and data structure
> is not an API and can be changed any time.  You can describe
> the logic without the names.

Understand, I agree this will introduce maintenance efforts in later.

I will refine the description and send a new patch.

Thanks for reviewing!

Leo
