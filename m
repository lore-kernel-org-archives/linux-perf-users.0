Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96957C0015E
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 17:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGXRyX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjGXRyF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 13:54:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E77B3C3A;
        Mon, 24 Jul 2023 10:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690221130; x=1721757130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A7TMcwc2FKHptC0Rm44KdH9oKvYd6rBLX1wakGjXXak=;
  b=cLnfm291kkOd6uQ28uFyTx9/d4C04N5qc1X/3pYaFcWj5buljxOLLZV5
   vMzRAp7ZW5cbZPpxSi1aAK3sDP7hoeklhytXQYFNq7QomLY5FF8WGSkME
   OtCfwedITwz7H4oyCxHs8B6b1eHCGVyA0edRslwenTv4DDMksOzLy4fAr
   yuPwhQBNfK79A2ljFbbzVflq1q28Jq4NSJ4mG7W3H6WuUWpDAR5/NUkWD
   R2K2qdm4ytt4ZbVWg9WV1l1xMNxP3FvrgXS6koXDi6acGXgNqzpoiqQlQ
   kyM58iPnZkwIhRxxqgLWnlr6GfqkSMbzWkcyxUFVji1zTUcdr/ahZaH0N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367538804"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367538804"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729005959"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="729005959"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.18])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 10:51:20 -0700
Message-ID: <5a24632a-4293-3009-e4c6-e81d6ceb8f07@intel.com>
Date:   Mon, 24 Jul 2023 20:51:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] perf: add new option '--workload-attr' to set
 workload sched_policy/priority/mask
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>
References: <20230718033355.2960912-1-changbin.du@huawei.com>
 <5889e93b-5ee3-8d59-c2fb-bce7070a1ab2@intel.com>
 <20230724040229.eipq7i43v4xcrq3p@M910t>
 <05b67e8c-6ba0-5774-93fd-d390ac4e3b19@intel.com>
 <20230724093418.ntluetxruz3ufqnl@M910t>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230724093418.ntluetxruz3ufqnl@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 24/07/23 12:34, Changbin Du wrote:
> On Mon, Jul 24, 2023 at 08:44:12AM +0300, Adrian Hunter wrote:
>> On 24/07/23 07:02, Changbin Du wrote:
>>> On Thu, Jul 20, 2023 at 01:00:58PM +0300, Adrian Hunter wrote:
>>>> On 18/07/23 06:33, Changbin Du wrote:
>>>>> This adds a new option '--workload-attr' to set the sched_policy/priority/mask
>>>>> of the workload to reduce system noise.
>>>>>
>>>>> $ sudo perf stat --workload-attr fifo,40,0-3:7 -- ls
>>>>
>>>> Not really sold on the need for this, but maybe it could be
>>>> simpler.
>>>> What about just adding a hook for a command (e.g. script) to
>>>> run before exec'ing the workload e.g.
>>>>
>>>> --configure-workload=blah.sh
>>>>
>>>> results in perf doing system("blah.sh 12345") where 12345
>>>> is the workload PID.
>>>>
>>>> Then maybe you could do:
>>>>
>>>> --configure-workload="taskset -p 0x3"
>>>>
>>> Acctually, we already have such option for perf-stat.
>>>
>>> 	--post <command>  command to run after to the measured command
>>>         --pre <command>   command to run prior to the measured command
>>>
>>> By involving a shell script we can do more complex setup. But sometimes I just
>>> need to set sched attributes. For example, to investigate the impact of
>>> various compiler optimizations. In this case, I don't want a script. This is the
>>> original purpose I try to add this new option.
>>
>> There is also command schedtool, but what exactly is the problem
>> with a script?
>>
>>>
> There is no problem with a script, just a shortcut for convenience. When I want
> to share perf investigation with somebody, I just need to share a single commandline.
> Anyway nothing bad, right? :)

Also depends on what you call a single commandline, since you could
always create the script and run perf in one long line :-)

I would still go for the simpler option: easier to maintain and
potentially more flexible.

