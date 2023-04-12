Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFABC7619A
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Apr 2023 15:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDLPUo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Apr 2023 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDLPUo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Apr 2023 11:20:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE6193F4;
        Wed, 12 Apr 2023 08:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC1063630;
        Wed, 12 Apr 2023 15:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4162C433EF;
        Wed, 12 Apr 2023 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681312810;
        bh=2TlxvyOrCIyB9YsYK1Bw0dLMpDzPG7m8BgTr+ARjzRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqXcWyUQM+FQApWq4v17krYaFCt6WOe74vHrfUXSaUGARjsuivpUWMOuJTOD4oT4+
         kRBSBilsF4WNv4SEeyMzCa5cpOIRdldztmSvHTrVgBG9+dbKYPLXdw7Hjbp0JffJ72
         XPhoA33ug/FQaXQSsOlJmE4VcikTgsKsXCZzcT+ijZYt+ZN9Axv+GHlFGZ1aH/Ol23
         AULUMyR7tBQ9I/Dlv4/VOC6MsPKKoS7b+UeV76RiRn8OixC+897RgG2phn2S75CWpR
         527INGXRAkp2JMI4I9j/iP4eRxKDHuR19l4VBRL1Xr5CecZGCpJqUAr6qb197ialHa
         Qn5uIrirVmxng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7C2F40080; Wed, 12 Apr 2023 12:20:06 -0300 (-03)
Date:   Wed, 12 Apr 2023 12:20:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Pantyukhin <apantykhin@gmail.com>, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools:perf:scripts:python:intel-pt-events del
 unusedvar
Message-ID: <ZDbMJkiJT2rD8MEj@kernel.org>
References: <20230114130533.2877-1-apantykhin@gmail.com>
 <ae03d3af-02de-0d36-4680-c4ad934da77d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae03d3af-02de-0d36-4680-c4ad934da77d@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jan 16, 2023 at 07:15:01AM +0200, Adrian Hunter escreveu:
> On 14/01/23 15:05, Alexander Pantyukhin wrote:
> > The event_attr is never used later, the var is ok be deleted.
> > Additional code simplification is to substitute string slice comparison
> > with "substring" function. This case no need to know the length specific
> > words.
> > 
> > Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Finally picked this one,

- Arnaldo
 
> > ---
> >  tools/perf/scripts/python/intel-pt-events.py | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> > index 08862a2582f4..dfd566369ca4 100644
> > --- a/tools/perf/scripts/python/intel-pt-events.py
> > +++ b/tools/perf/scripts/python/intel-pt-events.py
> > @@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
> >  	print(start_str, src_str)
> >  
> >  def do_process_event(param_dict):
> > -	event_attr = param_dict["attr"]
> >  	sample	   = param_dict["sample"]
> >  	raw_buf	   = param_dict["raw_buf"]
> >  	comm	   = param_dict["comm"]
> > @@ -349,6 +348,7 @@ def do_process_event(param_dict):
> >  	# callchain  = param_dict["callchain"]
> >  	# brstack    = param_dict["brstack"]
> >  	# brstacksym = param_dict["brstacksym"]
> > +	# event_attr = param_dict["attr"]
> >  
> >  	# Symbol and dso info are not always resolved
> >  	dso    = get_optional(param_dict, "dso")
> > @@ -359,13 +359,13 @@ def do_process_event(param_dict):
> >  		print(glb_switch_str[cpu])
> >  		del glb_switch_str[cpu]
> >  
> > -	if name[0:12] == "instructions":
> > +	if name.startswith("instructions"):
> >  		if glb_src:
> >  			print_srccode(comm, param_dict, sample, symbol, dso, True)
> >  		else:
> >  			print_instructions_start(comm, sample)
> >  			print_common_ip(param_dict, sample, symbol, dso)
> > -	elif name[0:8] == "branches":
> > +	elif name.startswith("branches"):
> >  		if glb_src:
> >  			print_srccode(comm, param_dict, sample, symbol, dso, False)
> >  		else:

-- 

- Arnaldo
