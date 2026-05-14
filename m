Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4C1F131A;
	Thu, 14 May 2026 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778735243; cv=none; b=IpP2eyquLCC3StFXiIRXmQf/nnjwHX5lzgIxkTTOuZk3pb42u9e5/Y2d9+UwrjcQ910nWPcSJjvZWdZ1n3en/wb/1L2SfWCXhyF/QeAYHR44Wp5Emnk3ty1WlZALTeblP4FCKps1Hjn7IQSm0mKSZArjL2X2V78IiIKtLAIatOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778735243; c=relaxed/simple;
	bh=m1VX1+Cs1y6NAynCJMAnljF2dh+IIFzjeI0LtRTOziM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qgrT7Q6jEIKbv1WXFzN4jWN4XjboXOm+IgYl2GPuYigRHQwv/wM0hDHymdMYavKpKMidlMMEMNdg+eT7baceNnFR6madekh43vMKbEpbx/TzE8gaty3kj1tSg/kZ/NcTkgqJjQeX6kU+MALtcLMLbpIuBpMumETNvHMaZZJgj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=E/oh4tN/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E/oh4tN/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7ADC51655;
	Wed, 13 May 2026 22:07:15 -0700 (PDT)
Received: from entos-yitian-01.Arm.com (unknown [10.168.197.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 951093F7B4;
	Wed, 13 May 2026 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778735240; bh=m1VX1+Cs1y6NAynCJMAnljF2dh+IIFzjeI0LtRTOziM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E/oh4tN/nyhRAFt0FylqFv26rxNYr0RLbwJycvUtCBR5EOuw4xnrNUwGQFUl8Fdnr
	 aMaaYdqq9tcsYZ8Usbbj9Jd4MTN28+Kac6h6lxa7WKAFMWPWsLaVF2fDlTou0GExN0
	 K25/GUzhMJfdsgdFVJlXBsG+2zTNhbDSt5LZ5Ziw=
From: Jia He <justin.he@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jia He <justin.he@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH 3/7] lib/math/int_log: drop WARN_ON for value == 0
Date: Thu, 14 May 2026 05:04:51 +0000
Message-Id: <20260514050455.2954509-4-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514050455.2954509-1-justin.he@arm.com>
References: <20260514050455.2954509-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intlog2(0) and intlog10(0) already return 0, and the math-int_log
kunit suite passes {0, 0} as a valid input. The leftover WARN_ON(1) on
that path produces a backtrace per test run. Just remove it.

Signed-off-by: Jia He <justin.he@arm.com>
---
 lib/math/int_log.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/math/int_log.c b/lib/math/int_log.c
index 8f9da3a2ad39..8585207cbe7f 100644
--- a/lib/math/int_log.c
+++ b/lib/math/int_log.c
@@ -59,10 +59,8 @@ unsigned int intlog2(u32 value)
 	unsigned int significand;
 	unsigned int interpolation;
 
-	if (unlikely(value == 0)) {
-		WARN_ON(1);
+	if (unlikely(value == 0))
 		return 0;
-	}
 
 	/* first detect the msb (count begins at 0) */
 	msb = fls(value) - 1;
@@ -116,10 +114,8 @@ unsigned int intlog10(u32 value)
 	 */
 	u64 log;
 
-	if (unlikely(value == 0)) {
-		WARN_ON(1);
+	if (unlikely(value == 0))
 		return 0;
-	}
 
 	log = intlog2(value);
 
-- 
2.34.1

