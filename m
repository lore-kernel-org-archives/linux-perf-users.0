Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B93B7B99;
	Wed,  1 Apr 2026 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775080374; cv=none; b=eBas8FRW1ZlC0SH8leZUpek6DkCAvcu1WMErWZS/xNN6fWT1aLr5Qo1CkIdumPXwPFo2jmzRQnduqJjEzb3+d1YFS34njR1zGUcJm0rql1JriKWv/a8rtpyIgL6cIIYCgv6x2lH23p7SfSNWI7kkALN6e6wMpgaZO5T38mC52hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775080374; c=relaxed/simple;
	bh=EMis7xbNom8wdFi0/aBqaQooiAu9a7GMvZJmOUAY4Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l23R3dg7pDMmfbE4E+F8iQC+qxl9LVDkxXDEBOhTwqFon1a6BObZECe2bYmLGXScnE+5jp6Z48Bvu949lLNyDrf0VVK/SUrcgeOuR6FjiW7gE2zxsdkiLDqJz7xOcJSKp2zOckXvofF2GA7hpd8UU4FGoed08jcav/ra1qi/x/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThllkOkP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThllkOkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD08C2BC9E;
	Wed,  1 Apr 2026 21:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775080374;
	bh=EMis7xbNom8wdFi0/aBqaQooiAu9a7GMvZJmOUAY4Y4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ThllkOkPXKF1HVD+7hsAiNLilmwP7WvzIvSe3LxVrl8CmwzPR/p34Mx34WvzKFvqN
	 X8kfxHteR/ZmXHMjTs7NaZiBAOOPHePS7N/2U16AxRA25NBoFswnPf5cpQrRD0NO4C
	 /iK244+/U/7q+LZvDNP82RpsC0CmFS90N6pG38unMXEyrYdYX4mcnfsJKzpyRmNxBP
	 8UD2QczopNmlzBSy5OjazCYtX4vK77q7NdCIlYhMOullDtH/GJj/9H830+3JpbbgR6
	 H9n9LUPXOW7Gc6OPJilVBNZNb2vpNoUkjHoWO/xLRnBbCZNPWXzEfz7+ZmUKZhuqdz
	 W5GPwLLudK4CQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
In-Reply-To: <20260319064513.9269-1-namhyung@kernel.org>
References: <20260319064513.9269-1-namhyung@kernel.org>
Subject: Re: [PATCH v3] perf test: Fix perf stat --bpf-counters on hybrid
 machines
Message-Id: <177508037392.42628.17191781963661090654.b4-ty@kernel.org>
Date: Wed, 01 Apr 2026 14:52:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Mar 2026 23:45:13 -0700, Namhyung Kim wrote:
> The test constantly fails on my Intel hybrid machine.  The issue was it
> has two events in the output even if I only gave it one event.
> 
>   $ perf stat -e instructions -- perf test -w sqrtloop
> 
>    Performance counter stats for 'perf test -w sqrtloop':
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


