Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F44193094;
	Sun, 22 Sep 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004403; cv=none; b=oKTRkU8jY4tCg0LCHYem4eTRnD2BJRIkkORFDTLy25d4lzCe3l3cGkF8j7RTlBCIzzJK5LFwZ8UKxCDdM267mEuuepUUsFcQNQXdxPbrLbjR9doZMsaIEJ9kKWmaS4VsQ7uvPCHBMiUhHFWDo2Z2j8urLVicHfmprb8+/9ofm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004403; c=relaxed/simple;
	bh=jgfGQViqUIdHjvc61m7hGg88QFYHSOGWQ2YxIC2zik8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usdbGHCt4BeTBd3QSeCmEnlyJ2PCA2RDG4FRj0Dn076ecJc5w3quZokTPcCFqfICFMm1J1TtmweOGO4jlpYRy3LGkASgWjLzOV8q/GxXFIQFvTDxCvuJSoGWLA0IRJPyolwAyT2xgvQW1RXyMRlHkm7867/MG3vRgDETwjTq2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCSHUvni; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCSHUvni"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71923d87be4so2557611b3a.0;
        Sun, 22 Sep 2024 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727004401; x=1727609201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1miczS/djrM1oRLmVfvqYPndy7eaWSYP+ZNheNjm3E=;
        b=eCSHUvniy7AkJCgEity+Zw74XdZ3FWtIa7Xxf7512iK7wZ42FqRrBVv+AX5jA49qK2
         GcoOtkeAhzeanoKG8ae/OXq3kqsDjkMy12crAhyT9RIT/mGsusQAuBNPvd/EsC+bCmXH
         7ZOisclqlALoMczcRH0CnNZfrAoS/uJ2HS4ilc0dQ3jHs+6yxuuzELCsvmKqpT258Aca
         ft6yFE6RBGHCqrqB1Gz5zURmfKDjnmE1uD4uqBJJWFA0VaKWfguw3OgaAS3+Ozz7JNjv
         Sr8K/CktNphC7uvpOfi6xfJag2e/Qsc0CEL02bdFUh34wHdwtKOR9TEoMLbPMlN01hIs
         SS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727004401; x=1727609201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1miczS/djrM1oRLmVfvqYPndy7eaWSYP+ZNheNjm3E=;
        b=wCX8+E5qQ1dl2JbnDV9S4op5GK18JsWQpAhC28VbI/CxbfDfQrs9Yi4lHwO/PD74oW
         Tpe93yLU1cbsSSOgK6ylMSdhvi7nS+aPif+qqMzj47iqYVGnzZTFJyBlNprqqmBfxjBR
         KTQSFjFRYXVJCXUi4RsKq8YispOn5F4CbUhUu0aU1WxznaX0OT3Pt2BMAR7xBv/j7W5V
         DP0ugrwi+Ia9PxTtpnolGcGp+TLEi8+XHDvPpdgaYoZmXlniQLzxxxaGg+uS4w7+ooHh
         qtl5eAfhLoOqWGnJqJYIy9pgSYVcQEodgrdGnC1tN4xFw2f79mElqm+cRkfjY8bbjCpl
         NtOA==
X-Forwarded-Encrypted: i=1; AJvYcCVF+ztHHZaXgztL2hLnSD/MPy7SKj2b4kXEuD2wY0DKcyVTunsPBOg+oPX9PhNHoh5yrd9lbrcwr0CTdmw=@vger.kernel.org, AJvYcCWlECZQCjdRNv8Z9jG+vqeST1LFcAZgkM4mHFGF2xTVsYATYfctTCMCZHYjeTlCbWcuIGK1YHKGApK8qf774XhoKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSb0OOFfSm2UnHbf0wM4TY9DoFQlXlSGrU6ccIjZy0o+y7Ghr
	6ypvIqwldrSmFEqhr0I+uYRXbDfn9g4IeJcDCtMVmh+8Vz6nVZ1r
X-Google-Smtp-Source: AGHT+IHVw/icyDor2IkF5AqqLi1A7+poPdoQ9oEoGbQ+zgeaGFzMdkWA+9IO6XSm9jVTpVhXInjesA==
X-Received: by 2002:a05:6a21:3a81:b0:1cf:489a:52c1 with SMTP id adf61e73a8af0-1d30a9674bcmr12370487637.18.1727004401072;
        Sun, 22 Sep 2024 04:26:41 -0700 (PDT)
Received: from localhost.localdomain ([103.175.62.244])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944bc3456sm12430339b3a.197.2024.09.22.04.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 04:26:40 -0700 (PDT)
From: Masum Reza <masumrezarock100@gmail.com>
To: 
Cc: masumrezarock100@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ze Gao <zegao2021@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Yunseong Kim <yskelg@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf evsel: display dmesg command of showing a hardcoded path
Date: Sun, 22 Sep 2024 16:56:16 +0530
Message-ID: <20240922112619.149429-1-masumrezarock100@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In non-FHS compliant distros like NixOS, nothing resides in `/bin`
and `/usr/bin`. Instead dynamically symlinked into
`/run/current-system/sw/bin/`, the executable resides in `/nix/store`.

With this patch,`/bin` prefix from the dmesg command in the error
message is stripped.

Link: https://github.com/NixOS/nixpkgs/pull/258027

Signed-off-by: Masum Reza <masumrezarock100@gmail.com>

---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bc603193c477..7a06b7cfdc7e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3342,7 +3342,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg | grep -i perf may provide additional information.\n",
+	"\"dmesg | grep -i perf\" may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
-- 
2.46.0

