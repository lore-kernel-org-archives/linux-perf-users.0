Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B38C4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 20 Dec 2022 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLTSdP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Dec 2022 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiLTSdO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Dec 2022 13:33:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49162283
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 10:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFD6961551
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Dec 2022 18:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170CC433EF;
        Tue, 20 Dec 2022 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671561192;
        bh=gN5I6bRgKG1QLSMnYZY5EBgdj4r5bB3ZFtObji42wZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHj30zgG5yLuUaFIc7YN2N2wl36/Or+M0rlzNdthLR++Qp63jGIhnIRELzo/n1npz
         4G1AzjkuMkIrVet6weWcrZscvi6U5oMf9e3V/IdvJrKCmtAEp/RUoUB9rk/ZDMlZnD
         0b12rLfJxdwbA6hGOxl2gJAEznH+opa5fspKTSfG3G/9VrKNAeDtpj6kjJFQwuIM6/
         oHBjtT1QKGGWjZmZZ34C9tiDc5Sr/KCy3u5eCj9lxQ6iUSWIB27AVu7aTonOdVHxzc
         d9/yi3d93chhqLBsm80a+84K9wVdSH/XURpr5JucP+uxSj7Y/E6HFjWiA36JqLZ4PW
         Tb0uHjKyaUR9w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F80740367; Tue, 20 Dec 2022 15:33:07 -0300 (-03)
Date:   Tue, 20 Dec 2022 15:33:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@redhat.com,
        disgoel@linux.vnet.ibm.com, atrajeev@linux.vnet.ibm.com,
        mpe@ellerman.id.au, irogers@google.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH] perf test: Fix "all PMU test" to skip parametrized events
Message-ID: <Y6H/47gl3d8+A+cA@kernel.org>
References: <20221219163008.9691-1-mpetlan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219163008.9691-1-mpetlan@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Dec 19, 2022 at 05:30:08PM +0100, Michael Petlan escreveu:
> Parametrized events are not only a powerpc domain. They occur on other
> platforms too (e.g. aarch64). They should be ignored in this testcase,
> since proper setup of the parameters is out of scope of this script.
> 
> Let's not filter them out by PMU name, but rather based on the fact
> that they expect a parameter.

Looks ok, applied.

Thanks,

- Arnaldo
 
> Fixes: 451ed8058c69 ("perf test: Fix "all PMU test" to skip hv_24x7/hv_gpci tests on powerpc")
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index 9c9ef33e0b3c..c77955419173 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -4,17 +4,8 @@
>  
>  set -e
>  
> -for p in $(perf list --raw-dump pmu); do
> -  # In powerpc, skip the events for hv_24x7 and hv_gpci.
> -  # These events needs input values to be filled in for
> -  # core, chip, partition id based on system.
> -  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> -  # hv_gpci/event,partition_id=?/
> -  # Hence skip these events for ppc.
> -  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
> -    echo "Skipping: Event '$p' in powerpc"
> -    continue
> -  fi
> +# Test all PMU events; however exclude parametrized ones (name contains '?')
> +for p in $(perf list --raw-dump pmu | sed 's/[[:graph:]]\+?[[:graph:]]\+[[:space:]]//g'); do
>    echo "Testing $p"
>    result=$(perf stat -e "$p" true 2>&1)
>    if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> -- 
> 2.18.4

-- 

- Arnaldo
