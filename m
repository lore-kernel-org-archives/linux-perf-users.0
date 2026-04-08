Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A22494F0;
	Wed,  8 Apr 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669541; cv=none; b=MPflZ7zoAAyoIvPxnp+KM3s+HSYdDDcpRVetd+U5sXUYx+G1U1hSfz5MP2s7o8/kTCNu1o/BkJIwgLNtsasUaAQxBttPxYKs0w1lnXJ2wta/xvLR/d4Xe4TKCtGzojC8vqnZO7U05z2R9CuEcSktUlztc+yTylbPf/b1sOvU95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669541; c=relaxed/simple;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMwMddblpYiLT6G0ddZBrGZ62b762vCkD6Wy097jTV+JyEY5YnwG8QllMvaXYccTeIyVnhx1v6bnbt+firQDhSofzmG/xGO+DOt67oVPNQEWq8buNAnJMIi/VC9YLeSHnj5MeTThl7nGBCtRwmJA8ROyahkRUfFEHsCK9yV0B2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYExXXq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYExXXq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732EAC2BC87;
	Wed,  8 Apr 2026 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775669541;
	bh=EShclxNu6pRrud94k4SQiZ8VTYXHzEfH6c2jhDarHLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYExXXq7mDUvZOc90zJJWToCoJprSQLzYsRo/6/2rS2DI1ow/+wpQTtlsv70he46o
	 EoBzhmmSGzC3OIqi41n6EUM0nOjd4GslZmqVGezAYQz5iWG8RCvsL5mNZxVxGJN/qM
	 t3TJPeSg4nu8nCGp8FWAvXx+GszjPBkssawdnBDNuRMU25TtFSW8GNISJw4RAh60lC
	 +Eybg8LTzfmzKkMhtmkTWYYs+axP6mxb5ltiR/i3KE5YM3OQK5/Hvor3wH3FWn/ybd
	 f+UWz3hmfAeRYNDVMz1Qt+AKoAlonHRj+pZyYvLydw7g/wwPmPeTeYPUDfV5P+9htY
	 PIxzpt3/TW+eg==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/8] perf symbols: Make variable receiving result strrchr() const
Date: Wed,  8 Apr 2026 14:31:56 -0300
Message-ID: <20260408173203.96700-2-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408173203.96700-1-acme@kernel.org>
References: <20260408173203.96700-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Fixing:

  util/symbol.c: In function ‘symbol__config_symfs’:
  util/symbol.c:2499:20: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   2499 |         layout_str = strrchr(dir, ',');
        |

With recent gcc/glibc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index b4b30675688dbda5..708375d67b85fd1f 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2492,7 +2492,7 @@ int symbol__config_symfs(const struct option *opt __maybe_unused,
 			 const char *dir, int unset __maybe_unused)
 {
 	char *bf = NULL;
-	char *layout_str;
+	const char *layout_str;
 	char *dir_copy;
 	int ret;
 
-- 
2.53.0

