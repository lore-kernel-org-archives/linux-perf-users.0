Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB66EB64D7
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 20:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjFMUcp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjFMUcc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 16:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB9199E;
        Tue, 13 Jun 2023 13:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81FD663410;
        Tue, 13 Jun 2023 20:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80ACC433C8;
        Tue, 13 Jun 2023 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688317;
        bh=oBQ8U1fHqp82qpMDxnRBO4x2zGTKKv5PhQJBQNLe6KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rWDt8k9o9TANEnQTd8kp25WxPMGpxHC2uvilvUFr1Qtpw1jU2slJRCsIU9zSpuG1o
         9p97CNNtIGJg+snGCHXueY3AKF0VCOrc73YUemztsNJwlxpvC0X6DOXOrEwXk5PBr7
         yv6F4tlbr35MS9ndu3PDkUe6JAC4Sb2PL9jF3kEYt4gNTGm+p9UjiyfbpzuAZfJdWt
         9pFiD20/QfNdX4xGUNr15zbhkUqSY8lm5Y92/s3uMV0XE9VqG44UUpVUux546g3P7G
         D8DCMixjFaYp6z8RfDb1R30fP4M81eGRnliZOx48jv4EaXDWC9ixfXdpo+NM0vcAie
         d6LYIK9DT4J/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 34D0B40692; Tue, 13 Jun 2023 17:31:54 -0300 (-03)
Date:   Tue, 13 Jun 2023 17:31:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 4/8] perf vendor events arm64: Add default tags into
 topdown L1 metrics
Message-ID: <ZIjSOjV6JePKH1lu@kernel.org>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-5-kan.liang@linux.intel.com>
 <CAP-5=fXjR_yhFqob_Kzsh3+dQ5N6zXzu-FJO5b4-qgYULth=eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXjR_yhFqob_Kzsh3+dQ5N6zXzu-FJO5b4-qgYULth=eQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jun 13, 2023 at 12:45:10PM -0700, Ian Rogers escreveu:
> On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
> >
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Add the default tags for ARM as well.
> >
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Jing Zhang <renyu.zj@linux.alibaba.com>
> > Cc: John Garry <john.g.garry@oracle.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/pmu-events/arch/arm64/sbsa.json | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/arm64/sbsa.json b/tools/perf/pmu-events/arch/arm64/sbsa.json
> > index f678c37ea9c3..f90b338261ac 100644
> > --- a/tools/perf/pmu-events/arch/arm64/sbsa.json
> > +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> > @@ -2,28 +2,32 @@
> >      {
> >          "MetricExpr": "stall_slot_frontend / (#slots * cpu_cycles)",
> >          "BriefDescription": "Frontend bound L1 topdown metric",
> > -        "MetricGroup": "TopdownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "frontend_bound",
> >          "ScaleUnit": "100%"
> >      },
> >      {
> >          "MetricExpr": "(1 - op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
> >          "BriefDescription": "Bad speculation L1 topdown metric",
> > -        "MetricGroup": "TopdownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "bad_speculation",
> >          "ScaleUnit": "100%"
> >      },
> >      {
> >          "MetricExpr": "(op_retired / op_spec) * (1 - stall_slot / (#slots * cpu_cycles))",
> >          "BriefDescription": "Retiring L1 topdown metric",
> > -        "MetricGroup": "TopdownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "retiring",
> >          "ScaleUnit": "100%"
> >      },
> >      {
> >          "MetricExpr": "stall_slot_backend / (#slots * cpu_cycles)",
> >          "BriefDescription": "Backend Bound L1 topdown metric",
> > -        "MetricGroup": "TopdownL1",
> > +        "DefaultMetricgroupName": "TopdownL1",
> > +        "MetricGroup": "Default;TopdownL1",
> >          "MetricName": "backend_bound",
> >          "ScaleUnit": "100%"
> >      }
> > --
> > 2.35.1
> >

-- 

- Arnaldo
