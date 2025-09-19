Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF172BEC5E;
	Fri, 19 Sep 2025 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316034; cv=none; b=mdcgRopDfD4fHM1JGthMgD3oXShnkYBw1Eia9LTy5ZiAyzlicm53rFvH7jphDkVZjPLOGvPMHnAJSLmtvV16MYE8YSE2rSvEGNiYAmNk70IC3EuXSKvB24meiOG2KBkHISjFqycx8rDlPaMLuwDGs+pglbtK0lWAm9goRzW7ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316034; c=relaxed/simple;
	bh=UR3s4Ebp3EGiQYKXabOa8Z3IzeZesJjuj+BGhfF6Z2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3a1miuicnjwCiwcTjcwkGokylHvLbJ+2j3PNGXaEsuYFKkO8hDu5yDjaE+qD2xYl3326FpBzoSLPwqINURsHovAIhsIIMuHHrri0inJNJUFQmhajDyfO9HhhCS5wMZvu5jXMeNfAd/RWb8wM4OjK5VcRSdpE/X66LThMWJKg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgiQbZlQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgiQbZlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F59C4CEF7;
	Fri, 19 Sep 2025 21:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316034;
	bh=UR3s4Ebp3EGiQYKXabOa8Z3IzeZesJjuj+BGhfF6Z2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgiQbZlQBPme+jkZa5Txcm7vvd6tR6oixPn4o9FS3jronEL+OTCRswBkyeFGW6DBC
	 7G9Q3gZYynxBqFEueIkmPSLFEez8/DLe8aKOsgdjmNIPu9Yu8YMTAjKeMgSr9XVLZa
	 awyrUoNxVcf9LjKukpGolQiK+7RKmHxoLqKMiyUv7Lqsl6zDgTr01K6kTtrQ2lXfU7
	 Z8CYglfQefXwIlJmMgs6LSNHmo11Q2e9LVXlhp7BJyLqBwuyKWyW0cz3NX4KBvnPiE
	 0bUzQPxjwvXDCcAbRNvL5/Ww066t//uDXIaQlLoij/+JzuycpQrUP+urTr8GJ1wswN
	 3wM2qYz1lplfg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 2/2] perf bpf: Check libbpf version to use btf_dump_type_data_opts.emit_strings
Date: Fri, 19 Sep 2025 18:06:54 -0300
Message-ID: <20250919210654.317656-3-acme@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919210654.317656-1-acme@kernel.org>
References: <20250919210654.317656-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When building perf with LIBBPF_DINAMIC=1 on a fedora system with
libbpf-devel 1.5 I it was breaking with:

util/bpf-event.c: In function ‘format_btf_variable’:
util/bpf-event.c:291:18: error: ‘const struct btf_dump_type_data_opts’ has no member named ‘emit_strings’
  291 |                 .emit_strings = 1,
      |                  ^~~~~~~~~~~~
util/bpf-event.c:291:33: error: initialized field overwritten [-Werror=override-init]
  291 |                 .emit_strings = 1,
      |                                 ^
util/bpf-event.c:291:33: note: (near initialization for ‘opts.skip_names’)

Check the version before using that feature.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 2298cd396c4235e2..59f84aef91b4a2ec 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -288,7 +288,9 @@ static void format_btf_variable(struct btf *btf, char *buf, size_t buf_size,
 		.sz = sizeof(struct btf_dump_type_data_opts),
 		.skip_names = 1,
 		.compact = 1,
+#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
 		.emit_strings = 1,
+#endif
 	};
 	struct btf_dump *d;
 	size_t btf_size;
-- 
2.51.0

