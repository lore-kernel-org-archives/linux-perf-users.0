Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032063;
	b=gNi+dq8YKjHijCE3R77c0XXfXe89zVVxOOcI11K2eiI7hdPXfA0VLvXnWe7fl4/BRcwu
	 AeQRseeWDv0cO08u8uzXYUx/LuViL7St6eSJGr0uSUbQvOrBS9GfxlbKwi1iN5+5abKba
	 ZD8lfT3A4fTO5vJUa8RYsUcC9CFCyq69aZw5L3lADl/mSXPVL++4WwSm3a6wtGE2ss3dt
	 hdWi9y1qInqhbsp9+EUBPYlhXQIySMemkS9qzOV0tplEBsUykGqI/C6tHHHhEt+WD8N+U
	 dmm/uBGCVj9HwSsVWpbKZLPpcUX82VbtAhpCtBdItygkWZXCax7b7Mz6K11jjykIA8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Content-Type;
	bh=lRI5eHw/F0qhMfZnLaSDIcM3OnDPh4RgpUpb+WjiY30=;
	b=IpmJmVNoMWog23Khs9BsmCavPO/7vkdnnIuvmsRzpz0Tn2sj7SdhJ55r0BQbSEuL1R8Z
	 9HV0WuSdJyso/7Ujh2DvNGHpllPXxr2RXpXrnTQRJn10PZQ8whPqZ4SLrUDfzYQ0l9gWn
	 0KnlR468vVQCIpGaQRIkpJq7g6naicIht+rwgxUz30lYE/VCXBDbvq4Mf0EVARhbDA6hj
	 MY9PMLgUXUD3cc0PrdA/Sxy6gt6dVLnOHu1NJ4ub9yMg2aCVa58TzvfeYIXpIjSogC79s
	 ZXUKmMJVT+rp13AwDi1r/q5Rf6OFe6BLk2ewS6mjTExdQ7RSb/qxuIRzDy1DPEALFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZN7T36t6;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C160A2601
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 20:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44C160A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZN7T36t6
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9501034c4so16823435ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795032062; x=1795636862; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:mime-version:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lRI5eHw/F0qhMfZnLaSDIcM3OnDPh4RgpUpb+WjiY30=;
        b=ZN7T36t6KTGiVF1+8yLnSbOW4kfQxRunwNTXxroMjauKCZlTabfT1PSgfAMbRTkpTy
         3FRB2ALKG+AppWEOufIW5apQGjEESUGb162KHkl0URGLpFxZeUSbLn4H97EaAENZZ+ql
         arczDLd2AjztEkIDHfgN+vA84gZIOinFxjViOdNnQnP033pi/W4L/c8r9ngTAswgCoVI
         innGp6LELuBmtik2KSIhuUki3NAul3YsGz+PCOG5Nygc1If3cVtvdTzcnqknGIfC8VS/
         BVwtAo+8E6IqHLClK1/H8A/KMPc+zRgmWzNUa3ogI2eB3lkpw90zo0Fep0kjfnVXrWDh
         YjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795032062; x=1795636862;
        h=content-type:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRI5eHw/F0qhMfZnLaSDIcM3OnDPh4RgpUpb+WjiY30=;
        b=xNpdWgQ00IpsSm6TJSo4aCP7CZkBeAEyWZWOjJG4QknbO/6qdrV8mJOkLvlqr/dyKr
         uDUFbKRqkf+kZcQvNdHpRFLxkz7F7JalbbyihvWKXZDdzt/TM4PmCFkfgOqnDT80Wn/W
         FUx+mDYKxSBRuKt90Q4aLfZyrf2TNsj+UGjgoB4D9yGTKbVCGo1/1EhW1Y17v/iqcbdX
         iFT0UONMK6fr0FQyObGmoG7migDZUqVOTzRcokrNoJn3QY+BNUImLmDu+UVwn6swJlar
         kyr1RgJkdVpUPGB0TC9ytux924eLgiWNxKpAzJ9rS/Gr8TbprBK8hfzFc2dNlV3H7HTZ
         agcw==
X-Forwarded-Encrypted: i=1; AL+hErHX+KW1G5v4r1VB34TBKPAPd11nKAGklIVtmV2WyWNbWyvQgj7wEC4Uw+R2me07J98EiDwfm8HXs+NrlmKLeoBF@vger.kernel.org
X-Gm-Message-State: APuU4Z+13+q0+gkeGRo+xn+OgBUp8uq2IUSt07lzkgs7Utqaxf0v0og/
	lPUsZYonRk+VAWMM3bDvIcB31SApT4RjhI+rNqEdkSj8oBMcEuULAb9zrzWB2hYMoIBa/M68kYD
	C+RQk/9CLpg==
X-Received: from pllo10.prod.google.com ([2002:a17:902:778a:b0:2f0:2039:7919])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c409:b0:2ed:3ca1:848d
 with SMTP id d9443c01a7336-2eff7518c0bmr36394725ad.25.1795032061925; Wed, 18
 Nov 2026 12:01:01 -0800 (PST)
Date: Wed, 18 Nov 2026 12:00:57 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118200057.2134362-1-irogers@google.com>
Subject: [PATCH v1] libperf mmap: Arm64: fix transposed reads of counters 12
 and 13
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reported in Sashiko bug linux-3291a858-209c-483a-b4dc-eeb57abdaee6,
the 2 counter read functions for counters 12 and 13 are transposed.

Fixes: 407eb43ae87c ("libperf: Add arm64 support to perf_mmap__read_self()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index ab3adf1d8baf..92acb0e911f7 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -376,8 +376,8 @@ static u64 read_perf_counter(unsigned int counter)
 		read_pmevcntr_9,
 		read_pmevcntr_10,
 		read_pmevcntr_11,
-		read_pmevcntr_13,
 		read_pmevcntr_12,
+		read_pmevcntr_13,
 		read_pmevcntr_14,
 		read_pmevcntr_15,
 		read_pmevcntr_16,
-- 
2.56.1.708.g77570a6a1d-goog

