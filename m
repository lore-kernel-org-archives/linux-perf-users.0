Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F946C2C8;
	Sat, 14 Sep 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726342644; cv=none; b=JYFjRqyI6DAn2cZaOoihZRfXkGT6G8dJYRbTWVSJ0AoNcKbyGZ5tWGbfBkjgP5qZ0Gvhdmyq3boSrks5JRH94b1r+v2n4o8PnUVrcF0NSst/Yx2dHa180sDE0hF/ZAIKUHBdaxHi4RpOP3WfnyQSIjNPSLdvYuq7jDW3j0FLdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726342644; c=relaxed/simple;
	bh=MYnxDhJfaOGhJX0j9S//ss4SKrySMSzE7ziT0ebvp38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxHSYmoWJln+xNQ/PdBKg6pBYN17cgm3TVNxUIR/IJr06N/LkCyAJGuLW2ZaCXWeDDC9bWIAkSrV07JptDjaVPgnwW6Jmt6w8Z+a/792teAze46tau+4FCVbMeYssUEgc4KAe7a0JlhxeNOTyHGMTx/xyqL8QrPJPP2UlCwWF1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npiADEgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npiADEgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C917C4CEC0;
	Sat, 14 Sep 2024 19:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726342643;
	bh=MYnxDhJfaOGhJX0j9S//ss4SKrySMSzE7ziT0ebvp38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npiADEgTOW2WKKjfIlDyUIsKG+jGP9wM4WEQvsqpUvE9LXxIxeOTvGKyYfY00p7h9
	 BNkOkKqNIg4pkCcKWjnwsXd2zVPBfvGwE1Hillu8/06IWhQK325xbL0LXGZ1LVczyq
	 tzuJCd6kfClZgweV8Rh4ic+SQWNklSv0fgjYziVVpETlYraaELb73b77Fvcg6D/9do
	 ROHyF79S95e81eEibs8ByA0AGp7TIwbdibYUGud8oNGZOfacmJHSDQhpMmJqvPM8ku
	 an0Z7Xnz/8u4yW0fWtuc3mlG3kQSFdgYKO+pTiM0qUHaL9GZhBGBiN/MmFN5kdRTC0
	 rA4QVzPpF1FyA==
Date: Sat, 14 Sep 2024 12:37:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <ZuXl8VhcmTMY3zNr@google.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1726268190.git.jpoimboe@kernel.org>

Hello Josh,

On Sat, Sep 14, 2024 at 01:02:02AM +0200, Josh Poimboeuf wrote:
> This is a new version of sframe user space unwinding + perf deferred
> callchains.  Better late than never.
> 
> Unfortunately I didn't get a chance to do any testing with this one yet
> as I'm rushing it out the door before GNU Cauldron starts.
> Conference-driven development ;-)

lol

> 
> Plus I don't have the perf tool piece working yet so I don't have a way
> of doing end-to-end testing at the moment anyway.
> 
> In other words, please don't merge this yet.
> 
> Namhyung, if you're still available to write a perf tool patch which
> integrates with this, that would be great.  Otherwise I could give it a
> try.

Sure, I'll take a look and post the perf tools patches.

Thanks,
Namhyung
