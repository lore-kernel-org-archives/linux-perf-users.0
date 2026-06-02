Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B443F1AA2;
	Tue,  2 Jun 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411401; cv=none; b=VjjQUWAhS+FRy9UVHjMtm+WxnEOBivSj1ZalNizeqV2pheCyGqXd+YNCQwzkH6OQJ5ejILv6RzatGffEHY/NYLb2d6zNrOtbPKRaygUPmubdKc2+LT2ratvQO1UpNCZqSVyuawXFmF0QiGAmc0bEG55heV0jrTUJWq5bgeHBC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411401; c=relaxed/simple;
	bh=jfPMQMukoDZOL2OvxeLdX83+munt2aPbdkWuPZ1sqGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJG5gu4ibF+GUESPGgfmViUih8zTsYG3fjt4JwOkzLcjNMawxPmTexL7XAll/hfYVMY9ma7jq8sd3TOOGqrjIzB1W1dTWuHSn+uNM6g27xhPJ2Wfcve4oqq1SEkg7hxQldAtmdS9jVvK53o7c2+nXxsjnPVXNeTGc/hL/sGA5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RGcWXYat; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RGcWXYat"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D32E73573;
	Tue,  2 Jun 2026 07:43:14 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A543F632;
	Tue,  2 Jun 2026 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411399; bh=jfPMQMukoDZOL2OvxeLdX83+munt2aPbdkWuPZ1sqGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RGcWXYat2NM8LPQrAF5MQ3I2F8tjxJMhsilOBlR8V2qc8MKkfS3VV65E0IWkmHQ4t
	 UelqzXs2AP5Lkk8wT8vbEIqZJd1Cpk8lrTwkH8sZ0DN0U8TDWc5qiYPGd/ym1Zr1jO
	 JqD0awy88GlRXYLL6xVNEK4A7qjIlwEGyz7ak/mo=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:50 +0100
Subject: [PATCH v7 16/23] tools: objtool: Append extra host cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-16-631baf679fe7@arm.com>
References: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
In-Reply-To: <20260602-tools_build_fix_zero_init-v7-0-631baf679fe7@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>, 
 James Clark <james.clark@linaro.org>, Kees Cook <kees@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
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
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Robert Moore <robert.moore@intel.com>, 
 Len Brown <lenb@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Gabriele Monaco <gmonaco@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411243; l=842;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=jfPMQMukoDZOL2OvxeLdX83+munt2aPbdkWuPZ1sqGM=;
 b=yySehyugf/1SO1lNOh/His1EzgG82GjsloGp7XZFdQ7OSz0wFSpH3T0jnpsaX4lhJa5gmCNVP
 jNLH5FEbrdTCRrJbwKM/iI6NESXZR0xZ7umiPgR2La9y0UFUfKliVbt
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append HOST_EXTRACFLAGS to HOSTCFLAGS so that additional flags can be
applied to the host compiler.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/objtool/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index b71d1886022e9b3d9fde52bf73bd502aa20d173e..182d0ab47a6ce8925ec8618f337d2664965b6c9c 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -11,6 +11,8 @@ ifeq ($(SRCARCH),loongarch)
 	BUILD_ORC	   := y
 endif
 
+HOSTCFLAGS += $(HOST_EXTRACFLAGS)
+
 ifeq ($(ARCH_HAS_KLP),y)
 	HAVE_XXHASH = $(shell printf "$(pound)include <xxhash.h>\nXXH3_state_t *state;int main() {}" | \
 		      $(HOSTCC) $(HOSTCFLAGS) -xc - -o /dev/null -lxxhash 2> /dev/null && echo y || echo n)

-- 
2.34.1

