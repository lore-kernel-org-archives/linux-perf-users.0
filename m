Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6C03D9DB6;
	Tue,  8 Sep 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904293; cv=none; b=B1u1ohUcLD0SlFScpykIqdGeDnXGQIE0150iVCoABDmznEh6eb6aKBDn0BvjB/jL8wyKZ4lXJ2oWR2HTuVBn6pXQ8LK9pKHPhfYFCY57z7mdTYTIFyexcbJ7MG1zfU6AtDAt0UATOegrCF3oTNhln2Ex4773nEOfXLbgRhdHq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904293; c=relaxed/simple;
	bh=J/2qhXnFVehMcngC1n+p+voM2EUahDYzujf5GE5U8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRBSA+Om1PyMCCAmg/4svoAVxKZail3QCtioDI3bq0MPCV2g6Him83fB73FCVTLNZiJ73fi9erxiKIbWdH8hSRCpQevV+oiJHg4QXbkOt16iFATly0jb9swSYjvKaL5Gg/A4edNqT0JHdE2VhVouDW3s4dUyhZJZcQaxXDS1zjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9fi18VT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9fi18VT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691AB1F00A3A;
	Tue,  8 Sep 2026 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904292;
	bh=7d1E8UOpN2gm96N0Y9ZF+5Auvlue83lkuuqxgTtddtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q9fi18VTDpkoeDIvQTyj2tuoXq1o5ubNgQIRswGzKJHNdK+oRfEiRVlMBpwDAGcgp
	 GDTs0DEcqu8WY3xa3fDNGWi9FIoedI3HjoBy0nwQpPPPwmNuw1/8ohGHFccrArhkOm
	 5XcruWMGqv/anP2wNqxMoxnIJ777QQsVaApJl2ADShVJ1l7XWgMvrDuOA8Jz9Bdv1H
	 cDkal8DhATejp/RTuBIwCVKOSFdil8CN06/i9ybTeEQqJNvfjrPt3HsMXy5oB7wsCl
	 O5/Te3v+Cqnz9ecZk+L7L6c4uHW0vAP0GufbQrJSB73cLW84At56j1FEpWHC1pK+3S
	 QgICjV8vL4UmQ==
Date: Tue, 8 Sep 2026 18:51:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, sashiko-bot@kernel.org,
	linux-perf-users@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] perf unwind: handle allocation failure in
 libdw__get_entries()
Message-ID: <aqCDYVVKI-tzSyrK@x2>
References: <20260818142902.639F51F000E9@smtp.kernel.org>
 <20260818144837.741469-1-triet.hoang.dev@gmail.com>
 <apNELHaLHzBrPwrd@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apNELHaLHzBrPwrd@google.com>

On Sat, Aug 29, 2026 at 01:42:20PM -0700, Namhyung Kim wrote:
> On Tue, Aug 18, 2026 at 02:48:37PM +0000, Triet Hoang wrote:
> > Check the return value of zalloc() before dereferencing the allocated
> > dwfl_ui_ti structure.
> > 
> > Return -ENOMEM when the allocation fails to avoid a NULL pointer
> > dereference.
> > 
> > Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
