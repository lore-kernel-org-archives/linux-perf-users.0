Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0F1DF96E;
	Thu, 17 Oct 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183162; cv=none; b=JWuEkTVl7wjxp/efZ+31MrAeSp+HgapXQpjfzIsWY7KiyXuMIKJpFZmD7s/jv/a52EXkBeJbJURY6/L2QJwcGc6j/hr91lruFeKtTYr4II1tXEFDRRcfU+T+/31YNNBwjam43+/liGIw1730DbuYhhfI6sWm1vEMsjvhtV+0LY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183162; c=relaxed/simple;
	bh=tb8dQv7yx10S84kB5tKyG8Quvbrc86dllNNk0OqOzWM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=chFKmcIH0WxZoaGUJ/n3pgs+/DshkOm9pmqP+pCnze3ZZ8M1oCkk+VUCHVuuBStvXSiU9f6zlqQIYKOFWZvvxafoDX6IigsBSYrCdpvDKSUAy51W8Fo8fsiGh1ZuPB7ykjdhuQFJPuvfWW2W0NKNRg2RsqoVCZ3BwQiheTFMVk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipguhI9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipguhI9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980DCC4CED2;
	Thu, 17 Oct 2024 16:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183161;
	bh=tb8dQv7yx10S84kB5tKyG8Quvbrc86dllNNk0OqOzWM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ipguhI9e6EFYQ00lg1LtXzijlZrcbs65oWkf8UwJ1feSiMAKrz84T2iC9LX04yVV4
	 xCQPp6MPGnS6hZNdVp7cStKD6caLv0NJVk2apnDGP6CiS20jm94h9EfTOQ/ccywevK
	 p3QWiOFtcjKsTeYdIngQXHQxICf7O9FWZT+nWAyR82GG0N/7qXWxLZZflXAqlOewb4
	 0nfhmn4RwUK34feH+CjzRzYtJvVlTLGn77nqpHkzn2CxU4C4hWqMC6OKQgpq/EIWnO
	 GfyZYjXCEaAbohr5uQtcsA34yhIxhjckkxFospLnyOrl1oZVQvD7Nc90PGu2H+vvDX
	 cf+HsCdunf9IQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241012204725.928794-1-leo.yan@arm.com>
References: <20241012204725.928794-1-leo.yan@arm.com>
Subject: Re: [PATCH v3 0/3] perf probe: Improve logs for long name string
Message-Id: <172918316158.639809.15313412336355889892.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 12 Oct 2024 21:47:22 +0100, Leo Yan wrote:

> The series [1] tries to use hashed symbol names for event names. This
> can avoid failures due to long symbol names. Somehow, it is preferred to
> specify a distinct event name when adding a probe.
> 
> This series follows up on the comment to improve the logs for long event
> strings.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

