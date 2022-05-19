Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA2C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 May 2022 18:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiESSpX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 May 2022 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiESSpW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 May 2022 14:45:22 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343C5C856
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 11:45:21 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id e144so3165992vke.9
        for <linux-perf-users@vger.kernel.org>; Thu, 19 May 2022 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UErDeXihakGThWuvWZEyYnX/IDLG+tP7OOkjLo42zSU=;
        b=ZFZcj8t2sudf8IYNq7JukgVc+l+tHXO3iI0qsAICIHY2ygKHz+QzkRwdVafSLNHg6S
         g57bJQSFd/EMGjboR4f6SpCS9Zbdg4929nTYIj8H0qLLNXk4vwUaaEwybUpdycCPQAmB
         8pIGiNaePzXR7UPrvsoy9WLWL+9b+eU3Han+/pO9/0pY+wB5U5hTCxKoAwhauzy81AhW
         /hfYdQuNDhXNylBIA9y2AUZTiITUBsPMuuTdoPXtjiillWTCZAj2Z8FLnDY++nX9ncNb
         su+I0KcwA96K2A2lmyOmT0j+zGno9ww85UMvyJSdtc4x1+qWc28AUAXbGRWanoHPaYXV
         ptRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UErDeXihakGThWuvWZEyYnX/IDLG+tP7OOkjLo42zSU=;
        b=aU1QL3euJO6gVcVZom6U16/aJiSa7ndgOUuY4tS1dQ3LlUxgGJSrPetZXvLYdpP3wQ
         /ksrCKgQy4GKHAiciaJssG8ebIh5SZXpWE5FiNv85fE8VrWH47cjvuNuYQYFk7uu48/f
         sq9mKWC5pEBvY6eAAy5XEY+w+mpymTLpJ/vyyoY1zs2xSrrkl1+4cojt+GvLZRZO1XDS
         bXi5zKml1L9fOQb1/0+qPwLy4Mlx5tzWJI1XkVNCG+xBtbnnLTqxL//la46e1WyRYrIf
         HwyAmusiBoG2FKWWjMLbeNj11a6puaWAMPJ4MHprOlFGcl7lMWHhjwU/Rv12tbG+SVJk
         2s1g==
X-Gm-Message-State: AOAM530t9w9Er4AXoJ5KBM9VUDXYZ14z6RzX9CyfkiE0FsAKg+QEUoQq
        GTvz/+dSAYetl2pKNAoe/vfcxGjueo/ou8PdVMI7rg==
X-Google-Smtp-Source: ABdhPJyDCcFCvUFsrfEXlIKurKxXhctkr6C5chXaKtZB0KMsbDNIfmezLlO3zvekD/VeMM8m+lzLHVGly/BsRhMUij8=
X-Received: by 2002:a1f:9fc4:0:b0:345:5848:4f44 with SMTP id
 i187-20020a1f9fc4000000b0034558484f44mr2807446vke.2.1652985920452; Thu, 19
 May 2022 11:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220519154324.12531-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220519154324.12531-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 11:45:07 -0700
Message-ID: <CAP-5=fXrtTe=6-z8-OMzG60XZmA92nHEhc94+NyCJK-ZPDekPQ@mail.gmail.com>
Subject: Re: [PATCH V2] tools/perf/test: Fix perf all PMU test to skip
 hv_24x7/hv_gpci tests on powerpc
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 19, 2022 at 8:43 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
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
> Changelog:
>  v1 -> v2:
>  Instead of checking for platform, used the pmu name
>  ie, hv_24x7 and hv_gpci to skip the test since this
>  pmu name is specific to powerpc as suggested by
>  Michael Ellerman.
>
>  tools/perf/tests/shell/stat_all_pmu.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat_all_pmu.sh b/tools/perf/tests/shell/stat_all_pmu.sh
> index b30dba455f36..7d046bb8a7b9 100755
> --- a/tools/perf/tests/shell/stat_all_pmu.sh
> +++ b/tools/perf/tests/shell/stat_all_pmu.sh
> @@ -5,6 +5,16 @@
>  set -e
>
>  for p in $(perf list --raw-dump pmu); do
> +  # In powerpc, skip the events for hv_24x7 and hv_gpci.
> +  # These events needs input values to be filled in for
> +  # core, chip, patition id based on system.
nit: s/patition/partition/
> +  # Example: hv_24x7/CPM_ADJUNCT_INST,domain=?,core=?/

I've no problem with this patch, we may need to do similar for other
architectures. For this specific problem I wonder if rather than
skipping the event the event can be fixed with domain and core set to
1 ? This would provide a little additional coverage.

Thanks,
Ian

> +  # hv_gpci/event,partition_id=?/
> +  # Hence skip these events for ppc.
> +  if echo "$p" |grep -Eq 'hv_24x7|hv_gpci' ; then
> +    echo "Skipping: Event '$p' in powerpc"
> +    continue
> +  fi
>    echo "Testing $p"
>    result=$(perf stat -e "$p" true 2>&1)
>    if ! echo "$result" | grep -q "$p" && ! echo "$result" | grep -q "<not supported>" ; then
> --
> 2.35.1
>
