Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102A6382F03;
	Fri,  7 Aug 2026 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112840; cv=none; b=e1yzrBGEd/8RzyWzVb2n+GTyvA48Jmqo4OlQH9/08tu1S+K5sviJg0zJ2xN2Rf8ZeCfjv7a+kzJsXtVfohZSG0cMKc3uuL03EcG2vQ7M0lWuGg8MSMykKVO1DCc4zKtIzt5yT4jblhwDZeiH2Ji1xSISqU+vHwk7BYEL7jBsa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112840; c=relaxed/simple;
	bh=wDXmBgEt8f4M9Ow+mlEp+DDVv7azAEbXbXizpO8wMYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqkwz+uvgYwSZgYD8sCCTSXHabqVzIEFu1cSwe6eSWt/1te62Y+rOS7pK3bBXHjPMkH8PtdVR8BVf6DaM72aCp3+5Dmz2hvvGrRMtuIRg20SIzxet7ilWCd0nKacolBx2r+TvBI24zO4hYwJ0QsNnze84tMV5BfM3EtoDzSAVNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3We5B66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3We5B66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76D61F000E9;
	Fri,  7 Aug 2026 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786112838;
	bh=OEoA4nKIHkYl8kyH/j7j2J8sVAbOsoUJbcanFZ4ww1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e3We5B66gvdRLITPpjuxhjSm+DQl43QZ8+Y9B+mul5KiZEVoIpz/WQrZSx8q7hOtG
	 NpmGywzWnlhynkdPWxX9p6gG4/2FX20WypFZ81seu28mECeNh95orMHJbCuR4BFUz3
	 gpnWkC+HjgSkXIsWTe8KEs+z8SzuWUvZu7pOix6NLx+8I6lzmQ4qKuSice1GlO8e30
	 o75XGMY27nDCXLo0ZIgJgB9kvO/m8X+8mK2UUqvsaxHSvLkrx71ZV+8YGqP46bHCPx
	 wEIEqSLslCq8YLqhuDSnk6A8K3G7KULsClOLnk0lxfob4lJQ0SgzMSgDhr29PZitM1
	 2b9xcGKHGVJ3A==
Date: Fri, 7 Aug 2026 15:27:14 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	"Rob Herring (Arm)" <robh@kernel.org>, Leo Yan <leo.yan@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH] perf: arm_pmuv3: Zero initialize hw_id branch stack field
Message-ID: <anXrQkKl7DXteMXp@willie-the-truck>
References: <20260807-james-brbe-init-hw-idx-v1-1-009d1843960a@linaro.org>
 <a985a304-b399-4e84-99e3-0c6200ae518a@arm.com>
 <66590828-a571-45eb-8e67-a55bebea1b97@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66590828-a571-45eb-8e67-a55bebea1b97@linaro.org>

On Fri, Aug 07, 2026 at 01:18:59PM +0100, James Clark wrote:
> 
> 
> On 07/08/2026 11:44, Anshuman Khandual wrote:
> > On 07/08/26 2:44 PM, James Clark wrote:
> > > PERF_SAMPLE_BRANCH_HW_INDEX is supported by BRBE so hw_id is passed to
> > > userspace, but it's never set by the BRBE driver. Zero initialize it as
> > > it should be according to the docs:
> > > 
> > >     * For the architectures whose raw branch records are
> > >     * already stored in age order, the hw_idx should be 0.
> > 
> > The in code documentation while defining perf_branch_stack.
> > Probably a good idea to specify the same above.
> > 
> >   * For the architectures whose raw branch records are
> >   * already stored in age order, the hw_idx should be 0.
> >   */
> > struct perf_branch_stack {
> > 	u64				nr;
> > 	u64				hw_idx;
> > 	struct perf_branch_entry	entries[];
> > };
> > 
> 
> I found it easily enough. I wouldn't want to put the same comment in two
> places and risk one of them going stale. And if I take it away from one
> place and move it to the struct then it's just missing from somewhere else
> instead. So I think I'd rather leave this one.

Yup, I've queued it as-is.

Cheers,

Will
