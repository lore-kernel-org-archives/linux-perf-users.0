Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D836ECAAA1
	for <linux-perf-users@archiver.kernel.org>; Tue,  6 Sep 2022 04:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiIFEbw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 6 Sep 2022 00:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiIFEbt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 6 Sep 2022 00:31:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ADD5C96B
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Sep 2022 21:31:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso5299708pjd.4
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Sep 2022 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TwGXpdoM7OeNK0fwpCzIsVwT/Hz9htnpHrj7Szi0kOw=;
        b=d/EC63uSRlXFOahRYs23o5mK5WCmA9ooP5KLOAGEr87tn/jfpYPQwjYIBMQfiSLDf0
         otaZpiAobLOglQuo7vZrPd7ULO2/oAagFZS+c85Wi9Bju72+8yoXbXjyN/ckgHyFBavx
         NxCsLqAe2QetFYwFOKmnrzVF3Jnw+qmrTZvERRoDwcoXQOHWqcSR2T23gO/+7LohA4zt
         eun63PhPAEqzvtYK4VxsnBWahAIHAnWxMbP9601ACSVzeS0uk4LBIGWiaVK59rrhpffp
         01AZjHHsOR/e/QQIVvn5arsomOBKYl9W5xdO2VwOkD4pO47aKl8Mf72fIz02atEgPdSy
         pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TwGXpdoM7OeNK0fwpCzIsVwT/Hz9htnpHrj7Szi0kOw=;
        b=1wRJquyu0HKK5iNpjbkPZsCxANdUWYa3Z5TjFgivx8zEmuEpq6G1r+yPdPYCwqEC7S
         yBLT58IhF9zUmxBKTPKItu77ipV/bHZYOJawKZLuL8HIz0msVIXOjb6Gr2RWzdtbHFc5
         oUXYDqFHPMovysGlxNYFcyAO1F5YB9ChOzKX0CS3496JKim7QMPUtqTLuyuiJFpq3UvZ
         QRQ6FmfOHHewzzT6/57bi73mICKlIGvgHRVNTsje83s68EPldlMj7A7nS63sJrH64DtU
         CPbN9b0Faep6iI2+7chukTX2Ft/z8CNz9cZ8MPEZlifqgXbKYA7AWpHJe4QRmWKR3sHt
         keXg==
X-Gm-Message-State: ACgBeo0fHPEZasQ5uM/s5d0vo2UUHbeyzymBrPWBxmkjXyTELfZjSV2A
        VvCplbI1k1TYRt1PpvrL8PKySA==
X-Google-Smtp-Source: AA6agR7su2KTPdKO6Eb9JV1SS/P9HnqflAm/xsS4Yr9pnVIwnPou3W4tzevu/rux9yHXyTRNKIlOlQ==
X-Received: by 2002:a17:903:291:b0:172:ba83:71a8 with SMTP id j17-20020a170903029100b00172ba8371a8mr54066240plr.65.1662438707776;
        Mon, 05 Sep 2022 21:31:47 -0700 (PDT)
Received: from leoy-huanghe.lan ([204.124.182.10])
        by smtp.gmail.com with ESMTPSA id j13-20020a63ec0d000000b004340d105fd4sm5271356pgh.21.2022.09.05.21.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:31:47 -0700 (PDT)
Date:   Tue, 6 Sep 2022 12:31:42 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] perf c2c: Prevent potential memory leak in
 c2c_he_zalloc
Message-ID: <YxbNLphbuGjCezww@leoy-huanghe.lan>
References: <20220906032906.21395-1-shangxiaojing@huawei.com>
 <20220906032906.21395-4-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906032906.21395-4-shangxiaojing@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 06, 2022 at 11:29:06AM +0800, Shang XiaoJing wrote:
> Free allocated resources when zalloc is failed for members in c2c_he, to
> prevent potential memory leak in c2c_he_zalloc.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
