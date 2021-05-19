Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AE7C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 16:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C56E60FD8
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 16:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242257AbhESQ2O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 12:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355371AbhESQ1r (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 12:27:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26150611BF;
        Wed, 19 May 2021 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621441587;
        bh=jnTv6Fnpv5CAvFwr4eDjPLRAM0eB+pt5/0/fOB4VUts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJzUB0vAvWg96cwyx/RhJJAtvOW6+LpNozV7O0hEmy9LySu4OSfxRvTA7Ef4QlE40
         +ZqvVpnlsb1CntYLvTuNiQJRb/K8rYFL61Oyt2R4Vfrw7Yst4IFK3ABZp9lZgD4BVh
         A+hAhjFA0kuegwid460WIbM8dXl17kEa+R7/a/FI4fgInQnPgs9S9+okQGAsi2ewHt
         2xPmvkrM7tkwAnqR+YUL6pCtt+r8Gzw5CJ8oVvZDT9Ua2uE81O8cGLG8h5CnFwJedA
         2Fx9TNdOTpRc+kryHEtfaxafcE9m+Fzrfytrqqk6IeqgcG+2v+Jb34z5Nw2k9Yz97i
         F1kWJ6ZjJWluA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E8F740DC6; Wed, 19 May 2021 13:26:23 -0300 (-03)
Date:   Wed, 19 May 2021 13:26:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     sumanth Korikkar <sumanthk@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: perf list dumps core using 5.13.0.rc2
Message-ID: <YKU8L/v7BDobrzBb@kernel.org>
References: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <555b92bd-1884-58a7-76fd-7dd197978436@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, May 19, 2021 at 04:57:05PM +0200, Thomas Richter escreveu:
> Using kernel 5.13.0.rc2 command perf list dumps core on my x86
> virtual machine:
> 
> [root@f34 perf]# ./perf list
> Segmentation fault (core dumped)
> ^C
> [root@f34 perf]#
> 
> The root case this this change in file ../include/uapi/linux/perf_event.h:
> enum perf_sw_ids {
>         PERF_COUNT_SW_CPU_CLOCK                 = 0,
>         ...
>  --->   PERF_COUNT_SW_CGROUP_SWITCHES           = 11,
> 
>         PERF_COUNT_SW_MAX,                      /* non-ABI */
> };
> 
> This change increases PERF_COUNT_SW_MAX to 12. However this
> change is not reflected in file util/parse-events.c where data structure
> 
> struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
>         ....
> }
> 
> is defined and it misses the symbol name and alias for this new software

Sure, it is not there, but then PERF_COUNT_SW_MAX is used in the array
definition, so it ends up having
event_symbols_sw[PERF_COUNT_SW_MAX].symbol == NULL

> event. So when command 'perf list' is called, the call chain sequence
> is
>   cmd_list()
>     print_events()
>       print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
>                           event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
> 
> where PERF_COUNT_SW_MAX is 12 and  structure event_symbols_sw[] contains
> only 11 elements. This ends up with the last element of the array being
> all zeroes and the line:
> 
>     if (!name_only && strlen(syms->alias))

But before this we have:

                if (event_glob != NULL && syms->symbol != NULL &&
                    !(strglobmatch(syms->symbol, event_glob) ||
                      (syms->alias && strglobmatch(syms->alias, event_glob))))
                        continue;

We need to move that syms->symbol != NULL part to be the first one and
continue if that array entry isn't populated, I'll add a patch with your
Reported-by:

I was scratching my head looking why I hadn't hit this, it doesn't
support PERF_COUNT_SW_CGROUP_SWITCHES so it bails out at
!is_event_supported(type, i):

        for (i = 0; i < max; i++, syms++) {

                if (event_glob != NULL && syms->symbol != NULL &&
                    !(strglobmatch(syms->symbol, event_glob) ||
                      (syms->alias && strglobmatch(syms->alias, event_glob))))
                        continue;

                if (!is_event_supported(type, i))
                        continue;

                if (!evt_num_known) {
                        evt_num++;
                        continue;
                }

                if (!name_only && strlen(syms->alias))

> 
> dumps core because syms->alias is a NULL pointer.
> 
> Is this dummy event PERF_COUNT_SW_CGROUP_SWITCHES simply missing in the
> event_symbols_sw[] array or is there more to it (which I am missing).
> 
> Thanks. 
> 
> PS: I can sent a patch if needed....
> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 

- Arnaldo
