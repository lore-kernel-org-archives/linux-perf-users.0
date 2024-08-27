Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2B977117
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Aug 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786982; cv=none; b=Asm4Jr7DI96eT9n4C2NcEzMew5ydBc/u/m7GCvgxKrgdMzskXME55KxBdp7Mmi/Z5T1+IaD7kT5sl6YxjChQTZHV/lGzbRteuacxSZNb4BBuN+dQy3SOx94Q8QN6IaR/9QUM+2pyEEHwzeq2dni/TN8V1Og1y/DWvVYNSXLriHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786982; c=relaxed/simple;
	bh=62thocNTCbwT8WTyhWacgMmJDSLQVl25Yk+npCczhNQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i2YMtMCE89IaV0x4tGrew4gaenEfnMU+uY0Jq1ylEw7yePPujhFEvwsGRuLRE+0Ou5kw2hRWIqkg4j2b66EC4xmLb6uS6qNBjxLfKakLnxYZpVzVW9OmBEhTtP2+VVyX9We/9YXnDjl4DO5P9lHj2i3QbPBSQ2XM16wIMUjNpOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D87DA7;
	Tue, 27 Aug 2024 12:30:04 -0700 (PDT)
Received: from [10.57.81.3] (unknown [10.57.81.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B8463F762;
	Tue, 27 Aug 2024 12:29:36 -0700 (PDT)
Message-ID: <939a1bf1-e71b-40af-a144-edb8d49727e7@arm.com>
Date: Tue, 27 Aug 2024 20:29:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH V2 2/5] Add dso__is_pie prototype
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724698250.git.scclevenger@os.amperecomputing.com>
 <197c2518fe6faea400e7d6ba49c28852fa48007f.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <197c2518fe6faea400e7d6ba49c28852fa48007f.1724698250.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/26/2024 10:35 PM, Steve Clevenger wrote:
> 
> Changes in V2:
>   - Updated mailing list distribution

Usually, we record the change history into the cover letter, or put it under
the line starting with `---` in the commit. This can avoid the change history
to be merged into the mainline.

> Add prototype to dso__is_pie() global.

Please squash the patch 02 into 01. Otherwise, the patch 01 will introduce
building regression:

util/symbol-elf.c:669:6: error: no previous prototype for ‘dso__is_pie’
[-Werror=missing-prototypes]
  669 | bool dso__is_pie(struct dso *dso)
      |      ^~~~~~~~~~~

Thanks,
Leo

> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> ---
>  tools/perf/util/symbol.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 3fb5d146d9b1..33ea2596ce31 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -127,6 +127,7 @@ void dso__insert_symbol(struct dso *dso,
>                         struct symbol *sym);
>  void dso__delete_symbol(struct dso *dso,
>                         struct symbol *sym);
> +bool dso__is_pie(struct dso *dso);
> 
>  struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
>  struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
> --
> 2.25.1
> 
