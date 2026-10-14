Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A43568FAE
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999272; cv=none; b=Otd8qjexI6NFh2sLGkIydnBchkX3AP/I6CGJZzejFYkTeDS/q0uIrndiT8AU1kPG9JAeZQdeT5tq6BKKCj43r+z3KAZNas8U4lc8zGW6onir7rk6h25Twoo+qcWha/cwq3MuTEz+DGAVw3XCqRsqz8NP8QJ4X80IyQSJtbUwv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999272; c=relaxed/simple;
	bh=rmvkBuVskFV9e0uaXGAhwVaag8Z65mBKAip2mW59AKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lpYmjdhqW46jVwWH7kiPEfwwaTyMQkBDuT+jh6XN9BYvgwcZ/62rFq4vGXdnQh3s+jlzzktTC40uMfyYBL0z0PbbYHD+gDHo2a/CcZQnmvsv0MaqJDwr50/gvJjkNZxYoiGmZmS9Qc2SV8ib7RFcO7ZVPx8q4ibLmXOTx9vI/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=CsNpT7If; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="CsNpT7If"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so38694565e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1791999265; x=1792604065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+3cvfSgStchcIK5VEU5FCDB/45EgYfNTwJxK1Z6ZP4=;
        b=CsNpT7IfgJjD6seMEHJT7omArIo8+ucIedYWty88JZkRBgT1WJeiyNjnRioRD77HCI
         cnUOFWb2/VedGjsv44SP+jOlsbNb5q+7weSYd569oTo7ZUYh21fb51nkY+YtH/Hx4h3Q
         BgMD8VDSZ83JJiKG+5iUkuBNdu8bysUB2ylrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999265; x=1792604065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f+3cvfSgStchcIK5VEU5FCDB/45EgYfNTwJxK1Z6ZP4=;
        b=Y4ogQlU2mhoYkkgugWZ16FIOSvyLF3TA6rRr5+Lt2WS1q5uUht8wBngonfVpccA8ZI
         YUulk5uxc16mXSPUHXgbzY0jCSam489mvwu0jmokxiKgHdbOJ8qHFrvicoR+6IM76GIx
         auo4cAdmym2yioPQfgX8EoVIFdnqPZ6mJGF1uyrCdfMs6fohQNoi/fMru8Oh1F0Hisb7
         e332G65n4Ee5HFgEYrI5w6TccZaWRMf1G+wNmNC3UBME+QhKhVIAwBnFpBF4rH4YosCC
         ZoRZQM4QcxJiCdq64fHvoiIRjxswuYXvd17wpmKN/ucAWEtrSl/s67v7lhU46g7ufhcW
         Hvjg==
X-Gm-Message-State: AFq9FYK7SZQD4Z40YiFVcsoyHebY0biPJDDWLT5Y9j45T7rn0CRM/jHy
	UQCShhJ1GSgERLZSn6BBsClhK1b0ubtfZMupvzF/vcUmoHlo4tzHx09zHtE4+t6LtXA=
X-Gm-Gg: AYBFou3F7+0rmLz6jdC23UBhgkzQoLLxJl6cznswiJ4vs+JtX7KovLP4s+ZeBtPt/jc
	iVIdrHMileoD/taK/oQyeWhapfG6OyXF4oUnnQJFsVDjfF3Fefwab5EuA6C/UJA2g66/Eo59skE
	Fdknh8yIJo6RBqA3nvXObxkz3UBvOc9kkBARXeea3GFLBnOrXjF45QsrLxi1n7CNwLRrS9BrKLg
	KLd/HbifEFLXpOOcRkkaeH5MYBMsVmEKc9+fHF6yOrKY6Zg7f0sU/0KSHOtQfAeMS175APpRxmp
	FTbs9DoGh6LHPVhXGiaBxlz8B+GZ2XrGVi56ZlpDaiPVeuh/ZRmNYnvAKcYN+Qm8gJ0JyynYPye
	a5dETJqT4WBCNy30/MfT5fMmPjv1TOOIN8QdAhRn6sadOg/RLrKSKTiH6kp46K+11i91XZUtXiS
	cRTf9aJy5Q1mRBx3/dK8hDznR8oJdoZE5qOtAiVnIoIWdZthyC6iYf6Yhp
X-Received: by 2002:a05:600c:4f89:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4a1acaa9f79mr118587875e9.25.1791999264905;
        Wed, 14 Oct 2026 10:34:24 -0700 (PDT)
Received: from localhost ([2a00:1358:e0ce:6800::3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm5977625e9.6.2026.10.14.10.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:24 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
Date: Wed, 14 Oct 2026 20:34:10 +0300
Subject: [PATCH 4/4] perf: support zstd-compressed kernel modules
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-perf-zstd-v1-4-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
In-Reply-To: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ivan Shapovalov <intelfx@intelfx.name>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=intelfx@intelfx.name;
 h=from:subject:message-id; bh=rmvkBuVskFV9e0uaXGAhwVaag8Z65mBKAip2mW59AKI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdDVVdHM2x2aGVTbFF6Mk1wO
 VdTR0xMTzd4VTVPdmMxMTZSY29SY3ZHU2RtT0hwZXlibDNxRDNtCitSeko3YTMzL0hRbU96M2Uy
 VkhLd2lER3hTQXJwc2l5Ky82MHNFZHpKeWdkOHR5UUN6T0hsUWxrQ0FNWHB3Qk0KeEV1SzRhL2d
 WbmE5N0JleUJpRUhIdWpkNlk3bVNOSlBudjJtNmJUemhUN092ZFlySm4xalpHaVJxUzNiNUQ5dg
 pUdDZQQXpOdlRNeFRhaW1jdnZkSHowSmoxVkxyYVJ2WGw3QUJBQT09Cj1zTndNCi0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=intelfx@intelfx.name; a=openpgp;
 fpr=04DEA27EEF682F17083D892295D5D5F5A5A5E5E5

Support handling loading zstd-compressed DSOs in perf (in addition to
existing support for gzip/xz formats). This allows loading of e.g.
zstd-compressed kernel modules, as shipped by various distros
including Arch.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/util/dso.c      | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4d5993da9f945..dfdda22becc39 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -982,7 +982,7 @@ ifndef NO_LIBZSTD
     EXTLIBS += -lzstd
     $(call detected,CONFIG_ZSTD)
   else
-    $(warning No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR)
+    $(warning No libzstd found, disables zstd kernel module decompression and trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR)
     NO_LIBZSTD := 1
   endif
 endif
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 42bfe30a3b518..0e8886172e239 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -277,6 +277,9 @@ static const struct {
 #endif
 #ifdef HAVE_LZMA_SUPPORT
 	{ "xz", lzma_decompress_to_file, lzma_is_compressed },
+#endif
+#ifdef HAVE_ZSTD_SUPPORT
+	{ "zst", zstd_decompress_to_fd, zstd_is_compressed },
 #endif
 	{ NULL, NULL, NULL },
 };
@@ -460,7 +463,7 @@ int __kmod_path__parse(struct kmod_path *m, const char *path,
 
 	m->comp = is_supported_compression(ext + 1);
 	if (m->comp > COMP_ID__NONE)
-		ext -= 3;
+		ext -= strlen(compressions[m->comp].fmt);
 
 	/* Check .ko extension only if there's enough name left. */
 	if (ext > name)

-- 
2.55.0.8.g37e2a0019f

