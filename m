Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45837C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Sep 2022 11:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiI3Lnw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiI3Lnc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Sep 2022 07:43:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5082A10F729
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 04:36:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b21so3742362plz.7
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Sep 2022 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VNyQp0QgLbiSR4UrkzGerU2xpnU4M2EzOYEYOEcYs8s=;
        b=OtJvqi03XP36gQpvxkIx//yPUbAaiN0yMbshB6jRXuNdkXyWri8UbdDtq4VC9LKaYS
         RVcS50+Lxh9L13rcjGup3srP1FpTcoHUH1PJa4bEhe+RFZ0HRj385delRxzbx829yCF7
         mfZmpNBXodwWiAPDYfmXsT8FqEaHsxAJxGCOS8iujOfFW30pqcUCTCiBW8hTuLXrq0EO
         8AtJzioCp9Eea/JZA51P/Xf3nqfFupMoTB4QguYZWsmOAOmYKS9N3I1w6Uy+Olog7pbE
         Ma7E72tXsZ929LHELk0nijPwlQv7b5gzjR/EWObVUA8BYcpCy9KvIEuxoGABnH/lHBvh
         Glvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VNyQp0QgLbiSR4UrkzGerU2xpnU4M2EzOYEYOEcYs8s=;
        b=hnCe1EGJiq3b9RWg8fwBiTOSG0x+xC7J84B0MgWW7wuufPF0wEiUzPy1BpzOrNkL9W
         ehW2AqCj4mfTGcmkwjugCDDUl+7qDi27t3+n/yY7xiBiEO5SrUovtB2GNm6SvKDGvofd
         JbKUATlT/TYplW0Z88/wVjYVtcWJcJ6qvYEzI/24UkCC4mTVrSHNm+W8VIiGyUshCRzr
         lOiiwXftD9xXuAt+I98Q8MNXcmmrxHFXKuWWI3Ulne5L0N+TkoL9Y7f+9XfNHxCH6dkJ
         wXX12QAJw1tvgwEYYHbd43VeJIQTquowiDXfGr3oY+Rx14aP75mEhAtRFJqsTWJI9XYL
         by6g==
X-Gm-Message-State: ACrzQf3wdQ7uWesMYYBIo9CHdmvut6aNrKu4eoVTdiQPFU9XQSxYYJ1D
        eeQ1tACLsPtYvS+Wv/VqqR6Fig==
X-Google-Smtp-Source: AMsMyM57sNHno17WAE2VqaljlStNaPLvuo9uNlR7U9CPycd6/ZYj2QGUoTAcsaQPGXeCFelwfFUtoQ==
X-Received: by 2002:a17:90b:4b84:b0:202:ec40:8643 with SMTP id lr4-20020a17090b4b8400b00202ec408643mr21660500pjb.86.1664537805616;
        Fri, 30 Sep 2022 04:36:45 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b00176c89243fcsm1691369plr.179.2022.09.30.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 04:36:45 -0700 (PDT)
Date:   Fri, 30 Sep 2022 19:36:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3] perf test: Introduce script for data symbol testing
Message-ID: <YzbTu/Dk/W+Ieycb@leoy-yangtze.lan>
References: <20220924133408.1125903-1-leo.yan@linaro.org>
 <f54b8720-2282-f4fe-fcb4-881562118eb5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f54b8720-2282-f4fe-fcb4-881562118eb5@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ravi,

On Fri, Sep 30, 2022 at 12:27:22PM +0530, Ravi Bangoria wrote:
> Hi Leo,
> 
> On 24-Sep-22 7:04 PM, Leo Yan wrote:
> > This commit introduces a shell script for data symbol testing.
> > 
> > The testing is designed a data structure with 64-byte alignment, it has
> > two fields "data1" and "data2", and other fields are reserved.
> > 
> > Using "perf mem" command, we can record and report memory samples for a
> > self-contained workload with 1 second duration.  If have no any memory
> > sample for the data structure "buf1", it reports failure;  and by
> > checking the offset in structure "buf1", if any memory accessing is not
> > for "data1" and "data2" fields, it means wrong data symbol parsing and
> > returns failure.
> 
> I'm working on adding support for perf mem/c2c on AMD:
> https://lore.kernel.org/lkml/20220928095805.596-1-ravi.bangoria%40amd.com
> 
> And this test fails on AMD because perf mem/c2c internally use IBS pmu
> which does not support user/kernel filtering and per-process monitoring.
> Would it be possible for you to add below (ugly) hunk to this patch:

Sure, the change is fine for me, I will update patch and send out a new
version.

@Arnaldo, I saw you have merged this patch into the branch:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf/core

Could you pick up the new coming patch?  Please expect it would be soon.

Thanks,
Leo
