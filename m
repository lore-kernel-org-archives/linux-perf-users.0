Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794392449;
	b=041XBIHBezmcx+G7F7sC4bautWAoG1zg2+qKe5cRFxT9Vx2nw1f4sLvd3p51H5hJlzIG
	 Ntg0VbD6Hdh+3L/OmSKaj5gEnqkzzKiVqF4FKjWJy1VsvKX68Rfe8YntW4TUcZadkXFE2
	 UZU5qxqopgXrCrH8bgwG2HgrXp193CUnp8yGm1b5Lh0B3sqw/KR+kmiW5ZbEbGRQUt2ai
	 mD2c0POjT+SJ3gIoAuSHzheUamtOg1sOvmLlc5AznLb4DwcxblDpR9S7tE74igSCw5in5
	 84CqnZdoBZ8htxeVMzbp8duUVIZlWY+2vBFfcGqL8tCwurXJrbIpA40g3SdUzeZkrnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794392449;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MKG7MRxrE782eRXN0KRbnOAHrs6HgscTeOs5tUgi8x4=;
	b=flyNCbrbR3047c5eWnmvAESD4XRWeQrUf0E7A4SQPNbSCNHCaG9jShOt/eex0cl3EibN
	 IG+xnpnzSqbTDdoTuBWE9psImCiCiiRcIh/iO/vFYU3nHUQbMFmxRJdkKK0H/8C2vePW0
	 tC6TWESTTYdHwROd9UUuGiSBjfGWld89dMWJYod/GuY2DmiXFBrISd8O40GI/ABRuQZSo
	 UB/DDkp7a/QpZF5pf3GmY2LxNY4HJFECZ3MCf67+pv4NNpGMDBnXpD1EdVE98rnvDGsvI
	 oOg8ylIB4wpC9EX8mk5Qtfm7AnNWHOh9rr1nMe1gSoOAcp8XIqmKyILXEkNb2zxGxOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKMAj1nz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976A606A31C;
	Wed, 11 Nov 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZKMAj1nz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2161A1F00A05;
	Wed, 11 Nov 2026 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794392449;
	bh=MKG7MRxrE782eRXN0KRbnOAHrs6HgscTeOs5tUgi8x4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZKMAj1nz+lQDf22PP+vdKrAbg8NksAHb2+ryKChN4V14FHTAkP/PPvJ0mbLGuVBkq
	 MtS872Xn8De+VMhU5pjX+hB+bnTPz4GNWSlLZRSru5EX8JEFpYP4zEPMZz+wLGp1I9
	 sTHD+iR0yl8+0LtpittCMPBPypS+1bKYi+sXmS7QfLPhTz4pAo4pzwwMIR28EgYUrv
	 B0LKY/DGcIDvOMQX2V00ikPs7mDykjK96bVh2NI8L6Gczv/5LDk+jSFvwTu1kLX3L/
	 8ZGdNX6xBHnjrobqimtqbqx9mweK3xPKJQNHaNlkSlYr/SNK3H1ip48MI1XOGgKQYP
	 dMy9crWHI9OTQ==
Date: Wed, 11 Nov 2026 10:20:45 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, yury.norov@gmail.com,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-perf-users@vger.kernel.org, mingo@kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tglx@kernel.org,
	linux@rasmusvillemoes.dk
Subject: Re: [PATCH 5/5] arch_topology: Use cpumask_intersects where
 applicable
Message-ID: <20261111-wise-discerning-cheetah-b1dc8c@sudeepholla>
References: <20261111075945.3930230-1-sshegde@linux.ibm.com>
 <20261111075945.3930230-6-sshegde@linux.ibm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111075945.3930230-6-sshegde@linux.ibm.com>

On Wed, Nov 11, 2026 at 01:29:45PM +0530, Shrikanth Hegde wrote:
> Looping over one cpumask and checking if any bit is set in another
> cpumask is same as evaluating if two cpumasks intersects or not.
> 
> So use cpumask_intersects instead. It is probably faster too.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
