Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86272291C07;
	Tue, 23 Dec 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766504216; cv=none; b=ev4Dk7QyqEcNNtnoJpZ5RzdLAeQ83lpmalgirjd9ce8Tpq5XsJ0JrTUH2bp+bHQl8apbyCGvGOrXTpMLO0Uo8gq8na6sXAyJ7NU5o3AJVAlrt7n3decMkzw8j6AznZqKCrFQ4xj9B1/gl18fVR7mD8viMaDkSOuGCKDFd3UTKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766504216; c=relaxed/simple;
	bh=m4z//eUixDG/1VtqVC5B8NOdz4cROO/SRKBQ9N6GWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF5Lb++QSfkPerVKPQ9uDKJRlMg/HBhkOTCyWnTJdTUuex9C6XEaLUDqXb3cCPNVb7w7SUeC9a9L4ObewCdxgDgDnEGip4AQyMbeOW9N/hQemGonyiYfvsUAnTCRDGS2wFklGXkrUGnrrTBA1lBeRQIzDMqE5CUrnrBuehnV+EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FBA339;
	Tue, 23 Dec 2025 07:36:45 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C8DB3F694;
	Tue, 23 Dec 2025 07:36:52 -0800 (PST)
Date: Tue, 23 Dec 2025 15:36:48 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/11] tools headers: Sync arm64 headers with kernel
 sources
Message-ID: <20251223153648.GG9788@e132581.arm.com>
References: <20251222225716.3565649-1-namhyung@kernel.org>
 <20251222225716.3565649-8-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222225716.3565649-8-namhyung@kernel.org>

Hi Namhyung,

On Mon, Dec 22, 2025 at 02:57:13PM -0800, Namhyung Kim wrote:

[...]

>  #define NVIDIA_CPU_PART_DENVER		0x003
>  #define NVIDIA_CPU_PART_CARMEL		0x004
> +#define NVIDIA_CPU_PART_OLYMPUS		0x010

Just remind, this is duplicated with patch [1], so you may decide
which one to pick for merging.

Otherwise, LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

[1] https://lore.kernel.org/linux-perf-users/20251219231325.2742580-2-bwicaksono@nvidia.com/T/#u
