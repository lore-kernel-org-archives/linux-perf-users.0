Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFAEB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Jul 2023 11:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjGNLNA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 14 Jul 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjGNLM7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 14 Jul 2023 07:12:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC42D78
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jul 2023 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689333178; x=1720869178;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ocTsRncx6NuZE1siHV5O7T9pi2EAo6ReDlJdw034SkE=;
  b=MqiWqDYnw8DrptugzLunSUfF5gVLehzFNClHLPS/BLOW0bPxr0/Ri3B/
   bX3cCBT9mldJxM1TggbvnLqhzgStgAbi7ZYP/mbzRDFoPnhxre8dSFcus
   CUF88/1mM+EjgVKUksBgXRVffKBIGWr8FPqfBKDsC0/gWRMSKAB1OaqKQ
   tr9gEVzRU8+BDZxAW7oZFQb8iVLL5Y7QrkwQKk46kAfPuhFjiCSRLqSY+
   WW3Epm9tZt+OkbaetYRgXtRUakTVnc+YHOJM4JyE9JLYhQKpSB2h9kqo1
   k57YNhXSakwUvgp/BHqOkKbK1ZlWCR1Mb7JTbtQ96+wF8BgLx5WGQ91a/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="362916178"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="362916178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722369344"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722369344"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.109])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:12:53 -0700
Message-ID: <d2662fac-1c25-f5fc-4126-eb2d1545e434@intel.com>
Date:   Fri, 14 Jul 2023 14:12:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: Is PEBS-via-PT expected to work on Alder Lake Gracemont cores?
Content-Language: en-US
To:     Tudor Brindus <tbrindus@gmail.com>,
        linux-perf-users@vger.kernel.org
References: <CABPTGz8qFqV0X0Wv0Tx=EZAcMORaGFAnwU94cZCeMbdGA6s6Cw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CABPTGz8qFqV0X0Wv0Tx=EZAcMORaGFAnwU94cZCeMbdGA6s6Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 13/06/22 22:45, Tudor Brindus wrote:
> Hi linux-perf-users,
> 
> I recently obtained an Alder Lake machine, and was hoping to try out
> PEBS-via-PT on its E-cores.
> 
> The patchset[0] adding support for Alder Lake to perf suggests this should be
> possible:
> 
>> - The "cpu_core" PMU supports Topdown metrics.
>>   The "cpu_atom" PMU supports PEBS-via-PT.
> 
> However, I haven't been able to get it to work, despite spending the better
> part of a day trying. I am on a 5.19 kernel.

I realise this is an old email but FWIW the Linux driver currently
supports only Intel PT features that are common to all CPUs.

> 
> $ taskset -c 15 ./demo &
> $ perf record -e
> '{intel_pt//,cpu_atom/name=br_misp,event=0xC5,umask=0x0,aux-output/ppp}:u'
> -p $(pidof demo)
> Error:
> cpu_atom/br_misp/: PMU Hardware doesn't support 'aux_output' feature
> 
> dmesg reports that the cpu_atom PMU should support PEBS-via-PT:
> 
> [    0.005511] core: cpu_atom PMU driver: PEBS-via-PT
> [    0.005511] ... version:                5
> [    0.005511] ... bit width:              48
> [    0.005511] ... generic registers:      6
> [    0.005511] ... value mask:             0000ffffffffffff
> [    0.005511] ... max period:             00007fffffffffff
> [    0.005511] ... fixed-purpose events:   3
> [    0.005511] ... event mask:             000000070000003f
> [    0.060399]   #9 #10 #11 #12 #13 #14 #15
> 
> Am I doing something silly here? As far as I can tell from reading the patch,
> PERF_PMU_CAP_AUX_OUTPUT is a function of intel_cap.pebs_output_pt_available,
> which should be set (otherwise dmesg would not be printing the "PEBS-via-PT"
> string).
> 
> Thanks,
> Tudor
> 
> [0]: https://lore.kernel.org/lkml/20210310165358.GI23521@zn.tnic/T/
> 

