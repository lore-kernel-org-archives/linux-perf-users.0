Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C5B30CD90;
	Wed, 27 Aug 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756282376; cv=none; b=SwYrbxtoNOTVGA+Ac30SWeUxLmbVSwxx+2FF6fkRUH5auIhCkmI60UW2rRiZEhR0Y+ct7OgdcY47utLNCfINciWSs1c5GwKIKu07SFkyiFp8mFeGWMXgDbxOYbPavKgFSpBEXKSPhnfQmWxd1k4Nc4Rn+3D0lkJGiK0qXPAUx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756282376; c=relaxed/simple;
	bh=QyQhFx8B3bKhrD6YrWj2wpyUU88MY9HsPrDbHArlac8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP55SCrWoYaYkb0xahCr65HW/IXypireK3gFGZI75qeVnJ0Nsos2VIGHErBUW8OW8w6+Fj738f1DitLvq7DJKNw0zuBYtwMmXjjWZuvrI7Ioane5I8ebO5AHCX5gdyQ8zxFTdn8GhnUDK5EakXiHrOgDRp1DcdYsTaqS5jbVKL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D7381691;
	Wed, 27 Aug 2025 01:12:46 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8316E3F694;
	Wed, 27 Aug 2025 01:12:54 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:12:52 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] tools headers: Sync arm64 headers with the kernel
 source
Message-ID: <20250827081252.GD745921@e132581.arm.com>
References: <20250825215904.2594216-1-namhyung@kernel.org>
 <20250825215904.2594216-6-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250825215904.2594216-6-namhyung@kernel.org>

On Mon, Aug 25, 2025 at 02:58:57PM -0700, Namhyung Kim wrote:

[...]

> But the following two changes cannot be applied since they introduced
> new build errors in util/arm-spe.c.  So it still has the warning after
> this change.
> 
>   c8c2647e69bedf80 arm64: Make  _midr_in_range_list() an exported function
>   e3121298c7fcaf48 arm64: Modify _midr_range() functions to read MIDR/REVIDR internally

Hi Namhyung,

Thanks for working on this. It is on our todo list for automatic
generating MIDR. Sorry for any troubling during the syncing.

Just a minor comment below.

[...]

> +struct target_impl_cpu {
> +	u64 midr;
> +	u64 revidr;
> +	u64 aidr;
> +};
> +
> +bool cpu_errata_set_target_impl(u64 num, void *impl_cpus);
> +

Currently, no one uses this API. It seems to me that we don't need to
sync this code chunk.

Otherwise, other changes LGTM.

Thanks,
Leo
