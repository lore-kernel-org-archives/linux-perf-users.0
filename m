Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7324C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 19:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCMTEB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjCMTEA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 15:04:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275F20686;
        Mon, 13 Mar 2023 12:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11443B811F2;
        Mon, 13 Mar 2023 19:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBAEC433D2;
        Mon, 13 Mar 2023 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734235;
        bh=IIULwayLKF+IZBfUmjMfHcwT/zNTawvcv6BWT0+K83w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HD6bx+RvJ3/nEpaktcIQ6ZKL248r2htM8XBPHWMDB19HBpfHnJkwthe2FOq9VzMA+
         HlmdaRKn0dt5lk9fMbAjOVNzZxaO2jqPpEaACKVpWZ1D3ecsD7eNf+eSBzLjerEQ1L
         FbNrzduLLW9FiI8B2jAWVxNzcwGTj7MFDBK7YU1CHXTTuEGCIBiMOV5jPbvIvyerSv
         W+FQTPQLxv3q5K1qu2mhRlCKtMCycftOlh/aXK/s2q0T7vtJsVQqlbKmrHU7PCZMjK
         9FJ+8Myy35daiFHa7WU5/QfHltQnbzxWHTXpOzUqyuPlk/OJEVUcV8iMyMF3hqUcgV
         U17TrsnV777Sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C958B4049F; Mon, 13 Mar 2023 16:03:52 -0300 (-03)
Date:   Mon, 13 Mar 2023 16:03:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] perf list: Add PMU pai_ext event description for IBM z16
Message-ID: <ZA9zmIti/WhBc6eo@kernel.org>
References: <20230308125326.2195613-1-tmricht@linux.ibm.com>
 <CAP-5=fXzeAJqRjtEqsWS26K-+qh3gsDJ+nKOEY7riqedTb-WQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXzeAJqRjtEqsWS26K-+qh3gsDJ+nKOEY7riqedTb-WQQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Mar 13, 2023 at 08:20:25AM -0700, Ian Rogers escreveu:
> On Wed, Mar 8, 2023 at 4:54 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Add the event description for the IBM z16 pai_ext PMU released with
> > commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA counters")
> >
> > The document SA22-7832-13 "z/Architecture Principles of Operation",
> > published May, 2022, contains the description of the
> > Processor Activity Instrumentation Facility and the NNPA counter
> > set., See Pages 5-113 to 5-116 and chapter 26 for details.
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  .../pmu-events/arch/s390/cf_z16/pai_ext.json  | 178 ++++++++++++++++++
> >  tools/perf/pmu-events/jevents.py              |   1 +
> >  2 files changed, 179 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> >
> > diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> > new file mode 100644
> > index 000000000000..7ccbded95dc9
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> > @@ -0,0 +1,178 @@
> > +[
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6144",
> > +               "EventName": "NNPA_ALL",
> > +               "BriefDescription": "NNPA ALL Sum of all non zero counters",
> > +               "PublicDescription": "Sum of all non zero NNPA (Neural Networks Processing Assist) counters"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6145",
> > +               "EventName": "NNPA_ADD",
> > +               "BriefDescription": "NNPA ADD function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6146",
> > +               "EventName": "NNPA_SUB",
> > +               "BriefDescription": "NNPA SUB function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6147",
> > +               "EventName": "NNPA_MUL",
> > +               "BriefDescription": "NNPA MUL function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6148",
> > +               "EventName": "NNPA_DIV",
> > +               "BriefDescription": "NNPA DIV function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6149",
> > +               "EventName": "NNPA_MIN",
> > +               "BriefDescription": "NNPA MIN function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6150",
> > +               "EventName": "NNPA_MAX",
> > +               "BriefDescription": "NNPA MAX function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6151",
> > +               "EventName": "NNPA_LOG",
> > +               "BriefDescription": "NNPA LOG function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6152",
> > +               "EventName": "NNPA_EXP",
> > +               "BriefDescription": "NNPA EXP function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6153",
> > +               "EventName": "NNPA_IBM_RESERVED_9",
> > +               "BriefDescription": "Reserved for IBM use",
> > +               "PublicDescription": "Reserved for IBM use"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6154",
> > +               "EventName": "NNPA_RELU",
> > +               "BriefDescription": "NNPA RELU function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6155",
> > +               "EventName": "NNPA_TANH",
> > +               "BriefDescription": "NNPA TANH function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6156",
> > +               "EventName": "NNPA_SIGMOID",
> > +               "BriefDescription": "NNPA SIGMOID function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6157",
> > +               "EventName": "NNPA_SOFTMAX",
> > +               "BriefDescription": "NNPA SOFTMAX function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6158",
> > +               "EventName": "NNPA_BATCHNORM",
> > +               "BriefDescription": "NNPA BATCHNORM function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6159",
> > +               "EventName": "NNPA_MAXPOOL2D",
> > +               "BriefDescription": "NNPA MAXPOOL2D function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6160",
> > +               "EventName": "NNPA_AVGPOOL2D",
> > +               "BriefDescription": "NNPA AVGPOOL2D function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6161",
> > +               "EventName": "NNPA_LSTMACT",
> > +               "BriefDescription": "NNPA LSTMACT function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6162",
> > +               "EventName": "NNPA_GRUACT",
> > +               "BriefDescription": "NNPA GRUACT function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6163",
> > +               "EventName": "NNPA_CONVOLUTION",
> > +               "BriefDescription": "NNPA CONVOLUTION function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6164",
> > +               "EventName": "NNPA_MATMUL_OP",
> > +               "BriefDescription": "NNPA MATMUL OP function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6165",
> > +               "EventName": "NNPA_MATMUL_OP_BCAST23",
> > +               "BriefDescription": "NNPA NNPA MATMUL OP BCAST23 function ending with CC=0"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6166",
> > +               "EventName": "NNPA_SMALLBATCH",
> > +               "BriefDescription": "NNPA SMALLBATCH OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6167",
> > +               "EventName": "NNPA_LARGEDIM",
> > +               "BriefDescription": "NNPA LARGEDIM OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6168",
> > +               "EventName": "NNPA_SMALLTENSOR",
> > +               "BriefDescription": "NNPA SMALLTENSOR OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6169",
> > +               "EventName": "NNPA_1MFRAME",
> > +               "BriefDescription": "NNPA 1MFRAME OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6170",
> > +               "EventName": "NNPA_2GFRAME",
> > +               "BriefDescription": "NNPA 2GFRAME OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       },
> > +       {
> > +               "Unit": "PAI-EXT",
> > +               "EventCode": "6171",
> > +               "EventName": "NNPA_ACCESSEXCEPT",
> > +               "BriefDescription": "NNPA ACCESSEXCEPT OP function ending with CC=0",
> > +               "PublicDescription": "NNPA function with conditions as described in Common Operation"
> > +       }
> > +]
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 2bcd07ce609f..b20d06fcc358 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -246,6 +246,7 @@ class JsonEvent:
> >            'CPU-M-CF': 'cpum_cf',
> >            'CPU-M-SF': 'cpum_sf',
> >            'PAI-CRYPTO' : 'pai_crypto',
> > +          'PAI-EXT' : 'pai_ext',
> >            'UPI LL': 'uncore_upi',
> >            'hisi_sicl,cpa': 'hisi_sicl,cpa',
> >            'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> > --
> > 2.39.1
> >

-- 

- Arnaldo
