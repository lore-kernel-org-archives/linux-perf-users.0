Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2403A9DA3;
	Fri, 13 Mar 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408836; cv=none; b=HGm19+hjCloCOm14LALJ3GE7bJ5sikWZkqZB7VUrc52k8oXV+/cn//ks2TtRD2/ZQSmVV9+BVqlip8wIr2uZsKqFxpE8AHqmvGB4gVba9YDUpptMeUjJ+40Oct4XtAHlFsCYEcDmrKQjodxAITtSsep9P0pz8A80XIS1DTFCBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408836; c=relaxed/simple;
	bh=AsX3C2hlUvkqktdPj7+pB/3rNjxKkhPkB+9v9ZcQKf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y01xcnoSKNUZUsz6Txz+XnzhL2+6TSAm4WRRYNmEvhCyd5rdnPdyzBbwyj7IJQK9xRLDSf9Xz8udzf5uLhysWTRDA3dVNQySyjIXITz+/kQ0bKTJCgBXBqRu+jcBXrdTPxLQf8d8GudZ5m8iR8mSiYrdmNZ7Q1NbXqrCk15uVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyFxil+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyFxil+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98853C19421;
	Fri, 13 Mar 2026 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408835;
	bh=AsX3C2hlUvkqktdPj7+pB/3rNjxKkhPkB+9v9ZcQKf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dyFxil+nKP2AhM6je5QpP0RaFX8/v/cDk7TTmgWg0TVuLcn9ryIJFFOKybiUVi50U
	 uvdQc8Y6kpDTi0BHcpPulUDB2ubvS6FkKhBDLSu9E0be+AZWlWih7uFLO3+aUElFmu
	 13ruL9CC83R8seUZq5gEOLGkDUjBcgQgaUXRI3n/91MR+gcPDy31cMuznMDyMbXhVH
	 bNDvCk/LVVtkfJBhMSijeGJi0YyQ09xstTBjmqtsJbqV6hlwX23eVom1+8lBf/DwiL
	 2LWG0BN+/BCF79835ZbyBurws49fKNyB2/jDJGmoytzZtrwJeDPyrFb34LppYcAbh5
	 csTNrevq9Mhxg==
Date: Fri, 13 Mar 2026 14:33:04 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	William Breathitt Gray <wbg@kernel.org>, Barry Song <baohua@kernel.org>, 
	Qinxin Xia <xiaqinxin@huawei.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kent Gibson <warthog618@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 28/30] selftests/hid: Append extra cflags
Message-ID: <abQR8dXwrbX47SEQ@beelink>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-28-9e35bdb99cb3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-28-9e35bdb99cb3@arm.com>

On Mar 11 2026, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/hid/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 50ec9e0406abaf316fba232c5da1967e27d0fa9b..686c5f79ca592c2ce94e37b39ab5c3ebe8483f79 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -26,6 +26,7 @@ HOSTPKG_CONFIG := pkg-config
>  
>  CFLAGS += -g -O0 -rdynamic -Wall -Werror -I$(OUTPUT)
>  CFLAGS += -I$(OUTPUT)/tools/include
> +CFLAGS += $(EXTRA_CFLAGS)

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

>  
>  LDLIBS += -lelf -lz -lrt -lpthread
>  
> 
> -- 
> 2.34.1
> 
> 
