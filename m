Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F748399D0C;
	Tue,  2 Jun 2026 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435668; cv=none; b=GR4dHwXdasyvQSFhGjbLldc+0z8ePI/RFpxinFU3dMJaFM07TpZf8Y1a0DaaAIVJOmVaZX6oNlqIiUiMBHDtomIQ/tcjWZow3T8O1ElRR+HQ3YktM6Olhb3bwOpLJuVdTILUamN7UpaF6rc1xEZ1Lc4A21e3ESBGD5JHNVPQUhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435668; c=relaxed/simple;
	bh=CqLzbxZx9AH9FzAh4LvVUVVPW2K6cBHPv0ACAyIlCFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFjC5JSdKbRg0fBDR+Du0QHvoMMZh6PehUIg+UEp5JrvqNffk4NPFTZaN+vKH7vzqjM9TbaNoTPGgsB6Y3PcKcVSH0FUZolR7kcXDU9mHpv66+P2HG/iyGTwRRVelbLUSXgLu8jkL7H/E8dIapuW5XUiCTQc/NSfml0abvTAm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGbxiqAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGbxiqAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6AD1F00893;
	Tue,  2 Jun 2026 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435666;
	bh=5Im0aFGY86Ref4h5NVxgo8G6mRjIHIC6V6c+NmxpZ7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oGbxiqAf5/9Y37S9HurefgORKKsuPw05nH9IaXGYJ3uBLDnVOVjyszYkL3c3RZkQz
	 z65VmHRuY4iQzjYrBAE+acFqfOFxAQpDyBqtBSUKaRJOFsYXdtrDFHcGySOm6LKDJA
	 CEptzPpFcny128FUjz37Rnqx2lnQnZhFJrHkRkpdWDLMiVBw+ZkpHnd4omyl47Gx0R
	 m1eKvM4EeQl6Ch3F8UDCKTQ9HcX6Mu2HPJdJseugvn4EdlvXaGkz/IELAptZhP4Sg0
	 FO/geevFdVsri9FF+Y7G2XCHLp50NjD8vA2Dto2phqkcXGf2owpAQf04c9thU9RiUG
	 HbJJKyR+J5e+w==
Date: Tue, 2 Jun 2026 11:27:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
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
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 19/23] tools: sched_ext: Append extra cflags
Message-ID: <ah9K0WzLJz3qL_cu@slm.duckdns.org>
References: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
 <20260602-tools_build_fix_zero_init-v7-19-631baf679fe7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-19-631baf679fe7@arm.com>

On Tue, Jun 02, 2026 at 03:40:53PM +0100, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
