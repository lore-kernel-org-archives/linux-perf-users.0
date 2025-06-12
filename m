Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726F211F;
	Thu, 12 Jun 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749709519; cv=none; b=cgeXdnxuqP2KcIOdxgF3s502SlJh2iT/zdXF0WCz07qNoa8hgylWW9VTn9tk7ZmSriWfsek8dBu3f6aweAt+HjWI7BBTC+kb8TyPr9E4vh78tj1m8pEi7WWaufigxGKiXUcGo/s1HM7IntYYMuwUTVQNwVR8QNEYmGXWxsYHKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749709519; c=relaxed/simple;
	bh=WbKlRgT6f7BkyMv2x9S6bRsCtZQ2+P+hdMNKp/TwS0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J97RJycPQQWFw+GT9sBRyhx1JGmYDLL/sMGh8NZExM1VNwWeudYtloHITyBhhL6W+r5DQvYOO49WTipDFjlVadKOAB47e5XXS4n28mx32otbXQfchc/8srgx/QZmzjQ6Ag7U+da3RaRIR7UWC5cLkPKk5K4QqiPIUQ3ATJosFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KZ+J5YWL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4S1BLYr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KZ+J5YWL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4S1BLYr0"
Date: Thu, 12 Jun 2025 08:25:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749709516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4Ia2CoUtifdcfPDTm3n0fPYredAvQzKsRuLKfT/bPA=;
	b=KZ+J5YWLgu5kKVteRk79rAVUYOXvqgSK7g6OSuiTul7gdxgMu3bMc7LuO1BXumBVsr1pC+
	eG9FL8Z7pw3VqA+DHUXQMrdmQMNsqVwptCp+v+vHZVHFNx3CHBg6xAK2N4aRPCjgLBn6qQ
	YwxuBgg/xZkh35cuYZ09+P4Gle9c2uTKVlrhloddEcwFBLgnCcaAz0JsUSZRpyj+ilxhTE
	ExBRNe9BbaN6BIFsVmu524sNXLIneYEP6K9Nwt+bvhxotHSzyU8Ss/9pzfXf3/Wei5kTaS
	r8QQ5CX/rAf6+nZ/Ffq9CnHx66CCN+pq3dvOygXitVVZdVb0tsfG9+5iKKn/mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749709516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4Ia2CoUtifdcfPDTm3n0fPYredAvQzKsRuLKfT/bPA=;
	b=4S1BLYr0T06auupOZKo0dZLI/0PnJcP+JnH3IuBB2BOllyQ1pnA6AuyfpWjZ4eJmMii8uc
	Zip7LyqZ4oPP7wDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf tools: Build failure in v6.16-rc1
Message-ID: <20250612062514.EZS2cVlO@linutronix.de>
References: <aEh6xO14wDSCFUDr@google.com>
 <20250611092542.F4ooE2FL@linutronix.de>
 <aEmBOO0bSJYSvX2i@x1>
 <aEmY259Mx92D60KG@x1>
 <20250611150615.FcVIIhgA@linutronix.de>
 <aEnSbBaFYgd4Gr9u@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aEnSbBaFYgd4Gr9u@x1>

On 2025-06-11 16:01:00 [-0300], Arnaldo Carvalho de Melo wrote:
> > Is this needed? Aren't these defines coming from that local copy?
>=20
> So, these are, as you say, in the copied linux/prctl.h, but in musl libc
> we have:
right, I briefly forgot about musl.
All good.
=E2=80=A6
> I thought this would be something fixed in newer alpine versions, but
> no:
>=20
> toolsbuilder@five:~$ grep FAIL dm.log.old/summary=20
>    5    19.53 alpine:3.16                   : FAIL gcc version 11.2.1 202=
20219 (Alpine 11.2.1_git20220219)=20
>    6    20.83 alpine:3.17                   : FAIL gcc version 12.2.1 202=
20924 (Alpine 12.2.1_git20220924-r4)=20
>    7    13.94 alpine:3.18                   : FAIL gcc version 12.2.1 202=
20924 (Alpine 12.2.1_git20220924-r10)=20
>    8    16.60 alpine:3.19                   : FAIL gcc version 13.2.1 202=
31014 (Alpine 13.2.1_git20231014)=20
>    9    15.72 alpine:3.20                   : FAIL gcc version 13.2.1 202=
40309 (Alpine 13.2.1_git20240309)=20
>   10    16.38 alpine:3.22                   : FAIL gcc version 14.2.0 (Al=
pine 14.2.0)=20
>   11    15.09 alpine:edge                   : FAIL gcc version 14.2.0 (Al=
pine 14.2.0)=20
> toolsbuilder@five:~$
>=20
> So the easiest way out of this seems to be not to explicitely include
> linux/prctl.h and define the new stuff conditionally, as I did, right?

Let me drop an email to alpine and check with them.

> - Arnaldo

Sebastian
