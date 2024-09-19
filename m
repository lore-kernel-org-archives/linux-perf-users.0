Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094312E48
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Sep 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709736; cv=none; b=C4iGXTwhilFErTfcqJamT1iY5hoa4VDCb33Ps3jeEHjZTIBGGbzTkR9evhDYqLo0sMS0UIeJVkHCEv+xdnLhRjm359lBmzW+3+Z7RRGHRTaNqx0phshXSBFcNacb+ByO3fYOLeDfBAeO2ThW3BM8+izQj1tKqbgWk8DDQVXjNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709736; c=relaxed/simple;
	bh=+BfpS3KEqyEFGD4EVRK0cm8e+bH48T32ouVTTydTMQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eK3wKFxXGVZQldfEuWntk3BVl1AvPNS/Gfdxrb8WI+MW/rtfQtgmSc1uwT3BxaFYfXA8i/ODFNxrcXR4tYs6+yjRKPvHoIY31Y4Q4rkrAyr17Vn2wjxeknTYpVL5pxBODOnn6bm4zI/p/soWpG/5nnkxHqheD7kUP4lm7P4Bilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FX06LFe5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FX06LFe5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71957eb256bso286780b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2024 18:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726709734; x=1727314534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r1e3S9pWTm/lEVJSPmr9Y58STRzRcLqR0sL+KSgVD4Q=;
        b=FX06LFe57QP1po872zLLPVt84oVA1axhqFaN0ukg53GnVvdDGZMLhZSt0CseIZKnMR
         4sq2QjClBqXGadJl4l7tcrWCZg7iLByQxlEcY4bI73lhPukOzl7+SQQBzQLZdin77Q9K
         1hm53XDsj+qrxVpRTaBXYbqQvvIJQKR0FORuUjyubaB1O3gGJ3nP4qgdoC3AHEGsB+Et
         Bz4R6Or+PLshab2aNvuXchRw6Ecsug1aDhFk9Mkq4DUZ5+Zrm4c8tKr5kJsi+gcC4THZ
         WkV1YEyK9RXXlnhBPSqNebWog/g8Hq6AE9TtXviW692zg+c1ZUoCSkWbITe0CRsnXVDY
         1w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709734; x=1727314534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1e3S9pWTm/lEVJSPmr9Y58STRzRcLqR0sL+KSgVD4Q=;
        b=Ku5gH0E+Qgv9n8ASdJ2Xux9IAFSc8ZdbV8PzzQdA4Qz2rcRKG+wsvRw9M2RB41R2yx
         vsxEuSuq09QRymS+3RKUhMDTn7kYDxo3+JiCvaqtiit9NT7qoy5v8iWTKqk37wXHVNj1
         O34CQevPTx05mg20LJCD5roaENLh/Ki59bemyARae2nRIsgTwYQ31jauReq2VFYdiTpF
         5RiEwlrP9JdREUC6SUmc2K0CeldPXA1El7USSxxbiNHTg14ndVapKssV8qdWTQukGeGP
         RXdhCOY+dZVHQ0x9LQrdzEby1BXDNDPahvxEcZZmZsS9LwlB5L2WVJSfxBuPEt33zLfk
         bSLw==
X-Forwarded-Encrypted: i=1; AJvYcCUuX/Rbj97urJQIytjn3+R5ZLCPg4W8YkRlug+7KQ/dvYy3Ec6Qv7SUj0HkdmdbKhGJRo7KVhjeDbxiGBES9edB@vger.kernel.org
X-Gm-Message-State: AOJu0YyknRhpEPNduq73k6kzO9pQTh0m/sMz2EwPFie4VvunXNaW11e2
	T3yfqpDZtklFi0qTrsOPOQNAEiz6EFvYyMNe/NS1eMODb2Elkp3Lti2L2X1PG0k=
X-Google-Smtp-Source: AGHT+IHQSQLaTaoG8epxHCgtggUQaJH8zELCvKB6tmSjd6xX6jo/pz1O8xhjQg3WkdHnuLbwgbf0Eg==
X-Received: by 2002:a05:6a21:164a:b0:1cf:3461:2970 with SMTP id adf61e73a8af0-1d112eaaf50mr32036486637.41.1726709734103;
        Wed, 18 Sep 2024 18:35:34 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc9ed9sm7282482b3a.209.2024.09.18.18.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 18:35:33 -0700 (PDT)
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
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leo.yan@arm.com
Cc: yangjihong@bytedance.com
Subject: [PATCH RESEND v3 0/3] perf: build: Minor fixes for build failures
Date: Thu, 19 Sep 2024 09:35:10 +0800
Message-Id: <20240919013513.118527-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 - Add reviewed-by tag from Leo. (see Link[1])
 - Resend the patchset with no code changes.

Link[1]: https://lore.kernel.org/all/b5688d4a-9389-4998-8031-3f002302311e@arm.com/

Changes since v2:
 - patch1: change LIBDW_VERSION to follow up the style of
   LIBTRACEEVENT_VERSION. (by Leo's suggestion)
 - patch2: Use a new line for the -ldl dependency and with comment,
   synchronize tools/perf/Makefile.config. (by Leo's suggestion)
 - patch3: include header files in alphabetical order,
   add reviewed-by tag from Leo. (by Leo's suggestion)

Changes since v1:
 - patch3: Remove UTF-8 characters from build failure logs

Yang Jihong (3):
  perf: build: Fix static compilation error when libdw is not installed
  perf: build: Fix build feature-dwarf_getlocations fail for old libdw
  perf dwarf-aux: Fix build fail when HAVE_DWARF_GETLOCATIONS_SUPPORT
    undefined

 tools/build/feature/Makefile | 5 ++++-
 tools/perf/Makefile.config   | 7 +++++--
 tools/perf/util/dwarf-aux.h  | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.25.1

