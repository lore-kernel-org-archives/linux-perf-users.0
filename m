Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B239C678D5
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 18:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjCHS57 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 13:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHS56 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 13:57:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9321B4EF8
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 10:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678301875; x=1709837875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=snWVTulzMCdK3OPFce899Z1b3WS4JTgMp6IitGULnYU=;
  b=KzRjNLP2uHgw0s0ks3cMuwGctXdVqO7UXqRTqZJcGQvanPF0+ybWDepD
   7DlwE0GJuE6Oupwv19XnvZotiVUWSd/DCdFq38bXT0nQhvazmx7nT/yCo
   mR5Q3qwXCihsYaPF15KuZ+6Y+kY6kBDggsT82GheadrWz6UZ6kLgyBaSA
   q+Twd50SouE0tFN1tSud032wpfw6l4VBvy+Arkdi9Ek7LPmKqsPCe5lzd
   XQNqoPiOq8E40nGeXIGGzTnZMSyM800HQIvGSJzMo3yr/jrGPtiIB5fwu
   7f+TdKBroafe6lisGAk7wmF0kPYsQpaOX2SDbbTl2AJF17lHa5nw596Ld
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="324564112"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="324564112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="654457252"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="654457252"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.228])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 10:57:53 -0800
Message-ID: <921ab358-691d-26b6-a8f2-1f34239b571a@intel.com>
Date:   Wed, 8 Mar 2023 20:57:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: brstack information with perf-intel-pt?
Content-Language: en-US
To:     Iti Shree <itishree1999@gmail.com>
Cc:     linux-perf-users@vger.kernel.org
References: <CAO3P5YQ-BU+fmhQo98SAKdc96qMEsim4nNvMRiBmsW0YSUYjQg@mail.gmail.com>
 <a1b7c912-1554-a623-6799-32dbd0ead4de@intel.com>
 <CAO3P5YTf+by5ppR2K44Bw+1h0B2JAZH__oJThS6hepAe5v6LMg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAO3P5YTf+by5ppR2K44Bw+1h0B2JAZH__oJThS6hepAe5v6LMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 8/03/23 10:49, Iti Shree wrote:
> Hello Adrian,
> 
> Thank you for the reply and the link to itrace page.
> 
> On Mon, Mar 6, 2023 at 6:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 13/02/23 20:33, Iti Shree wrote:
>>> Hello,
>>> I am trying to get brstack information in perf.data with intel-pt
>>> flag. I am passing following command for the following: perf record -e
>>> intel-pt// -m, 32768
>>>
>>> When I try to check if brstack is present in the gathered data with :
>>> perf script -F pid, ip, brstack -i pt-perf.data I can only see pid and
>>> ip information.
>>>
>>> I can seem to find branching information with --itrace=b however I was
>>> wondering if there is any way I can get brstack information decoded
>>> into perf.data when I use intel-pt flag similar to what I get with
>>> default perf record?
>>
>> You need to use --itrace=li which will synthesize "instructions" events
>> and add a branch stack.  Note that the period of the instructions events
>> can be defined e.g. --itrace=li10us for 10 microseconds.  And also the
>> max size of the branch stack e.g. --itrace=l10i for 10 branches.
>>
> 
> I am wondering if I can get a branch stack on "branches" events Either
> by some --itrace options (I tried --itrace=Lcr/lcr) or by modifying
> perf's codebase a bit?

At the moment the code will not synthesize a branch stack for a
synthesized branch event. "L" is for synthesizing a branch stack
for real events (e.g. -e branch-misses) where as "l" synthesizes
branch stacks only for synthesized instructions, cycles or
transactions events.

So the code would have to be modified.

But how are you consuming the data?  "perf report"?

> 
>> Typically you need to be aware of decoding errors also, so also add
>> the 'e' option i.e. --itrace=el10i10us.  There is also 'L' which adds
>> the branch stack to non-synthesized events (that you may have added
>> with the -e option).
> 
>> Some more information about --itrace for Intel PT is here:
>>
>> https://perf.wiki.kernel.org/index.php/Latest_Manual_Page_of_perf-intel-pt.1#New_--itrace_option
>>
>> General information and examples for about Intel PT can be found here:
>>
>> https://perf.wiki.kernel.org/index.php/Perf_tools_support_for_Intel%C2%AE_Processor_Trace
>>
>>
> 
> Another question, not related. I am working quite a bit with perf and
> Intel PT right now, is there any sort of active IRC channel/slack or
> discord for more interactive discussions? If not, would it be okay to
> cc you (or where can I find the right people to reach out?).

It is just fine to email me and cc linux-perf-users@vger.kernel.org

> 
> Thank you again. Good day!
> 
> Iti

