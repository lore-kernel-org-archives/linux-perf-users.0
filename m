Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31389C433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 15 May 2022 07:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiEOH1x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 15 May 2022 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiEOH1w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 15 May 2022 03:27:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E959AB874;
        Sun, 15 May 2022 00:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652599671; x=1684135671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Smy0VW9Z/B0hw61N8jmj4g4kLpvB1teUObFaA9+9Bgw=;
  b=fPYuatnlvF1Nozp1hkrsg/XrTkjbnKkp7XYNN5RnxHjrk3HvvxSXxIT4
   R1ehTedzYTfFK+fqk4J/Rkuo3D+MKjOma8ia2Iudti13fF2GAGgnXO6c4
   7PAkyZXHY2SU4/qKDYLPQQ51EmUU8HcX+pNwTl9ddmx4No09OiWf/G/5K
   RLexhYmFqs9pixYpySJ6QukU+0fOO1STiYCpe8LMz5vcGwcykfMbK4OW4
   oexMj/XgfKm2gKb4RYOsf7sWdb/EfqCewLsyNNFZ01W7QaPhE+rbW5Xtq
   734WXDqwZRnFbUyoPZ4pvqyIP9qzgZOiXgEYh1YzvyuLDmyF9Op5CEdJq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10347"; a="295864279"
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="295864279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 00:27:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,227,1647327600"; 
   d="scan'208";a="595975304"
Received: from fiegl-mobl.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 00:27:48 -0700
Message-ID: <47690d71-6ebf-b85c-97f7-d37b20f3cd65@intel.com>
Date:   Sun, 15 May 2022 10:27:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH 6/6] perf intel-pt: Add guest_code support
Content-Language: en-US
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Leo Yan <leo.yan@linaro.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kvm@vger.kernel.org
References: <20220513090237.10444-1-adrian.hunter@intel.com>
 <20220513090237.10444-7-adrian.hunter@intel.com>
 <875ym9h4mt.fsf@linux.intel.com>
 <df56f04b-cb25-5a47-ffef-b2e2ee0f6b74@intel.com>
 <871qwxgv1e.fsf@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <871qwxgv1e.fsf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 13/05/22 21:13, Andi Kleen wrote:
> Adrian Hunter <adrian.hunter@intel.com> writes:
>>>
>>> I'm still not fully sure how it exactly finds the code on the host,
>>> how is the code transferred?
>>
>> I don't know.  From a quick look at the code in
>> tools/testing/selftests/kvm/lib/kvm_util.c it seems to be using
>> KVM_SET_USER_MEMORY_REGION IOCTL.
> 
> Okay so it assumes that the pages with code on the guest are still intact: that is
> you cannot quit the traced program, or at least not do something that would
> fill it with other data?. Is that correct?
> 
> It sounds like with that restriction it's more useful for kernel traces.

These patches are to support tracing of test programs that
 *are* the hypervisor, creating, populating, and destroying the VM.
The VM is not running an OS.

Like:
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/kvm/x86_64/tsc_msrs_test.c
	
guest_code() gets mapped into the VM at the same virtual address as the host,
so the Intel PT decoder, which wants to walk the object code, can find the
object code in the host program.
