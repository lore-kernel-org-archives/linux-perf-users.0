Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7521514E1;
	Fri, 28 Jun 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585700; cv=none; b=DCC7NJVDSOHLp/N6sVtvj6LBW27sA4efw0xWLba0JQFVOhAyoP85yY35SD9HAyC9Wf9hWUz+xm3d/tM9h9NPN3Slagb/vBDJHlsiEfafZ5F5T0WbvblVk0PjowBYkjxCKcAKlfU+bene2lt9RvAGOwIlOJ4prqBCOMHKLVxDOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585700; c=relaxed/simple;
	bh=Yj6cy91JoTBSw4EEoKl0+lYXCoG15CGxHS5xc7/9UnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOwUyvBgwqg0Z++aE+MFhfB0CK7NfTcpMU7ApomppVy/ie7CM6vGpgUllSfW958nw49W4vvvn5EyYg4u9iIYJHRM+1XDuYOgmvRQPYlEcUUjTPdlb1geuBddQysa72xRCFNM692kMGtgVDxJfMQDqc1eG5Ok6c+eomYD6//YZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SehGggs3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SehGggs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C29DC116B1;
	Fri, 28 Jun 2024 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585699;
	bh=Yj6cy91JoTBSw4EEoKl0+lYXCoG15CGxHS5xc7/9UnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SehGggs3AT6JuDKxcRm9xAd4jqMyleLaDWRlGXMy1iGX+uiF+7L+xlYfkyADO9UaD
	 3VXdxiuWwNogq5mmpSX6AW1La4RoUj4dHJQpllUr9V/RVv7I2HF1aXgKXsYs7bVVMH
	 z4PnTV5CSq0Tqvl+MzOhFqWVhdCSNCxaSNi7cNR8pfmy5ciTUkWSJU07CV+Qab3Pg6
	 8iAmA83XQR+HblOd00vwmXPvGHSlvjxjb2czj9awcki8z/d9VJOV1AVu2rdmxsxhu/
	 V2ot62V/YauUWSAfbQb8D8Rk2cYy8zMv2Q2vHljs7A0+0i1RW2gGTqTQltnK7pIhhu
	 m/YAiBqX5POIw==
Date: Fri, 28 Jun 2024 11:41:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/8] perf trace: Filter enum arguments with enum names
Message-ID: <Zn7LoTU45bhZaihh@x1>
References: <20240624181345.124764-1-howardchu95@gmail.com>
 <20240624181345.124764-5-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624181345.124764-5-howardchu95@gmail.com>

On Tue, Jun 25, 2024 at 02:13:41AM +0800, Howard Chu wrote:
> Before:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
> No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS_PINNED_HARD) && (common_pid != 281988)"
> 
> After:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875, mode: HRTIMER_MODE_ABS)
> 
> && and ||:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS_PINNED_HARD && mode != HRTIMER_MODE_ABS' --max-events=1
>      0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0, function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 12639433638458, mode: HRTIMER_MODE_REL)
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_REL || mode == HRTIMER_MODE_PINNED' --max-events=1
>      0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee7bf8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 12772614368016, mode: HRTIMER_MODE_REL)
> 
> Switching it up, using both enum name and integer value(--filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0'):
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0' --max-events=3
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 12601748739825, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 12518758748124, mode: HRTIMER_MODE_ABS_PINNED_HARD)
>      0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb164081e7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires: 12518768205836, mode: HRTIMER_MODE_ABS)
> 
> P.S.
> perf $ pahole hrtimer_mode
> enum hrtimer_mode {
>         HRTIMER_MODE_ABS             = 0,
>         HRTIMER_MODE_REL             = 1,
>         HRTIMER_MODE_PINNED          = 2,
>         HRTIMER_MODE_SOFT            = 4,
>         HRTIMER_MODE_HARD            = 8,
>         HRTIMER_MODE_ABS_PINNED      = 2,
>         HRTIMER_MODE_REL_PINNED      = 3,
>         HRTIMER_MODE_ABS_SOFT        = 4,
>         HRTIMER_MODE_REL_SOFT        = 5,
>         HRTIMER_MODE_ABS_PINNED_SOFT = 6,
>         HRTIMER_MODE_REL_PINNED_SOFT = 7,
>         HRTIMER_MODE_ABS_HARD        = 8,
>         HRTIMER_MODE_REL_HARD        = 9,
>         HRTIMER_MODE_ABS_PINNED_HARD = 10,
>         HRTIMER_MODE_REL_PINNED_HARD = 11,
> };
> 
> Committer testing:

Further testing:

root@number:~# perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS_PINNED_WRONG'
"HRTIMER_MODE_ABS_PINNED_WRONG" not found for "mode" in "timer:hrtimer_start", can't set filter "(mode != HRTIMER_MODE_ABS_PINNED_WRONG) && (common_pid != 103306 && common_pid != 3476)"
root@number:~# 

Maybe we can list the possibilities, i.e. print all of 'enum
hrtimer_mode'

This can be on a followup patch, just recording the idea here.

- Arnaldo
