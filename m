Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F7EF9F7;
	Mon, 17 Jun 2024 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718656157; cv=none; b=MwnU/6jyqPlkIVxOwseSiQHXicu8sPGsiFKy7qjv4416eEhnPngReNpRdOw63EsYKL7mR2ev8/vJC6IszTt0T+WgibuPbB49dAuFZZp2BuXQRM27xkjOq6bijdv/4dybZ54IL/pj3ReulogN6tNsQ5gry3G6+Vg24LWPe87YLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718656157; c=relaxed/simple;
	bh=5/p/HNAqCZY2F/FoEBUzjPOktcDZIlr3PmT6al0Qj2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGnA6lnOo/AV9YQ+4EtCAVcE9CPmJimxNJZaY9nfuDRP74qV660hdpbD4yeavYnEJSeQ6h1j0uGHFJUhCk2TovLdy3fk7zWQ16PK7MOeuzoR+4K7I6DkWU8w9ogkYV54WUbmuIsJ1aYUqu1sZu6L7yRQ/TlRIHoPqYpgQtBtf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI85OdbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI85OdbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDF0C4AF1C;
	Mon, 17 Jun 2024 20:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718656156;
	bh=5/p/HNAqCZY2F/FoEBUzjPOktcDZIlr3PmT6al0Qj2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jI85OdbJ1FSEscGeh+Fe+3RPXI5kVjDnQNavDGepUTdYIiw/ju3Rj3YEYSTixUXDC
	 qqjR7xmbeScrhv/BzUlWRK5JQHYjHeGwvLxkjb0hPJIJTZB/gn6737WvGQhRCE+unQ
	 I0JJo9NfHUPgVQu0+tEP4ucl5Yslu8HegQmi04aJ0rWg8Nmqhiw8VB/G0sUUy3DLpD
	 IzNwVX3r6hmpcCus/nJRIStR5sfmFuVPDvy+2tEv3L47tr7hl/YROH4npf88oPaVNg
	 qAKiyATFYksRvl9opzKjf+Uck1CHWAAGxMWGHkT3daKCw+PoqNIjLMybf/yXIQTRm7
	 ohmAhtobzx7zw==
Date: Mon, 17 Jun 2024 17:29:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf trace: Filter enum arguments with enum names
Message-ID: <ZnCcliuecJABD5FN@x1>
References: <20240615062958.367524-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240615062958.367524-1-howardchu95@gmail.com>

On Sat, Jun 15, 2024 at 02:29:58PM +0800, Howard Chu wrote:
> Before:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
> No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS_PINNED_HARD) && (common_pid != 281988)"
> 
> After:
> 
> perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
>      0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875, mode: HRTIMER_MODE_ABS)

This one I had to apply manually after applying the other two patches:

⬢[acme@toolbox perf-tools-next]$        git am ./20240615_howardchu95_perf_trace_filter_enum_arguments_with_enum_names.mbx
Applying: perf trace: Filter enum arguments with enum names
error: patch failed: tools/perf/builtin-trace.c:904
error: tools/perf/builtin-trace.c: patch does not apply
Patch failed at 0001 perf trace: Filter enum arguments with enum names
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf-tools-next]$ git am --abort
⬢[acme@toolbox perf-tools-next]$ patch -p1 <  ./20240615_howardchu95_perf_trace_filter_enum_arguments_with_enum_names.mbx
patching file tools/perf/builtin-trace.c
Hunk #1 succeeded at 894 with fuzz 2 (offset -10 lines).
Hunk #2 succeeded at 932 (offset -10 lines).
Hunk #3 succeeded at 1905 (offset 3 lines).
Hunk #4 succeeded at 3832 (offset 3 lines).
Hunk #5 succeeded at 3842 (offset 3 lines).
Hunk #6 succeeded at 3883 (offset 3 lines).
Hunk #7 succeeded at 3902 (offset 3 lines).
⬢[acme@toolbox perf-tools-next]$ 


I'll push what I have to that tmp.perf-tools-next on my git repo at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

- Arnaldo
