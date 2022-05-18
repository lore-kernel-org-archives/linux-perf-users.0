Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3C4C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 18 May 2022 13:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiERNFl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 18 May 2022 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiERNFk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 May 2022 09:05:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E761ACF9B
        for <linux-perf-users@vger.kernel.org>; Wed, 18 May 2022 06:05:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3CsF0szhz4xVP;
        Wed, 18 May 2022 23:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1652879137;
        bh=GuVwZp/TlOFSd6W4AKwTAir7ZsMlh2c6/tLElwH66Dc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IRUWSxUOK1ibcO8aDVNgHkp7JrjimbYml1PjCRrRr/nyaNFo7FlmHMZFRo+CecmEr
         pPnKZhGYRcRfNMqcupDxKyuT5e06PsCu+FoFmV9IuGQnse6HkqKhqD9JvdZfGL50Px
         +7HtKH5gaBlOdcQb1hmyvI5OxHEhHEX9s+rRWTb9rTJ1HD31V5PI7Zr2H4zZDcnA4R
         Fb21erq8gnFJvjmT9zJr7w/g5v1WueTD3ddkutKbrfnScu95LPU9l59qeywGBmZqXD
         Hw+NOrfhBqfp+Py1ggGPsfmdpr773i76m4mB/fYjdwCrFIz53M2stERNQigvw/Pj9k
         ZbIlT6RYuBf6A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, irogers@google.com
Subject: Re: [PATCH] tools/perf/test: Fix perf all PMU test to skip
 hv_24x7/hv_gpci tests on powerpc
In-Reply-To: <20220518092903.7065-1-atrajeev@linux.vnet.ibm.com>
References: <20220518092903.7065-1-atrajeev@linux.vnet.ibm.com>
Date:   Wed, 18 May 2022 23:05:36 +1000
Message-ID: <87czgbng7z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> "perf all PMU test" picks the input events from
> "perf list --raw-dump pmu" list and runs "perf stat -e"
> for each of the event in the list. In case of powerpc, the
> PowerVM environment supports events from hv_24x7 and hv_gpci
> PMU which is of example format like below:
> - hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> - hv_gpci/event,partition_id=?/
>
> The value for "?" needs to be filled in depending on
> system and respective event. CPM_ADJUNCT_INST needs have
> core value and domain value. hv_gpci event needs partition_id.
> Similarly, there are other events for hv_24x7 and hv_gpci
> having "?" in event format. Hence skip these events on powerpc
> platform since values like partition_id, domain is specific
> to system and event.
>
> Fixes: 3d5ac9effcc6 ("perf test: Workload test of all PMUs")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/stat_all_pmu.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index b30dba455f36..4a854b545bec 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -5,6 +5,16 @@
>  set -e
>  
>  for p in $(perf list --raw-dump pmu); do
> +  # In powerpc, skip the events for hv_24x7 and hv_gpci.
> +  # These events needs input values to be filled in for
> +  # core, chip, patition id based on system.
> +  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/
> +  # hv_gpci/event,partition_id=?/
> +  # Hence skip these events for ppc.
> +  if lscpu  |grep ppc && echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then

My system doesn't have lscpu installed, why not use `uname -m`.

But why check for ppc at all, the name of the pmu seems unique enough -
no one else is going to call their pmu something so odd :)

cheers
