Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92FEB8FA5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Sep 2023 07:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbjIFHC6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjIFHC6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Sep 2023 03:02:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ABB10C0
        for <linux-perf-users@vger.kernel.org>; Wed,  6 Sep 2023 00:02:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68c0d262933so2192504b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Sep 2023 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693983764; x=1694588564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bOnepIQCwDJc0Ol2faDFJoKyl17qehBQgFjOxk2yOU=;
        b=ItiOw4QjLUNO6wlW2bCq4O98I42nPVeRvL3ChIJ6iJzQoRDfFGmq7lPU8Oo6cR+cAo
         Fy1fHkcRi74NXog4vpPJXYl0EIbrVlEAwwYy4JENVFz//DWKCWlGiJ4WqI6a3dzv21As
         vYALOTkcqygLc04OgjO6z16v7Vxzkn1XgTmdaxjuvovTZ1AdFJ9B3URf6U+uCJ+nbMrv
         /XoOKM62s2I2FGaHkecxybYDWwoxecFvYoFn7BM3FHGN8NPhhzlTLmfTucOwE3Mk5U/m
         rtLYdpy0VWPn7FKjY954shMrfrbuyfiJ21e+QINYJd4trwHvmv6RxbaBKsCuLvh+MWQC
         y8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693983764; x=1694588564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bOnepIQCwDJc0Ol2faDFJoKyl17qehBQgFjOxk2yOU=;
        b=GzmkcMpjW7/khbwVgwtC2wez0MpL68v2uk1fvSxwFBjFPdsMfO//b2npwzFkcqF07v
         HkUVtdVYeKOUdJyVLu1bWeD4bS5GD1Sn41zFHIr2doYXMPjBcSNvleDxoHQYAGFXIhe6
         4J4Fv9YnoN3QyUQUfj0mkcaYfVJjxM0mtPFBLQad/ItdjYZqJv5+Y2rcTVNHmsPWjlQq
         Xy1g3lKhiu5zLuMe/EiLDPEEIkaZ4MKKw7qcRSvgR2Al0WNxgNsibsSE+arUd5eqh3vS
         +7mry4KQ67+fEYmI85X4Rx1zWYJpSxguYHaH19bSWVs1KZCIasP1Z+IwHvr+tYG700Ix
         cNnQ==
X-Gm-Message-State: AOJu0YyvDpGNOa86BBKs9pkhMGYBt/PhutLb8XZYidMdWO/0GXyQb4+q
        spPcreCGkL2n/hgLseeZP30wOA==
X-Google-Smtp-Source: AGHT+IGf8EtxGmsoMwjlaVopnTftJ5aYiB3q3jQlbgXnfvpOjee82EdHZhKtZ7IyleF+2HOGCXGfNg==
X-Received: by 2002:a05:6a21:3b4a:b0:142:aced:c643 with SMTP id zy10-20020a056a213b4a00b00142acedc643mr14336394pzb.31.1693983764200;
        Wed, 06 Sep 2023 00:02:44 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id q19-20020a62ae13000000b0068a49aad7d4sm10167691pff.79.2023.09.06.00.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 00:02:43 -0700 (PDT)
Date:   Wed, 6 Sep 2023 15:02:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf/core: Bail out early if the request AUX area
 is out of bound
Message-ID: <20230906070238.GC388456@leoy-huanghe.lan>
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-2-xueshuai@linux.alibaba.com>
 <20230804085947.GB589820@leoy-yangtze.lan>
 <534c5e53-07bb-07bd-0435-76a10b55228d@linux.alibaba.com>
 <bad0d23d-a66e-0558-469b-a2dd1d5eb497@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bad0d23d-a66e-0558-469b-a2dd1d5eb497@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Shuai,

On Wed, Sep 06, 2023 at 11:27:38AM +0800, Shuai Xue wrote:

[...]

> >>> +	/* Can't allocate more than MAX_ORDER */
> >>
> >> The comment is confused.  I'd like to refine it as:
> >>
> >>   /*
> >>    * kcalloc_node() is unable to allocate buffer if the size is larger
> >>    * than: PAGE_SIZE << MAX_ORDER; directly bail out in this case.
> >>    */
> > 
> > Hi, Leo,
> > 
> > Thank you for your quick feedback. The comment is simplified from Peter's reply in v2
> > version. Your refined comment is more detailed and it makes sense to me, I would like
> > to adopt it if @Peter has no other opinions.
> > 
> >> To be honest, I am not sure if perf core maintainers like this kind
> >> thing or not.  Please seek their opinion before you move forward.
> >>
> > 
> > and hi, all perf core maintainers,
> > 
> > I have not received explicit objection from perf core maintainers @Peter or @James so
> > I moved forward to address their comments. It's fine to me to wait for more opinions from
> > perf core maintainers.
> > 
> > Best Regards,
> > Shuai
> > 
> 
> Hi, Leo, and all folks,
> 
> Any more comments? Should I move forward to send a new patch?

I am afraid I cannot give a reliable suggestion.

Anyway, I personally think the returned error value in this patch is
better than the kernel oops since the kernel oops is a bit scary for
tool's users ;)   Another reason is the perf core layer should report
error earlier rather than relying on the page buddy allocation layer
to detect the memory allocation failure, which is easier for both
developers and users to understand the failure.

IMHO, a good practice is to respin a new patch set and send out for
review.  Good luck!

Thanks,
Leo
