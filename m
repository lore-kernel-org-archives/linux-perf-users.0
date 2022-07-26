Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425BAC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jul 2022 00:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiGZAza (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiGZAz3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jul 2022 20:55:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082A824F25
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 17:55:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy29so23409920ejc.12
        for <linux-perf-users@vger.kernel.org>; Mon, 25 Jul 2022 17:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ILf1h5u1nM9ffsTeHOVxXz+E3MwVXVmsI4fPGP1KKw=;
        b=zPFG/2GOaR/DN0ilqBdjYm0XIP9wkDh4fBPTbZ8eGcFFCaO6w99PdaXUgbF+Ns2gg5
         kaXL+NjmkYRGrg/FOE2KS8FDCWDJW3Lun09UkE/8CG0Vj7NQ+XMg+Ut8ki6Iqt7Gr/6U
         s6Xa0Sr/dGNR/mSZk4ZHJaBSTVywrxfhaKYrJJ7qaEG4pegFYCzRvuyDJkg8G8hYakb7
         P4AdfTTKgBCjr4aJCHdRYNWKXKvopVoM1oDSXuQxnAejbX+yFYVyRFj12+KkFuQuQINH
         zA0PWQxNmiZ+cIbDBztMJ9O8Edin1hPjsqiVt4uEnVtxDOLHxlbk9eYlkRRQhBU2s4bH
         a1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ILf1h5u1nM9ffsTeHOVxXz+E3MwVXVmsI4fPGP1KKw=;
        b=lwjeHKPdbQ7dpKR+TZR56HckfMY6tncY4CMSsEcqTp7bW7tM8+ppEx7PZ5nFa0VXHm
         tdn7c1x9+Si2wkRY6k3W4rjH/0AR7ryC7fBUEfknjfW1LUYZK8i38bkrGIfAlIAgJYx/
         m64CE+TAUTVueIlQsMr5Q2dMSN5drqWnjZYu0i3c2pMF40+ixKF5jcTCAoDJ1oOwAt2D
         l4ysQ00g2R1bWTKl96qaBq2dspEcObVOd6ii27ivsCJLa1gnbwhxk7EvW+IkVoSom6y2
         D/caicHnMbG5D8n0JQaTt7oRBtRB1tjnD+VDCr8LK9DrSCKllh1IxZNRD85tggiCUKST
         VRQQ==
X-Gm-Message-State: AJIora+Vr4+536rRXtYP8IEgScfnsiMYtsHs5LBw35422f4047iP4OVf
        GnDMTvu/Bczpyg4US8Dp4GMTrQ==
X-Google-Smtp-Source: AGRyM1sreX/ffzyrEmA/aUBlxPJLFoGG39ka/uwfVU+GJRvz7mCLAzjPa4nOFzacaioGLh8ukPH+Zw==
X-Received: by 2002:a17:906:8477:b0:72b:3e65:55c5 with SMTP id hx23-20020a170906847700b0072b3e6555c5mr11706963ejc.255.1658796927399;
        Mon, 25 Jul 2022 17:55:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([104.245.97.243])
        by smtp.gmail.com with ESMTPSA id g20-20020a17090669d400b00727c6da69besm5948091ejs.38.2022.07.25.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:55:27 -0700 (PDT)
Date:   Tue, 26 Jul 2022 08:55:22 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] perf symbol: Minor fixing
Message-ID: <20220726005522.GB36862@leoy-ThinkPad-X240s>
References: <20220724060013.171050-1-leo.yan@linaro.org>
 <CAM9d7chkrqr4P5AMRYw48JcDNsrGSMRKhwyamY5NAWbuF6jttw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chkrqr4P5AMRYw48JcDNsrGSMRKhwyamY5NAWbuF6jttw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 25, 2022 at 09:54:21AM -0700, Namhyung Kim wrote:

[...]

> > This patch set contains two minor fixing for parsing symbols.

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks for reviewing, Namhyung.

Leo
