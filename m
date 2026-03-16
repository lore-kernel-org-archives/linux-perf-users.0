Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F22382F39;
	Mon, 16 Mar 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656336; cv=none; b=vFgx/PPPQYZDHdi9xMPFWCHRsLU7rSfNt+/6xRxFcOlRFc3D49a9SRLaZc1VlClX+T4G/8IfyiMLTT/EAzKSlhSXJKbinfUFkgqZk1uWHWuiDrpH+npYEv6wJBYSB/Uq1uHkFfDAqXi1rmSD4u3gKScR+6qbAx4ZkSPw7ddkBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656336; c=relaxed/simple;
	bh=VcQoevz5PpKDvBMKOrGZaYG4Cb6KdK39Xe1IgM/636Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7KeJGM7SpEJrE6PT7AeVobFgi1niW6ZophRVYtcNgd7nZWSFT7Gpoc5JqJsygdEUcqSYLgvjzIs4iZByyZoK2GwgyV9zC3y7ggzPHaXfTkzd9P8sdUdhOgi6yX2FrGFqmmM+LNbjSPorpu9G5mNJ+lRxlQ/cWSfBwrVZZvVUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707D61477;
	Mon, 16 Mar 2026 03:18:49 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0300E3F73B;
	Mon, 16 Mar 2026 03:18:54 -0700 (PDT)
Date: Mon, 16 Mar 2026 10:18:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Oliver Upton <oupton@kernel.org>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: REQUEST: Syncing tools/arch/arm64/include/asm/cputype.h with the
 kernel sources
Message-ID: <20260316101853.GC8048@e132581.arm.com>
References: <aba3Z0aelph_gQ6c@x1>
 <20260316094344.GA8048@e132581.arm.com>
 <abfSjoaZYrSqmIdA@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfSjoaZYrSqmIdA@J2N7QTR9R3>

On Mon, Mar 16, 2026 at 09:51:10AM +0000, Mark Rutland wrote:

[...]

> Are you happy to spin a patch to remove the check?

Sure.  I will send a patch soon.

Thanks for confirmation.
