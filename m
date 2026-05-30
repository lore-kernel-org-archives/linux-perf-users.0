Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43E13D53C;
	Sat, 30 May 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100338; cv=none; b=gl2QmjPItiwFrerSOiDbupb6+ovPfuMa+L+0GgKT8F3fO6vCpDzMkzSm9zGa6XuDBGwxXBKmSE/Aa+85Bt8/AaNdkRA0cbo66RPe4R0m/n4FWXuIcTX7F3Vci0RwnbrVShTB6tdgq0RuDIC7m5T9tM6PRwppSag4wW5xXG5Eur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100338; c=relaxed/simple;
	bh=SeLNK8OIHYu49w4Ka4DF+KPV2e1RaXMn/ECHyh2HtGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRKM5s2/dYYpe3kL8EA0FTvxWkBv4pDYiZn7sfOtkW32lo3gYY+V6aZ+O2bFf5gdImwC/TiysgReHo4Y+tPS1P4GImbOQm1DDpmCh9/YaJCnIK5Dcc1pu3wGLAZ8yUzI6h26HN0Wt2tismYKzzCu/ZtrKsSxdGIglf9mh61RLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKcJ3V+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKcJ3V+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA891F00893;
	Sat, 30 May 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780100337;
	bh=4DvnlXu4Gbkbemr1OuMvTb1hvu9djqrqEsaMMZptRWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKcJ3V+9KDiNMTtd60SnyhWGs+WqIi1Roaco6NlkPSit303wHbxkLM1/yYpBClJ61
	 TQJmLbNBVGqMxIPmRaWzZhP0NT+bdZKAQf3I0pdQIGgcYThQVW3GbF4r9cusluUvj4
	 erb6cd9XEJZRCwBhMBY4nUAS3IYbC16uNc7UP0YvvKafjWK2CS/VoIoHTFFjVrdnde
	 SgiBv0uKMT3A8r5llFARfaqSZzFxSGQrxcaNR2IS0KQBuF6KwQ8gPKFhLATyk1bnHH
	 k0txNrx+eQpNpnq8xzG7umSgiHyD/wjZ8VUcxkJ+wrbqgcwEPtoLqqec3QJAxRA59Q
	 kIGQTsUd2C9xQ==
Date: Fri, 29 May 2026 21:18:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Miguel =?iso-8859-1?Q?Mart=EDn?= Gil <miguel.martin.gil.uni@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org
Subject: Re: [PATCH 1/1] perf util: fix perf_exe() buffer write past end
Message-ID: <ahos7mGhWpiwkwY6@x1>
References: <20260526110852.7259-1-miguel.martin.gil.uni@gmail.com>
 <20260526110852.7259-2-miguel.martin.gil.uni@gmail.com>
 <CAP-5=fW6uR+VBp7F=98iSKuS6j+wAHbbpSjxRZ-9mxaudupY4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW6uR+VBp7F=98iSKuS6j+wAHbbpSjxRZ-9mxaudupY4Q@mail.gmail.com>

On Tue, May 26, 2026 at 08:05:44AM -0700, Ian Rogers wrote:
> On Tue, May 26, 2026 at 4:10 AM Miguel Martín Gil
> <miguel.martin.gil.uni@gmail.com> wrote:
> >
> > perf_exe() passes len to readlink() and then unconditionally writes a trailing NUL at buf[n]. If readlink() returns len, the write lands one byte past the buffer.
> >
> > Read at most len - 1 bytes and keep the existing NUL termination. Also guard the fallback path for tiny buffers so copying "perf" cannot overflow.
> >
> > Signed-off-by: Miguel Martín Gil <miguel.martin.gil.uni@gmail.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> and Sashiko is green:
> https://sashiko.dev/#/patchset/20260526110852.7259-2-miguel.martin.gil.uni%40gmail.com

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
