Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18756C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED28D61059
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbhIJOUS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233952AbhIJOUQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 10:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7AB561026;
        Fri, 10 Sep 2021 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631283545;
        bh=i6M0iOLrjNvAS8282FvsD30z58/M3IiYRbF0ZxjnaSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alhM4CKRWKUCoOGJYCkIp8kgoQlSnvxGHjuF4yHPFDlHTBUPzjtiO2dCSObASqIMb
         XOyOxteJLhrpUXnEkQCUbr7KmZ4+2ZDkb0O/Zq939QYu+YaWmFDHO7uTxCtvK7AzjE
         X2ASN96cMo4bHVIKSpELEjY1OKI+rkv6lbmEBmo3aozGw7q1+d5g9mhqBwxJo3u0+e
         tdcB78c5etBQ3TOiTFUgUAFicspFp3Xor+clJtulkyQaef5yIlA65ZOWvqx8o3rIhz
         abhkRDEkcYp2Y8xgEdRuC4ufImwTl2O6BKV3enrBKirC/48fLLKwqdsxhUY8yQ87mT
         1XbDcikcI/lkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EA204038F; Fri, 10 Sep 2021 11:19:02 -0300 (-03)
Date:   Fri, 10 Sep 2021 11:19:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, yao.jin@linux.intel.com, namhyung@kernel.org,
        kim.phillips@amd.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf annotate: Add fusion logic for AMD microarchs
Message-ID: <YTtpVpo3d/h5YkVc@kernel.org>
References: <20210906105640.1040-1-ravi.bangoria@amd.com>
 <20210906105640.1040-2-ravi.bangoria@amd.com>
 <YTpveO0qqKFTaxTk@kernel.org>
 <6a987cad-6c46-280e-f791-6c59b6628a45@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a987cad-6c46-280e-f791-6c59b6628a45@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 04:47:31PM +0530, Ravi Bangoria escreveu:
> 
> >> +static bool x86__ins_is_fused(struct arch *arch, const char *ins1,
> >> +			      const char *ins2)
> >> +{
> >> +	if (strstarts(arch->vendor, "AuthenticAMD"))
> >> +		return amd__ins_is_fused(arch, ins1, ins2);
> >> +
> >> +	return intel__ins_is_fused(arch, ins1, ins2);
> >> +}
> >> +
> > 
> > Can we instead make x86__ins_is_fused be a pointer and instead of
> > storing arch->vendor we set it to one of amd__ins_is_fused() or
> > intel__ins_is_fused()?
> > 
> > I.e. here:
> > 
> >>  static int x86__cpuid_parse(struct arch *arch, char *cpuid)
> >>  {
> >>  	unsigned int family, model, stepping;
> >> @@ -184,6 +216,9 @@ static int x86__cpuid_parse(struct arch *arch, char *cpuid)
> >>  	if (ret == 3) {
> >>  		arch->family = family;
> >>  		arch->model = model;
> >> +		arch->vendor = strndup(cpuid, 12);
> > 
> > 		x86__ins_is_fused = strstarts(cpuid, "AuthenticAMD") ?
> > 					amd__ins_is_fused :
> > 					intel__ins_is_fused;
> 
> Sure. Will post v2.

Thanks, if you're quick we may get this into this merge window :-)

> Thanks for the review Arnaldo,

- Arnaldo
