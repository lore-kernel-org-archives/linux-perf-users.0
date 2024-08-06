Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86F1BD015
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943944; cv=none; b=rWy6e8REJRMXuZPOSqHns79cr29OLy+z/U5aKS8vlYaJBC8fh0CDFm6D32f/2V0mv2rMDyNhEY4kbcOH2JL316ezx/ppC5F80+jIcnhhsA5tUzhOMVOQqovH7hRpl/9apa7cgqug9vqsKmM1VnEpsB2mCngFqOF0EbU9uNMvfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943944; c=relaxed/simple;
	bh=6CR9UQjkgal7LkIGEGpUcZhdfwSV+MxIRMCQF+gBjmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KpNsmjNsnJYq+OwfCifIe2Pa5ER4A8jHGAKu6lqrT1FFy8YDmR5FbNRgXx71g5TjArAlyZfqB3D2QK0mRcRfyrmXyACpV3SKugjyUsk2EIBScRnxpyF/w+QwiCEWx/lGTlJWxc96JwFuUEOTMSbOOyIg8tGweXr2ATvT6kPoTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fwjv4CI/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fwjv4CI/"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so339067b3a.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722943942; x=1723548742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSHlgWacjUS4vOaMoEoHxbw1T99xn+rPmcgHEdgJZjI=;
        b=Fwjv4CI/BdL2ol3njvomkttCyQQH4BzbB6/zKDHkmUKMBkupA7aDcpi4+EslQiiZ6y
         4VlrmZ6iemOCF9JPpQZnqpGU6vZjqKLCf8gIapDB6ASDFYuzJPN9jHUApjG3dwyJab39
         MXaX/EaLEX12zBiwDAAVioCa2eFkDUpuWY60M55jViYKOP6MfFnre4VmbR/Sj3O1ybwm
         AlK9spm07ViI7gx13Y/I506aXQRUVsH4mOReLlLahPBrnWYjaCtw2TS7isCuuVNlGwVm
         NdLeJFrhU4a88HIn9WzJOCTnsCqRWjmz2KX3/xLTaSsyJRm8NSN6KTcmYDecn+1KcmAA
         4KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943942; x=1723548742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xSHlgWacjUS4vOaMoEoHxbw1T99xn+rPmcgHEdgJZjI=;
        b=HDmasbNTCra1DjG3CcpMW2mX/j1UnYLgpf4aE3bl/ylw5tp4J7V8qtENDrODrGsTcs
         FiAiLCbuwVVIbW3fTIaCA5HiIY/+ShfDPNT7XztpECymSOcW72wYHwwQCmNaN20kOCCS
         jqUvv3Suvy7UnUJ2X46KcibRmicArk7nYI7TjXvh0imgIjcXB0QaZrXruFJn5nValnO9
         L+OFM5zKI4AQoxu6xc4WSSY2ws7cluXudFIak7gkW8Lh8a1Hs2sI8LhEmAF42D1f97E4
         UcCbaKFBFGfQHFEcYx5ycR0+2AJPvIxs3j5zEld0kD+piO9A67WmsIy2nFm165U7GuAq
         DjFA==
X-Forwarded-Encrypted: i=1; AJvYcCWpQyXQi1ShtqPGF3ErG3A6KCGM23NBZggkX48RKp5PiN+htJEHE3ZYCqfly8eW2omtryZaiwXTeVErRx6YcMeeHKoarZltcosxotA/q9Sn4g==
X-Gm-Message-State: AOJu0YzQipU6bQTjTiUw+iDKEaTSS0aG79BOP6fEw7eRmzoKvcRa4Gu8
	iVKvqGs/z3Fo/IIU6ChVqMlXQkcmrLDqrar/xYR6j4Ujcek1q7qK+oJQc/Eowh0=
X-Google-Smtp-Source: AGHT+IFSc0DGvVef7kfrRrxXlOWywNjME4WENCUeDKzEYh0HwOxlgbr4j30ZSVthYZ6HUyQBwIHeSw==
X-Received: by 2002:a05:6a00:1792:b0:70d:2b95:d9cd with SMTP id d2e1a72fcca58-7106cfce6c5mr17747435b3a.16.1722943941780;
        Tue, 06 Aug 2024 04:32:21 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec010a9sm7037636b3a.10.2024.08.06.04.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:21 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH 0/3] perf: build: Minor fixes for build failures
Date: Tue,  6 Aug 2024 19:32:07 +0800
Message-Id: <20240806113210.1649909-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset contains minor fixes for build failures when statically compiling in Ubuntu 20.04.

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 4 ++--
 tools/perf/Makefile.config   | 2 +-
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

