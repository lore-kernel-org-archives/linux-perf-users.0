Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70071E5705
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Jul 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903862; cv=none; b=NOcqsFWK49Rd8bi6H1coMYuYaa39v68RXho7ZZAhKylKSt6+vtashftt2etRbjy1WdLlgdHHvN3wGi2VnThTfLdGTMGKx3VNebzN+n99k0qafaa4m/R9O5Ed3IyfNqs9cfun467SeKe1zQIKKLEhUR7/+VOetSvQNDF6Uu/mzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903862; c=relaxed/simple;
	bh=NAca4JpQFDXPv9R2KVVi94JxHMfnH6H40qNH2bfYB90=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWOJsSwrAUySyjXiGQ3HIcb6KhTz/X8fCCI3BBuqRNDBkGdL/TS73J3J07ue8zYaRAlLrjws5I80t64t1PnX12UAM42kkqGtESXdZoP2bibxsDrabl9WcUJWvz+hjPTMablaK8Et33UNoZiGJVIL/pz9nn8FqZvs3e7uApimN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89912168F;
	Mon,  7 Jul 2025 08:57:26 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 915293F694;
	Mon,  7 Jul 2025 08:57:38 -0700 (PDT)
Date: Mon, 7 Jul 2025 16:57:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf: arm_spe: Relax period restriction
Message-ID: <20250707155736.GC2182465@e132581.arm.com>
References: <20250627163028.3503122-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627163028.3503122-1-leo.yan@arm.com>

On Fri, Jun 27, 2025 at 05:30:28PM +0100, Leo Yan wrote:
> The minimum interval specified the PMSIDR_EL1.Interval field is a
> hardware recommendation. However, this value is set by hardware designer
> before the production. It is not actual hardware limitation but tools
> currently have no way to test shorter periods.
> 
> This change relaxes the limitation by allowing any non-zero periods,
> with simplifying code with clamp_t().

Hi Will,

Would you mind checking if this small patch is okay to pick up?

Thanks,
Leo
