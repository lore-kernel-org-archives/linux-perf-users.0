Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCB62576;
	Sat,  5 Apr 2025 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862631; cv=none; b=ej1gxErYOOi0vS9U04UqmNJI2riE0gxK9ZmGEI9O0FJYtDx3H+wXj7PgADRwEaJdEZFWdi0B5xWGzjIYkqVHWbmz6XtdmYIvIGukJeZ3H0MllyKTvfPSyEyCrKOLBtTck+0ZpXvFYlYb208AqPSu1ui4kSMKLa8uL+BT081MbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862631; c=relaxed/simple;
	bh=eF2lHtquK+W/TtDAsqBHzZsBDAVNuueclMze9x6VVBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l1axXI00Mrxg0OaePgskunDfxBWv1SstN6VMk3euNqaDbN1KKobBK9pCsTmL3D95iSPKiTexvKHQAz9z1zQvBbENOz8KDU2bfVORDvaNV0qzawgRckIdSBcU4/vT/tVhtURAfv6mAQjxxwcHuG5TfEGWxicXWXUWNGUj3/5yNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkhVq3h1; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkhVq3h1"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22403cbb47fso30925945ad.0;
        Sat, 05 Apr 2025 07:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743862630; x=1744467430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EOXkfaY8W0+hGcnGB2czx/qh543j4t18t+LlhHhRIYA=;
        b=JkhVq3h1/d05oBFI+9p/c1vYPqk3IC1Z4NJbMrcBcFUo8FinKbSAB8n5VsCqcLzGQQ
         osuxAoaQsIO63JWsW2jPhww1XYXahcNfy0+RqEFroVUmn3BG5SwZqK7dPMASjFWdVc7x
         xeCTYXdDiQg8rTumU5/yyED/CXn1RpQ4g0bJFJLSDdhsottgeaJH8vrW3Ba0vU6ywJHB
         vnqGJMMEfv8xXf2CZj+CUKGj5mbxCnk31bKFnoSploM8IDeDfRWFQLG4pUHIr4EcTwI2
         xDpOkxqZqJaWoa7xH+ubnPM6xgcK9b8vSkm/vXSaAJP+ljJN5y7IvvMM6alhIBd1NSUE
         Rj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743862630; x=1744467430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOXkfaY8W0+hGcnGB2czx/qh543j4t18t+LlhHhRIYA=;
        b=FHgtE+ZekRoiRLb4sje9R6jbPLsFJ0XXDwci2DWbstZhomG/bPsiNg339nA32TdKu0
         5j2zzhcgAJi0qflYICiVOpincrTgBPdbTNA+QB5qb0yYpBXx4GMnUCcqo/FkAd2gaaan
         XedE5fQdpf3fSZinzZpkf6oYnmOKQExz1Qr6NWq3eeDNxSpRGAzUAZ+HBYfaKDIbGPF9
         3FRwZ1lzx6w8BjFfcjdQbIUbofz9FXb+3WZ+98ydT3jQfMnKJsSWnCNWHlnQhoxLDMq6
         IXkSP43GSA0W9GGs1n6kfsgkaPavuJJZUm9wSUqyyDr6mfmt0TL7EymNCFXFDmJKbVcL
         hwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZqgAUfcZXHGhWkheg8nksgYiEBgZ2Ie0kL7Oglrl9GBNMUr4aDx9sAQP1uVk1mNNaAHkqtfTG1RmCCBKGMXGHg==@vger.kernel.org, AJvYcCVllbmlcSFktEvtCkAEi5wFiztGSwtbSU/aoSB04ncxD0+U1KRMPU2zhcgPpMMe24zQWq30Z7Xk15TEgxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiRs+j7Mgr4iOr8W6djk5zlHhD03l0t3+iCYf0oLiTalfmIlg
	A9dZi4TIma1USo67psQVxaFYp9Hxo9pWmbJvQ8N+mbDdfGi74AMcRLA5mAwSNNg=
X-Gm-Gg: ASbGncsagDlKGdXUPlCBiPPUuEwIrHUs2ewyYUinkNVyOBP9DAZs8P0Cx+zO+BsOY/L
	RIAhMp34mXCv3+B6V1LtCGE+VDu3bCTujgorB0n6Cft+gg5r0XxQ8UOyC9hBFgLBjMdfDADDTtz
	wWHCk10+geeacoZw09RyO5+FPhzeQUX4/NxTps18TXupL0GkUEXBm70OAurSfa8dDs3EFrKZV4c
	+D+dMaLSgVDD4m5ngcoxoFEjty6niWJZCuI1Eza0kQ8PBZSGsKk8FaI3GYObOMTz+7KjdJekT5U
	ypzVk3HjgRjuNCKJxHkIe47QsI418bs86sh0H085twNf5RZ1R8A2ZC1xRCGM
X-Google-Smtp-Source: AGHT+IH1US/51L+5cU3iCVbb2tSWaKS//Y88SCjr1IfwMXGK0vBz4Wp8lksOT37j0hX0X228LDZjjw==
X-Received: by 2002:a17:903:1111:b0:220:faa2:c917 with SMTP id d9443c01a7336-22a8a8c9b35mr102290025ad.34.1743862629736;
        Sat, 05 Apr 2025 07:17:09 -0700 (PDT)
Received: from localhost.localdomain ([27.38.130.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865dfd7sm50208505ad.136.2025.04.05.07.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 07:17:09 -0700 (PDT)
From: Qing Wong <wangqing7171@gmail.com>
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
Cc: Qing Wang <wangqing7171@gmail.com>
Subject: [PATCH 0/2] perf/core: Fix broken throttling bugs
Date: Sat,  5 Apr 2025 22:16:33 +0800
Message-ID: <20250405141635.243786-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qing Wang <wangqing7171@gmail.com>

There is a bug that broken throttling, this patchset intends
to improve the accuracy of throttling.

This patchset does two changes:
  - Revert a specific patch to avoid broken throttling when
    max_samples_per_tick>1.
  - Add throttling judgement when max_samples_per_tick=1.

base-commit: acc4d5ff0b61

Qing Wang (2):
  Revert "perf/core: Fix hardlockup failure caused by perf throttle"
  perf/core: Fix broken throttling when max_samples_per_tick=1

 kernel/events/core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.43.0

