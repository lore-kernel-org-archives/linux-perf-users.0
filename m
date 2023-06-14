Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435CEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jun 2023 02:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjFNCtA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 22:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242313AbjFNCso (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 22:48:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37F1FC1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 19:48:16 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3a9eae57cso27193325ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686710896; x=1689302896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0YlFQAyWxbuL4Zsr4kr8EBosxhqQEgpBKxBIFTH5hE=;
        b=KejiIVIHfhPCnwN1mYw9NB3AagkSdpS+LUX00U7yMb0BZFE8CAriat8e/7Pa/YmPDW
         7N4n4SDA+y19EFfKUce9zSP0awfJ8ydt2d7Y4Kn4uTnseeQ/YMNbeH1XZjLv8FDsnemk
         JmhfAvWtrlCE9jXrHErOgjxgUJ3PIQHY3zHTXLbGNjnN/WdwwKw9HiG+FPJpcIfkZ0uX
         s8373Tzs4x5ddcaVnudyeXZ/ZiYzZO0c9sDHjkkJDR17NATD7IMBRjcnmQ8Z25j9+/Dg
         v/x/lJHFeLdQqBBmzB6QX/5FmhpF9xDtm3cJJad9p8SfCWJLel/d7qKqmMsimtUTpcT9
         byKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686710896; x=1689302896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0YlFQAyWxbuL4Zsr4kr8EBosxhqQEgpBKxBIFTH5hE=;
        b=lwLU7wnHJbVgNPeMG+s+tznObfkXXHQjzgXIZFP+DMW24jvpnQSt6ArbBkVsa73mpv
         l96XV94YFHzuTakzQklLiu5KhG34oia8Lyurvz5vDCEhGZeH6BB5QnHAxuehXmqn1Ser
         htBi7vU7Yqwh8dseXicZz42khqeSXw8i2s3lUSaE90IHH3mUnpJjQetWKUaXQ8Mc9qH/
         MWwhING0w331ud4VyC1SlvgdnF67vl04zi0vWszEPKRMeqGGJQVTiS6K0z26n1U7Rng0
         tuDqJHdqfiHtjU9nonnP3I0snpmA7K7axMkEzVvl2Sg+9RYtYzQbX7G2KkYxG2aHgv5U
         oXZw==
X-Gm-Message-State: AC+VfDxeDZBT69FE0z+CY9IQs37lBuY3bhhgbLRPQQm5VFKLI3g2k5TI
        Ipw93RPhu9On6We9wTjxVcSwuw==
X-Google-Smtp-Source: ACHHUZ6ErTAXlm3FfgIHNOscl4ATQNoo6KtiqunTj/PImDO4p4fi/ERgK1MRsNStbB3teZwD3dotxA==
X-Received: by 2002:a17:902:e744:b0:1b3:c4c1:ec4e with SMTP id p4-20020a170902e74400b001b3c4c1ec4emr402092plf.30.1686710895980;
        Tue, 13 Jun 2023 19:48:15 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b001a9b29b6759sm10964697pls.183.2023.06.13.19.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 19:48:15 -0700 (PDT)
Date:   Wed, 14 Jun 2023 10:48:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com,
        john.g.garry@oracle.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH 01/17] perf: get rid of unused import
Message-ID: <20230614024810.GM217089@leoy-huanghe.lan>
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-2-atrajeev@linux.vnet.ibm.com>
 <ZIjJYCL38UX9FIl4@kernel.org>
 <20230614015914.GL217089@leoy-huanghe.lan>
 <ZIknI2imecS5doHN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIknI2imecS5doHN@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jun 13, 2023 at 11:34:11PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Since have applied this patch, it's no need to give my review tag :)
> 
> No, I usually can  add a Reviewed-by tag even after having applied it to
> my local tree, as I still need to run tests before making it available
> via perf-tools-next, when I should not make any further changes.

Understand now.  Here is my review tag:

Reviewed-by: Leo Yan <leo.yan@linaro.org>
