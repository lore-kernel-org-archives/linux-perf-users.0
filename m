Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF41C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8F160FF2
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Oct 2021 12:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJTMvV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhJTMvU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Oct 2021 08:51:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E9FC06161C
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:49:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m14so2864701pfc.9
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Oct 2021 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MW5XKMinfkic3DGxRVbSGJ7Lv3LsHXlWTeKEhPjWG0A=;
        b=WAS9LYADJJxprsNJhUgU2leBPsNjhVj2U0f2idYZJZCFoe6pjmxyePWQaUW6uiYI9E
         o7/2o48KMeQnDiiFQnmr7tTB/rI+iVNIazciNypQ4bE6abuDJEjMyXiGx7v1riLZHjNm
         SGRBjpB3uoC0PuOQbiSZ+7OgPHTVONyen2Zdqt8Z/IB7j6iylnukXoDtHyb5xfGkLR2W
         +zYzt/tyxiXWRkFrvZKYajOxIBFSD6laJ9p4SmfbpzHNAQ5HQzP6RXyGVDaJtKSFw21z
         EI4rnQ15hXiWagaqCgPk7qSHVIbgLDRai1sz1uxIiA/K3XhL9pO3qNcd+RUHaFC8nDir
         6Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MW5XKMinfkic3DGxRVbSGJ7Lv3LsHXlWTeKEhPjWG0A=;
        b=hMsipCZbFtD3B3ckTMYTsSkyTuA5tPNseYUmV91Hq1XZ0hTyPrOykdUstSyeJu3WrI
         lU1EX3xhtclN9FQUWbBL0QT1SdWnDdFVlCUet3uyW2BzFBDwottL1rGep8YfyqOtnBcG
         VUTZa2Ih3f2ZH0DVeY5JK3LjRFXt67Zp+QAy2k6cPSmFsPvYrbT9NZWHji7mYaG9b7ba
         jsAoQ/fwQngKozbAAEJqAC4XE6AEyouc1kaHp36ExiimZL/gvKKWiXaX9FFFGfs52AXR
         vwIo4I33vzHxoELfKVt2xJKIvq3Zr3QexBqSnkTcH7BieqgQDY8rsbIctTxcm2fNJ8m/
         zFAQ==
X-Gm-Message-State: AOAM531YgUk5++oatpc44Wk96/o6d7JQa6A9qICLUQ65v/n/5HShzg8P
        prXAdU7Io2YVwgepgdweYfvavg==
X-Google-Smtp-Source: ABdhPJz/ojuR/19tWAPkVZPReLPgVZVffGrnzOj4hJq6C+s4AtggeMF/FwJA2837GyU+HSy3z7MI3Q==
X-Received: by 2002:a63:2cca:: with SMTP id s193mr26427467pgs.240.1634734146295;
        Wed, 20 Oct 2021 05:49:06 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id nn14sm2297124pjb.27.2021.10.20.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 05:49:05 -0700 (PDT)
Date:   Wed, 20 Oct 2021 20:48:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 3/5] perf arm-spe: Add snapshot mode support
Message-ID: <20211020124855.GF49614@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-3-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:33PM +0100, German Gomez wrote:
> This patch enabled support for snapshot mode of arm_spe events,
> including the implementation of the necessary callbacks (excluding
> find_snapshot, which is to be included in a followup commit).
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
