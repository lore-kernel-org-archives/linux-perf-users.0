Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392CC54EBC
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjAJKtJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Jan 2023 05:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbjAJKsx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Jan 2023 05:48:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEF0B87E
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 02:48:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v6so16870569edd.6
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 02:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8aXPYPxKe/n2X+QW4z7qAUF1kuaWh05p+ZxFJ2mi0Q=;
        b=aQyzyRNXmgqci3DnUSk57J0W2mrpSKHgqGqg4B7cZrJM6RC3RvD4p3/187sB+qzV86
         BLWZNKp3FHCuFIoMP39MN3XylGvaHwxyjRiiyK5dDiK90DaTRDDWsiVg6bzhFpp0zqOA
         aiiD2XPAW2miVm4LiyYnmi8zX+85AFLFGcPqi/5lOz7Cj+6o4o7a7mVReUZ+naO60GkL
         pZmUEAlQ24q8/cjHnq6bS9Uc3LRf/NqAXIMwEEaCKQHvKX34id0f5W0C8zsCOPPGHZcV
         f0okinLREF6s21mBwaIe6EulJdudW1orgExnSHGczCb1y66P1O4h7nx/XUq2jgtWaXOr
         2JAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8aXPYPxKe/n2X+QW4z7qAUF1kuaWh05p+ZxFJ2mi0Q=;
        b=k+6U/R3d91dbw3aMrX/7E2wyUDtMkEJRrmzsapnmdHzbvccLcaB4fCyAulqiNc2csi
         MvX/NNtaJptbTeGWHHCdyruY287xv2jqTqb091As931FfPMuk1cWJnSftpwvcx7NM1CI
         OYcCKDH/8cyEmy8MxmkO4kflC7fRySGzBju9vwAaq0pUTTn9gu1dchdYwlL0SnJ8I45p
         n6SkqQb/asXhO7lbIzRl5vYbTRRC1rB4NzNvU1hTwP72ngfx92j5ZKynbXasIOPIWMkZ
         X90RCdRKTO2fBp//HUMrGWbn6KvmvMhvfEOjwH3wYllD+bQUQLYnIORd5jRnx1xsxOT9
         QfnA==
X-Gm-Message-State: AFqh2kpotJ1gDtL/Pxt/saxv/BILf77Ht968K6ubDv3k64ARo/IIDpna
        LfLMDYU9nJ+c2S7ToDDbBrA=
X-Google-Smtp-Source: AMrXdXsV5PyVKjjgWKeKy1UFb4meNet3vrHk/0lkVID2j++wjdtrzpqXCE5geQcuNYuk/qviPwWu7g==
X-Received: by 2002:a05:6402:2883:b0:499:d1ca:6d83 with SMTP id eg3-20020a056402288300b00499d1ca6d83mr7953edb.2.1673347730147;
        Tue, 10 Jan 2023 02:48:50 -0800 (PST)
Received: from ddolgov.remote.csb (dslb-178-012-041-046.178.012.pools.vodafone-ip.de. [178.12.41.46])
        by smtp.gmail.com with ESMTPSA id en6-20020a056402528600b00499b3d09bd2sm2605962edb.91.2023.01.10.02.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 02:48:49 -0800 (PST)
Date:   Tue, 10 Jan 2023 11:48:48 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        mingo@redhat.com, jolsa@kernel.org, irogers@google.com
Subject: Re: [RFC PATCH v1] perf record: Correct address filters for
 duplicated symbols
Message-ID: <20230110104848.hty4upem76lkxj2y@ddolgov.remote.csb>
References: <20230106203751.403270-1-9erthalion6@gmail.com>
 <aad6782c-fb30-ba39-ba59-775c5f227d56@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad6782c-fb30-ba39-ba59-775c5f227d56@intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

> On Mon, Jan 09, 2023 at 09:02:02AM +0200, Adrian Hunter wrote:
> On 6/01/23 22:37, Dmitrii Dolgov wrote:
> > It seems the logic to handle duplicated symbols is off. In case if the
> > symbol index is specified it will:
> >
> > * find a match
> > * continue searching
> > * check that start is not null and idx is set on the next loop
> > * exit with the error code 1
> >
> > My guess is the expectation was that at this point the second match is
> > found (because *start is not null), although the new symbol hasn't pass
> > dso_sym_match yet. Here is how it looks like:
>
> If *start && idx > 0 there is no need to match anymore.  The
> code is just getting *size.  Looks to me like it should be:
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 265d20cc126b..c2e323cd7d49 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -2611,7 +2611,7 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
>  				*size = sym->start - *start;
>  			if (idx > 0) {
>  				if (*size)
> -					return 1;
> +					return 0;
>  			} else if (dso_sym_match(sym, sym_name, &cnt, idx)) {
>  				print_duplicate_syms(dso, sym_name);
>  				return -EINVAL;

Yes, if there was no intention to continue searching symbols, this would
work as well. Just in case I have verified this on my test, everything
is fine. Would you send a patch for that?
