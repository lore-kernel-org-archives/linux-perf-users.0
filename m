Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8B197A8C
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Jun 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632377; cv=none; b=GmM3SauOFdZ4RtMrb9dVOxxIdILez8BwqpX49k8jD576aIDaA+UyXty2BSy4nnmCI+pIgAwse1jRqWVMtNdQFMIuUXPbDLi/5katHHjWCNdvnyv1Y9ypAs4vYEFrNOR/xOoJ7e6RH66L3HouYRWiAHRknL1TH4TNepmO9dqwh90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632377; c=relaxed/simple;
	bh=mn4AKGj+59AeBy0CFIAacQr9WPJ8o3lkuZsEUO0gzoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pm4Vxgv5Shrl21nCaZCMA5lqXUbA/GGcwOVkjfCBWMm021kAAxxn3WSNzdW66lzLjys+RmJ5QVauQi7jx2H5JMP8hau0q+q5v9FvB7dds+QfY07yJ14O/6NM4EwDOaQ7vacrBPi2Ioy8yWLyy8ThSKtGR39aEqWlHwXg3A13bWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A5CDA7;
	Mon, 17 Jun 2024 06:53:19 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 197343F6A8;
	Mon, 17 Jun 2024 06:52:53 -0700 (PDT)
Message-ID: <371abb9c-41a5-4bf0-928f-a60848776bfc@arm.com>
Date: Mon, 17 Jun 2024 14:52:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/10] perf tools: Only treat files as map files when
 they have the extension .map
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <20240601125946.1741414-10-ChaitanyaS.Prakash@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240601125946.1741414-10-ChaitanyaS.Prakash@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/06/2024 13:59, Chaitanya S Prakash wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Strengthen the check to locate symbol map files in the tool's /tmp
> directory. As the existing check allows non map files named in
> "/tmp/perf-" pattern, it leads to possible dwarf library corruption
> when perf is built with NO_DWARF=1. The try_to_find_probe_trace_events()
> function behaves differently when built in that manner. Extending the
> current check condition using the str_has_suffix() function to not only
> validate the pattern but also ensure the file is of ".map" type allows
> test perf probe of function from different CU to pass when built with
> NO_DWARF=1.
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/util/symbol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..fbcc189edd8d 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
>  	const char *map_path = dso__long_name(dso);
>  
>  	mutex_lock(dso__lock(dso));
> -	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
> +	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0 &&
> +		  str_has_prefix(dso__name(dso), ".map") != 0;

Does this work? Shouldn't it be str_has_suffix()?

For reference, there's another fix for the same issue here:
https://lore.kernel.org/linux-perf-users/20240617130332.13427-1-atrajeev@linux.vnet.ibm.com/T/#m9b1e62f0cdbcd4caf019f2ad97d69b29df568522

>  	if (perfmap) {
>  		if (dso__nsinfo(dso) &&
>  		    (dso__find_perf_map(newmapname, sizeof(newmapname),
