Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938A3DD875;
	Tue,  4 Aug 2026 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863080; cv=none; b=kU4RV0jCjpIE++dONwQ9H5Ewgb89uzh4F76vsOQDirrfQapwu1f/APZyhSz8YE1ltYjZPz1kkeFFHOYzIxCyMJIQNhvFGHsGDwgQuX+40HDMSyXrcRIcgKIHES3zIxkDA8zmCHvBz5+asbmLEBt3R3ICULpb8X4e+s1I0TxbLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863080; c=relaxed/simple;
	bh=mayN1Go3zJkmDYXadtU+YLfldy3KoqHkShYtZwqJIFk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E/swSFcTdAQaO+DkotGimCEc0+/w4OavTUqleVlcwI9ObxJBpZhWZ0eR/e2/LTQfX2XpJRMAepbJMgtHn8TA5YOU4HrbMIiN8wg0glnezYnZkuiA3ism4ggm4jklAegB7gwOr5F5xrcR7fIN5absaTavp7P/jA2EWzFumPOVYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDvRJLQ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDvRJLQ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346721F000E9;
	Tue,  4 Aug 2026 17:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863069;
	bh=Hf0veXQ7jmlgmm/KW8jBkWdlSJIs2DlaudgFQ1vZNUE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YDvRJLQ7mOorq3pZ9BJqtqW0Iggy6tDyBRLR/+K2jQ9lEOXundZ1VVV38RLOu57fq
	 QTYdQ9UXfiOEzzTE88fHRYHB7g1tUnc19Q4GUHRlpmR85DQN/3kuxMcHFMAQdbrljU
	 fbDZc1D//VscRhxUOMf0SFEBliH9Wdej8X/eq9IXAaQqZ2VJOPBXsxNZhp02HURCWv
	 Wb37rN4cCw47HP9OTAeOmh0gSw93FoYWXSaMPshaUw40ZJT++zBcSIS54Uf2tQm/47
	 jz/RHXHa0uX4JHYEzk9gOpoO/HOKGBfZVpwjTAMKchbi7bVPuQjo8slPtIUtn0ffx8
	 GooHQ3VwoWTig==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260727161705.64807-1-acme@kernel.org>
References: <20260727161705.64807-1-acme@kernel.org>
Subject: Re: [PATCHES 0/5 v1] perf tools auxtrace hardening series
Message-Id: <178586306917.3573204.3625961710942979174.b4-ty@kernel.org>
Date: Tue, 04 Aug 2026 10:04:29 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 27 Jul 2026 13:17:00 -0300, Arnaldo Carvalho de Melo wrote:
> 	Please consider applying,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (5):
>   perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
>   perf auxtrace: Fix queue grow overflow and old array leak
>   perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
>   perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
>   perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


