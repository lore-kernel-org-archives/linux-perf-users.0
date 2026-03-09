Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037638F65F;
	Mon,  9 Mar 2026 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051461; cv=none; b=dRq8fipRagy2InHEImwNIgQHx1AANf4lGV3TLtyoDkLZRGylPOu7H3Kw8w1K4jFNYQxH80j+LweDcbV+W3PXoevaqUBYs0E4BasiOgrQFGNmQlpi1npVcyr+KcxEiMjBR0rIMC0lu/4UPhEYwhN6wLdqnBDFok+CoRPapG2sWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051461; c=relaxed/simple;
	bh=h17xRooob/NjSPrlNjlltY9eQtTUi8G3SHGUmwObWzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9VumBNum47Lt3JuoQirButTWBU7eNd3n//1NYFUmXMAycSejRcl7Qg5+EbiSs2ijCuzbJqekxrtgvCAB7dSpOqcLwTEmxpEqHeFy5/ZBtyKzWxF+eIohlCcVeVtNPQLg84/A0mNfjB7tQZHOAWT6u0iGD+YRXrjmMPDf7h5l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcISnSBW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcISnSBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB55AC19423;
	Mon,  9 Mar 2026 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773051460;
	bh=h17xRooob/NjSPrlNjlltY9eQtTUi8G3SHGUmwObWzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qcISnSBWeBIBZ8/E3/T6klqoS/HrhPByDqp4ynjbpZNT26WjwIWyyiB6kQ2GCBoJC
	 7lRpQFAKHLrJlufltvydY9o+fPsT81SJK5fTBsWowsJHD6uEAc6GT9gZKwBq7cx2Sc
	 dfM5wSYpPuWluKxR5hxNoJ3AC6TsrgINwsliqk8n7VclULyyjSh1UMgmXDldapD6Ji
	 6MiPvOve4ZyLkKN2Jk0TcBliZAjlfB52HWLttkbyUckBtOqaKX7I4eD6rN1y0qK9Nr
	 cF/woPOUAoQ6K6yic4sUMOVpuiY6tt43tLhQF9uqWwYOxne+k6h0pX0ElJDWH2l8cO
	 dhcKFft+HcBjQ==
Message-ID: <a0e77fec-4271-40a7-b725-ae7ace6eac48@kernel.org>
Date: Mon, 9 Mar 2026 10:17:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/30] bpftool: Append extra host flags
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>,
 Qinxin Xia <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Kent Gibson <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-6-6477808123b7@arm.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-6-6477808123b7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-03-08 16:46 UTC+0000 ~ Leo Yan <leo.yan@arm.com>
> Append HOST_EXTRACFLAGS to HOST_CFLAGS so that additional flags can be
> applied to the host compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>


Acked-by: Quentin Monnet <qmo@kernel.org>
