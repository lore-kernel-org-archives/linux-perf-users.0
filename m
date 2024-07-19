Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8855769
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402475; cv=none; b=glif3I2Q59npFMmc6bAINi6pOkVrUCpNuep9e7ozvX0A43+wP529l6Owib0M8G7grkBH2RVItHeEI2c2BnCDw2XPAlnP/kD8r3HTHbVjUiNvrwNi94N06vJYgyi8CxmcNYtsYjNDwfvAKx5+bUn1+HLIPkvN8VHSoPFgj+asUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402475; c=relaxed/simple;
	bh=fr5AFMIDxAw+1dMUMcSOcv7Fh4/3QS0Nvrccv7i6CF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBH8elLZoQlQLaXCoeEWlsEyYHvUHX2ivH0tWIO27DFpq/0HeCvsH7QGf8xyKT22WceFaPIgi+aasD1qEVDD0Ik0tJzylacFVGbvSwlhwMbcTt5YBoPaz00YV0eP/trg980WMssaCKaW59ZV9YFCXrmZUPnyAGl2HnNKUZ0Ieoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eltl8HIo; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eltl8HIo"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b5dfcfb165so12189836d6.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 08:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721402473; x=1722007273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fHscifLSJ4MOcICpnCk6DijNmMct+hYZEzclOKVCfZU=;
        b=eltl8HIob2Yc4Yq20mLEBpJkOvaXTCNI4KT3oXlkIh8OMIL1kHhtknNM7f7uB4NTvO
         LH14xJdfghgJO53DzX2rNfGt78oprra9tSy27UfhEkjf1QK93EuIyj4Viv0m6ZZnOOpJ
         52Bj57S88vyLbuikJc5zN7arygOScAHqMwuzpLc489QzS8xDKJqi7RZF4nkAkeNJB7ky
         EOZ5lBWv+Y2ET29NqHc6qnk73Q2eIf4k+CQbi1B84EZn7Rpdkbe/ID/LAr8nqgFuSr5k
         mRAeCq0gb91RX/G9twNeh5INItd6AYGZsxtKOtv4UD9f6f6iLgvjzGtgno3aDZCLntRB
         ttCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402473; x=1722007273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHscifLSJ4MOcICpnCk6DijNmMct+hYZEzclOKVCfZU=;
        b=Ixwm12tIEoCyqZ1vTDMGlTLI4275+xRTVvHA7WyGEEuXC71//ZiSrYedOS887N92Eo
         ipKu381L1X/zclJGV23L/H5fK4ngPinQnfTC0dHUpxNyZFTW7OWQkeZULUKlwTJPyiG/
         7Qg3Qt8kjiWpuxLrBp3i2xUiRTSCC0739FcyB0EQGkEe0UYqLTIhhVhDa5g0aRVqXpAc
         UKyYGTtlPpGX7oL+E/udboZV+Ak9BmqLoaUbnSTqL+GL59pOY53odgXaM5mUNeDmm4iH
         eYqXidbJ89/i6X4VpsHEMZbb0LlMWw527d3/s6d+riq50z4/7INTZqHU0TSK3tNJ1ATC
         TcLA==
X-Forwarded-Encrypted: i=1; AJvYcCV7097epHbbbSqrUpwM7m6Ep5YSvJRnjvZmw4gJNM+TD8eKVvC4+AScLytaUgsumkPABRMnENJfICdg2vJfwcZ7bDDFgtcncMa4Ey4nwCAf5Q==
X-Gm-Message-State: AOJu0Yz/5qaXaSGn384+21B/YU3dsDiZYF6pxoNjv5WmVlAfQOEtQXC7
	aID7SKtir+X1gyLZjtQUvakJVeI3tnUTeVwTsKNmF4o15P6NRUd0nDfKuAJhBL0=
X-Google-Smtp-Source: AGHT+IFkXu6WJB5QYfOAaZn9s1piO8yPCpYHKpBKZg8ljDLEmTZ0U7tZoZ2JfNjGtNrLvasw2PMYrQ==
X-Received: by 2002:ad4:576d:0:b0:6b7:9b2c:98d3 with SMTP id 6a1803df08f44-6b79b2c9b20mr80138806d6.26.1721402473067;
        Fri, 19 Jul 2024 08:21:13 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acae194dsm8456146d6.107.2024.07.19.08.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 08:21:12 -0700 (PDT)
Date: Fri, 19 Jul 2024 10:21:09 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Eric Lin <eric.lin@sifive.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	peterlin@andestech.com, dminus@andestech.com, locus84@andestech.com, 
	jisheng.teoh@starfivetech.com, inochiama@outlook.com, n.shubin@yadro.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v2] perf arch events: Fix duplicate RISC-V SBI firmware
 event name
Message-ID: <20240719-6219a417bc6fcf36ce67920f@orel>
References: <20240719115018.27356-1-eric.lin@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719115018.27356-1-eric.lin@sifive.com>

On Fri, Jul 19, 2024 at 07:50:18PM GMT, Eric Lin wrote:
> Currently, the RISC-V firmware JSON file has duplicate event name
> "FW_SFENCE_VMA_RECEIVED". According to the RISC-V SBI PMU extension[1],
> the event name should be "FW_SFENCE_VMA_ASID_SENT".
> 
> Before this patch:
> $ perf list
> 
> firmware:
>   fw_access_load
>        [Load access trap event. Unit: cpu]
>   fw_access_store
>        [Store access trap event. Unit: cpu]
> ....
>  fw_set_timer
>        [Set timer event. Unit: cpu]
>   fw_sfence_vma_asid_received
>        [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
>   fw_sfence_vma_received
>        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]
> 
> After this patch:
> $ perf list
> 
> firmware:
>   fw_access_load
>        [Load access trap event. Unit: cpu]
>   fw_access_store
>        [Store access trap event. Unit: cpu]
> .....
>   fw_set_timer
>        [Set timer event. Unit: cpu]
>   fw_sfence_vma_asid_received
>        [Received SFENCE.VMA with ASID request from other HART event. Unit: cpu]
>   fw_sfence_vma_asid_sent
>        [Sent SFENCE.VMA with ASID request to other HART event. Unit: cpu]
>   fw_sfence_vma_received
>        [Received SFENCE.VMA request from other HART event. Unit: cpu]
> 
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc#event-firmware-events-type-15 [1]
> Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event files")
> Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON file")
> Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80 JSON file")
> Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON file")
> Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic firmware and hardware raw event")
> Signed-off-by: Eric Lin <eric.lin@sifive.com>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Nikita Shubin <n.shubin@yadro.com>
> ---
> Changes since V1:
>  - Add "Fixes:" tag for every patch that copied firmware.json
> ---
>  tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json       | 2 +-
>  tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json        | 2 +-
>  tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json       | 2 +-
>  .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json  | 2 +-
>  .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> index a9939823b14b..0c9b9a2d2958 100644
> --- a/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
> @@ -74,7 +74,7 @@
>    {
>      "PublicDescription": "Sent SFENCE.VMA with ASID request to other HART event",
>      "ConfigCode": "0x800000000000000c",
> -    "EventName": "FW_SFENCE_VMA_RECEIVED",
> +    "EventName": "FW_SFENCE_VMA_ASID_SENT",
>      "BriefDescription": "Sent SFENCE.VMA with ASID request to other HART event"
>    },
>    {
> diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> index 9b4a032186a7..7149caec4f80 100644
> --- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> @@ -36,7 +36,7 @@
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
>    {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_SENT"
>    },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> -- 
> 2.43.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
