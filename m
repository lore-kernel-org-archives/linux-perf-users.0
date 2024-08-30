Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D7A1BF7E8
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725050683; cv=none; b=gsIwkTFw3DrOrv6SJUMdeQi2pJUTYoNSb61rqM7gsqPVFalBS2hidX5RxQNQL4bACOpT971gl79Cqd0nzXP3Sg6FHrNULGXOOlnmygcbLEjEMEf5sDfsJp7Z8Ut3cLeuV3+ix5q3EgvQjmYRS9phdHIJJB35viBMhMCgAoik75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725050683; c=relaxed/simple;
	bh=D1nTxohPBNk3lpJa6onxEA/84dTL3d9biGOhG8PHxc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbo2AVjgtOwVZpOIRBqeY/p+MKjLKV+7KtZPbthbyIFftASpi1YBJoymjOauLQV2c6/f9Q223XtN4gFXx0ySYdwJOXxEzGyNdP32oKcyBnNW2xhrux7/39N31Xck0Lb5+BIMXGRatWSUZYkjWBlrZsrwhBTL0z5+tnj2lqkm+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSa9QsKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSa9QsKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C8BC4CEC2;
	Fri, 30 Aug 2024 20:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725050682;
	bh=D1nTxohPBNk3lpJa6onxEA/84dTL3d9biGOhG8PHxc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSa9QsKHJ2GRIM7+qxhwUy1vmVBXqnxSShpQGGac3Pt2wV6mg8JDJDRkXqiLeu6NN
	 kLv2gzuNDOnoPcVQELKCPUcQFkCTozRmRODCRm2nvbO0IiDIm3XJeAclVpAnTlh8Bi
	 zGrPY+xa4GsGawVw3o3ezhtNJx5pIsNPztRCLEdJM/t0icU5d/b6iZ2z0wNeEVdlmx
	 YEwosIryLDm4d/MDSod2Uf+AP7Q0yWtwEvO+qj3esKGv15kIh/MWgCU3aRfvtGadDa
	 VR4JpjCM3vmipCqUEr7EIPlF7S4Oe35ioghdE3wyReuVweaPMh7zAn965d7huvqsCz
	 HTdKAF36Phbow==
Date: Fri, 30 Aug 2024 17:44:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com
Subject: Re: [PING] Re: [PATCH v2] perf, script: Minimize "not reaching
 sample" for brstackinsn
Message-ID: <ZtIvN7pf66_DOq_Z@x1>
References: <20240229161828.386397-1-ak@linux.intel.com>
 <ZjvhQbZhsda_kvy6@tassilo>
 <Zj4zfpmJhbXGrqRS@x1>
 <ZtHqj6Rl1jdHJFKl@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtHqj6Rl1jdHJFKl@tassilo>

On Fri, Aug 30, 2024 at 08:51:43AM -0700, Andi Kleen wrote:
> On Fri, May 10, 2024 at 11:47:26AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 08, 2024 at 01:32:01PM -0700, Andi Kleen wrote:
> > > Looks like this bug fix was never applied. Ping!
> > 
> > There was a comment by Adrian, about adding a comment with some
> > explanation, may I add that to your patch while applying it?
> 
> Yes.
> 
> > 
> > Adrian,
> > 
> > With that in may I have your Acked-by or Reviewed-by?
> 
> It looks like the patch was never applied. Thanks for Kan to reminding
> me.
> 
> Please apply it.

I'll check.

- Arnaldo
