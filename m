Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA2B67A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833572; cv=none; b=Fk2FM2DAi95edMOSRPmGDhjFqtG2MDeBwUOBKvTKf+EFXwoGP8k+XJawJM2fT9Uij4gks3bvl0SFH3JDGyp2SCg8HPVmERD/ueq7NLpFWctVHg1wQ58IjgTXncO3P7ePeq2q5cnIyLan2liJRY35QgonkMieCTv3MXK7y6gBpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833572; c=relaxed/simple;
	bh=vecoUljxBqhaCzDWwdk1TrxoxLzhhLgob1vnZvShUBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1KjZP/KZwkQCvwvPoAacoLzMeVLOQ/2UBrKiG/RfH7g2QSKGZc72icTWpklvyvikzThhcLM2KClMqHduE58xXjQ5I4cqTJxR22okZKC5ResFAjg85rS/m142Aissml4CTegYroPSbbbdWLB4Y2uzCp0bGuJtx36qDsZkmjhy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E467DA7;
	Wed, 28 Aug 2024 01:26:35 -0700 (PDT)
Received: from [10.1.33.31] (PF4Q20KV.arm.com [10.1.33.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65BE3F762;
	Wed, 28 Aug 2024 01:26:07 -0700 (PDT)
Message-ID: <63879f18-4176-4e61-acd8-1cd7f13dbd12@arm.com>
Date: Wed, 28 Aug 2024 09:26:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/4] Force MAPPING_TYPE__IDENTIY for PIE
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724820993.git.scclevenger@os.amperecomputing.com>
 <05faf8cf48948cdadcf3757eb5fc0305497805c6.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <05faf8cf48948cdadcf3757eb5fc0305497805c6.1724820993.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2024 6:09 AM, Steve Clevenger wrote:
> 
> Use dso__is_pie() to check whether the DSO file is a Position
> Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
> MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
> into the script.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/util/map.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index e781c8d56a9a..c846faec177b 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -173,8 +173,8 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>                 assert(!dso__kernel(dso));
>                 map__init(result, start, start + len, pgoff, dso, prot, flags);
> 
> -               if (anon || no_dso) {
> -                       map->mapping_type = MAPPING_TYPE__IDENTITY;
> +               if (anon || no_dso || dso__is_pie(dso)) {
> +                       map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
> 
>                         /*
>                          * Set memory without DSO as loaded. All map__find_*
> --
> 2.25.1
> 
