Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D811990A1;
	Thu, 19 Sep 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735698; cv=none; b=ABy6ZMw3i2rEIRigDoPQpJeW6nyeWe2YnC9l8gPmK4XER4fwUtX44bYiw9+DjipU+QBSY66P3wehpsE+nJoXXBjWsOoArT+ehfsXN247CT8oB7d25xcYjwIlLXf7ucd32zLJQQ48OC7QubqWp/v9Tm3LRlhAxPVNcSG2VPJocbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735698; c=relaxed/simple;
	bh=brUGRPagFDoC2hg0hqT+CGDG53HNbe00WCE0NisuZfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aen8ssDLxhnVQ8ZvqRddP/1CqKnPK16Kts/73oZ5ZS0b4AQNNVTqivQHV2cGBOejr3O5YsTWoi8RtSUchl7l3l5GnBjS96JlaXFN8ERwGxnzd1ztTNkALw2XPDbgw8rO3ZMU+fXyPwSFyBEzPKEkCysC4qS7IJGM8/Ub4KR1XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eofXfxqn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eofXfxqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B15C4CEC4;
	Thu, 19 Sep 2024 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735697;
	bh=brUGRPagFDoC2hg0hqT+CGDG53HNbe00WCE0NisuZfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eofXfxqnadNTFE7vY28rXSXTF5hdsSxfgMAKo4f3jXZGdtCCAIg4FvipNnB2clNg3
	 7LMYX3fJCYJaWGI8IhzUvpYZPkbFVbKPiMDPZVfF4sqf5561QkcwjzvWHyGZDINuvV
	 cFnI/Y3MV/cNEUW8J7PxtXTTeKz+iu9G156UzJDOIzQn9ZIs32WPIHXu0ip/vmhLZn
	 RAsZgAx/JEuUfi8nvVwwWojuaNBkuXSf3kkcbgQ88AHTdL0c95gPT1TTTalOtjD+ua
	 1+q8iMEK2nzKb6PPXoRvabRF8mMA3kbTVxNgG+WeSta3/KvURhXWCyidvavIAdEb7Z
	 2WcNUd21jQJkA==
Date: Thu, 19 Sep 2024 10:48:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [GIT PULL] Performance events changes for v6.12
Message-ID: <ZuvlTLMflCigipCr@gmail.com>
References: <ZurLc9qEjBH9MkvK@gmail.com>
 <CAADWXX-xNBRC8yAUmCdPxe3W==Dxa_Xi6P_ceYDAEAeKYiqC4Q@mail.gmail.com>
 <ZuvhwjNgDmpmReUl@gmail.com>
 <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADWXX-Mu=h7hh1KmiWMPoDoVSTb=oQ5Huat+2=hsm59g4R6YA@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Sep 19, 2024 at 10:33 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Thanks a lot - I fixed up my SMTP sending path, so starting with this mail
> > it shouldn't go to your spam folder anymore.
> 
> Well, that didn't work at all. It's still marked as spam, and the
> headers of your email still say you go through gmail:

Because I'm a moron:

I fixed my setup, tested that it's working fine:

      Received: from nyc.source.kernel.org (nyc.source.kernel.org. [147.75.193.91])

... and then I sent you the email from a Mutt session I started yesterday. :-/

This mail should be fine. I hope.

Thanks,

	Ingo
