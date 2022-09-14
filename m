Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6B4ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Sep 2022 08:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiINIJM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Sep 2022 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiINIJL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Sep 2022 04:09:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A16DB6;
        Wed, 14 Sep 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663142950; x=1694678950;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=x6jv+juyBGbvYIFFN5KEyxVieFn/ohhcaZvzZ2Mkf48=;
  b=eUEIJmPC1Y6DDnuK5jESuQTfGCkxNWQUjSHXVRJmDNCxCGb+WhN3ZIwd
   1RxYcBnamLNCj/6wSzk9W6fTFaymUWIZ+XTvUe7iPy5W0pWdLHtRR1pZs
   WbnIZvKVNI5+QnNJ9aFdp0+hk4UT3rE1cOUtJF/OH2VwDx1lh73c4Yufw
   EeDMBZC73u6hkPmzmCc9G1AFGH7qO1k62aIYGFfVRfVIVoGNGXsu241uf
   EkPgkq8Jky0g/oxCTn2AWoP0o2TeE2vrdDvTeDMEWDVFvATZ67s5w1wVY
   XXBEr5QQ+bg47S6ldHZXORGNkjqzw7Zb0DUzXn/HtH/gcXJdTRMLyfLr8
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="362331212"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="362331212"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:09:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="678944517"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:09:08 -0700
Message-ID: <ccaff990-ff5f-f21e-81f0-01b809beaf2e@intel.com>
Date:   Wed, 14 Sep 2022 11:09:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] perf test: Add tests/shell/lib/waiting.sh
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20220914080150.5888-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220914080150.5888-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 14/09/22 11:01, Adrian Hunter wrote:
> Hi
> 
> As requested by Namhyung, move functions from test_intel_pt.sh
> to tests/shell/lib/waiting.sh, and parameterize timeouts.

This is on top of series "perf test: test_intel_pt.sh: Add per-thread test"

	https://lore.kernel.org/lkml/20220912083412.7058-1-adrian.hunter@intel.com/

For Namhyung's comments refer also:

	https://lore.kernel.org/lkml/CAM9d7ci3JKNaLDMo6patFHZbLSm-r1UmOmZtrwCX8Gu0nsPMBA@mail.gmail.com/
	https://lore.kernel.org/lkml/CAM9d7ciRCnpNjOfoEbO27pNk28ddjg1vVdgrZtvWQ-mbD7jg0w@mail.gmail.com/

> 
> 
> Adrian Hunter (2):
>       perf test: test_intel_pt.sh: Move helper functions for waiting
>       perf test: waiting.sh: Parameterize timeouts
> 
>  tools/perf/tests/shell/lib/waiting.sh   | 77 +++++++++++++++++++++++++++++++++
>  tools/perf/tests/shell/test_intel_pt.sh | 68 ++---------------------------
>  2 files changed, 81 insertions(+), 64 deletions(-)
>  create mode 100644 tools/perf/tests/shell/lib/waiting.sh
> 
> 
> Regards
> Adrian

