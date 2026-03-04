Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F3336D9FB;
	Wed,  4 Mar 2026 22:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661865; cv=none; b=lqKPTSrFhKpld/mWGaBFGTTVYMFNA99ULSCdU7e63uUwP2HiXMDfJW5O6MgPXbfkcy4UHBz35rQDpY41YcOruvzSMUrFhyfEMQxWLCUM0QxaOethmXdywhFVkONKYx1qGfTNQHoBKT4a+Tw40mPUblUqXlmnDlP/X5jGJvQOitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661865; c=relaxed/simple;
	bh=EW5XUf9+GOhOgRtRjTsztrS4t//jE7FyRLSWD9YD9IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ3rgCY7YZY+T+i47gQvxfIlzb/UJXEKtwdBWDBh7pyf7uNQVr1xs/qk4o9Xmj7T3tlGHM8LObQeUWCSrmmc4lRydQutKpoCZoEvlMk5yP16bfRma3E3+RQEOEHVKKokPgut+dBfzwvh337rLWqjV5fQZpnbXdK83pcFjpyFy7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2uQIHsl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2uQIHsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385F4C4CEF7;
	Wed,  4 Mar 2026 22:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772661865;
	bh=EW5XUf9+GOhOgRtRjTsztrS4t//jE7FyRLSWD9YD9IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2uQIHslVqbqj5jSk5KoxANUm1C9zCQMv8BhU6X+VZ90PWLaNwKo+7IIf29K9IvEl
	 BW6yTr5Agynu62WmgAtCFtMahArhhS7nl3MwnEr0HqPVqsAobtqu4ZP46FywlSBclt
	 87RWkjz3qVdA65m+QK59UQiArwsI6qvEwO+vhsGzPxlEey/BXMV+RsBbEyIN3PRM7h
	 wQdpTgQIAhfW4WAeg7AgqtWuwT2SyNZPfjnIXQqu7qTlSiaQJ8KRey6HFfGLRrIzFd
	 +/vvBJmcZwZgpEcgaEWdFvhg5DXbPVS5LXTEALdHn4SJeIVGGjhKybiGhZm1cH6Lzq
	 LpPq03dNe3hOQ==
Date: Wed, 4 Mar 2026 19:04:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: 9erthalion6@gmail.com, Ian Rogers <irogers@google.com>,
	a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
	gary@garyguo.net, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, lossin@kernel.org,
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <aaisZpekRMOoa8Yw@x1>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <177266093391.3626597.10862709116758155175.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177266093391.3626597.10862709116758155175.b4-ty@kernel.org>

On Wed, Mar 04, 2026 at 01:48:53PM -0800, Namhyung Kim wrote:
> On Mon, 02 Mar 2026 15:58:21 -0800, Ian Rogers wrote:
> > The typedef creates an issue where the struct or the typedef may
> > appear in the output and cause the "perf data type profiling tests" to
> > fail. Let's remove the typedef to keep the test passing.
> > 
> > 
> Applied to perf-tools-next, thanks!

I applied this to perf-tools as well, for now just at tmp.perf-tools
tho.

- Arnaldo
