Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60176C001B0
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 07:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjF0HwO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 03:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjF0HwN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 03:52:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DC62268D
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jun 2023 00:52:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D222F4;
        Tue, 27 Jun 2023 00:52:49 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC0903F663;
        Tue, 27 Jun 2023 00:52:03 -0700 (PDT)
Message-ID: <334989bf-5501-494c-f246-81878fd2fed8@arm.com>
Date:   Tue, 27 Jun 2023 08:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 13/22] tools/perf/tests: Fix shellcheck warning for
 coresight.sh shell script
Content-Language: en-US
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, acme@kernel.org, jolsa@kernel.org,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com,
        john.g.garry@oracle.com
References: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
 <20230621083021.71203-14-atrajeev@linux.vnet.ibm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230621083021.71203-14-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 21/06/2023 09:30, Athira Rajeev wrote:
> From: Kajol Jain <kjain@linux.ibm.com>
> 
> Running shellcheck on coresight.sh throws below warning:
> 
> In lib/coresight.sh line 1:
> ^-- SC2148 (error): Tips depend on target shell and yours is unknown. Add a shebang or a 'shell' directive.
> 
> In lib/coresight.sh line 13:
> PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> ^--------^ SC2034 (warning): PERFRECOPT appears unused. Verify use (or export if used externally).
> 
> Fixed the warnings by:
> - Adding shell directive
> - Using export for PERFRECOPT variable
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lib/coresight.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
> index 6c3d34ec64d8..c7d97a0186c7 100644
> --- a/tools/perf/tests/shell/lib/coresight.sh
> +++ b/tools/perf/tests/shell/lib/coresight.sh
> @@ -1,3 +1,4 @@
> +#!/bin/bash

There is a comment a couple of lines below this that says the shebang
was excluded for a reason. It's probably worth leaving it excluded or
updating the comment.

>  # SPDX-License-Identifier: GPL-2.0
>  # Carsten Haitzler <carsten.haitzler@arm.com>, 2021
>  
> @@ -10,7 +11,7 @@
>  
>  # perf record options for the perf tests to use
>  PERFRECMEM="-m ,16M"
> -PERFRECOPT="$PERFRECMEM -e cs_etm//u"
> +export PERFRECOPT="$PERFRECMEM -e cs_etm//u"

This might silence the warning, but there are other variables like DATD
that are used in the sub-test scripts in the same way. They just don't
trigger the warning because they're also used in the top level one.

I think this change makes the code more misleading than solving any
problems. The coresight.sh script is sourced in the same process as the
sub tests so exporting variables isn't needed which is why it already
works without this change.

>  
>  TOOLS=$(dirname $0)
>  DIR="$TOOLS/$TEST"
