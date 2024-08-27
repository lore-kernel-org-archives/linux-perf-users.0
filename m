Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12C146A63
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724788562; cv=none; b=Uj6ZEoJ0izBKv89QNg7LMnvK/DhI42wqNV6/TXpDA5slJWUxKO5SzxeMTNVsXXTWyuyVpp2eo0NxSicRl2clXCZ+RVSMlVOk0EkXHjUofJQhjfARQZijAEUsLQtNhH2I7tXv+InAh35mG1vRn4aHUP984NzS9wZVYfmk1M/EgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724788562; c=relaxed/simple;
	bh=dss9UXEub2dCvn9EOvkHbAMk+liUJ8szIrA1zlbmtLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJq1TknDkmVP+ovbqOlGEpIPUelggx8R6DVE9/ax7idHrMY1L1W1l5lY7ycov6MnaIniDwvP067piAng1weBFpogeLsqXZjzXKCYC1A7jCMYoOP6tKO4svQYaaqt0S/iSpczsG41X6YFoFHsLnlCWXut3ntfrFYmZTH06oFGN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C976DA7;
	Tue, 27 Aug 2024 12:56:25 -0700 (PDT)
Received: from [10.57.81.3] (unknown [10.57.81.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E98753F73B;
	Tue, 27 Aug 2024 12:55:57 -0700 (PDT)
Message-ID: <9ab26232-90af-4e6a-9960-a8486f0d7bf5@arm.com>
Date: Tue, 27 Aug 2024 20:55:52 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/5] Force MAPPING_TYPE__IDENTIY for PIE
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
 <2ed246c95cac628cffc1628c115a4b791459f8fe.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <2ed246c95cac628cffc1628c115a4b791459f8fe.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/2024 10:35 PM, Steve Clevenger wrote:
> 
> Changes in V2:
>   - Updated mailing list distribution
> 
> Use dso__is_pie() to check whether the DSO file is a Position
> Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
> MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
> into the script.
> 
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>  tools/perf/util/map.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index e1d14936a60d..df7c06fc373e 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -171,8 +171,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>                 assert(!dso__kernel(dso));
>                 map__init(result, start, start + len, pgoff, dso);
> 
> +               if (map->pgoff && !no_dso)
> +                       no_dso = dso__is_pie(dso);      // PIE check

Here the logic is whatever the `pgoff` is (zero or non-zero), we need to
always set the mapping type as MAPPING_TYPE__IDENTITY. It is no need to check
pgoff and is no matter with 'no_dso'. So we can simply check dso__is_pie() and
set IDENTITY flag for the true case.

    if (dso__is_pie(dso)) {
            map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
    } else if (anon || no_dso) {
            ...
    }

BTW, please rebase the series on the top of the perf-tools-next branch [1], I
saw this patch has merging conflict on it.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
    branch: perf-tools-next
> +
>                 if (anon || no_dso) {
> -                       map->mapping_type = MAPPING_TYPE__IDENTITY;
> +                       map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
> 
>                         /*
>                          * Set memory without DSO as loaded. All map__find_*
> --
> 2.25.1
> 
