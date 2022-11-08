Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5AC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Nov 2022 20:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKHU5e (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKHU5e (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Nov 2022 15:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DB85F864
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 12:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9214E6178F
        for <linux-perf-users@vger.kernel.org>; Tue,  8 Nov 2022 20:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92428C433D6;
        Tue,  8 Nov 2022 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667941052;
        bh=49yUNaK0Xy40RzZQ8Gmjq/wjdUfbv1ybDc9tX4cGuQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nln5MO2wwkXiDS0CjrB6+QZ4ujWJ2Erdig+8IQY7eA4OWIZuvFt8ymGgHjVMI+Bg+
         ZIwZnUxvU7QRbIA61kv428d34KhGK8LXb5pKcIUuzvxp44dR482LO/+j/ctm7QJExE
         EmFxWkm5jXBrr5IJ0bnJpyBCtgzOtyT8AssqIb7Vz/T/R4FcfAhDo+5n5zraJT98Vf
         eUo4Wlc1FNLkeGXGf4T8qca5HjsTQCmvesLfaCBVPCrnF79gplO3d9NKVbkp7lnAj+
         THvufH3BqiY4mQ+fPySDEXXDbBmTM3lbKHFOz1MDprBY5dkzP8fR9YfkGcumWguzu0
         WoGfjo5X8L+dw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D95584034E; Tue,  8 Nov 2022 17:57:28 -0300 (-03)
Date:   Tue, 8 Nov 2022 17:57:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, maddy@linux.vnet.ibm.com,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, james.clark@arm.com,
        kjain@linux.ibm.com, namhyung@kernel.org, disgoel@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] tools/perf: Fix printing field separator in CSV
 metrics output
Message-ID: <Y2rCuGSKoIjHwWGx@kernel.org>
References: <20221018085605.63834-1-atrajeev@linux.vnet.ibm.com>
 <20221018085605.63834-2-atrajeev@linux.vnet.ibm.com>
 <173AA14E-B018-4BA7-A7A8-E7069E273960@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173AA14E-B018-4BA7-A7A8-E7069E273960@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Nov 02, 2022 at 02:07:06PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 18-Oct-2022, at 2:26 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > 
> > In perf stat with CSV output option, number of fields
> > in metrics output is not matching with number of fields
> > in other event output lines.
> > 
> > Sample output below after applying patch to fix
> > printing os->prefix.
> > 
> > 	# ./perf stat -x, --per-socket -a -C 1 ls
> > 	S0,1,1.89,msec,cpu-clock,1887692,100.00,1.013,CPUs utilized
> > 	S0,1,2,,context-switches,1885842,100.00,1.060,K/sec
> > 	S0,1,0,,cpu-migrations,1885374,100.00,0.000,/sec
> > 	S0,1,2,,page-faults,1884880,100.00,1.060,K/sec
> > 	S0,1,189544,,cycles,1263158,67.00,0.100,GHz
> > 	S0,1,64602,,stalled-cycles-frontend,1876146,100.00,34.08,frontend cycles idle
> > 	S0,1,128241,,stalled-cycles-backend,1875512,100.00,67.66,backend cycles idle
> > 	S0,1,95578,,instructions,1874676,100.00,0.50,insn per cycle
> > ===>	S0,1,,,,,,,1.34,stalled cycles per insn
> > 
> > The above command line uses field separator as ","
> > via "-x," option and per-socket option displays
> > socket value as first field. But here the last line
> > for "stalled cycles per insn" has more separators.
> > Each csv output line is expected to have 8 field
> > separatorsi (for the 9 fields), where as last line
> > has 10 "," in the result. Patch fixes this issue.
> > 
> > The counter stats are displayed by function
> > "perf_stat__print_shadow_stats" in code
> > "util/stat-shadow.c". While printing the stats info
> > for "stalled cycles per insn", function "new_line_csv"
> > is used as new_line callback.
> > 
> > The fields printed in each line contains:
> > "Socket_id,aggr nr,Avg,unit,event_name,run,enable_percent,ratio,unit"
> > 
> > The metric output prints Socket_id, aggr nr, ratio
> > and unit. It has to skip through remaining five fields
> > ie, Avg,unit,event_name,run,enable_percent. The csv
> > line callback uses "os->nfields" to know the number of
> > fields to skip to match with other lines.
> > Currently it is set as:
> > 	os.nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
> > 
> > But in case of aggregation modes, csv_sep already
> > gets printed along with each field (Function "aggr_printout"
> > in util/stat-display.c). So aggr_fields can be
> > removed from nfields. And fixed number of fields to
> > skip has to be "4". This is to skip fields for:
> > "avg, unit, event name, run, enable_percent"
> > Example from line for instructions:
> > "1.89,msec,cpu-clock,1887692,100.00"
> > 
> > This needs 4 csv separators. Patch removes aggr_fields
> > and uses 4 as fixed number of os->nfields to skip.
> > 
> > After the patch:
> > 
> > 	# ./perf stat -x, --per-socket -a -C 1 ls
> > 	S0,1,1.92,msec,cpu-clock,1917648,100.00,1.010,CPUs utilized
> > 	S0,1,54,,context-switches,1916762,100.00,28.176,K/sec
> > 	-------
> > 	S0,1,528693,,instructions,1908854,100.00,0.36,insn per cycle
> > 	S0,1,,,,,,1.81,stalled cycles per insn
> > 
> > Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
> > Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Hi All,
> 
> Looking for review comments for this change.

This clashed with a patch from Namhyung that I just applied:

http://lore.kernel.org/lkml/20221107213314.3239159-2-namhyung@kernel.org

Can you please check? I just applied the other patch in this series.

Thanks,

- Arnaldo
 
> Thanks
> Athira
> 
> > ---
> > tools/perf/util/stat-display.c | 13 +------------
> > 1 file changed, 1 insertion(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 879874a4bc07..5ca151adf826 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -551,20 +551,9 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> > 	new_line_t nl;
> > 
> > 	if (config->csv_output) {
> > -		static const int aggr_fields[AGGR_MAX] = {
> > -			[AGGR_NONE] = 1,
> > -			[AGGR_GLOBAL] = 0,
> > -			[AGGR_SOCKET] = 2,
> > -			[AGGR_DIE] = 2,
> > -			[AGGR_CORE] = 2,
> > -			[AGGR_THREAD] = 1,
> > -			[AGGR_UNSET] = 0,
> > -			[AGGR_NODE] = 0,
> > -		};
> > -
> > 		pm = config->metric_only ? print_metric_only_csv : print_metric_csv;
> > 		nl = config->metric_only ? new_line_metric : new_line_csv;
> > -		os.nfields = 3 + aggr_fields[config->aggr_mode] + (counter->cgrp ? 1 : 0);
> > +		os.nfields = 4 + (counter->cgrp ? 1 : 0);
> > 	} else if (config->json_output) {
> > 		pm = config->metric_only ? print_metric_only_json : print_metric_json;
> > 		nl = config->metric_only ? new_line_metric : new_line_json;
> > -- 
> > 2.31.1
> > 

-- 

- Arnaldo
