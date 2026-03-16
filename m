Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A4368291;
	Mon, 16 Mar 2026 22:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700065; cv=none; b=BBipaTLh8+EcBHn8Wif3xF0cqF7RefoA2Ueneo7n+BiztxrYQLoVBhCq9lELkB4f9TZvVL5ojBF/kb0RqK21wT/+WQ+CtTsqoi1MbQCvDeaQX5Ofj3YMOw3ZHG3f91bH0NI7OtDZX9S055SFAeTkackgF0m1ReExH8ubWmVRKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700065; c=relaxed/simple;
	bh=OJlcpQpHkNiFDHBKElKokhr6lSjmnGtG6ejDF5GDiko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbFvQd0r41fCKjkYnuMP0wOxjufSrTwAG60rHS+5OzlCSMaFRnWaqCGSuedobtqkVRDIt++b2czZxMtzxoe3bJV2QbPylCsE4HTozWUf2pm2e51R+McDxIeMXLsiI1nGHJShO1wnBxyYymZuJRsYR+O1j7+/BJynFgTErXIC7u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m4uk2Nex; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m4uk2Nex"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773700062;
	bh=OJlcpQpHkNiFDHBKElKokhr6lSjmnGtG6ejDF5GDiko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4uk2Nex3xyIREXtespm+kOv3CAz3sfNvC1O1sjYFKn9tgTAdBreqEaPKVoehtg6C
	 4eOUxGWjxYznoAJZ8QN4yABHlOZgj6kHqKd39ttdiecKPW6ycTZN5++6RFMjxJz37U
	 CXfNsEPClShOsReniYlLhZmWzXfCNXg9ci4slqEE=
Date: Mon, 16 Mar 2026 23:27:41 +0100
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
Subject: Re: [PATCH v4 29/30] selftests/nolibc: Append extra cflags
Message-ID: <aacd52ed-4ef6-49f1-90a4-0affeea908e6@t-8ch.de>
References: <20260311-tools_build_fix_zero_init-v4-0-9e35bdb99cb3@arm.com>
 <20260311-tools_build_fix_zero_init-v4-29-9e35bdb99cb3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311-tools_build_fix_zero_init-v4-29-9e35bdb99cb3@arm.com>

On 2026-03-11 08:29:54+0000, Leo Yan wrote:
> Include tools/scripts/Makefile.include, which may provide additional
> flags in EXTRA_CFLAGS, and append to CFLAGS.
> 
> Since Makefile.include already defines cc-option, remove the redundant
> definition and include.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/testing/selftests/nolibc/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 0370489d938b540721a4fb814ebb68c463760e73..d1a9c1d5988bdc6a8778ef418aaa4c5ac1d26a10 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -3,15 +3,13 @@
>  TEST_GEN_PROGS := nolibc-test libc-test
>  
>  include ../lib.mk
> -include $(top_srcdir)/scripts/Makefile.compiler
> -
> -cc-option = $(call __cc-option, $(CC),,$(1),$(2))
> +include $(top_srcdir)/tools/scripts/Makefile.include
>  
>  include Makefile.include
>  
>  $(OUTPUT)/nolibc-test: CFLAGS = -nostdlib -nostdinc -static \
>  	 -isystem $(top_srcdir)/tools/include/nolibc -isystem $(top_srcdir)/usr/include \
> -	 $(CFLAGS_NOLIBC_TEST)
> +	 $(CFLAGS_NOLIBC_TEST) $(EXTRA_CFLAGS)
>  $(OUTPUT)/nolibc-test: LDLIBS = $(if $(LLVM),,-lgcc)
>  $(OUTPUT)/nolibc-test: nolibc-test.c nolibc-test-linkage.c | headers

The rule for "libc-test", which uses the standard $(LINK.c) to invoke
the compiler, does not respect $(EXTRA_CFLAGS) automatically.
Is this intentional? It also affects all other users of lib.mk which
don't have any custom cflags handling.

If so, there should be an override for the "libc-test" target, too.
But if I am supposed to pick up this patch, I can fix it up when applying.


Thomas
