Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C968BBA34;
	Thu, 24 Sep 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271533; cv=none; b=UGDbbEe+xhj8WEye1Hybi2FZeQzH6g/+4RtV/kwNG088Bo3uMB3z6OxMR+ioTngRmO1T65rykQQwxkbrPjCQXLezt8xIpYmGEiZTJptRa9uPsUioQJuqYgxPTMRe1DnFNe8YnYRNV42d8Jf5ehHx53gHoi1YmTw3HeZ2bMaRcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271533; c=relaxed/simple;
	bh=kBdfCMbhqBUgKgsL6tmY2Qg7Kej8fo5oBpY5/dOJNNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG2cp/8Xm9G3xFy0b0YylBmY8Qw+BkX5ap0P3cORQkLX669Mk64jnOBPFUD1P7ndtb0uQvyj7TBg4z0ntBOznC0jbzPoj7wOP3ke+KQ/oBYK7lpIvb4Lzo04PEcx+N7nXPWKJtTSvgeT5PKf2vzLiHKR4JDVUsH1bZuiF6MQ+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os85GjL2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os85GjL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC91F000FF;
	Thu, 24 Sep 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271531;
	bh=gaDMnY09PB18FPHraAkmxxFVSs3vEWSrI+whk9nZC6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=os85GjL2NhGiS7HO1BwuhKhHxnPqRkMa69apFY5sy/yFu3wYWcrXsK+8PjcEMUpjn
	 xDqzd/bH/+0+pd7fqimpwaHGeNmJWkikJoWB/IH7Qo6pbOR858EougKZZ2Sw5Ny98K
	 HSGtxZFokT5HYjnQTb3KtjwPmBtECj6cziYDbRGZnD4xbk08R+Ag8TpDmjJjUDSJln
	 KveJi5Y26zT9R27cxV3P37zBGNArRkhcC2UAeGnyojSxUPSbLJ1KGXSZBLaI7WQNA+
	 WpXvQnPxfvwg+vrntaJMjE2Cc8TKCIP/VaprJ+9Aiqwh3tZu+jTDix42JI4Bm0UtcA
	 z9NzfvTpiFuLw==
Date: Thu, 24 Sep 2026 19:38:48 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Christian Melendez <chrismelnu@gmail.com>, namhyung@kernel.org,
	jolsa@kernel.org, peterz@infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf stat: document task-clock/cpu-clock in TIMINGS
Message-ID: <arVgKKaTOIGN4Xwr@x2>
References: <CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com>
 <20260923135140.386033-1-chrismelnu@gmail.com>
 <CAP-5=fV2O4bV99bOicODQxXc8frtUu23=3o7JBhoOtf4VzuyKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV2O4bV99bOicODQxXc8frtUu23=3o7JBhoOtf4VzuyKA@mail.gmail.com>

On Wed, Sep 23, 2026 at 08:14:09AM -0700, Ian Rogers wrote:
> On Wed, Sep 23, 2026 at 6:52 AM Christian Melendez <chrismelnu@gmail.com> wrote:
> >
> > task-clock/cpu-clock appear in perf stat's own example output but
> > were never explained in perf-stat.txt, unlike time elapsed/user/sys.
> > This came up unanswered on the list in 2013 and 2015 without docs
> > ever being added.
> >
> > Link: https://patch.msgid.link/CAP-5=fV0-yvc68BUSKoSajHjHY_A6COgbEJYiFxRg+G-8LeJhQ@mail.gmail.com
> > Signed-off-by: Christian Melendez <chrismelnu@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
