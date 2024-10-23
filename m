Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3971CACEB;
	Wed, 23 Oct 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706421; cv=none; b=XTXbdI7TjW5jnkxh/kCg8Pnr8dQx8Z8tphtvaT/PS8hDv5v5Ld/B7IhjuW7a+M1oMANGBoUb6M5Wo2MWd239hwk1Ep6ZtrkfE4aL6AV26OifiGSuMd5eC4KfaJ/2uT9elTwI9kZtE3Kd0EUhNGB/v81+9fde40Uxfay/zhRoJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706421; c=relaxed/simple;
	bh=GC5YOYBRx+gZl5V2Ks6B0SwBBanF3+LpkxO9ECEL3OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pEHaFXitSH6HTkqBbaB3tI3FOxBWTWqs4ZBXJkITaNj6iXLMCC8dvHUM3yia87xcQddRogffg/Y6cj+Vv6A6nHk7PgUJO0Vf8NCuEJsNITGPyEU0P3FWox93dggLF2TU9oomnOfr6DYVMcXrS9MHU7vmzNEkRuJBbk6+pxyPXg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHi+3rIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHi+3rIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF47BC4CEE8;
	Wed, 23 Oct 2024 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706421;
	bh=GC5YOYBRx+gZl5V2Ks6B0SwBBanF3+LpkxO9ECEL3OE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gHi+3rIWTAlYmZiI9E/LBenZ+HjGozLX/pfewYaJz9B8m7hafF6Ty8/iUVtYeBitE
	 CkOE+uo4sB814xC1iBshkTIqcMr2M3PjKqabpM5VU2TbEzFInA6+IH6R4EaEdw/3MX
	 uB0Hx7u0hnvXBKKyuP/HjBd6tXJ2S0OYgZYiUgI9Krbe5yXUrZgAcVJRTZsQKSBXmQ
	 RsR+YPcnwNHaGvIkQZQZxN1Ea0S8wsJNP6p8iagEY8D9B8mexyMQFJ8igCivoN6PLQ
	 uezCIihveURVpG5kmgX0ysdYdKML6IebvN5ZPWLNeS1RxCiGqCrFKuGDTwgNgAu/x6
	 kqqNtQgq+UNog==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Brian Geffon <bgeffon@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20241016190009.866615-1-bgeffon@google.com>
References: <20241016190009.866615-1-bgeffon@google.com>
Subject: Re: [PATCH] perf tools: sched-pipe bench: add (-n) nonblocking
 benchmark
Message-Id: <172970642080.1242473.4539711950671023449.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 11:00:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 16 Oct 2024 15:00:09 -0400, Brian Geffon wrote:

> The -n mode will benchmark pipes in a non-blocking mode using
> epoll_wait.
> 
> This specific mode was added to demonstrate the broken sync nature
> of epoll: https://lore.kernel.org/lkml/20240426-zupfen-jahrzehnt-5be786bcdf04@brauner
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

