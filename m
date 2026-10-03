Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B435C1A1;
	Sat,  3 Oct 2026 07:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791013417; cv=none; b=B+qIOdWUt2loqZFJzRM20vm2ZoAQqXhdWO7FB8quNYcJspM0aHtrQzQbMga1pKHzxbanNCiD7p8mmweZHiQejOKvYg0bH15Thib0PdcfiIeCX0C1TIK2PG7lmXe724caQS+KOCsm417KiK2+Zb48I4ceiiwMziI2jaPu1S1dhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791013417; c=relaxed/simple;
	bh=66gE6xhnMcAUOpdVUq4nmWMgFkCmzyTotfcIdVhVQMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idCxNVXrPjA++8ymXmi9YMCZRCVqA3Ar6tgF/L2eqUns84MVWTWQywVgxV9JIXbOc+Sy0UODR73PYHXA5ysRicHiK6dBt44j5MCVrY3loxEPKHhq5iOPX2uRv90Y6yHpUG6FUKmlOD4gZccSDv7KFrAZn8GRCkQgxoRllGBPkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIEh6Ewf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIEh6Ewf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C942A1F0089B;
	Sat,  3 Oct 2026 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791013416;
	bh=OuVWL3qbkXapYyfqCRAnxTJht0rUeRn/WTlX9sDBumc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MIEh6Ewfj1P/V3nZgJJZEQ7SbVJSEEXINTC/y8Ikkz1fzLadV6YRok3+qL9057lmO
	 sBM7r6wkFDIVJpy+S/D2qkhV3ojpzx+2AauTnt/8XUlboHVJmcKZAFA0T0FKRIh41d
	 VfzUrc+uxESdnmRKNjoZ1s9mFvxtzdpbHSX8+fkXh9Fj6NHR1pmBAuP2k/FQ3wW1Cc
	 fvAY9hclIy0t5D1o1xuVO/ZMDtfAJ0HK0mLsBGSJ/mwPr3RbYrqH+2ctpwBtK0RTVp
	 c/3nami4h/OSp1wLA5LuVMMkdcIEBaqTkrlYqQqnomJAq0dQudh+I7TApXwwfu0qiD
	 KC2rl7xg1YAPg==
Date: Sat, 3 Oct 2026 08:43:31 +0100
From: Will Deacon <will@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ
 lookup
Message-ID: <asCyI2_CNSoDJy1w@willie-the-truck>
References: <20260811041934.7609-1-phucduc.bui@gmail.com>
 <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>

On Sat, Oct 03, 2026 at 07:07:12AM +0700, Bui Duc Phuc wrote:
> > Not sure about this. If it's optional, why should we bail the probe if
> > we don't manage to get an irq? Surely it's better to continue without
> > the interrupt in that case?
> >
> 
> platform_get_irq_optional() returns -ENXIO when no IRQ is available.
> Other negative return values indicate errors, including -EPROBE_DEFER.
> In the case of -EPROBE_DEFER, we should propagate the error so that
> the probe can be retried later.

Thanks, The -EPROBE_DEFER case seems more compelling, so perhaps we should
check for the expliitly (because it won't fail the probe altogether)?

Will
