Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE911A0BE0
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502056; cv=none; b=a0RNCzWiegCetFBwdosccMgGHgoS+PgFPmXJj1DEFk5lOZQ5yRXR8lru3mAO3/GZNPZLTwtPN7TNvIeVR1tFT7i7UPVWrW7BPwGkeOBDcKHZReNHauwWRzpDKiis4CZiUNspJwdpgOzFaXj95wW/1giPF8A2IxqcIXxe+LsL9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502056; c=relaxed/simple;
	bh=vZO3AQe7+CZOR/U3Zg+1o41nmB25hPOspCaBT/odcNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBFt8rcCxsQD7Lyas3J7qJmXY/q3erIj4vKO3Lh+9yxs6TwKIQW89JRNiXUv/DIBN5Lx3KBZQkvG2kSKUW6ZzAMbw1bwrKm4zwER4PklMy9DD3LQwWsArkVrMoFy2jRPf1U1xch1RXv7sFsMBLlk4hzA8lEU02IwkU4LY5O4MSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mb1rWkWa; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mb1rWkWa"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso59307935e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 08:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502053; x=1741106853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD4YPrrWymRk6rucC/v1JXU8kR8dNumKu6tLq4ELeWE=;
        b=mb1rWkWa7YMG1EkPMWOFSDe8yfK3dLX9c+lVL+/so0ZK6jRuatm/rkZ2MCiLNuTzPm
         0IDBrnGwpQlgmnfTv0YScD4VK0xmLTZGP2P0ZgAlKHlrL9qk2CsZjOd8sufEgiYgaETv
         kzDY5+yLsFmqGhWjaLB1gK5kV8FIkq4GuD/P6y7d8jhKtHWcEAKdOiTmE4WGNZSTokl5
         jRvXW/ETtPL5tgKVdhE/BiLf3D1U1apwMX5AosDBzRURVa2rDNzq+b9GdF5t45TgGmNM
         fh7nLTTV9qxom+PHEeK0VDpY4y/Nm4wwAzt9RBH+AIU5j2YUGzjqy8kfFo3VPDqjpE4q
         0Aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502053; x=1741106853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD4YPrrWymRk6rucC/v1JXU8kR8dNumKu6tLq4ELeWE=;
        b=fnbtzoMYM+U+Un8I1e3T703sN+xZ2M2mMF44tf1U8SYxBIV40UsFtovSJhOym2810Z
         6i/FEZW1Mpoq9hbYiKy+LYLo+BubtSKAV9cDnHxmKLacvY29GVXTTHTIDJ/RwfXsr4Cr
         6N02Q5pmqzkE+f7aR0jmJV8I2OAD44Hiy+lVodqeXr+E1zIVcteEudZKaIQNQy3fCmtg
         GXhYMvDCo7EATjfDa8xkE/wvkkL4JrNqsSQYSf6FnSJwyRH3xYhAqAmYb4SLk350UHk3
         yCbWG8ZM8s3gLqCT7ig0r0zCEX3zeSjU8tnzWfwL1oT3pdL5oNA4e8f6a6kRRWe4eSey
         1JAw==
X-Gm-Message-State: AOJu0Yy0CnxXOsslXJ9DzCc1ijtH1CvdYuovq4s9sPK5ak9iphr1zzz2
	BOCSHHvA/SwsCikLUzoQZNBhsRkRVICqEmt9eV3rqxYQjyMobrykyrS0xcrw2Lp4G6jh/7Xfj3X
	W8/A=
X-Gm-Gg: ASbGncu/KhJJ0NBVsqRtmvxa/4YqcB/C0zyIHkiRlWuVLrf1lCrUr/G13i4SRnjixoK
	vD4VPm1Ci8apYRoqubw7Lg9qnKtj/PZMXz0i7soxLvB+71Ja7SwTwl477xvCjCs9KYeE2ehtL1C
	7JkmcKDl/X95CYDlhhQ+3TBPgTGsnW5zPKinvWwYGUBcfS0/XAVBcJ/82lnPVlJHblgWe46VBnq
	rvDUs7LOX4FNc9s9Ava0PD1nB7F/N6J3bv4UyXMSV2e8OW755P/P/PaZnu/erQNYQHpsHXDshkS
	S0uN/+qgavsVht3bGLrK4Q9QJA==
X-Google-Smtp-Source: AGHT+IH5ZcoPzqCagrsFUM8SoRpAwVswd6FpNDml9RsM7oTLv0BA6f40Ah7/FOS5lM9Vwj5qLNvnWg==
X-Received: by 2002:a05:600c:3d19:b0:43a:b186:8abc with SMTP id 5b1f17b1804b1-43ab1868ac3mr38322035e9.2.1740502053232;
        Tue, 25 Feb 2025 08:47:33 -0800 (PST)
Received: from pop-os.lan ([145.224.90.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab154754esm32072415e9.21.2025.02.25.08.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:47:32 -0800 (PST)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org,
	cyy@cyyself.name
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Weilin Wang <weilin.wang@intel.com>,
	Junhao He <hejunhao3@huawei.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] perf list: Document -v option deduplication feature
Date: Tue, 25 Feb 2025 16:46:30 +0000
Message-Id: <20250225164639.522741-4-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225164639.522741-1-james.clark@linaro.org>
References: <20250225164639.522741-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-v disables deduplication of similarly suffixed PMUs so add it to the
help and doc strings.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/Documentation/perf-list.txt | 2 +-
 tools/perf/builtin-list.c              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index c3ffd93f94d7..8914f12d2b85 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -27,7 +27,7 @@ Don't print descriptions.
 
 -v::
 --long-desc::
-Print longer event descriptions.
+Print longer event descriptions and all similar PMUs with alphanumeric suffixes.
 
 --debug::
 Enable debugging output.
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index c19826f218a0..fed482adb039 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_BOOLEAN('d', "desc", &default_ps.desc,
 			    "Print extra event descriptions. --no-desc to not print."),
 		OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
-			    "Print longer event descriptions."),
+			    "Print longer event descriptions and all similar PMUs with alphanumeric suffixes."),
 		OPT_BOOLEAN(0, "details", &default_ps.detailed,
 			    "Print information on the perf event names and expressions used internally by events."),
 		OPT_STRING('o', "output", &output_path, "file", "output file name"),
-- 
2.34.1

