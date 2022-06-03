Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B32C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri,  3 Jun 2022 19:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbiFCTZy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349214AbiFCTZw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 3 Jun 2022 15:25:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C315623C;
        Fri,  3 Jun 2022 12:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89C36B82448;
        Fri,  3 Jun 2022 19:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B74C385A9;
        Fri,  3 Jun 2022 19:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284349;
        bh=NeiNF/CCbHgDNoySgxrVAjiAq33HyWlIJ6s2PpKaPY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ls3SsvgqDKp2XdXCbl0QiQ9A6+4teM4g+jNy93/6kVMdI1r/xLeEBu7Z3dBILEcPG
         bRb/h+b1kbjn8DWCjonrZPqOYGCX9n9lyg8MzETymfEgWGQ87bNYcXgr3zfGpIlMKT
         FrqRXoPMPnCC+cD5L05A5T36lXTCBeXXBVHEXRCy7Znxvl9kRjyltuKfCEEYbdjw17
         51MwZJI3PsLWVACgI5Vh2wBjCVKpH0+nRE7KV+cb6gwI1Nihg0rpG158tZ3HTEPNye
         X+xUtkufBekRlXvgykzfn1zqqu0PDnSUFWtoFbIxA1OiYJhG0hhsd1q7ldmIHcOk6/
         Z7l3ZtTyj0KdA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F9594096F; Fri,  3 Jun 2022 21:25:46 +0200 (CEST)
Date:   Fri, 3 Jun 2022 21:25:46 +0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, kan.liang@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, tglx@linutronix.de,
        bp@alien8.de, james.clark@arm.com, leo.yan@linaro.org,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH v5 1/8] perf record ibs: Warn about sampling period skew
Message-ID: <YppgOuFXzaTmCsmY@kernel.org>
References: <CAM9d7ch2dtTjhSt9i96yr4JLEWy7EgNArRvSURE4h5gLL6=7EQ@mail.gmail.com>
 <20220603051223.4272-1-ravi.bangoria@amd.com>
 <76f02f9c-139b-f26b-0cc6-6edc486f5244@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f02f9c-139b-f26b-0cc6-6edc486f5244@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jun 03, 2022 at 10:58:13AM +0530, Ravi Bangoria escreveu:
> On 03-Jun-22 10:42 AM, Ravi Bangoria wrote:
> >>> +       if (ibs_fetch_pmu && ibs_fetch_pmu->type == evsel_pmu->type) {
> >>> +               if (attr->config & (1ULL << 59)) {
> >>
> >> It'd be nice if we used a macro or something instead of the
> >> magic number.
> >>
> >>> +                       ibs_l3miss_warn();
> >>> +                       warned_once = 1;
> >>> +               }
> >>> +       } else if (ibs_op_pmu && ibs_op_pmu->type == evsel_pmu->type) {
> >>> +               if (attr->config & (1ULL << 16)) {
> >>
> >> Ditto.
> > 
> > Thanks for the review, Namhyung.
> > 
> > Arnaldo, Would you be able to squash below trivial patch into original
> > patch? Please let me know if you want me to respin the series instead.
> 
> I'm planning to respin with asprintf() change. Sorry for the noise.

Ok, will wait for the respin then.

- Arnaldo
