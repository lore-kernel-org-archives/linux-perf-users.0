Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D72D2E6112;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750787590; cv=none; b=rblLiv2xKatXVK2t87MLOdAYTpHIZissXtf3jjoeKzawRxtmSEo+pSLv69dRLSzvCzz7E4nb0Uix80/WEY4vrF6oNx7SKevl/84oF5YgRwr1M9Mco5flpYnVDaK2R1JBFuZuxeC/pmXUaI2ZE3Au0QgTz7nDNSr/sk+f4MZjx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750787590; c=relaxed/simple;
	bh=tTtHDW4KpG4xCxKti2qpyhAV6+jduLkCiFbcw7mm7Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sk2C1AdN5X77LPvDGkX7UXcqxA3oq4wdBfBaBm5OHkGRmmMN7NxYFRlM95kRgVPEewTNFIzYHqG4JU+8D1JtD0VfGMCYouSxDdLk8xBixjkXi/I9fTu9Vl58UqSsjnBMdgrS52FqNb9zc7a9olvqd6vJG0kT6CVFx3lawoRQTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPl19xtR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPl19xtR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D18C4AF0B;
	Tue, 24 Jun 2025 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750787589;
	bh=tTtHDW4KpG4xCxKti2qpyhAV6+jduLkCiFbcw7mm7Yo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PPl19xtRbwNHvg/lSDZZMYMdqkkYxk+zUrtpA0Qu/KPf4fOyAx4XWK5kzAT00qFX6
	 +h8021rg64PEhgakPi2i+jvCzJd4ktU0WjDgzZlW8qBwp7LfdHMgHgVTiDgWVh/o43
	 XHwexOjsteC8sic1mzAaQ9tIGLomo771R9UaR5XpCFJ1E/ZhxA2JgpoLk4vIy8SrbJ
	 Wnr7lszkRIr/5BfF9Ft1zXBIX2xJFkPXkTVSC4yMhSWM8Xhhm2uEQf2hmbbgDTkYYN
	 8hZVLivK17CnHPvgkiK0AwgsYmJoZD2/c+pJMQbrEpbrD8ZLLoctbEFBwmUvzHKrFA
	 Gdz9mHkiz0Xtg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
 Howard Chu <howardchu95@gmail.com>
In-Reply-To: <20250502204056.973977-1-namhyung@kernel.org>
References: <20250502204056.973977-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf trace: Show zero value in STRARRAY
Message-Id: <175078758951.337518.2774382796978951070.b4-ty@kernel.org>
Date: Tue, 24 Jun 2025 10:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 02 May 2025 13:40:56 -0700, Namhyung Kim wrote:
> The STRARRAY macro is to print values in a pre-defined array.  But
> sometimes it hides the value because it's 0.  The value of 0 can have a
> meaning in this case so set 'show_zero' field.
> 
> For example, it can show CREATE_MAP cmd in the bpf syscall.
> 
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


