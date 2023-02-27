Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9043C64ED6
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Feb 2023 12:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjB0M2R (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Feb 2023 07:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjB0M2Q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Feb 2023 07:28:16 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D25D32A;
        Mon, 27 Feb 2023 04:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1677500859; bh=45r2F7pMo5/b+WnaKlZH9rDvVipqqe8nois6iv1W+fY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=dl1Uqlci+twDXbHxg6doTDmOYrTHQsiQfEvrULQfC24DRExMRzpb0pvtZvVsS3PuO
         cYU++1yAE2+oJ60hQ0dM+fc156xnCa8fdKBD/V3TaHm+sOGzptUeiyvCojqLsbMS2Q
         vbagiXchq2C1sTkpxVfxyEf/M96gC7f95zqogQac=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon, 27 Feb 2023 13:27:39 +0100 (CET)
X-EA-Auth: PvGfg/P+ZTbdFxj/dOecIx/mwxuxCL4nBxuwsxCjBGrSjZ9jsyKv52sRJcwNd/8aNyYiUvPFZBk3l54x1wU5ykSTWR86r8OT
Date:   Mon, 27 Feb 2023 17:57:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] perf/x86/core: Remove repeating test expression
Message-ID: <Y/yhsmvkeJ0h7tFI@ubun2204.myguest.virtualbox.org>
References: <Y/yYTY7c7L0+d+Gb@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/yYTY7c7L0+d+Gb@ubun2204.myguest.virtualbox.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 27, 2023 at 05:17:25PM +0530, Deepak R Varma wrote:
> Current implementation already checks validity of the cpu_type for the
> hybrid pmu two lines above. Hence there is no need to again include
> it in the immediate if test evaluation.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Please disregard. I misread the bitwise operation as logical evaluation. Sorry
for any inconvenience.

Deepak.

>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 87a7f0cd77fd..89db2352deb9 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1893,7 +1893,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
>  		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
>  			continue;
> -		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
> +		if (pmu->cpu_type) {
>  			next_str = strchr(str, ';');
>  			if (next_str)
>  				return snprintf(page, next_str - str + 1, "%s", str);
> -- 
> 2.34.1
> 


