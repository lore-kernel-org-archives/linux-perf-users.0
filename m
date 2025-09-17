Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE434BA29;
	Wed, 17 Sep 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126436; cv=none; b=PW0WvNku6N0UbYe7a6xkWfDq774hX9FQP+ykHQJLMiqD1xOx2IgueJIsTJBYz1AfbENxjW7DcQ6upDUFQRZDMN0vt2x6AKXIRJ0x4s4uWYIfsGU8ill3XnjQUo2Dyq2BRN2OIqzCacrN1hU31JELgF5Z9t5xJQEL4Z6gF0usTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126436; c=relaxed/simple;
	bh=cOVSyMgBFMJzBwwANhZZV/LitiowID/KXFkTCSotoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob1+rNIFPIDVBb4Nawfk3rPpzpla28Kx0FEtMIzM3opSdtzrvMFh8a6ekYV6v/BEejZlrUFo5ywGQAJhAudpNNAoVLYniEeya09zRnfnY1vmpA1OPoPi5dWEDbHgkTMW2QEbmfcIbVjTr6Ti544PSZTF/GVvstJ2sQRO/uN+Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+S/RB3G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+S/RB3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8AC4CEE7;
	Wed, 17 Sep 2025 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758126434;
	bh=cOVSyMgBFMJzBwwANhZZV/LitiowID/KXFkTCSotoWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+S/RB3GJHFFSnc0+vFb+IHpcEl3c17djnHbqyCf555RId41VgnmE2jiv5PP1qGOe
	 2T+Rthhzbk93Lpn6mp1OiyEULt5cZrrhHURNpZi5PMh3bTuBm7gdDk/IuL45znaan6
	 WBQs5eJKkMGc/JAKa/qW47V9sCjw50lXbEPFEfiVhFNMzQyTGe5/2pHx5lXzqhMtxZ
	 iz60Et/uv/TdBUTDGTw3e6Crc2pjdiKqlI4RpnxnUOavQit7R5nwq8l7zwjNwlRiuU
	 ScYkiDJoIKEyXbgCpxWMmOjzd0S3IDHnJQKzYzqeck5XVxIotY26m1VHm9Ki/L65pc
	 LAN73OjaoGzsA==
Date: Wed, 17 Sep 2025 13:27:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Fushuai Wang <wangfushuai@baidu.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace: Fix IS_ERR() vs NULL check bug
Message-ID: <aMrhX1i58syq-MXl@x1>
References: <20250917095422.60923-1-wangfushuai@baidu.com>
 <CAP-5=fUvvcfPOEyoTGFD9oahxzKGMZXPZ1YikLqzwE3hw7B=bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUvvcfPOEyoTGFD9oahxzKGMZXPZ1YikLqzwE3hw7B=bg@mail.gmail.com>

On Wed, Sep 17, 2025 at 08:31:02AM -0700, Ian Rogers wrote:
> On Wed, Sep 17, 2025 at 2:54 AM Fushuai Wang <wangfushuai@baidu.com> wrote:
> >
> > The alloc_syscall_stats() function always returns an error pointer
> > (ERR_PTR) on failure. So replace NULL check with IS_ERR() check
> > after calling alloc_syscall_stats() function.
> >
> > Fixes: fc00897c8a3f ("perf trace: Add --summary-mode option")
> > Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
