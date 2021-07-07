Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F5C07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB2261CBE
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhGGOHe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231720AbhGGOHc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 10:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C810C61C92;
        Wed,  7 Jul 2021 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625666692;
        bh=X05+giyFKsVT+sh0hnEHJ5D9wx29IQi/oJ6RZCCiYdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw9QDbboQVZmhJTdpYKUBDl5Urg8AOtcJ1QcxY+8FidTj0Qsdc6Ya7EXPDznObwfU
         jkeLZzQ7OE4HyTFk4vUuIEDUv757Vf7BcEpdhCI3EjpWwzCn0pzJUrLGqrXFDhGjNs
         OvAOFNolWWTIED7BlLP4MI+QgazZICx1UIirNIRa4P1lKUq+pcEFJxQgX89jqu3ovQ
         Fd5zgVv6ROfuCjczgWuRMLt5STOmLgPBSeEnZTpT34aFunQlzZd6lCPJT5UA321LxL
         jJijpFNGL2n4xTOvo/UPFmqQGRPFYOjkGn1lWbzOzPU2FFLzOYkBP9w1fc+FMddedL
         rJIcTENISNdOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A48F40B1A; Wed,  7 Jul 2021 11:04:49 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:04:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, maddy@linux.vnet.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com,
        "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH] perf script python: Fix buffer size to report iregs in
 perf script
Message-ID: <YOW0gU4yNpgN8MjB@kernel.org>
References: <20210628062341.155839-1-kjain@linux.ibm.com>
 <20210628144937.GE142768@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
 <ee98968a-f343-a68e-9a3e-58e97dc130c8@linux.ibm.com>
 <c6fb2136-21e1-325a-f7f7-9745dbe29661@linux.ibm.com>
 <YOSr25+a+r3MF2Ob@kernel.org>
 <d59266da-2aa6-69ff-646b-144ba874ee2f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d59266da-2aa6-69ff-646b-144ba874ee2f@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 07, 2021 at 11:16:20AM +0530, kajoljain escreveu:
> On 7/7/21 12:45 AM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 06, 2021 at 05:26:12PM +0530, kajoljain escreveu:
> >> On 6/29/21 12:39 PM, kajoljain wrote:
> >>> On 6/28/21 8:19 PM, Paul A. Clarke wrote:
> >>>> On Mon, Jun 28, 2021 at 11:53:41AM +0530, Kajol Jain wrote:
> >>>>> @@ -713,7 +711,16 @@ static void set_regs_in_dict(PyObject *dict,
> >>>>>  			     struct evsel *evsel)
> >>>>>  {
> >>>>>  	struct perf_event_attr *attr = &evsel->core.attr;
> >>>>> -	char bf[512];
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * Here value 28 is a constant size which can be used to print
> >>>>> +	 * one register value and its corresponds to:
> >>>>> +	 * 16 chars is to specify 64 bit register in hexadecimal.
> >>>>> +	 * 2 chars is for appending "0x" to the hexadecimal value and
> >>>>> +	 * 10 chars is for register name.
> >>>>> +	 */
> >>>>> +	int size = __sw_hweight64(attr->sample_regs_intr) * 28;
> >>>>> +	char bf[size];

> >>>> I propose using a template rather than a magic number here. Something like:
> >>>> const char reg_name_tmpl[] = "10 chars  ";
> >>>> const char reg_value_tmpl[] = "0x0123456789abcdef";
> >>>> const int size = __sw_hweight64(attr->sample_regs_intr) +
> >>>>                  sizeof reg_name_tmpl + sizeof reg_value_tmpl;

> >>>    Thanks for reviewing the patch. Yes these are
> >>> some standardization we can do by creating macros for different
> >>> fields.
> >>> The basic idea is, we want to provide significant buffer size
> >>> based on number of registers present in sample_regs_intr to accommodate
> >>> all data.

> >>    Is the approach used in this patch looks fine to you?

> > Yeah, and the comment you provide right above it explains it, so I think
> > that is enough, ok?
 
>     Thanks for reviewing it. As you said added comment already explains
> why we are taking size constant as 28, should we skip adding macros part?
> Can you pull this patch.

Sure.

- Arnaldo
