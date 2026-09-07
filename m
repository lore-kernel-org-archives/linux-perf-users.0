Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D3407CCF
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764331; cv=none; b=Up0h6AXemlqbuI1Qj4ieZjWJzf+d+UJj5abOsgvNukzfTj8Bbs1eozdBdPOcu4AJwpB6VkZ7pQdKbyR14YckSXGwtWiaHavXG63vKn7bhaGQ303gDPkMHTxGGq7hk3QPJ5sctqR+z0mVVeSFafUjqQ318KQfaCihN/Po43STbRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764331; c=relaxed/simple;
	bh=cQ7zS/QId7Bwmk26KveePTRypTp2hM0WZcmcs9cY60E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgiehY3wrbzkktC01BUQu10OuJKQP7ttPE+jmSyZeibRauFHPA2wWWvAWtu/wJds/x7XLlWgfSE7s8XMAwnv5Zf8lXEeD/mYhLAtLEvlWh/AHqsJ4gN6Z3PUmf2h8kxQ5vOvRpaO+l/+qIBypVAYyWwCBS7J1Uin1+MZDH0lhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBpgnLX7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBpgnLX7"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso3858490a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764329; x=1789369129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q+N2cTdj7t2uPFMAcFvWCC70meDRlhm3qPL9Ts1rBkI=;
        b=oBpgnLX7tdXGet2KfhRNYNloT3fTQoOWswrFvroIBsk0MkxJ/2sOxYakZmvZAGRDcE
         /4S9DqFYxCnAmldiqh4n2z6QepE7BstUkN/nN/bqLhtnEEJWZ4fRNP0E0S1jGNFpfqIN
         btDnV1sMO86uU2LDfrrXnJuuQph6gImh3F+Rtl1KEkQc2Q0F3U191AKqjqvwO4zEdQq7
         7y/Uv4qg+HhI5RPNPOaIVePfl4U5w5/GfcVPkROpJBg7oyZbNIcWEhiydIVXr/jGTzm8
         eKjDaHHVfnDZmSVPamB+3hDuSuzFF6orpWwr/uotu1GZoWbSZHTH/3rxYXxbzznGbVFw
         CiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764329; x=1789369129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q+N2cTdj7t2uPFMAcFvWCC70meDRlhm3qPL9Ts1rBkI=;
        b=sif1VynxFdKZFrZh2lzEFYjLpxmkUCVpHyRcwSsT/7z/hqO4eu91otvkbaJwQXDRqt
         YeQ/aZcXMCiNdgmj5RS/g/ZZspXonsXSnWYO1yoATCG7PqypxJPr4dlsU0ExdHUfyFO9
         lZAPDjwuksNsRFsVJi8LP+ysI59dDuaIE4t5sLOIvXKfQAhe3xtuzLJHAMEJ4cAzQvdE
         i6bcFGa8ybZ0jcYyXMoOIgqNb/8dcVL7zSoWDTM1ivqG9DojnFgnhh7HEPnfd9wxGal+
         u1lXkFxy8AAa8SZUcHPChuC/hOx/f0AHy66u52HM6loIUMjfJP6uH/vZ+HmbgozfcsXx
         BUfQ==
X-Gm-Message-State: AFuF++mCBbWF/Ah4/To/ZQh9YyFYH1FUNBaKBbS1DD6sTy8SlKknBRla
	YbxanEo5ouwnuo5k+IRS19T7gsbEvLsAaE4HgXtKOhUAOjTPT5dkqnA/
X-Gm-Gg: AYBFou3GOsmShT6hKiTzN12pAQixATGMXcK/JjTi1iV6tc2pj/q/LeNL6lQ6Fo8qoam
	XAqsbq2MHG0BL/xKFcxSvNyUpFOZFNaP5Myv/hpDWyKjDyFsODXxUrOpXooIoKODzppQ6gmhoHA
	TDXbo2B0IO4GUEfqj4UVpZdm9v/0+L8Hrqhom0Iv5WDnLViMsgh3dCH7JbLHYUfx0UcHFgPOvAe
	NYLt9f0f0jvFlx6gwxCJlufzxVIO9rp/62FSSd2Epdl7e9Nn7uNP5d52LUUg5iNQFSvzdIfNgXj
	wxqd3/3NFyUzo1Nw+EEdNZMzP1KAV0/xK92FXLozMreLhngSxTglLykt2CrbQ+2VWQIUQ5XPCHb
	5nr5AsX1KevfWcmB90nXMLaVdU8+oTXt5Vx+SlSFz5AdG2UrdU3yv3FzTTP7scvOvtYw0ASdfLl
	4IbQdRMrVOQnTs8DEiibEW41AQZvTr4cIEFxz23PteHq6gpgRfsTGpznveqYee5kjZZuvnIAlKw
	mfZQ7//q8JkRg==
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id 98e67ed59e1d1-39b26101029mr31707296a91.1.1788764329483;
        Sun, 06 Sep 2026 23:58:49 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm21996689c88.3.2026.09.06.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:58:49 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] perf: fix repeated word in log message
Date: Mon,  7 Sep 2026 12:28:43 +0530
Message-ID: <20260907065843.34410-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the word written twice, reported by checkpatch.pl as a possible
repeated word.

Only the message text changes, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/perf/util/synthetic-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 0c150193cca8..b9e5a5da5f6e 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2266,7 +2266,7 @@ int perf_event__synthesize_extra_attr(const struct perf_tool *tool, struct evlis
 		if (has_scale(evsel)) {
 			err = perf_event__synthesize_event_update_scale(tool, evsel, process);
 			if (err < 0) {
-				pr_err("Couldn't synthesize evsel evsel.\n");
+				pr_err("Couldn't synthesize evsel.\n");
 				return err;
 			}
 		}
