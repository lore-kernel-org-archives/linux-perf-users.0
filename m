Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4B6C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA4860FBF
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbhIEVZn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238248AbhIEVZm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF61C061575
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 192-20020a1c04c9000000b002f7a4ab0a49so2710388wme.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHMMjMhivqxPIC3BtkbJ81QY4VqIQKA1P04hghydQHE=;
        b=blzt7fZtvB6K4OGSadqhLwBVNex1NyJ8EpCK6MYDlLhG7ABNf22VxXThAJSLenmGB2
         HDlwrnAgLuunPi2Yavpb4X7ac0ESpxiLtJCxRzS0KI/vOkSG+l1bf17zk4lFq0pjurHU
         9THFIiJSjBYKKXTaFmuR/3US+nX0kT+2lzGjki/2AtxOqvQdwxGWREmhkh08D8Dv7yi3
         ptMvOuJcOy2Io9OHBnP2X1k6uYRTS+EsX7Ep3ZmyIlVzB0umMTR+srV4pSfiFeisYdvO
         lOzbuVEDxwgIYrwwonjf3jgsqe87xMb4VQIBIZ6r13NDUJU3QH20Gusf3Ackqd3mDSOe
         m4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHMMjMhivqxPIC3BtkbJ81QY4VqIQKA1P04hghydQHE=;
        b=cbkpiynDxZRAwcX0YcepYg9oU49t3EDYqyRcqM9Dr6oYyRhMcMNmSIb6p25qCXh1QD
         c04HGg2x9Wj4ZO4dRVwUSwKsaxOHzKciFEoMr0/8B89Zv3rgfadifexNxVdS+fI7FEV5
         23+MkfC0auk2tI48p8hc8WNrjx85kKlqc7sCkQ3N90mzJRpFqc0r1ZO8NwFmchcJeFjN
         CEOgQeXeBkvdsYyi260M7aQu3LuhKl0h+L3dy73Vjee0v9XNJhMroqS9uoEJ9z3q++ju
         0Bz72DkL8RjBFjZnEwV/ddOUCarcfp1AU2LAVzqW5/IF4VtryPjWwnyiX0lELM9IMu9p
         8MvA==
X-Gm-Message-State: AOAM532lPpsraxTKNDcp5l9+amRrcd8KR/EVKLNm+/CUcJeRsAQjxhY5
        Axj8bo+QRv5I5B7jGlcBtGn0gvNmqVXgPkc20AZZgw==
X-Google-Smtp-Source: ABdhPJwCr66YTIe29GSyel5c8aNkiSz88bTezmxuBX+hr0RdF99snnNSHEBKn/tKUxxYLOBikYsO/dQMOnYirgwBwsI=
X-Received: by 2002:a05:600c:5123:: with SMTP id o35mr8587349wms.153.1630877077157;
 Sun, 05 Sep 2021 14:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-4-james.clark@arm.com>
 <b0e6b1d8-f9a7-676f-c739-314b91388565@arm.com>
In-Reply-To: <b0e6b1d8-f9a7-676f-c739-314b91388565@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:26 +0100
Message-ID: <CAJ9a7VhQKvgzwkdUNTApYvD4jPGP+ULQ4MnAjbqOwve1L=9d5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] perf cs-etm: Refactor out ETMv4 header saving
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 09:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/08/2021 14:41, James Clark wrote:
> > Extract a function for saving the ETMv4 header because this will be used
> > for ETE in a later commit.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
