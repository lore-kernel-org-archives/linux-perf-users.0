Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC3C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 13:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D0A60F6F
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Sep 2021 13:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239650AbhITNrn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:47:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:45174 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236385AbhITNrn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Sep 2021 09:47:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="223166976"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="223166976"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 06:46:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="701062486"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.131.200]) ([10.252.131.200])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 06:46:15 -0700
Subject: Re: [PATCH v8 0/8] Don't compute events that won't be used in a
 metric.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
References: <20210918063513.2356923-1-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <7307f6f3-74a8-ef3e-428b-fc294454e463@linux.intel.com>
Date:   Mon, 20 Sep 2021 06:46:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210918063513.2356923-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 9/17/2021 11:35 PM, Ian Rogers wrote:
>      
> For a metric like:
>    EVENT1 if #smt_on else EVENT2
>      
> currently EVENT1 and EVENT2 will be measured and then when the metric
> is reported EVENT1 or EVENT2 will be printed depending on the value
> from smt_on() during the expr parsing. Computing both events is
> unnecessary and can lead to multiplexing as discussed in this thread:
> https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
>
> This change modifies expression parsing so that constants are
> considered when building the set of ids (events) and only events not
> contributing to a constant value are measured.


The series looks good to me.


Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi


