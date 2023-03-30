Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D28C74A5B
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Mar 2023 02:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjC3Cc1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Mar 2023 22:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3Cc0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Mar 2023 22:32:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A319524E
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 19:32:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q102so15925423pjq.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Mar 2023 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680143545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3cJZfEXazIu0RyCr6dj5L3jtGo+WiGbTKxGLGBfEyo=;
        b=MBFKxmiUeIKmhWq8oeCh+GRAwRucQ7yAnW5myJl/xjb/CMm18Irj+t0hkbFJZetlZg
         kp28RJDE75Xsd3aEcaQU5aQngMEaNkTiVd96w/qk2FYx7aqvAyMfPDjtn9hWJDgt12cK
         bocoOOYGFfslK50UwpBKfY5BaV7cFLhdvCxJhjSkA8DenK5FE+zj5YiduMfEXM/2t5l3
         I4B0QFPB9pYefBbSwYnFLPYcD9ODLH+asd6vlOytqQuGee8nrFB1hI8dPpA63tz3LJb1
         IaEtm234YrJxi8dtZJ+NfxZDN+QJK9m3K+meSq9CsSenPhBtriMnR5icR8cZlw5WeibR
         6H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680143545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3cJZfEXazIu0RyCr6dj5L3jtGo+WiGbTKxGLGBfEyo=;
        b=NxsOALpSwmJ42D0J+bvTl/MFak/xF0wzCksCUbs0ylBqAjPTOz6Yw9bM3EzMnWYmIn
         HaWX2DtUnux4B+Mj/ri3xfx6AYYFjAI2ZlsT49JSm/cjJP5NCxmMRLRAGtmbDYJDnotx
         9OO9lZInCQxPK2NJl5Hhjt8GtIY1bHabdy29X0AN3g7nOZdMN24UVFfVY73+8dgLTqO+
         rfEm26ffmBYIcZ0TZLfRw8aoV6eoMW1F6LF4gEbINhrfmL7WY02Lj2e87RwfiOTVL3jW
         TEcyIn+UaOXxX3mmaW3A8yKt7YS34aZfDBSSLst+9TzOIjYzXDn5F60m5lU03Eb4A+7P
         3I1g==
X-Gm-Message-State: AO0yUKVdwMKI32jW/HzLHj7MGyHEg/aeqdeqqzB+6eKq+9X8GS8uD8NW
        2Gh9LpWY4b4Mtl2qh+lFO70Drw==
X-Google-Smtp-Source: AK7set8R0cmMRUfzW0dAO2ZSj8Ig0qWUemT7PvM0jB5gvDRukyHROfrLICELC4ok8IJX4z2tNJ2wPg==
X-Received: by 2002:a05:6a20:e1e:b0:da:b92c:a949 with SMTP id ej30-20020a056a200e1e00b000dab92ca949mr18496286pzb.36.1680143544883;
        Wed, 29 Mar 2023 19:32:24 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.100.185])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm24486846pfo.144.2023.03.29.19.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 19:32:24 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:32:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Add raw decoding for SPEv1.3 MTE and MOPS
 load/store
Message-ID: <20230330023219.GC252145@leoy-yangtze.lan>
References: <20230327162057.4057188-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327162057.4057188-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 27, 2023 at 11:20:57AM -0500, Rob Herring wrote:
> Arm SPEv1.3 adds new load/store operation subclasses for Memory Tagging
> Extension (MTE) and memory operations (MOPS). The memory operations
> are memcpy and memset. Add support for decoding these new subclasses in
> the raw decoding.
> 
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org
