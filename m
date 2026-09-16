Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB4455633
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551135; cv=none; b=ivVmiO+yXUo6kO9Ct5BpK4C998UkT1PnHePL6ZcyMPZ8mNajRRHXXb7251PjOVNNeH+ek1QFzPz7/pYVeKBE/RKevD4+rDElu2V+LwzKNdeGUrJrkwEZ+tZXt1Yx2zWf5W/MiRWEXtB14Xda/tExjpJmPIz0DUXMVnVashz9BAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551135; c=relaxed/simple;
	bh=la8IZH7YDw9SpimkZ00WJV6Uu78AQvTllZ8srncgV48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STau2A7MPXqs5XGzNMyAsvKEpB2YH3ox9aBW3Nxtn8ng/f2LP0d0TQu8G2b4txjBdE1+EOtdeftMLsuJ2cQLVibH+svldklYOKT7+8YDYhNuGsiO+k16jvLcd2auxEF7SzdeIzkchhZD2uhu813oX6X4ao06ncY/Dv3eCF3PGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tkVrWgyN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tkVrWgyN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2B71516;
	Wed, 16 Sep 2026 02:31:44 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E763F86F;
	Wed, 16 Sep 2026 02:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789551108; bh=la8IZH7YDw9SpimkZ00WJV6Uu78AQvTllZ8srncgV48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkVrWgyNZIfYoSjTq2nXj1v9dgPhjECHns2uDsk8j/reWdWO6k/k8YYt6AgeoYT1a
	 KHNlXDLeOLKCtLL5y3AvmboVa4iBJd7+Nn/EJaFVi5nkdgZzEdybvRvpaaFpDP+ih1
	 tUtY6+ZH1VaWfJrw5ZqDBzW1UyWC06AJ9qGirzfo=
Date: Wed, 16 Sep 2026 10:31:46 +0100
From: Leo Yan <leo.yan@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, mark.rutland@arm.com, ilkka@os.amperecomputing.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf/arm-cmn: Fix multi-filter encoding
Message-ID: <20260916093146.GG200420@e132581.arm.com>
References: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec590cd4cc61b54d6ad3b306b69777ad7729c9d6.1789475062.git.robin.murphy@arm.com>

On Tue, Sep 15, 2026 at 01:24:22PM +0100, Robin Murphy wrote:
> The current special-case for EVICT_STATE_SEL filtering effectively
> assigns the "filter" and "filter2" controls in the opposite order from
> how the CMN S3 r2 TRM states "Filtering is programmed in pmu_hbt_lbt_sel
> and pmu_evict_state_sel". On reflection, not only does this seem
> unnecessarily non-obvious to users, but it's also likely to be a problem
> for scaling to a full multi-filter abstraction in future. There is a
> logical order to filters based on their bitfield positions in the
> pmu_event_sel register, which the TRM descriptions allude to, and the
> cmn_filter_select enum already (almost) follows, so let's fix the UABI
> to follow suit while it's still unreleased.
> 
> Fixes: 09178f536bb9 ("perf/arm-cmn: Plumb in new filter types")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

It's hard to say how useful my review is, but I went through the patch
and also asked AI to explain the rationale. It makes sense to me:

Reviewed-by: Leo Yan <leo.yan@arm.com>

Seems we could implement a generic way to navigate filters based on
the hardware bitfield ordering, e.g. filter_next(sel) and
filter_prev(sel). This can be deferred until we have more combined
filters.

Thanks,
Leo
