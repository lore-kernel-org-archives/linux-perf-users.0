Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD524678E;
	Thu, 30 Oct 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849479; cv=none; b=ceUdL4zZEmfkzeeLJ6RuL0TVpucNJTjQq/WdOIl7yXCeEMBEow9oPBAIgrsSpT95qNigj2Q4CCvZr3UJLZoTZti9pT5JJuFyFUTa72FW+uZmBY/n29O/vX82VEwfadLZVNsMqtUPytdibqU4nzF4dzyy4K1L0uyXIBPmleokV2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849479; c=relaxed/simple;
	bh=hFkhO06aqkw8K60d6/UG3E86xtwlqbxjvDfNit9wy6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pa7pSWbWBVkidiwAmNee+76MnWxbtRqQ5NwWslVw8Q1zQ0wQzsLQ+eYwLmxQ7XYxKpK3TkxD+oO1Y+KypjdQbJ16IAhKOmqObOL/std/EBJtMqb50JCWG4UWeftFF1Zla+FA3grdDPL/NmPBf4t68/7CPHEuYq8T3NUUJyiEdaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=TeCb4RzO; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="TeCb4RzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1761849098;
	bh=hFkhO06aqkw8K60d6/UG3E86xtwlqbxjvDfNit9wy6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeCb4RzOKcGP7cM8RYMc0f9RQcWsvPgS0tXACgPo2+vfkpmqNlVoD45DtI7kp90Ir
	 nEKhYEA8w7WFCnH54mRTxIPAk6oYdcjkdon08GFcBig7ndDwMkFshoKVMd0vs3Rw1t
	 qWSevAL3Up236pHR4urYnfO5+FM0TNnRGuML2jVc=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id A436D5F6E7; Thu, 30 Oct 2025 19:31:38 +0100 (CET)
Date: Thu, 30 Oct 2025 11:31:38 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Mark Brown <broonie@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Fangrui Song <maskray@sourceware.org>,
	linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <aQOvCugzYe/2DcNW@firstfloor.org>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
 <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
 <87zf982s52.fsf@linux.intel.com>
 <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdda89a7-ff60-46b0-8ce3-28ffec1fac2a@sirena.org.uk>

On Thu, Oct 30, 2025 at 06:07:49PM +0000, Mark Brown wrote:
> On Thu, Oct 30, 2025 at 10:53:13AM -0700, Andi Kleen wrote:
> 
> > IMNSHO the whole sframe effort is misguided because all the major ISAs do have
> > shadow stack hardware support now which is generally a better option. 
> > It would be better to invest effort in deploying that widely.
> 
> It's going to take a *considerable* time for the hardware support to
> become standard.

Optimizing for the past instead of the future?

Not on x86 at least. All my x86 systems have it, except for a few old
skylakes.

-Andi
