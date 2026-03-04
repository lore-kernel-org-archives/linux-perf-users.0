Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAEC364E9E;
	Wed,  4 Mar 2026 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772656472; cv=none; b=LyQrvr3Ck7dO2HAg2e1AHw2SFH+GX+TQgIjNo5fAsVyv8b9bR0akUCn1DWtUyJDGAwnMrHVx/MgoTicE8BAxO8Ir2RCVZe2AuoaltSqhG+kPoD/847NKzjk3P4OrU6UyGcdZmmswMYY4x7M3K3gQzb8L+2PBseck0BeLjWY9E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772656472; c=relaxed/simple;
	bh=dQGRPzSeS1qh9wsp+smQzZroOWOr2CWSmUpLUZ9TfuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q26YOsncGycdkANlWrvwL0wFG2PIY3OoQdDo4g1Yv/jpPT0EunkmOv1L8inW36HKm1gAL3juXWmLU+wY56Z4HP+2x8+lTfOsOdPWI7/tdT+xRLHufN3rCd3zOEM+DI+a4ulMQAL9ill3w41aOx1Xz8FNTR2giPEzHpyeaxmK4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDd68J1V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDd68J1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C06C2BC9E;
	Wed,  4 Mar 2026 20:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772656472;
	bh=dQGRPzSeS1qh9wsp+smQzZroOWOr2CWSmUpLUZ9TfuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDd68J1VV2PdxkSHTukC7pWd0ubvFEwbe2ZD4yvj365ym4ejW5jbubJYQ+7PiZiLw
	 rdyZ/+B0x9n9XIwVL1eoOu6RBw21Rrkw345BL4mFXEDGzXZiNcjZKeTFT3EyTo3+2O
	 UI1HNwiTJqi28efBD9V4aMMRMnhzVMAejNbhtpCD9TEVOlRRUfQzjp45GALovvsp19
	 wuQPkTxrq2baP0r3hPEMLmIwqDiayVE0657Fp0fijEHPFuTmnnni4qCtkpDUAVu/QW
	 qKOwOZj2MAU/XLVEK/nB5YROyVUIllH+U5RSbikRwsm1u9kI+qL6TEwuC4ZZfaVWoP
	 fxF3eTFuFoM7Q==
Date: Wed, 4 Mar 2026 17:34:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Dolgov <9erthalion6@gmail.com>
Cc: Ian Rogers <irogers@google.com>, miguel.ojeda.sandonis@gmail.com,
	a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org,
	gary@garyguo.net, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, lossin@kernel.org,
	namhyung@kernel.org, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v1] perf test type profiling: Remote typedef on struct
Message-ID: <aaiXVfUz3glQolE5@x1>
References: <jiwt5mjma2puv7kjbgploxx2l5tankjm4zu2tsa75qkckwnwjk@f7mz5vlvzpjz>
 <20260302235821.588686-1-irogers@google.com>
 <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gfdliffsgy4j6q2vrilr6kapy3hczh4udszy4wcba6aal3ado4@hfeqa2eizu5y>

On Wed, Mar 04, 2026 at 11:44:16AM +0100, Dmitry Dolgov wrote:
> > On Mon, Mar 02, 2026 at 03:58:21PM -0800, Ian Rogers wrote:
> > The typedef creates an issue where the struct or the typedef may
> > appear in the output and cause the "perf data type profiling tests" to
> > fail. Let's remove the typedef to keep the test passing.
> 
> Yes, makes sense to me, thanks. As mentioned in the previous message, it
> sounds fishy to me that perf record and perf mem record capture
> different data type -- I'll try to get to the bottom of it (I was sort
> of hoping to finish the cross compilation topic first, but since it's
> not moving that fast, why not do some debugging here).
> 
> Reviewed-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Thanks, applied to perf-tools, for v7.0.

- Arnaldo
