Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40289ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Sep 2022 06:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIWGYt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Sep 2022 02:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIWGYr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Sep 2022 02:24:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232A82E691
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663914286; x=1695450286;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lUrHTRbLjHyO625/uRuGloyeUzUC3gHCDg6hl2k92Ww=;
  b=M00xi2uDqgSDHMkDto2NR3J8dzCqlWwYMEj2IMA8kVdrb5GY4nwZ1gya
   5kch0BT5pqBGCK/BFyCloVwma4gE2VIzHxjTN2HKdZ/L2CETDIYlgJkar
   Gsc2zg4enh0gUsJU55toBU/ofOiMZcDfZ6m5wuDFSUe7OaerByPE5p89g
   pzZRbdIQnvT5eVisA7UrSi9tAOUIl8X27+ghwl6xg0WIujOquBvGYNgU6
   0ZqBf/ZpbtwSpo21gqec7gGt64IkILt++TI3mO3pdgDzn4xyJw6DSwmaG
   hNPMHMBG1LC78IuH9xIOgx2RmB8AWEzvKt/cVG5CMrj/mphgwCiA7Mr1I
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="280889869"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="280889869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 23:24:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="682546459"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.208])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 23:24:42 -0700
Message-ID: <444a5a64-7bc6-d5fd-2880-611c5cbca587@intel.com>
Date:   Fri, 23 Sep 2022 09:24:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] tools/perf/tests: Fix string substitutions in build
 id test
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
        Ian Rogers <irogers@google.com>
References: <20220921170839.21927-1-atrajeev@linux.vnet.ibm.com>
 <Yyy0W6CnPk7BkkCU@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Yyy0W6CnPk7BkkCU@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/22 22:15, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 21, 2022 at 10:38:38PM +0530, Athira Rajeev escreveu:
>> The perf test named “build id cache operations” skips with below
>> error on some distros:
> 
> I wonder if we shouldn't instead state that bash is needed?
> 
> ⬢[acme@toolbox perf-urgent]$ head -1 tools/perf/tests/shell/*.sh | grep ^#
> #!/bin/sh
> #!/bin/bash
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/bash
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/bash
> #!/bin/sh
> #!/bin/bash
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> #!/bin/sh
> ⬢[acme@toolbox perf-urgent]$
> 
> Opinions?
> 

Please don't change tools/perf/tests/shell/test_intel_pt.sh

I started using shellcheck on that with the "perf test: 
test_intel_pt.sh: Add per-thread test" patch set that I sent.

FYI, if you use shellcheck on buildid.sh, it shows up issues even
after changing to bash:

*** Before ***

$ shellcheck -S warning tools/perf/tests/shell/buildid.sh 

In tools/perf/tests/shell/buildid.sh line 69:
        link=${build_id_dir}/.build-id/${id:0:2}/${id:2}
                                       ^-------^ SC2039: In POSIX sh, string indexing is undefined.
                                                 ^-----^ SC2039: In POSIX sh, string indexing is undefined.


In tools/perf/tests/shell/buildid.sh line 77:
        file=${build_id_dir}/.build-id/${id:0:2}/`readlink ${link}`/elf
                                       ^-------^ SC2039: In POSIX sh, string indexing is undefined.


In tools/perf/tests/shell/buildid.sh line 123:
        echo "running: perf record $@"
                                   ^-- SC2145: Argument mixes string and array. Use * or separate argument.


In tools/perf/tests/shell/buildid.sh line 124:
        ${perf} record --buildid-all -o ${data} $@ &> ${log}
                                                ^-- SC2068: Double quote array expansions to avoid re-splitting elements.
                                                   ^-------^ SC2039: In POSIX sh, &> is undefined.


In tools/perf/tests/shell/buildid.sh line 126:
                echo "failed: record $@"
                                     ^-- SC2145: Argument mixes string and array. Use * or separate argument.


In tools/perf/tests/shell/buildid.sh line 131:
        check ${@: -1}
              ^------^ SC2068: Double quote array expansions to avoid re-splitting elements.
              ^------^ SC2039: In POSIX sh, string indexing is undefined.


In tools/perf/tests/shell/buildid.sh line 158:
exit ${err}
     ^----^ SC2154: err is referenced but not assigned.

For more information:
  https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansions to ...
  https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and array. ...
  https://www.shellcheck.net/wiki/SC2039 -- In POSIX sh, &> is undefined.

*** After ***

$ shellcheck -S warning tools/perf/tests/shell/buildid.sh 

In tools/perf/tests/shell/buildid.sh line 123:
        echo "running: perf record $@"
                                   ^-- SC2145: Argument mixes string and array. Use * or separate argument.


In tools/perf/tests/shell/buildid.sh line 124:
        ${perf} record --buildid-all -o ${data} $@ &> ${log}
                                                ^-- SC2068: Double quote array expansions to avoid re-splitting elements.


In tools/perf/tests/shell/buildid.sh line 126:
                echo "failed: record $@"
                                     ^-- SC2145: Argument mixes string and array. Use * or separate argument.


In tools/perf/tests/shell/buildid.sh line 131:
        check ${@: -1}
              ^------^ SC2068: Double quote array expansions to avoid re-splitting elements.


In tools/perf/tests/shell/buildid.sh line 158:
exit ${err}
     ^----^ SC2154: err is referenced but not assigned.

For more information:
  https://www.shellcheck.net/wiki/SC2068 -- Double quote array expansions to ...
  https://www.shellcheck.net/wiki/SC2145 -- Argument mixes string and array. ...
  https://www.shellcheck.net/wiki/SC2154 -- err is referenced but not assigned.
