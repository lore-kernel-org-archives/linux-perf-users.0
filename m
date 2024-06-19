Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C6157E93;
	Wed, 19 Jun 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822373; cv=none; b=WngyvmvjvfQQopFeFseO4FkU9SIdGTNTWTBjL3RWHzWfzhIF6FbtfA2YmmCtbGorFAyxlGtLHOq6pvsgJBtxJg4pipOlo6x87SghwT+SubJrRHiz53mh8P5rvvUPyQSws46tVzdgL3zUAc0l0mo5CQLfTkvGby1fpwvZm5ixR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822373; c=relaxed/simple;
	bh=ZEqVVV8hma1sBW8JEOiV4irpaUFqN8hKsPQLx0n1r24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdnLcbE+YlXTXuIexIHwvFu9GXIUmGfKrVSxSyd9h7ssYFM4R1PDw6MwCTK+k/PUHi6Z5qCvU1k6MPX+Xe6Y6lN5CJ42bLJzxwsokWHrJMkuB0WAhD5SOpPrQt169YT5KQ0qKOI6WjWBP+RnN7NK30G8c5R4z5qeanePtawaED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyDTbCdE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyDTbCdE"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-705e9e193caso100166b3a.2;
        Wed, 19 Jun 2024 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718822371; x=1719427171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSSF8rCLCqfCwCteTtDEL5pGKT4d+aFWwNIMPEJ041A=;
        b=DyDTbCdE+UJKHUwswPtf94oa8qrOLF6HLVhoeoLbx7piyvGUV8w8f9nMm3iQSwqurp
         UBqVweWY16hNIkjBe2WJcT21s/9UOZ6PoWov2jx5pzKPQORVDtWeYXLTmk9hzbXg0llu
         SXBeHiRiytBoJW7ettE1x4ZefxxtQS8lUG67rUtW3VLkkje7spAQxhC4UrKmDqsbXlXG
         YBMSI0PBCEOeij+cI60akS3qeVKVsFt9IBaZNIN6nd8DISsA84hiz5e6bUeXsi9AQXV4
         vEJvDX1YDWOJJU7juJqjKlage1igsUGAFIiF9RP4uBt9TkyGJdo25LSXQ3VFjmzXDO2Z
         GASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822371; x=1719427171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSSF8rCLCqfCwCteTtDEL5pGKT4d+aFWwNIMPEJ041A=;
        b=FnayTHydNC0lqREKosFQL1/aQd+kFe/rxA645Elxk71Au70k2HwXG5rhBdRSY0BvNj
         Mv452hjY2JUtbyMXKCFAKY5y+fBbgr1MF5jlec1mnWcvcjNfj1VRwX8uRq7yEEVbLtd9
         CQvRY8lBkKlfMHYXZZTRZUGc7IJM5FzbexRfiIXoIKsDScyI2wFdzma31JreqYOVcHrj
         He2dX1iALxYWWNoB+0fuvKtpiozOAYqGScyQsThWD/GvpD1B5i22XPb0R1SESspAVQlC
         EtMG0bpHgMJAJm+V5vM2eEpqh8XpcPjqzh/woFOOBO/RmMuTNfgEYmntTgN1pzCSrl0w
         cp7w==
X-Forwarded-Encrypted: i=1; AJvYcCVXXQ+g1e8fc6U1PI7rDA6uRlcEy1/FuEGHKKuO9I6dkP6DoT2aTXSj45Daqnk0cSCYXD8Jk4GMUlAriFBI9EoYH1rihJgkRYBII5INAalDFCDhD0mSNZn4qEZ4AsgGeSuzYVvd1T6fCtU99FUCjA==
X-Gm-Message-State: AOJu0Ywe/heWoD/2Hb/nYJOi0RrzXSVNrFT/c7SOSD1laWzDqTfrcLSS
	PyZgQJZQPrKYoFF6qd+G3Ne9yqo4Hc9wfgoWL+0K2nh1niaLUcSu
X-Google-Smtp-Source: AGHT+IFJtOOlPWSGh3/opZRzsT39XE+oljsAdMMNoEFNhTior3dSrfJaeYZvt/cqYQpNizzmFULgcA==
X-Received: by 2002:a05:6a00:2d89:b0:6f8:f020:af02 with SMTP id d2e1a72fcca58-70629d01686mr4187972b3a.34.1718822371185;
        Wed, 19 Jun 2024 11:39:31 -0700 (PDT)
Received: from localhost.localdomain ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cf12142bsm10798238b3a.86.2024.06.19.11.39.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Jun 2024 11:39:30 -0700 (PDT)
From: yskelg@gmail.com
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: kan.liang@linux.intel.com,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Leo Yan <leo.yan@linux.dev>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] util: constant -1 with expression of type char and allocation failure handling
Date: Thu, 20 Jun 2024 03:38:58 +0900
Message-ID: <20240619183857.4819-2-yskelg@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This patch resolve this warning.

tools/perf/util/evsel.c:1620:9: error: result of comparison of constant
-1 with expression of type 'char' is always false
 -Werror,-Wtautological-constant-out-of-range-compare
 1620 |                 if (c == -1)
      |                     ~ ^  ~~

Add handling on unread_unwind_spec_debug_frame().
This make caller find_proc_info() works well when the allocation failure.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 tools/perf/util/evsel.c                  | 2 +-
 tools/perf/util/unwind-libunwind-local.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 25857894c047..bc603193c477 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1620,7 +1620,7 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 
 static bool read_until_char(struct io *io, char e)
 {
-	char c;
+	int c;
 
 	do {
 		c = io__get_char(io);
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index cde267ea3e99..a424eae6d308 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -390,6 +390,11 @@ static int read_unwind_spec_debug_frame(struct dso *dso,
 			char *debuglink = malloc(PATH_MAX);
 			int ret = 0;
 
+			if (debuglink == NULL) {
+				pr_err("unwind: Can't read unwind spec debug frame.\n");
+				return -ENOMEM;
+			}
+
 			ret = dso__read_binary_type_filename(
 				dso, DSO_BINARY_TYPE__DEBUGLINK,
 				machine->root_dir, debuglink, PATH_MAX);
-- 
2.44.0

