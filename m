Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B0B211A28;
	Thu, 21 May 2026 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368507; cv=none; b=IBo6ZAitWkYTtfp/lJ+Yb9kKDTzhNXuCAkIZ2L/tIg4pYV8IBohQVXPZt0CSMtM3W0wwQl+a66VKzlVx5UWb4uD2OjAFO5Y392NHGffNeZ8t4fPLuH+mJRtIFtfSnlrTpk5haeP/V80ineujTL+cxBEnfdeXkwmxjbCip9lIN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368507; c=relaxed/simple;
	bh=ECqJCqd0ciuGY+aTPEbNBxRaXd+7Zw7aogpKOnvnvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0iKyh2yxTpdX140HRx5RtYgoq7JP4QAG7UN/GoBJ4EWriLzJqHN13HNbHFNyZdExA6psssRedipoZMQwhDG/mWD105mLJL8cYKLU5MumK3L5pvrKIedf0tu/II7WwBeRzSK0IocQ6KyAj6HGgvPmN6nPYC4NsUbcn2l9ZNlOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlUIQmq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlUIQmq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A9F1F000E9;
	Thu, 21 May 2026 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368506;
	bh=ovz7lV/rv3430Sl0P56zep/Q2wkte2D2maxx5P0dH54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AlUIQmq8yzDUxwn5tiGcWk3/+CIebguc/OP2wnFLHKYqvhK03tHodOEMHKhtQzy9N
	 ftCLJn5tl7g2bP5NW7mnQzlAFlv+mheuPrmwwR8EWcOKcyVBZfay3FNLkOUIiCKC+e
	 F0NFJ5699OH7eLMCmq+Da4QV01gG0hEt3HtsSm1FSBCXeZOWvHPd0DdgJItbks2HPG
	 ceARUuVYd8ls/Z5dWxZkfCsBzXt4f24fQDlLAkM5j5BAfG8ZNARUvuCVDw8mxeOO8z
	 zjvrGDNtAXQdvcKneYnGbOjbyJrA0TNS78V5xPsF2O7K6NoT+Mdf7TSooW/LJzpxHh
	 vgQL8DG/mKS8w==
Date: Thu, 21 May 2026 10:01:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 01/27] perf session: Add minimum event size and alignment
 validation
Message-ID: <ag8CNsomAdrEF02X@x1>
References: <20260521011027.622268-2-acme@kernel.org>
 <20260521015919.702051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521015919.702051F000E9@smtp.kernel.org>

On Thu, May 21, 2026 at 01:59:19AM +0000, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [High] `perf_session__process_event` returns `event->header.size` for unknown event types, causing the stream reader to skip double the event size.

> >  
> >  	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
> >  		/* This perf is outdated and does not support the latest event type. */
> >  		ui__warning("Unsupported header type %u, please consider updating perf.\n",
> >  			    event->header.type);
> > -		return -EINVAL;
> > -
> > +		/* Skip unsupported event by returning its size. */
> > +		return event->header.size;
> >  	}
 
> [Severity: High]
> This is a pre-existing issue, but does returning event->header.size for
> unknown event types cause the stream reader to skip too far?
 
> When the caller reader__read_event() initializes size = event->header.size
> and adds the positive return value (skip), it causes the reader to advance
> by 2 * event->header.size.
 
> Could this misalign the stream and break parsing for the rest of the file?

Will be addressed in v2.

- Arnaldo
