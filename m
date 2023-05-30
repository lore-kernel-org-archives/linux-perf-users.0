Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D4C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 May 2023 04:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjE3E5h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 May 2023 00:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjE3E5g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 May 2023 00:57:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D75C9;
        Mon, 29 May 2023 21:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685422655; x=1716958655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BsdtVrFGCJbQ+fRw/SSLLWJvAmhHbsbfCItALlMk470=;
  b=GQCDc6WBp0Q9CKAhM98FUIYws+Luoff5PiAbjb5b29WY2h6JF0dal7iP
   bOrwsnRKfGz1BVrP2dZX8QV7/miZ/BTi+3B9KkYq+puWGuE+zsxKsnR39
   QY70ExO9dS8t00Al5YtEDrDYS80n+EREIyQdfVZGDazHYxzm+YwVP6Wca
   A2mBWrh/7pV1g5WRcYI17Tfk3ml+Q9s7xGjR/uHd1Ce49fQ1/SrGtawpf
   NkEz0GPmEyjx+MrOgqeeG1U5PWuyIgy4Teo774VdtTzdRogtmfihcCSAY
   SNwtEt1K6hvZFqJZnT/RUtmpsx/5wa5Ec+RvE7yADvg9XTwWpGzEm90we
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="339405183"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="339405183"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 21:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="830595390"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="830595390"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2023 21:57:35 -0700
Date:   Mon, 29 May 2023 21:57:33 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Address some perf memory/data size issues
Message-ID: <ZHWCPXKo2fFJmtlT@tassilo>
References: <20230526183401.2326121-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


FWIW I think the whole patchkit could be replaced with a one liner
that disables THP for the BSS segment. I suspect that would be roughly
equivalent for memory consumption because 4K pages that are never
touched would never be allocated.

-Andi
