Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE718ECAAD3
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Sep 2022 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiIEKAs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237158AbiIEKAl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 06:00:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13D140BDB
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Sep 2022 03:00:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id qh18so15980728ejb.7
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Sep 2022 03:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=FGeyGBvucY/aPj3BEw9X/LWihxhqIvfD/NBugB957bA=;
        b=H/hTbYQSHdwbnWR9mV8ud8JBChSBuhYyDa12FaFxABykHpKIZZmWg3se1irtGnuu2K
         Ay7GzBm2LCeCVhzBAc7203HYGwzJDWlD7B18qLHhy4gA54y0xdG4ktr1BACYNca5xdKX
         im6fo5UtBbUHYTbQ7GyW62AbV6ipXVVZ6GGagofXnM+gkZ9eVkyL66Pqm7t2zXn+7Crr
         QCca6a8wOqzwI/94Ym//GUoInMVjhCqtUqRRDasHPitvNV97i35bmTp7tj/ZqznuYWVA
         s3KpJEyIuqRGfkgLTEQFKwpsBOGwLH6JUtAHVM3OGW0dAWfXxeDJrYm5oQKs5WNXug6p
         MI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FGeyGBvucY/aPj3BEw9X/LWihxhqIvfD/NBugB957bA=;
        b=Sju3GMJsP9NrN+vKo38NHDCtrmQA//iklXbuwOAmQFASlCzAyUXqLjd3aoljysNAyv
         dW1xG7+vq+W7f09xyVFD10bYSPf79IraGJdj8kONxRevmtbqW+qa9oHk3KhiqeAELrDe
         pIbrfkPa52+Lrd2NJQRWto7QEaA9KKTd5ogTnXNad3BVsnAEeTRYTnZD5u/3m+OD/nUO
         L8kJ9gkFqvuMeo1PbviejYu19A64IJzL8rWJdbwiKuqjxEKCI9UcaE7tR0VTp0nSFXAx
         4GlhduLoL3ZTyKK25T7WtwhmYVAKpjjVbtD9daPAlkCwRBIsVkSQW9Xtc37B4AURVwLG
         CuQQ==
X-Gm-Message-State: ACgBeo2CtMOm/OXvSUYx0HZLYBZL6U+m51or/JsXlIvlffC5aiXoOLwJ
        Tsa9a2ZMZl+rog/vCQoOHOzQ7paNIn8Veg==
X-Google-Smtp-Source: AA6agR5wieRoEMZ8F6+Gf9jOtOXCaCA+40fqoAKwE2wzhNsMTzLAfxRtUrwnBrrJdXSsbPBiRropJQ==
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id nb9-20020a1709071c8900b00741445375bemr29532218ejc.208.1662372033137;
        Mon, 05 Sep 2022 03:00:33 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b0073ddff7e432sm4928786ejd.14.2022.09.05.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 03:00:32 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 5 Sep 2022 12:00:30 +0200
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com
Subject: Re: [PATCH 1/2] tools/perf: Fix out of bound access to affinity
 "sched_cpus"
Message-ID: <YxXIvno0W1UeiH8K@krava>
References: <20220905045441.1643-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905045441.1643-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 05, 2022 at 10:24:40AM +0530, Athira Rajeev wrote:
> The affinity code in "affinity_set" function access array
> named "sched_cpus". The size for this array is allocated in
> affinity_setup function which is nothing but value from
> get_cpu_set_size. This is used to contain the cpumask value
> for each cpu. While setting bit for each cpu, it calls
> "set_bit" function which access index in sched_cpus array.
> If we provide a command-line option to -C which is more than
> the number of CPU's present in the system, the set_bit could
> access an array member which is out-of the array size. This
> is because currently, there is no boundary check for the CPU.
> This will result in seg fault:
> 
> <<>>
>  ./perf stat -C 12323431 ls
> Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS
> Segmentation fault (core dumped)
> <<>>
> 
> Fix this by adding boundary check for the array.
> 
> After the fix from powerpc system:
> 
> <<>>
> ./perf stat -C 12323431 ls 1>out
> Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS
> 
>  Performance counter stats for 'CPU(s) 12323431':
> 
>    <not supported> msec cpu-clock
>    <not supported>      context-switches
>    <not supported>      cpu-migrations
>    <not supported>      page-faults
>    <not supported>      cycles
>    <not supported>      instructions
>    <not supported>      branches
>    <not supported>      branch-misses
> 
>        0.001192373 seconds time elapsed
> <<>>
> 
> Reported-by: Nageswara Sastry <rnsastry@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/affinity.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> index 4d216c0dc425..a1dd37347abc 100644
> --- a/tools/perf/util/affinity.c
> +++ b/tools/perf/util/affinity.c
> @@ -49,8 +49,14 @@ void affinity__set(struct affinity *a, int cpu)
>  {
>  	int cpu_set_size = get_cpu_set_size();
>  
> -	if (cpu == -1)
> +	/*
> +	 * Return:
> +	 * - if cpu is -1
> +	 * - restrict out of bound access to sched_cpus
> +	 */
> +	if (cpu == -1 || ((cpu / __BITS_PER_LONG) >= (cpu_set_size / 8)))

hm, there's __BITS_PER_LONG in one case, but then there's hardcoded 8

would this be simpler:

	if (cpu == -1 || ((cpu >= (cpu_set_size * 8))))
		return;

jirka

>  		return;
> +
>  	a->changed = true;
>  	set_bit(cpu, a->sched_cpus);
>  	/*
> -- 
> 2.35.1
> 
