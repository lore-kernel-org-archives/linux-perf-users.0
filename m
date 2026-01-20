Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C044CAF3;
	Tue, 20 Jan 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932953; cv=none; b=HJbUj4brDc1+Kym4HfBbXE98IVv4XQHsB5JSahFk1FMnUnfDS4xjMQ0hZ0efS6nPy2lHJjK9yH17T40RBQPrUF4YPhZghd0TCa38skidMQ0lZSWJHChl62fTev/nZaKFro5L2KCP0NW8ebhcFnN8s2dk3hEnXx1RhQitKFZYmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932953; c=relaxed/simple;
	bh=xc4xb49B3KNNfaMm6hHsxVUe9bx66n4OHiUBuFGNgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb9lIqdMuBpwpfEwLBkN4K92sWT0zyO7bk9mpNWiFR9a6jMGLs9VLQevrO4odrVYJ5OjBpr8FTldfzi2LQHSpzFD68lFuHC1/CFJ0RkBotPStmUBHu7gFk5O5a8kLu0u5f7nb2kq95gAUoEE+BzSg1QtcKhC+jhwG2dsPtg2AUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9AB51476;
	Tue, 20 Jan 2026 10:15:43 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2533F694;
	Tue, 20 Jan 2026 10:15:49 -0800 (PST)
Date: Tue, 20 Jan 2026 18:15:47 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	James Clark <james.clark@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf: arm_spe: Correct setting the
 PERF_HES_STOPPED flag
Message-ID: <20260120181547.GI2732125@e132581.arm.com>
References: <20251110-arm_spe_fix_truncated_flag-v2-0-a629740985cc@arm.com>
 <20251110-arm_spe_fix_truncated_flag-v2-1-a629740985cc@arm.com>
 <aSSEXzMr1drvL2zz@willie-the-truck>
 <20251124184815.GC724103@e132581.arm.com>
 <aSSrrmX_nAl82GKE@willie-the-truck>
 <20251125142036.GE724103@e132581.arm.com>
 <aV_aHi9BLFzjnmx7@willie-the-truck>
 <20260114175240.GA1286628@e132581.arm.com>
 <aW-wfy3u5OD3BQAQ@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW-wfy3u5OD3BQAQ@willie-the-truck>

On Tue, Jan 20, 2026 at 04:42:39PM +0000, Will Deacon wrote:

[...]

> Ok, so looking at this and the next patch I wonder if we could simplify
> things a little by having arm_spe_perf_aux_output_begin() return an 'int'
> to indicate success/failure instead of touching 'hwc->state'.
> 
> Then arm_spe_pmu_start() and the interrupt handler could call into
> arm_spe_pmu_stop() if they get an error code back. Would that work?

Yes, your suggested approach is cleaner.  I will respin patches.

Thanks for the suggestions!

Leo
