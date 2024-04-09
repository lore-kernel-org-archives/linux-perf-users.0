Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C285631
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658119; cv=none; b=qynZbZFGlx7TlsbT4Yy9e6nYn/g3JkLGzbXET69JWoRk04oQgkmHySutsuWmy4u6mfp3oxg9vl+sV/qhbeIrDfY7ox4pzBRSRB1SoViLVzfEkNCEcJXP2CjiFCkVBfRtW+2Sd59JeGk4rdqk6JH7SFQX7A3X8g3TDSAZBqcmy18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658119; c=relaxed/simple;
	bh=gue8F4EmzdskPgu72KCdnvJQXgP388yDHIsKhgBC6VI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkj559BWCGeWwDtBK0Qz7WDU6Dvw1dmoD8kMf7s/Lg3fllTXSGk+DOYR2x5n3aPN2PSY99Ieu6vFCue8/1I+pe1MHX+w3Mfe9Iah+qhSlaDtfJvxP0/zmMf70dlDkA1r4WHykfVpPuTLcKlyCgyAPAuQ3P9tjnMIE7ZCkJ0428c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03711DA7;
	Tue,  9 Apr 2024 03:22:28 -0700 (PDT)
Received: from [10.57.52.202] (unknown [10.57.52.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6723F6C4;
	Tue,  9 Apr 2024 03:21:56 -0700 (PDT)
Message-ID: <7ba7a9ee-901c-48a4-bd6c-b59294da7a65@arm.com>
Date: Tue, 9 Apr 2024 11:21:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/8] perf tools: Only treat files as map files when
 they have the extension .map
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: anshuman.khandual@arm.com
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-8-ChaitanyaS.Prakash@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240408062230.1949882-8-ChaitanyaS.Prakash@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/04/2024 07:22, Chaitanya S Prakash wrote:
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
>  tools/perf/util/symbol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9ebdb8e13c0b..812684aa42ce 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1792,7 +1792,9 @@ int dso__load(struct dso *dso, struct map *map)
>  	const char *map_path = dso->long_name;
>  
>  	mutex_lock(&dso->lock);
> -	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
> +	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0 &&
> +		  str_has_suffix(dso->name, ".map") != 0;
> +
>  	if (perfmap) {
>  		if (dso->nsinfo && (dso__find_perf_map(newmapname,
>  		    sizeof(newmapname), &dso->nsinfo) == 0)) {

Reviewed-by: James Clark <james.clark@arm.com>
