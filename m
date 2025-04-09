Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B732254B09
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Apr 2025 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201145; cv=none; b=BJkMj4e+6pY/K+0UPG+JprhqYmlTH+SqHF/K0FY8njMZNZah80nKU+jWPsKfpms1HOKqth5+KiiP8de1dK9VmzM4z4hWcO4+N0omIuRogKlsvtOwa7PWzqVGK8FNx789YsYNO8uWt/ispBBB4EbwqkESZtNsS/hWd4UVtg+kKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201145; c=relaxed/simple;
	bh=7j0ThK/zmxZKq+hmRd+NLEQ6tVz3WOymt4j6Zloihr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtpx+0B6PfFF9a0CidUiHQKnl0Zm5CEnOl/J3c8oX74CTzr0Tkk/xGdFpZKqDnSr34AY0MdApN7u3iX8gRfXPPsMW5odUoSEEqb2nKa6s42Qtpm7q6nWMEC9h+0hKk5zSi1+j13CEv3zTHuo4ZUYoR8RyOXPVF/faUTsVH5Izuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6fp9A0o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6fp9A0o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C199C4CEE3;
	Wed,  9 Apr 2025 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744201145;
	bh=7j0ThK/zmxZKq+hmRd+NLEQ6tVz3WOymt4j6Zloihr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6fp9A0oMqywZKhbHU6EMae1Wh3SEPWU7K4DTmYHVSD4DlgHhuytMa0hCTRLiMjvb
	 Ax1MNY0mJej+/Gwx4kl89kEGBJiUL315JVDUKvJNadE4E/sfCePqA9dMCFawfsm/mQ
	 dmkwN6opNH1tUdkv66pTqBzbPfuD/4xLcQNupi6RllC8DQtkw2KN3kpNeMB6YETm2h
	 3BsZlEWscbps9zyEWak2h/kRJNoxcItLg4gq88tRn/w9/jmq8S+HkEZazpqk2kG6WG
	 rIFSTajB7s/DRIf8IqNKkKnIuyjNkYNrjopCB/bZcPXPXpgdktCjoSZZiIVJToG7lD
	 s1A9jGS7ECE0g==
Date: Wed, 9 Apr 2025 09:19:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_ZltdaHx9XuKcd9@x1>
References: <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
 <Z_TYux5fUg2pW-pF@gmail.com>
 <Z_XaOp4TCBKe-M0o@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_XaOp4TCBKe-M0o@x1>

On Tue, Apr 08, 2025 at 11:23:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 08, 2025 at 10:05:15AM +0200, Ingo Molnar wrote:
> >      - Yay! But very unintuitive. The intuitive step would have been 
> >        the left arrow key BTW. (with restoring the cursor position to 
> >        the cc1 entry I pressed 'Enter' on originally), but that doesn't 
 
> That is how I implemented it initially, yes, over 10 years ago.

I'll experiment with making the Left arrow key, if already on the first
column, to work as zoom out.

- Arnaldo
