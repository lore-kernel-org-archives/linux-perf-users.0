Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC7342175
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971355; cv=none; b=pYSalxn6RiregGrHdQ5uUYvzo4hd8d9FQBJLUj8PG76Djfk/Kqc9wSDtA9fzG/4zx7eNaCue55zJaIteGXIYu0gfth3N8fZhkgjxp3YfqwptzOuul5AvVJ5SY9ZxEmM3NjLGVGuZ6tet3Uzh1btOAO8pw622HX0icmjf6npMJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971355; c=relaxed/simple;
	bh=yTPeVDmuI6ozTy596uszZMpt6gUnWCRfBR2rXrYGi8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e59pKIFXjYVIw2q+pbdmPl6wDJAJdyVNX/eVY2UZD0Z5RVIFo31DWdAijlnMaKBZl6tY0vOVogA/YKjz4w1gNw8PizNC7PgUEr/SniqKDxOU2MsE6IruSRr/Km39rTWRNZ3j0C51B/ovTnV9WnW6pHezF66OtZMFg9zjzYujIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 671091515;
	Wed, 12 Nov 2025 10:15:45 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA8783F63F;
	Wed, 12 Nov 2025 10:15:52 -0800 (PST)
Date: Wed, 12 Nov 2025 18:15:50 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 18/25] perf/uapi: Extend data source fields
Message-ID: <20251112181550.GC3243746@e132581.arm.com>
References: <20251017-perf_support_arm_spev1-3-v2-0-2d41e4746e1b@arm.com>
 <20251017-perf_support_arm_spev1-3-v2-18-2d41e4746e1b@arm.com>
 <20251112180309.GA3243746@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112180309.GA3243746@e132581.arm.com>

On Wed, Nov 12, 2025 at 06:03:09PM +0000, Leo Yan wrote:
> Hi Peter.Z, Ingo,
> 
> On Fri, Oct 17, 2025 at 11:05:07AM +0100, Leo Yan wrote:
> > Arm CPUs introduce several new types of memory operations, like MTE tag
> > accessing, system register access for nested virtualization, memcpy &
> > memset, and Guarded Control Stack (GCS).
> 
> Do you mind review this patch for extending memory data source field?

I didn't include the perf core maintainers in the recipient list.

I'll resend this series for better visibility. Sorry for the spam.

Thanks,
Leo
