Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133E420468E;
	Tue,  2 Jun 2026 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411374; cv=none; b=uPeG7Zvj2W0j75OjADt5TzDsxB0Xjp07ARvIm//HCjB9+3S07AeFKu0clrqRqGcfIr/mS+b289lLxA5i69dzn/2PwX8llI1zq8Eor61kok9KyPlZjb2SUTRqcf9+cfuSISSKNGz1mTACmMQQo6F+q4SMj9kjS4TYp63frxE3DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411374; c=relaxed/simple;
	bh=2HoqdzVaKyMOdHF+5ZyEJJUITN7f8BhS5qzwI6ubjPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TdIpna3Xre+yxZ69S1zCwu/6DLcm3oUv8Qj69crOIbRVkFIR9hy9rD3rGKQZQoUkjqxUgfXuhHSqdJ40SF9h5ERRr2n5UJ71bTrsVTSjpQoeGgQvugD0aFv8wXrM3Vk7Doxso1kbeE/IbZNnWx4fManHdABWPWVcSFYcp3OoHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lTu4v/HF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lTu4v/HF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E03357A;
	Tue,  2 Jun 2026 07:42:47 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7D73F632;
	Tue,  2 Jun 2026 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780411372; bh=2HoqdzVaKyMOdHF+5ZyEJJUITN7f8BhS5qzwI6ubjPw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lTu4v/HFTpjOfSEvoNxvln5r1WVvThxLL1wUrakXVR7gd55bPkQY2iWEnCh6z0tYd
	 zbeJwwn0U8G0tAxLYGtAqQQ7yCnySQAm556jA90qS/nfQfXoKUAIUjiT+YHNG7mFDh
	 wkpMdL455xUDTGqiH5ahUeyTWfI/7UbZlAi17bQg=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 02 Jun 2026 15:40:47 +0100
Subject: [PATCH v7 13/23] tools: hv: Append extra cflags
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-tools_build_fix_zero_init-v7-13-631baf679fe7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780411243; l=747;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=2HoqdzVaKyMOdHF+5ZyEJJUITN7f8BhS5qzwI6ubjPw=;
 b=ex6dIZZzXwUm/U8W/8K/maO3rF/F7qJ9Y6DwAzhpgQtrgSKFpsxLJkZ7G8MHIkQoI/hLv2AYX
 EKAUE4cGorTAasStSCAG/rMLD32TjnFkkDj3YzQ2101TY9gc6OBjUvT
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Append EXTRA_CFLAGS to CFLAGS so that additional flags can be applied to
the compiler.

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/hv/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 016753f3dd7f61e88d91dd5dc939ad66f8485acc..9a141d1a80d7b0e2b971d5a4adf67e2e7a65d3f0 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -18,6 +18,7 @@ MAKEFLAGS += -r
 
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
+override CFLAGS += $(EXTRA_CFLAGS)
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
 ifneq ($(filter x86_64 x86,$(ARCH)),)

-- 
2.34.1

