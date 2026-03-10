Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC7C3D4110;
	Tue, 10 Mar 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165060; cv=none; b=lP3afinlT8LFcz8WMUYPUTllUji92K6SMHfJi2+7bwHJEX3u098OBVtp/SO5GLjvoKi/ESu5EN/gR/T7AyQMxLPWpxJcKrfJBLbZvXR5DHRzqdN+8Xuo6U2Ul6xJFvs7VituIkwi7u5MVHeF8wzJZEkEC5V+SscnqAJpz4onnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165060; c=relaxed/simple;
	bh=WcpIf4jmyVmqqaM72AFjCpjIwQJCn0VVYDwmYUBwxoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3VICnZZCrGKg86pzGY/0E/XQOLpps97xOwGczAg3IyfwbhUv9SrdtBmOZgazYTvmyD8IEmyWP4spYBIP194mxSsSDCjH2aHWuf7G81sYj0XgNGTUvG8bwK8UdUkbx+wEcvbYRP8LDUHZHhBOihiNJYe0C9+KvEufod5MNO3EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1C1A169C;
	Tue, 10 Mar 2026 10:50:51 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81E153F694;
	Tue, 10 Mar 2026 10:50:57 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:50:55 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	William Breathitt Gray <wbg@kernel.org>,
	Barry Song <baohua@kernel.org>, Qinxin Xia <xiaqinxin@huawei.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 27/30] selftests/bpf: Append extra cflags
Message-ID: <20260310175055.GE4153946@e132581.arm.com>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-27-6477808123b7@arm.com>

On Sun, Mar 08, 2026 at 04:46:32PM +0000, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

FWIW, this patch causes bpf selftest build failure and was reported in:

  https://github.com/kernel-patches/bpf/actions/runs/22825654003

The Makefile reuses CFLAGS for clang to build urandom_read, which may
cause GCC specific flags to feed to clang and causes errors.

The updated patch will introduce a new variable URANDOM_READ_CFLAGS,
without appending EXTRA_CFLAGS, this can effectively avoid incompatible
options.

Thanks,
Leo

> ---
>  tools/testing/selftests/bpf/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 72a9ba41f95ebb825d25799c07ba3f0311243e45..29dfcdbe98c781b53f1e87dcebecf2027bafcd5d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -49,6 +49,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>  
> +CFLAGS += $(EXTRA_CFLAGS)
>  CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
>  	  -Wall -Werror -fno-omit-frame-pointer				\
>  	  -Wno-unused-but-set-variable					\
> 
> -- 
> 2.34.1
> 
