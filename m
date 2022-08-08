Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E49C00140
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Aug 2022 10:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242305AbiHHK4M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 06:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242448AbiHHK4F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Aug 2022 06:56:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B20262A
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Aug 2022 03:56:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q30so10396630wra.11
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Aug 2022 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vc8KZx5Ir/5pr/HPZoQQcJVfbd+Hj8oalK48kkbjiYA=;
        b=DyKst5/ow6TqmTNvkn6Z1YTtFNJEdaoaOmWt/HXjJ5SbW+7WC9b2aOZ5DVZxs6zWL4
         1sJOTEXQhb3649jDDrT8zrG4tPZTOEZ0uyEhjbiAHl3s5D+gsaXzr7dBvhMXLl/qvPug
         M3yuuP3E35ewegUsRJibU+6Ao/0AcUYLrazosRddrUVPCZf7J6rPxYQK8cyV8lNfVhrs
         7qQ4cm+YnNd0jz9ngIS5A/xOfpDYnQ/ufDZxcv1ixucvoY73yXrGQTfgegQrd4MrDhyt
         qfgi2HJ9BtdZv0flCmsGwOOLU09WVfpJarMJydzN+YLDbefEkzMpyS7RjiEgU2RKYyRa
         hqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vc8KZx5Ir/5pr/HPZoQQcJVfbd+Hj8oalK48kkbjiYA=;
        b=HwSRoBau/gfoO5wcB5Z9zCOIeJEBlvaKr5EjkvtWg0MTG6a+dS/4lwgqA9mV4ErUKt
         zHy544U07fasFA5liNOjx6Fc4pXThOaIa0d2TzHA9ixQAyQ5MXCVMGMbM3A60jhCZJf8
         8308nXMSURLlsg08137qtMtRrS/vWmfSjPg5c9c1VzW6BnuCy8Auq2msaTqszw0sNarB
         b6OTPw5EdVcMKnHH8mLMt1yUqSe+vs51Q7ZuwAweL7XreblCV0q/WPikjzMOwVlRqKo3
         6OOhCBHTehpPNxoE5fBGzHwS5Rctynr63yjgJGYfHDCUgDbDl3gFB/9ftvW9MDwGleNd
         mewA==
X-Gm-Message-State: ACgBeo36zxbspEprTV0UddIZJAHuocHR+lT4PybdED2ansagPQLRT9YB
        h0TGO/CEv/nih82Bl8rbflxwAI0wl+JZEyj1UFA=
X-Google-Smtp-Source: AA6agR5vmcGVzSihDjLzD94CfSujSI31yhVc+PIsw7HLCtp5ilLu7UH/Ld9+UcOS5/ME/8EjSGd/mA==
X-Received: by 2002:a5d:63c9:0:b0:220:68e1:7f3f with SMTP id c9-20020a5d63c9000000b0022068e17f3fmr11273580wrw.134.1659956162649;
        Mon, 08 Aug 2022 03:56:02 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([167.71.129.183])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b003a2e7c13a3asm13764124wmb.42.2022.08.08.03.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 03:56:02 -0700 (PDT)
Date:   Mon, 8 Aug 2022 18:55:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: perf recording with java runtime broken with commit 2d86612aacb7
Message-ID: <20220808105556.GC35313@leoy-ThinkPad-X240s>
References: <defae7d2-5f3e-5de1-bcd0-f7ee7871a9f9@linux.ibm.com>
 <20220808083618.GA35313@leoy-ThinkPad-X240s>
 <b8ce5423-f6ee-42bc-75eb-ce182cc325b8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8ce5423-f6ee-42bc-75eb-ce182cc325b8@linux.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 08, 2022 at 11:25:29AM +0200, Thomas Richter wrote:

[...]

> > Ian has committed a patch "perf symbol: Fail to read phdr workaround" to
> > address java JIT symbol issue:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=6d518ac7be6223811ab947897273b1bbef846180
> > 
> > Could you confirm if have included this patch in your code base?
> > 
> 
> Thanks Leo, this patch fixes my issue.

Great!  Thanks for confirmation.

Leo
