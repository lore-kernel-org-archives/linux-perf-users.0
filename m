Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407D238E5D2;
	Mon,  9 Mar 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094861; cv=none; b=jy45Q6/f3aasdN2qrVo3GKb8Nt2eitgkbSBqxtUgYHfvMKFHU78GmUWqQuHgr9oYzkYx08T1N4Yfyhr2Lab61A/ACJguYd29zA/gUqHmDgcTGxjM37ma4G/3xk8bRwKTREpDnDfA0OgGV+v/61BcXFTIky3lKoGFQdTxpcO/tdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094861; c=relaxed/simple;
	bh=cPpaWJQ80q+Lffa6Wa0Eh87ldCBLbEMQduRkLHgrlQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWkc1b8JrfMkgddzPyJleBl1dAXFP0y8jfSR7UsxWHJF50NKY6RzeQoGp3q6J6UYd2QKEwpDICnf+O0SwOla2OomeLe5moiOqECTD7s0ubX/IfpfHYr4BZi/sX/jM0XJ4a9qxJA2dVxrenpeC+Jfrh+za2DUPQM/uGLYqotytw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l4FtqkE2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l4FtqkE2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773094851;
	bh=cPpaWJQ80q+Lffa6Wa0Eh87ldCBLbEMQduRkLHgrlQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4FtqkE2r3xNDU+YNU5fDpID5U4KhRcECi077BNVvuAQ7eHjVs7AGtsG5ppDmyH2R
	 DsU/qkDlIZ7U0BC9t2/AyTsfKeE2mUMLWGDZ8kcUnHC8pjcPnPoo0goxIom0ZuZtIG
	 McB7anzqo30tlykekx0wC1giSfEHW6i5oc5PPb7s=
Date: Mon, 9 Mar 2026 23:20:51 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
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
	Willy Tarreau <w@1wt.eu>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 18/30] tools: nolibc: Append extra cflags
Message-ID: <a23c078e-e057-4e2e-8c85-945cb61a4f88@t-8ch.de>
References: <20260308-tools_build_fix_zero_init-v3-0-6477808123b7@arm.com>
 <20260308-tools_build_fix_zero_init-v3-18-6477808123b7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308-tools_build_fix_zero_init-v3-18-6477808123b7@arm.com>

Hi Leo,

On 2026-03-08 16:46:23+0000, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/include/nolibc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
> index 1958dda988954d8a604b28f5feb75ebb67ee2e14..b7f0385ccba14fdaa08aab6192acf0296b47cdbc 100644
> --- a/tools/include/nolibc/Makefile
> +++ b/tools/include/nolibc/Makefile
> @@ -105,7 +105,7 @@ headers_standalone: headers
>  	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
>  
>  CFLAGS_s390 := -m64
> -CFLAGS := $(CFLAGS_$(ARCH))
> +CFLAGS := $(CFLAGS_$(ARCH)) $(EXTRA_CFLAGS)

I don't think we need additional cflags in tools/include/nolibc.
The only thing this Makefile does is to test-compile some headers.

>  headers_check: headers_standalone
>  	$(Q)for header in $(filter-out crt.h std.h,$(all_files)); do \


Thomas
