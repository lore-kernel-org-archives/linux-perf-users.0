Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690CA38E126;
	Mon,  6 Apr 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497915; cv=none; b=otQ9GB+ss0JHRsOQlIeJsfhlU6+cZI+5bQlBs8cJYmm5i/TCobVkI/i6gbv4SF9byg0C+R3LDh/7eZgekBBRTMZCXuoFJa8/IxoNjXmYVdZvfZ0kAAK1W1dzdQj2KC5eZ4Jeg+CzNRdb67LJd35Z4kEGRi1Q4Otrk+uheP26+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497915; c=relaxed/simple;
	bh=Ve6x1AwkxFcLVietZY6qu5e3CEpbe2Rj0av5z42vphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmGLZbM0D6pRBtnBZC1ksiWAqU2H+1IHHoWVRaMWV8nmZrRs7Q6y7oevYXwlYilZcS9PrSs0kNpuy3f51WI2NJGNHsmoAY5cS3VozT45B7CdEi0IqFYmt4CTy/Aj0VRSX8axewS9raCaxYDA6hv3xmBcNVZ47u5rjkY+S/7Z8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOmPRRah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOmPRRah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B150BC2BCAF;
	Mon,  6 Apr 2026 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497915;
	bh=Ve6x1AwkxFcLVietZY6qu5e3CEpbe2Rj0av5z42vphI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rOmPRRahTUiG9YLdi9Z9zuSIlbTOlUP+KYUrP+ziSh/9bJ45zVZRfB3Dqr8S12mro
	 yxC5YfNXRBUMG5t9YnqTtncU6ZitzBmEELsdzmVA2LSk0H8c3a/0FBePhPKnDCYYzI
	 fF7sQZhAqzmkU/racpwvirceYfH9isr6/HuQkpk2Ld7bJnbCd01N2c9wyfhp1lmEh3
	 jLI8VFNqOlJE1QtCpMhxRq2WcydZwTohY4E7v+9riaMTtSUmA3ENMpociixD6FuDqJ
	 1Cm1T6NSwbqRpqfgettAZUsxbmTn60lt6yat2QNcK1XgBE0ZWaAqjdmhk4HvNfZWxR
	 WnjW5Zz502CYQ==
Date: Mon, 6 Apr 2026 10:51:53 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6] perf utilities: cln_size header
Message-ID: <adPyuaptzUlTdpi6@google.com>
References: <20260308172037.123654-1-ricky.ringler@proton.me>
 <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com>
 <20260321204145.26359-1-ricky.ringler@proton.me>
 <acW2j7hki-u50YYz@google.com>
 <20260328200442.134489-1-ricky.ringler@proton.me>
 <actrosC-vqhjMA-A@google.com>
 <20260403220758.41790-1-ricky.ringler@proton.me>
 <adBbXHuhs6TlwJre@google.com>
 <20260404011313.51901-4-ricky.ringler@proton.me>
 <adND6AGUKu8d0YlO@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adND6AGUKu8d0YlO@google.com>

On Sun, Apr 05, 2026 at 10:26:00PM -0700, Namhyung Kim wrote:
> On Sat, Apr 04, 2026 at 01:16:56AM +0000, Ricky Ringler wrote:
> > Forgive me for wasting your time with my last message...
> > I switched work machines and attached the wrong patch file.
> 
> That's fine but you could send it as v7 so that the tools can pick the
> latest version without confusion.
> 
> > 
> > ---
> 
> Also, adding this mark invalidates the following paragraphs and leave
> them out from the commit message..  I'll update it this time but keep
> that in mind for the next time.

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

