Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C907155749;
	Wed, 15 May 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787511; cv=none; b=QtPLwbaEJUN9OYLOrCYfWvcX9vTNsz1u1MHvQTgEiJ4dCb2lW/HdzX0HTHC4rN7J5fpUYN/KWQWcfenNk7XXZkGKGjcVnVdwyHQPc73vm7wgyhld4rORM3UHR8bbxX0sl0yxtJGIWk56NsD9ksg/knX2SWMjiFi9MQxx/LPo9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787511; c=relaxed/simple;
	bh=LEUHsrTdwa6alzDTTaOO55XhQjMYEv4S83zzoa18X5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mg02pdkGhgdR26+VxCtx9DKNk2n0SReO+Fw0S30HIK5p9FOaS6v/dux9ZjaDx9HfYTi2Ei4nGtjV2WwW6VURI8a4rURCgdsQugP6w4+fScA/dHzQK1z5Ppj77tO03ZMBTmjqpDOa3nyou2XPG5sdwvz+FVR5fBZiwlzJx63ttdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1438B1042;
	Wed, 15 May 2024 08:38:53 -0700 (PDT)
Received: from [10.57.35.76] (unknown [10.57.35.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 232AB3F7A6;
	Wed, 15 May 2024 08:38:25 -0700 (PDT)
Message-ID: <89e6a60e-5dfc-431a-aeb5-d4f1e9fdc4b0@arm.com>
Date: Wed, 15 May 2024 17:38:28 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf arm-spe: Unaligned pointer work around
To: Ian Rogers <irogers@google.com>
References: <20240514052402.3031871-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240514052402.3031871-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/05/2024 07:24, Ian Rogers wrote:
> Use get_unaligned_leXX instead of leXX_to_cpu to handle unaligned
> pointers. Such pointers occur with libFuzzer testing.
> 
> A similar change for intel-pt was done in:
> https://lore.kernel.org/r/20231005190451.175568-6-adrian.hunter@intel.com
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

Reviewed-by: James Clark <james.clark@arm.com>

>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 23 ++++---------------
>  1 file changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> index a454c6737563..7bf607d0f6d8 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> @@ -10,24 +10,11 @@
>  #include <byteswap.h>
>  #include <linux/bitops.h>
>  #include <stdarg.h>
> +#include <linux/kernel.h>
> +#include <asm-generic/unaligned.h>
>  
>  #include "arm-spe-pkt-decoder.h"
>  
> -#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -#define le16_to_cpu bswap_16
> -#define le32_to_cpu bswap_32
> -#define le64_to_cpu bswap_64
> -#define memcpy_le64(d, s, n) do { \
> -	memcpy((d), (s), (n));    \
> -	*(d) = le64_to_cpu(*(d)); \
> -} while (0)
> -#else
> -#define le16_to_cpu
> -#define le32_to_cpu
> -#define le64_to_cpu
> -#define memcpy_le64 memcpy
> -#endif
> -
>  static const char * const arm_spe_packet_name[] = {
>  	[ARM_SPE_PAD]		= "PAD",
>  	[ARM_SPE_END]		= "END",
> @@ -70,9 +57,9 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
>  
>  	switch (payload_len) {
>  	case 1: packet->payload = *(uint8_t *)buf; break;
> -	case 2: packet->payload = le16_to_cpu(*(uint16_t *)buf); break;
> -	case 4: packet->payload = le32_to_cpu(*(uint32_t *)buf); break;
> -	case 8: packet->payload = le64_to_cpu(*(uint64_t *)buf); break;
> +	case 2: packet->payload = get_unaligned_le16(buf); break;
> +	case 4: packet->payload = get_unaligned_le32(buf); break;
> +	case 8: packet->payload = get_unaligned_le64(buf); break;
>  	default: return ARM_SPE_BAD_PACKET;
>  	}
>  
