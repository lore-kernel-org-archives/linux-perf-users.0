Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB361C54B9;
	Fri,  6 Dec 2024 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518122; cv=none; b=LFTg4owXMaNy3iF/cpVIMoHKAxoGFyQYTqiSU01+g2JnxMZDT3e06PXIHO58xmXtv3TXHfZckgX64lRXmJd9dT2G24hT/VfEXYviv8BP9wtp8IAYktICbxYDaQbGQGsAwzlJdk9GtB3pt0HN4IFQq18asx9GGv73MdKNH8sF+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518122; c=relaxed/simple;
	bh=f9P/jPt2Xk7eLs1J+wW+EbnV/Hcd/t5P7gPqvx1H6XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYCpPNRbVx4OMRjvUcu17Zn6kxC1nJDnGaeVbNu9WeMa57sfliWlF64Uh4Q+ChnIJzUZ2R4BzSo/aACLJ3GSuKoXPmGj3wUwT+fD2aROsCkDxAd0/lyOW95Ns2iuEnteJhP1V9DASc0EQf0+SVe+ErAZlzhdVa2AdOU0adjZ3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiSiMadz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiSiMadz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B2AC4CED2;
	Fri,  6 Dec 2024 20:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518122;
	bh=f9P/jPt2Xk7eLs1J+wW+EbnV/Hcd/t5P7gPqvx1H6XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiSiMadzG9sWqB5uPVdsD6fLnDDCA15PEsm5uhrZy1A3qAbrICMZ01aMswaW1lLY+
	 Hgltz610111+BwmpnovyOSVQU8J+bp5xHFdql4fuVfbrWxp4hkrwTQhvEzasu/ojqD
	 pXmE1PgNi+Hw3tDmpR9abHCOlAwKtJ8dQRGNU1GWo24nDzdSQwv4j0c1q9L7nGO9ZT
	 fFjHsroG/Zg8WTSd8MVjFWHwLQstkplUvWyDNi010n4rHKSNisqbbAry3flvUEMy/W
	 MfuOZNzxtiV2Pb9xk9hcs4oLb02iVCrVqTGZnXyvhQg/KMaxjOsZHIwYNdbWZ/cxzE
	 1wazldEoHMKVg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephane Eranian <eranian@google.com>,
	Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Cc: Francesco Nigro <fnigro@redhat.com>,
	Ilan Green <igreen@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH 1/5] perf config: Fix trival typo 'an' -> 'can'
Date: Fri,  6 Dec 2024 17:48:24 -0300
Message-ID: <20241206204828.507527-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206204828.507527-1-acme@kernel.org>
References: <20241206204828.507527-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just a trivial typo, should be 'can', did a spell check on the rest of
the file just in case, nothing more stood out.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 1f668d4724e3749a..36ebebc875ea2d09 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -40,7 +40,7 @@ The '$HOME/.perfconfig' file is used to store a per-user configuration.
 The file '$(sysconfdir)/perfconfig' can be used to
 store a system-wide default configuration.
 
-One an disable reading config files by setting the PERF_CONFIG environment
+One can disable reading config files by setting the PERF_CONFIG environment
 variable to /dev/null, or provide an alternate config file by setting that
 variable.
 
-- 
2.47.0

