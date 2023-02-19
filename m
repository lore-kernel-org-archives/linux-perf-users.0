Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD91BC6379F
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 12:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjBSMCb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 07:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSMCa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 07:02:30 -0500
X-Greylist: delayed 581 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Feb 2023 04:02:29 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F810A97
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 04:02:29 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 4564A1236E7C;
        Sun, 19 Feb 2023 12:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1676807564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlM/jmDxuMpikTFQLI7Ipru8I8W1UZUK0W6ugJVYzIg=;
        b=Du2to3A8IVx/+YQJsJhrR15PFz81aW47bkBKCFbWyZofxmFsMR9m+j6eAkU7XJBv5voM66
        TP4X/YFbksBWA1fZj0+cngPt3XFXkt1qyFklHFuWip4LKs8hAm/w5gQTXljBE7vPosnW5Y
        nAfbQKAXm+eatr/48j8GjEruY/DBX9c=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, hpa@zytor.com,
        Wyes Karny <wyes.karny@amd.com>
Cc:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, gautham.shenoy@amd.com,
        ananth.narayan@amd.com, Wyes Karny <wyes.karny@amd.com>
Subject: Re: [PATCH] perf/x86/rapl: Enable Core RAPL for AMD
Date:   Sun, 19 Feb 2023 12:52:42 +0100
Message-ID: <12153455.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20230217161354.129442-1-wyes.karny@amd.com>
References: <20230217161354.129442-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello.

On p=E1tek 17. =FAnora 2023 17:13:54 CET Wyes Karny wrote:
> AMD processors support per-package and per-core energy monitoring
> through RAPL counters which can be accessed by users running in
> supervisor mode.
>=20
> Core RAPL counters gives power consumption information per core.  For
> AMD processors the package level RAPL counter are already exposed to
> perf. Expose the core level RAPL counters also.
>=20
> sudo perf stat -a --per-core -C 0-127 -e power/energy-cores/
>=20
> Output:
> S0-D0-C0           2               8.73 Joules power/energy-cores/
> S0-D0-C1           2               8.73 Joules power/energy-cores/
> S0-D0-C2           2               8.73 Joules power/energy-cores/
> S0-D0-C3           2               8.73 Joules power/energy-cores/
> S0-D0-C4           2               8.73 Joules power/energy-cores/
>=20
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  arch/x86/events/rapl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 52e6e7ed4f78..d301bbbc3b93 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -537,7 +537,7 @@ static struct perf_msr intel_rapl_spr_msrs[] =3D {
>   * - want to use same event codes across both architectures
>   */
>  static struct perf_msr amd_rapl_msrs[] =3D {
> -	[PERF_RAPL_PP0]  =3D { 0, &rapl_events_cores_group, 0, false, 0 },
> +	[PERF_RAPL_PP0]  =3D { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_cores_g=
roup, test_msr, false, RAPL_MSR_MASK },
>  	[PERF_RAPL_PKG]  =3D { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_gro=
up,   test_msr, false, RAPL_MSR_MASK },
>  	[PERF_RAPL_RAM]  =3D { 0, &rapl_events_ram_group,   0, false, 0 },
>  	[PERF_RAPL_PP1]  =3D { 0, &rapl_events_gpu_group,   0, false, 0 },
> @@ -764,7 +764,8 @@ static struct rapl_model model_spr =3D {
>  };
> =20
>  static struct rapl_model model_amd_hygon =3D {
> -	.events		=3D BIT(PERF_RAPL_PKG),
> +	.events		=3D BIT(PERF_RAPL_PP0) |
> +			  BIT(PERF_RAPL_PKG),
>  	.msr_power_unit =3D MSR_AMD_RAPL_POWER_UNIT,
>  	.rapl_msrs      =3D amd_rapl_msrs,
>  };
>=20

With this patch:

```
$ lscpu | grep 'Model name'
Model name:                      AMD Ryzen 9 5950X 16-Core Processor

$ sudo perf stat -a --per-core -C 0-15 -e power/energy-cores/ -- dd if=3D/d=
ev/zero of=3D/dev/null bs=3D1M count=3D100000
100000+0 records in
100000+0 records out
104857600000 bytes (105 GB, 98 GiB) copied, 1,59252 s, 65,8 GB/s

Performance counter stats for 'system wide':

S0-D0-C0           1               1,56 Joules power/energy-cores/
S0-D0-C1           1               1,56 Joules power/energy-cores/
S0-D0-C2           1               1,56 Joules power/energy-cores/
S0-D0-C3           1               1,56 Joules power/energy-cores/
S0-D0-C4           1               1,56 Joules power/energy-cores/
S0-D0-C5           1               1,56 Joules power/energy-cores/
S0-D0-C6           1               1,56 Joules power/energy-cores/
S0-D0-C7           1               1,56 Joules power/energy-cores/
S0-D0-C8           1               1,56 Joules power/energy-cores/
S0-D0-C9           1               1,56 Joules power/energy-cores/
S0-D0-C10          1               1,56 Joules power/energy-cores/
S0-D0-C11          1               1,56 Joules power/energy-cores/
S0-D0-C12          1               1,56 Joules power/energy-cores/
S0-D0-C13          1               1,56 Joules power/energy-cores/
S0-D0-C14          1               1,56 Joules power/energy-cores/
S0-D0-C15          1               1,56 Joules power/energy-cores/

1,593982452 seconds time elapsed
```

Hence,

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thank you.

=2D-=20
Oleksandr Natalenko (post-factum)


