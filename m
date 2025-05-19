Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05403221544;
	Mon, 19 May 2025 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690918; cv=none; b=XyQYl12fz2upscQt67Sluk+8H2tHrNblMXs0t1Ibcee+f786nXbVm6oOw56IYgGmR0HvbBonUeC7veuhnUCmKRs+wfRx+11bPZPCtxqRolh5umJmT5sPPmWaWIgFB5mcWMbx9xomyvDjedINFkykWHgGd17iaXrfBX7LtTO0q+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690918; c=relaxed/simple;
	bh=aW1bwa5rZ3qUdauCH8SmNmXYhQ11h29sIlhqUxa2sNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvZNQrXXFKPaYlQ0EMTz1Nk9+DkggfHqh1ZmsQjRonezvjqRDsemht4e+nu3XPviYNQ0tntKE0Py2XFnXNqgyGw/6lxZcX+/oSY69Vry3HGGvK1rPIoyTxZM9A1IAUZsDQ+fTHFzgTmjFkiLeISEMIjsxg1k8DQsaIJgiq/Hyhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNbFEd+0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNbFEd+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3B2C4CEE4;
	Mon, 19 May 2025 21:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747690917;
	bh=aW1bwa5rZ3qUdauCH8SmNmXYhQ11h29sIlhqUxa2sNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNbFEd+0dQ/E5IEspZAO2uoCZt0PALi6KAGs+Yk0lUAoMflyAHwo9z09/zlNcMjuy
	 ifZ10gu0+HiGfW+rPI5d7Ss0cmiRftcSkv3ZET0oObF6W5hPbmtDInqrqfIiccuvZa
	 Bna1lv3ctK2BHsvSTfTsqC22eK2V+s8UIOwBpDnhVMkc+NnI+H/qsX0kOmMaDMLLMM
	 ooK/kZAGKOtmS0IV5kv60XPl8XIZzCSL3eu0w3bWxBTT7hl98HvtZ9bUKyovt6kjCb
	 FggWA+EbLOs1qJYczgdbmerbQeLm3c4VT2VUBDTc5JK0347eSSBQC/sST9wAXy7y1b
	 960baq0IuPxuQ==
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
	I Hsin Cheng <richard120310@gmail.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 5/7] tools headers: Synchronize uapi/linux/bits.h with the kernel sources
Date: Mon, 19 May 2025 18:41:24 -0300
Message-ID: <20250519214126.1652491-6-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519214126.1652491-1-acme@kernel.org>
References: <20250519214126.1652491-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes in this cset:

  1e7933a575ed8af4 ("uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"")

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: I Hsin Cheng <richard120310@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/bits.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/include/uapi/linux/bits.h b/tools/include/uapi/linux/bits.h
index 5ee30f882736cbd1..682b406e10679dc8 100644
--- a/tools/include/uapi/linux/bits.h
+++ b/tools/include/uapi/linux/bits.h
@@ -4,13 +4,9 @@
 #ifndef _UAPI_LINUX_BITS_H
 #define _UAPI_LINUX_BITS_H
 
-#define __GENMASK(h, l) \
-        (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
-         (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
+#define __GENMASK(h, l) (((~_UL(0)) << (l)) & (~_UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
-#define __GENMASK_ULL(h, l) \
-        (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
-         (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
+#define __GENMASK_ULL(h, l) (((~_ULL(0)) << (l)) & (~_ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #define __GENMASK_U128(h, l) \
 	((_BIT128((h)) << 1) - (_BIT128(l)))
-- 
2.49.0

