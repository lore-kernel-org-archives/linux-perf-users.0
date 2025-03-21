Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE41EA7D3;
	Fri, 21 Mar 2025 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554211; cv=none; b=BQZXm42/jFNzIRcr14LDU4/suy4LXj6bMxhJQasOGTh1N882Vv2AlvkRoVTzEEpujRuWzOb5uES93MfAfQb7WRv3A0RSNkMnE7WQZYGXHa4YW4TuY6FrTsODgN8Pgm5E/fRE0xxkkotPkE41aLqp27gxmiwOe4ywnPVjjLeUdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554211; c=relaxed/simple;
	bh=qoDXzTaTrBe0hY9iTwEYkA57TTzzUEN2PdNsGqvsUV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSZchc7Jc5DCWmEgjVccdfUK62FIpqhTWRgzWAlMvXwjOp+6MsVrTSfnaDExIrzjU3VGTbqdsoKDCBDOAISeHaCBfDGGpsTDbVA8TRZ3tinFZvk90YriU++MeroM97pMcL9VQK+dJuSAbJPlURuDUuHj2dLISScVEs12OFYYWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZJzMg6ykhz9sSf;
	Fri, 21 Mar 2025 11:34:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3GmTi5jJn-m; Fri, 21 Mar 2025 11:34:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZJzMg5yTxz9sSZ;
	Fri, 21 Mar 2025 11:34:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B08BC8B79C;
	Fri, 21 Mar 2025 11:34:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id m9V4WbKxrQHq; Fri, 21 Mar 2025 11:34:23 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 747608B763;
	Fri, 21 Mar 2025 11:34:22 +0100 (CET)
Message-ID: <7cd87317-4f2a-45af-bd07-6e715406ff55@csgroup.eu>
Date: Fri, 21 Mar 2025 11:34:22 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] tools/perf/powerpc/util: Add support to handle
 compatible mode PVR for perf json events
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, irogers@google.com, akanksha@linux.ibm.com,
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
 acme@kernel.org, hbathini@linux.ibm.com, adrian.hunter@intel.com,
 jolsa@kernel.org
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
 <20241010145107.51211-2-atrajeev@linux.vnet.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20241010145107.51211-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Le 10/10/2024 à 16:51, Athira Rajeev a écrit :
> perf list picks the events supported for specific platform
> from pmu-events/arch/powerpc/<platform>. Example power10 events
> are in pmu-events/arch/powerpc/power10, power9 events are part
> of pmu-events/arch/powerpc/power9. The decision of which
> platform to pick is determined based on PVR value in powerpc.
> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
> 
> Example:
> 
> Format:
> 	PVR,Version,JSON/file/pathname,Type
> 
> 0x004[bcd][[:xdigit:]]{4},1,power8,core
> 0x0066[[:xdigit:]]{4},1,power8,core
> 0x004e[[:xdigit:]]{4},1,power9,core
> 0x0080[[:xdigit:]]{4},1,power10,core
> 0x0082[[:xdigit:]]{4},1,power10,core
> 
> The code gets the PVR from system using get_cpuid_str function
> in arch/powerpc/util/headers.c ( from SPRN_PVR ) and compares
> with value from mapfile.csv
> In case of compat mode, say when partition is booted in a power9
> mode when the system is a power10, this picks incorrectly. Because
> PVR will point to power10 where as it should pick events from power9
> folder. To support generic events, add new folder
> pmu-events/arch/powerpc/compat to contain the ISA architected events
> which is supported in compat mode. Also return 0x00ffffff as pvr
> when booted in compat mode. Based on this pvr value, json will
> pick events from pmu-events/arch/powerpc/compat
> 
> Suggested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

I see this patch was merged into mainline allthough it had CI failures 
and still has.

Could you please fix it ?

arch/powerpc/util/header.c: In function 'is_compat_mode':
Error: arch/powerpc/util/header.c:20:14: error: cast to pointer from 
integer of different size [-Werror=int-to-pointer-cast]
    20 |  if (!strcmp((char *)platform, (char *)base_platform))
       |              ^
Error: arch/powerpc/util/header.c:20:32: error: cast to pointer from 
integer of different size [-Werror=int-to-pointer-cast]
    20 |  if (!strcmp((char *)platform, (char *)base_platform))
       |                                ^
cc1: all warnings being treated as errors
make[6]: *** [/linux/tools/build/Makefile.build:86: 
/output/arch/powerpc/util/header.o] Error 1


The following fix but is maybe not the right one as in reality 
getauxval() seems to return a long not a u64.

diff --git a/tools/perf/arch/powerpc/util/header.c 
b/tools/perf/arch/powerpc/util/header.c
index c7df534dbf8f..1b045d410f31 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -17,7 +17,7 @@ static bool is_compat_mode(void)
  	u64 base_platform = getauxval(AT_BASE_PLATFORM);
  	u64 platform = getauxval(AT_PLATFORM);

-	if (!strcmp((char *)platform, (char *)base_platform))
+	if (!strcmp((char *)(long)platform, (char *)(long)base_platform))
  		return false;

  	return true;


Thanks
Christophe

> ---
> changelog:
> V1 -> V2:
> Corrected commit message and subject line
> 
>   tools/perf/arch/powerpc/util/header.c | 32 ++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index 6b00efd53638..adc82c479443 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -10,6 +10,18 @@
>   #include "utils_header.h"
>   #include "metricgroup.h"
>   #include <api/fs/fs.h>
> +#include <sys/auxv.h>
> +
> +static bool is_compat_mode(void)
> +{
> +	u64 base_platform = getauxval(AT_BASE_PLATFORM);
> +	u64 platform = getauxval(AT_PLATFORM);
> +
> +	if (!strcmp((char *)platform, (char *)base_platform))
> +		return false;
> +
> +	return true;
> +}
>   
>   int
>   get_cpuid(char *buffer, size_t sz)
> @@ -33,8 +45,26 @@ char *
>   get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>   {
>   	char *bufp;
> +	unsigned long pvr;
> +
> +	/*
> +	 * IBM Power System supports compatible mode. That is
> +	 * Nth generation platform can support previous generation
> +	 * OS in a mode called compatibile mode. For ex. LPAR can be
> +	 * booted in a Power9 mode when the system is a Power10.
> +	 *
> +	 * In the compatible mode, care must be taken when generating
> +	 * PVR value. When read, PVR will be of the AT_BASE_PLATFORM
> +	 * To support generic events, return 0x00ffffff as pvr when
> +	 * booted in compat mode. Based on this pvr value, json will
> +	 * pick events from pmu-events/arch/powerpc/compat
> +	 */
> +	if (!is_compat_mode())
> +		pvr = mfspr(SPRN_PVR);
> +	else
> +		pvr = 0x00ffffff;
>   
> -	if (asprintf(&bufp, "0x%.8lx", mfspr(SPRN_PVR)) < 0)
> +	if (asprintf(&bufp, "0x%.8lx", pvr) < 0)
>   		bufp = NULL;
>   
>   	return bufp;

