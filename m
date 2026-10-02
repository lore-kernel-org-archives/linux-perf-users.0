Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F2480DC7;
	Fri,  2 Oct 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945097; cv=none; b=jgLGwFcYoYPh7EpYWhJYms1bCixiOxjKTl6aLvdc25/Dvcf+HViKBjNGnWBxJuJ2KAzkitYE9QWS2Z27yF08gGTm86A5Bxd+VBL5chxuWLeAOfOOohdurnwpwO4l77syDc/ph9bRDYmiNTrsN4cNNkkaSelXvoweK7nqChC4QII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945097; c=relaxed/simple;
	bh=XV8eqkePqFKKv+d5Dfr2oAfNhpdHDRq37q8bRBJMDcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxn+hAgkg5VBOAqaqXn3JztkVTl8yZkBvOK6F5PuyYO81L8oRiwQfJkYEJzFa5D5+jS1bEFH6ntMCmR0iZxgjpHrwv1EYFf3tCh5Nqkn7pYVrcOAJsjWpO7LROvyOugfQoAbng4VzxYa88uDywXqt4soRRwRtVqhsK8QTmqMTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnoG2iSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnoG2iSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CCC1F000FF;
	Fri,  2 Oct 2026 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945089;
	bh=LynaPcEemc8Fvi0pdqSvue8XBTJnHlD/bhr/8DNTDJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mnoG2iSMabxxw+PTv5TXCr8x8UA2J9i6P8AwYTSdEEaEC8q9g0s9oV4VZF0e1bZLM
	 t4Qf5KI06OubB1qzyD088zZe4hkWta82J91l67s1whCwbU57Z5VSNtuzsszxEtpwAL
	 RNB564Ra2u29j8JUN/1Eec9Z7owo5I6eRm3qBu7XsJRO8XFI069xrOpzrb28S5ZLSJ
	 bThxaW8o5WHZUvufJ2WVney2gc7xEE2UGnWu7CvQZvFkUm2+xfk5QPK0u+DdcvtFLZ
	 phluqkj9PH0AViV2udz5FuUGCoVRpOrF71yzEf31tZYkWcDOJ6bFkCg7ggKLXT2Qh4
	 zKeR3PQ4+mICA==
Date: Fri, 2 Oct 2026 13:44:44 +0100
From: Will Deacon <will@kernel.org>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Message-ID: <ar-nPJyVzPcvbICa@willie-the-truck>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>

On Fri, Oct 02, 2026 at 07:26:51PM +0900, Tomohiro Misono wrote:
> FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.
> 
> On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
> stopped at a value just before overflow, an overflow might still
> be incorrectly detected, resulting interrupt storm in some case.
> 
> Work around the erratum by avoiding programming PMU event counters
> with values within five counts of overflow.

What's the user-visible behaviour of this erratum? It's not entirely clear
to me why we need to do anything at all.

Will
