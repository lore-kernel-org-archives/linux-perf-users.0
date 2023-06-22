Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A42EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 20:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjFVUPY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 16:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjFVUPX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 16:15:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6051FCB
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 13:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687464922; x=1719000922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HVvgAGt3wVo2vSF7zabtoUzCcAxsSVHn/T0tqujib1E=;
  b=luyEwS25uSjYKFTlo+zPNG23YZunvcVseq7phuZUciuZYVoE5nGr1xDM
   ojnMZQwAHlPNqJT37VGUXYYNq/7MKYjwXeYADtpF2fhCizurmDrFjNpuu
   Rzf8CP4ocLx4Sf7Aj/r33+2tTI9fqdBUouVH5INyaIbVLOrbCHfQCuLub
   WoFKJK/4Jw+6OK6RdPNVwFOH/oPpWEwDtuZjKKjt6fouEbQ8jsUB9mmrK
   MmrVaOdhE6qE8jzNLqUNAxgtqLeI2c45v7QIW6KuII9GX9x9mNLyvMdwf
   /Wxs/SMHxTqW+YqkEFtc4i9MFerx3c+1TvxfIRO4Bhsn1qcHCV2NAX8LS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="359465560"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="359465560"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 13:15:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="828080196"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="828080196"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 13:15:21 -0700
Date:   Thu, 22 Jun 2023 13:15:20 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: Perf stat regression from d15480a3d67
Message-ID: <ZJSr2PbOrpFrSIaL@tassilo>
References: <ZJOmXU/41HMzanM9@tassilo>
 <CAP-5=fWZAcXcE3CP-V7t=gSehO-AacHJWhjHjtA5nCd5B2-n1A@mail.gmail.com>
 <ZJQSUHLe9Cqpw21n@tassilo>
 <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgpegLH9QpUhHQy0ckMpO6CaKaYrAeHKNm4CT01R4bhGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 22, 2023 at 12:09:14PM -0700, Namhyung Kim wrote:
> Hi Andi,
> 
> Sorry about the breakage.
> 
> On Thu, Jun 22, 2023 at 2:20 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > Can you provide an example that is breaking?
> >
> > I only have a very long auto generated example[1], because it's not
> > easy to make a non scheduling event and it's also dependent on the system. The example
> > works on a SKX.
> >
> > >
> > > Wrt event order, cases like:
> > > ```
> > > $ sudo perf stat -e '{data_read,data_write}' -a --no-merge sleep 1
> > >
> > > Performance counter stats for 'system wide':
> > >
> > >          1,960.81 MiB  data_read [uncore_imc_free_running_1]
> > >            438.48 MiB  data_write [uncore_imc_free_running_1]
> > >          1,961.85 MiB  data_read [uncore_imc_free_running_0]
> > >            438.79 MiB  data_write [uncore_imc_free_running_0]
> > >
> > >       1.001127356 seconds time elapsed
> > > ```
> > > Reorder events so that the PMUs match (ie the -e order would 2x
> > > data_read followed by 2x data_write). This covers more cases now so
> > > that perf metric (aka topdown) events aren't broken when coming out of
> > > metrics:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2139
> >
> > How is any tool supposed to handle arbitary output reordering like
> > that? Perf is not just for humans, but also for tools.
> 
> Is the problem of reordering the output or hiding something?
> Do you mean both?

For my tool it's both. In this particular case it's the hiding
that broke it

If the reordering only happens on broken groups etc. as Ian wrote that's ok for me
because I can avoid generating them. But I can't tolerate hiding.

> >
> > >
> > > Given the original commit message there seems little point to give the
> > > 0 counts, but perhaps it is something that could be done on the more
> > > tool oriented CSV and JSON output formats.
> >
> > It's not 0 counts, it's <not supported>. But even 0 counts can
> > be important.
> >
> > We should always output when something doesn't count so that
> > the user knows something is wrong. Hiding problems is always a bad idea
> > and not an improvement.
> 
> Right, I wanted to skip (or hide) events that are not reasonable
> like with redundant or invalid setups.  It should display those
> error results.

Okay so the skipping can just be removed?

> 
> Didn't you say you only have problems in uncore events?

For this test case I only hit it with the uncore, but I would have a general
problem for any event if it was hidden.

Thanks,

-Andi
