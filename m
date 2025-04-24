Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BD1DE3B5
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 06:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745475592; cv=none; b=EBxCBl9ntfvQkdF2EGjSrBQ+jjS1KD8t+07wL5k3rlT3yNDI8hYdHLxVQMD3Ug9i9SU8oVj7FScbPACk6pvTpnl6YGo9WnvcGTwK2TUUzzcT7DBS7RzC6FiG/QwrV/bme+5oNGipwPxnuaR+THB1nKkqx5iY6N//efLVmd3Hkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745475592; c=relaxed/simple;
	bh=8WBEzvFvzcnUry5ByhlVSbBbZ7FtMYDtGZpBJNOydFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=F4pQif1MLLh2yC8Xb7k71aLr+Zxi/KYxRYli7HouBaG0+gHypbhzl1uQOQbQNVPghTPU+/olndaYvcu9j7cBiErGEA6+zMpBcwYMy05DYofGA+UVrrGYCpP987TeD33lRBF9OrTludaLYlBB3Fo41fpskGiauZhjkKupzRHIBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yy84hYsJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yy84hYsJ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so665076a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Apr 2025 23:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745475590; x=1746080390; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlBZFAnQpqkb4CsXjJ6dhx6UI0k4k3C05j4TiMvZBL4=;
        b=yy84hYsJDwzcytu0gZEofNvmSzWX7iuzLwEcCs2Zdl6BL1Or1+1xZUG+0Nbp2M6Vf+
         /vHxzcbOtYVYJwh7XM/8lb4rGWxbu7zgbQ1DSDzdTRidr5jFRHMS7FL5fnPy/J5m9QTG
         ywARzx9e3/sNAAH+tTVxzDEjqwRKf2EQ9bnYkFMchJAfIvAg7WXMFRNwNYFFncutYLrx
         O1bhnZX8xJqcsSz7EhcXU0CtAKEVUAPlsFj18QkvIXxFqgS7RetoC4/jU8d5cRYjehil
         eOFJSpcbL3+wogQN/1COvkYmtOgGY08aaxnTvlaUEIcQ8Uvn+poz3+MIVGy0/tqNMh3G
         2s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745475590; x=1746080390;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlBZFAnQpqkb4CsXjJ6dhx6UI0k4k3C05j4TiMvZBL4=;
        b=T6zyb8vCxI1Ld27p5xUGtJkaNQDwi20DSQHrX/cHXt9XLFkRGZq1SFxGfUGB5Rg1NV
         so+fFLuJwgDcpDBLsDmnGw3AkJnxc5l2/BynM/7aznJygn3suOIt1t7FOWFkSpm4LG5d
         Dmg4z8h70Kydv7ndQ16wTr38yAjvOCCyUhTUWyLeuK+4iDHK/3k5s7TI7q/w9yPKmnxC
         u9BytEkkTTmjgitSPw22UdAeePvztdKIAI92Mh81+mNB8yFw17m6lm/Ui+8+pQ35SW1y
         GaRsc+98b+5VfOA08jbJFVPw47ebewUMpacGQ081xc6IT1N6E1+nyQlas08kMk3lfIFc
         oZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXiuzHKtoTvN1ONBZVwJV7DgejXzNGNJ64fwiTmw8/p+CiEuNwKDL8gmPO+6yYvK9DG8iWz6NDVU63iBlhkDQgo@vger.kernel.org
X-Gm-Message-State: AOJu0YxLjvEnzdIFVi9MrxEgxgB7BMAtunGbLuYKhBRmsfqGsBLPo/x4
	6W/e+VrgGaQ0Z70sQpVXg6X6ad8bQ141qy2Pk5DNYY/MD5nj2gF0FrnREuc/wj+4CT7xtNIHJEX
	Zi33PVA==
X-Google-Smtp-Source: AGHT+IGGogw0YsFms32g9TlBHej1fV/Wy4O+HvhrKdgWqhm2gdg7i+rPeo9GR+c9Tekt2aEKLL75eFpjU0V2
X-Received: from pjbqn11.prod.google.com ([2002:a17:90b:3d4b:b0:2f9:e05f:187f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a43:b0:2fe:a336:fe63
 with SMTP id 98e67ed59e1d1-309ed33b7e2mr2615005a91.24.1745475590353; Wed, 23
 Apr 2025 23:19:50 -0700 (PDT)
Date: Wed, 23 Apr 2025 23:19:39 -0700
In-Reply-To: <20250424061943.1321025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250424061943.1321025-2-irogers@google.com>
Subject: [PATCH v1 1/5] perf build-id: Reduce size of "size" variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Michael Petlan <mpetlan@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Later clean up of the dso_id to include a build_id will suffer from
alignment and size issues. The size can only hold up to a value of
BUILD_ID_SIZE (20) and the mmap2 event uses a byte for the value.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.h         | 2 +-
 tools/perf/util/synthetic-events.c | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index a212497bfdb0..e3e0a446ff0c 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -13,7 +13,7 @@
 
 struct build_id {
 	u8	data[BUILD_ID_SIZE];
-	size_t	size;
+	u8	size;
 };
 
 struct dso;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..68bb7c5fe1b1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2248,7 +2248,9 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 
 	memset(&ev, 0, len);
 
-	ev.build_id.size = min(bid->size, sizeof(ev.build_id.build_id));
+	ev.build_id.size = bid->size;
+	if (ev.build_id.size > sizeof(ev.build_id.build_id))
+		ev.build_id.size = sizeof(ev.build_id.build_id);
 	memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
 	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
@@ -2308,7 +2310,9 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 	ev.mmap2.len = len;
 	ev.mmap2.pgoff = pgoff;
 
-	ev.mmap2.build_id_size = min(bid->size, sizeof(ev.mmap2.build_id));
+	ev.mmap2.build_id_size = bid->size;
+	if (ev.mmap2.build_id_size > sizeof(ev.mmap2.build_id))
+		ev.build_id.size = sizeof(ev.mmap2.build_id);
 	memcpy(ev.mmap2.build_id, bid->data, ev.mmap2.build_id_size);
 
 	ev.mmap2.prot = prot;
-- 
2.49.0.805.g082f7c87e0-goog

