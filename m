Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF25C49EA6
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 01:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4CE6198D
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 01:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhF1BwZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 27 Jun 2021 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1BwZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 27 Jun 2021 21:52:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A737C061766
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Jun 2021 18:50:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a2so14004838pgi.6
        for <linux-perf-users@vger.kernel.org>; Sun, 27 Jun 2021 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8iY2XvGYIEGsPy5ZGZiQi9ADeEM827+ckbpfPdEArIg=;
        b=HpotKYvpqG61Gpg54HUKhviArjzigfbpU5tFnq0t8nL+1oJI/JDmpDiYEdrBt/6kNc
         3cnt9SoxgI1NRzO7R7ERaCRg8nGA+dMEsIYD6fzdki7oE2QaLP5L9UnpD1wjtBY1TBRM
         j9ln8ZzVASY9u8024p6Wo443xXptBdCSDiFoz3G3hl8Urncmc5OlNI9A1YjnMgYISe4H
         cgl9tsf1Swp28c1xuqHQD07yBDV0rNdyRJ3V1/QB1kbDbtp3Dk7CcMAjXKC7FDRdGdJF
         s8npiLmjK9oX3q2JqSYHD9vf8dJOkOWq7gwmc1WWF6C0SSxWGQGagp5gsxZf9NmifpWn
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iY2XvGYIEGsPy5ZGZiQi9ADeEM827+ckbpfPdEArIg=;
        b=rMjbA30KJyZVmcIiFRvR7cmH7xYxoSl9mR76FVn7rBfmojfPLERjBw8NrcJ2qsMahq
         nu3JQrRD70qNCKsqJsH3AZ2a83996DO7+KDC29LlTc78k+L9OeeS+jBzg3Go1ZBmd6tK
         46bCSrjwBDFJ38cvK7ccnekkJinHg5SEEUa/bpsEEyA3qykgAQ7Mwbs5FlgnP7DXCpEj
         Ov1kBBsn9TDsn8sqLwrzzbGppsGtdsq5eV5vDo3/eD765Ze0UR5f0jDNdHOHkvpADXRt
         omU1G5iu0be2InfwbPcvYNgDDGK9VzWNvaI3RJ2oyI9/ytMRGpVN8twFym3O+xfziXy0
         GdZQ==
X-Gm-Message-State: AOAM531T7nsbrqkpvorBXehdnzDkbD3F1fNvJkluiOSQWBHmK2voSE3O
        OrIsfsqgh9bYPQLwCljgQcISfA==
X-Google-Smtp-Source: ABdhPJwVsR2cyfJyFTLxc+oAucQiwJumgusFZrJ4XQp+UursvqAWuCuaYAIp2flT20pbByydH2JfQQ==
X-Received: by 2002:a63:e205:: with SMTP id q5mr20722318pgh.404.1624844999931;
        Sun, 27 Jun 2021 18:49:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id t13sm12283459pfq.4.2021.06.27.18.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 18:49:59 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:49:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, james.clark@arm.com,
        andre.przywara@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Fix incorrect sample timestamp in perf
 script
Message-ID: <20210628014953.GA163942@leoy-ThinkPad-X240s>
References: <20210626032115.16742-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626032115.16742-1-yangjihong1@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jihong,

On Sat, Jun 26, 2021 at 11:21:15AM +0800, Yang Jihong wrote:
> When use perf script to parse ARM SPE data, sample timestamp does not match
> the timestamp stored in the AUX buffer, arm_spe_prep_sample function set
> "samlpe->time = speq->timestamp", "speq->timestamp" is the timestamp of first
> packet in auxtrace buffer. As a result, the time of all samples in a auxtrace
> buffer uses the same timestamp.

Could you confirm if the patch set [1] can fix your issue?

Thanks,
Leo

[1] https://lore.kernel.org/patchwork/cover/1431624/
