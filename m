Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF9172628;
	Mon, 24 Nov 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010459; cv=none; b=cGEVt0jZgXoHK1D3eC7AvQGenn0ZyL7QfYfYiq2FJtTph2BRQ8lgQFi5lKQEvmi1cH3qf2w9V8Z1UXJ+APCWojnWfw0RXyYmZq/v8zD1WEGhy9vZU4DYoNdR2w1V/Fx8rn9CS46FlAE/m8Xu16OLCfP+8mwwUdjPNDQYXhxIoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010459; c=relaxed/simple;
	bh=UFDVS+/AhxMYcb0l/6MuXzNN5AnKJXIcAsg760eWauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUN7dL9juaf868Z7Z7wh8qO6bVtiiSOoz74gMTuY9PZPzTbd19vgvF3alPDhc920UzaTQIPoxz7UoSJ9++/+CUzc1LeXewOCVVDgBxkcBevX6oKCp8nBXcgZWqXnXeun8gRKWkTGaY79+VVCABFTht6eCXgGxEi9Pm4vv+ApblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C6801477;
	Mon, 24 Nov 2025 10:54:09 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2185B3F73B;
	Mon, 24 Nov 2025 10:54:16 -0800 (PST)
Date: Mon, 24 Nov 2025 18:54:14 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <20251124185414.GD724103@e132581.arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124184815.GC724103@e132581.arm.com>

On Mon, Nov 24, 2025 at 06:48:15PM +0000, Leo Yan wrote:

[...]


> > If __arm_spe_pmu_next_off() fails, it will call perf_aux_output_end()
> > with the TRUNCATED flag set, which should then disable the event
> > via arm_spe_pmu_del() and update the state there.
> > 
> > Is that not happening?
> 
> Correct.  However, this patch is not for the flow you mentioned.

"Correct" might not be clear enough - I meant that the flow you
mentioned does happen.
