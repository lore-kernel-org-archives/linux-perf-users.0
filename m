Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80750168AE6
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Apr 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450300; cv=none; b=XNQWF4h9lh15jabUqOPz2NIxHBMc8fssf2WpRDhavO1pV9Z/aPItxn8+AOg0kXRQeuEHDPqpJKSybgoNmGnuLcOjqO4drPGJ5WYTH3su40BF9lDUL7EbBwZtI4xUnWnxrCyDl2aAHAz1d4nkkNJt0zdSp0n7X+eFj45ChZ+xHV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450300; c=relaxed/simple;
	bh=VVP7t2hEtco2jpUzzUTyH+ybMe2CslngYuZ+73v7emM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGeOcte4mxcHFnOtpMSLfEBZyoV0gwsudfvWVJGYN0RsK6EisCzP7lyu15eFDh8ZcmVNcXrHeTI3adAqARRLArxdNfzX36HJ9am7vYsXJGnGg7g1EcWpgicxLAcioove2WBZZbRkIo27aq9EBH4+ck6yxkKjrhSub/xou/a0kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5QVh3dY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5QVh3dY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A4FC113CC;
	Thu, 18 Apr 2024 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713450300;
	bh=VVP7t2hEtco2jpUzzUTyH+ybMe2CslngYuZ+73v7emM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5QVh3dYip0Kl3KaTikYUKPnFvtNZSjkDqMil+gL9hvvj8wXhVDAwk7sdTapp3GC4
	 +SdoGrjxtX3yKFiHWDXivKbX+sy9k9/GlTpRDsPGzkSL5ndaRZsUcdWjmEGC2/V+Ki
	 h8zD7yiBv0kq2o4HbpeErzXSQDNRv3mSoFdvbsPMfRxMiDpwzToOiHYVnfZLRmHJ0j
	 e07bVSEgWT4d8CnfqB8dZc5nDfkqiKSClnqNoYbIDbyuVlTu4cDEuM7KuQPni35jor
	 y9JO/9tGc5cGDYCZ8xs+S0T6y6kXxu2/zUX+XsO3leIDt2lLdC98FL75xSlRh0H791
	 BBwi5g6kBRStQ==
Date: Thu, 18 Apr 2024 11:24:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Dima Kogan <dima@secretsauce.net>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/2] Better error messages for 'perf probe --add'
Message-ID: <ZiEtOQsaQnSSAR2x@x1>
References: <20240416045533.162692-1-dima@secretsauce.net>
 <Zh6dT13FfgdHuMql@x1>
 <20240418053537.7ba9c7a8d256987521ea1593@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418053537.7ba9c7a8d256987521ea1593@kernel.org>

On Thu, Apr 18, 2024 at 05:35:37AM +0900, Masami Hiramatsu wrote:
> On Tue, 16 Apr 2024 12:46:23 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > On Mon, Apr 15, 2024 at 09:55:09PM -0700, Dima Kogan wrote:
> > > Hi.
> > > 
> > > I tried to add some userspace probes to some C++ code, and got this:
> > > 
> > >   $ sudo perf probe -x tst --add _ZN.....
> > >   Error: Failed to add events.
> > 
> > Both patches look great, Masami, can I have your Acked-by?
> > 
> > If you find other cases where the error messages can be improved, feel
> > free to send us, please CC Masami, as I'm doing now.
> 
> Yeah, looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
