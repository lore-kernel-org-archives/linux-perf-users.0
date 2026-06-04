Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC914280CC1;
	Thu,  4 Jun 2026 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538590; cv=none; b=mfpozc9dLUqa10t9R95LjNt6ATcLTDvllq5nxySoLpRvcVxTGa+8n9C7UUeOGBwlW9xQjX9FDyS5MaE2ufTvKlJLhqBK/IzXwg3t0IVPQAOx/vrba1qnJZsH62Ahs23MCiNofavJD3jVCVTo3SDJeOTgLIUKe7nzWVamVhXa46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538590; c=relaxed/simple;
	bh=V1HC3NO0IVyYJqEZ4uh+kRJRgytJAdfdldak6/UcyYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwf3Ci65HRTUzPMcIBye+CO9lBEiJe5qD6h2zrLGj8wZCZbng43slxGqjRJeujpRD0v6udGb87PtACWwgcyZrZOMzLCiXK45Xh1XxK+qI+wbp6+kaJQEGTz6mKbebxMPRvLVJy9wZ3rpI/F52iGyuDYo4NAkDSHz0t1XUuQUNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwgGbogQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwgGbogQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208511F00893;
	Thu,  4 Jun 2026 02:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780538589;
	bh=5kapYDcSfKOdhK1XTAL6xdCTPTkQP9mzXkK+CmD6YJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iwgGbogQqUxTAtjvfPevfzYMzMC4MDd/zNjZcaPl/wJ4cueU0l2IzjYIrAryDD41f
	 Xpxsz/PbOfyxf8WQbPE4lSksLdc/8Omj3jAAKCLcZ4fqbuC5+JfJdfdhz9eKYhrKmY
	 LVwKavQoseWH0n9PuNQb8x2uSTIChk6RZ4+Icirt4z6ozdtDbEgYCcsX24lMmpwIrS
	 VgUQmRCBlZJEvL2y3QCMXnTltMvZZmXlBYq/gYRe7SnkW7E8uZ6NAnZT20ymB0FAUO
	 r7lf8ed8YZYKUW4FeDvx3dpBeY7mOh7arjNaANovAUDQpMYU5OnhLwemYS/Jfk5JrL
	 /jau2MAgPOkJg==
From: William Breathitt Gray <wbg@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kees Cook <kees@kernel.org>,
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
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 10/23] tools: counter: Append extra cflags
Date: Thu,  4 Jun 2026 11:02:35 +0900
Message-ID: <20260604020236.889250-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-10-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-10-631baf679fe7@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=252; i=wbg@kernel.org; h=from:subject; bh=V1HC3NO0IVyYJqEZ4uh+kRJRgytJAdfdldak6/UcyYM=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFkKd1ZdzFFkUd1+W2XrdQa1Ynul4Mmz+b8eFrHJeXzun UlzvaZ3RykLgxgXg6yYIkuv+dm7Dy6pavx4MX8bzBxWJpAhDFycAjCRH9aMDF+0olJeL39l4K/7 rWQj3/zHOzRs3uwTjZDdMvVHjrfooheMDD1V2k/31C96WchfYSuWrn6LhVNEd9aONK87a48xLNG 25wYA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Tue, Jun 02, 2026 at 03:40:44PM +0100, Leo Yan wrote:
> Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
> the compiler.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Acked-by: William Breathitt Gray <wbg@kernel.org>
