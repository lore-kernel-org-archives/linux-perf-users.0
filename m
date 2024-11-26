Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371211185;
	Tue, 26 Nov 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660382; cv=none; b=Xz9Jdtna98y5XLboKdfMFzdFoUx+ePg3FfoAaOSXcvB2YZXSMTQWcaeQ77JZorNP6HglcwcPVeOLGhbWWnv1XZvV6MC824m6x8/nxC+EeuHAUOg3zYJ2J6RJsGjJFBNlop/Ci9fkiIGrCaYQ/qcDzP+Zzs4Z85WOmnDo+ry6lFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660382; c=relaxed/simple;
	bh=RDPvd1tGqygeGMLEHUH8GGp91x7Kngt8zbj5S35GxsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uoBoFEFrzgWgtp2lf7dCoUPIwK+su5rjVohwcnkqSBJbB6r6CFZIOvWcCif1wZ+KHFp5SmtWVXcMTTiHsrHWLSteNzmkfyNYEXltdG//ytmcuu/zeIpp8ERGbTyw8Igxr7eDGik5b2BGHx4o97eTmydw67a7F2fmWy5MImWWyKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkv84y+c; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkv84y+c"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e1742d0dso4120513b3a.0;
        Tue, 26 Nov 2024 14:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732660381; x=1733265181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bI6xDS+WUzZjIbowtDV378qMXfDoLJd2A2/NdsRd/I0=;
        b=dkv84y+c0ikKI17Zx7aF2GIOYepzWJBKbrKUlDcrqLJjQPaknzsU0gxJ12uONIp8gE
         oaWJiH6Hd0YldUhCZuuCLHoGTmqOOGFQbPvzVIMyw0cvnOByMK2F2Lamjw7krDwV90ND
         AaKaKQVt8ZMiBb7TBMpRo4cRVOGjSj6kQBKtRqV4tAYNVZiDXHBYQ5EXW/6fi3xgJkzx
         4/saFqUkNNaFwyHWjJpkhK2QyFQ2/j/Yv2f+Ob0n5FL0uVmqP31kUjN8YT6QhE0gaJI7
         YTajsgQs66vhxTd6D02P3xcxBReKb27G/W4p7MAacq+ek0XeheLlocAEkj2A4R4Dc8Nm
         EADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660381; x=1733265181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bI6xDS+WUzZjIbowtDV378qMXfDoLJd2A2/NdsRd/I0=;
        b=Bv2f2Pu4X8Jn9iScDKWbDAGPiXNaWYMnBkPE4hW4dhsKGjKIpC88SNhtvti1PKw+LA
         nHzjY6a+mB705qy7aIRR4pmkgLZarPiyWk3gEKV18h2M76Z8a5yUXMzOi/AnWNJs4abu
         TDzAl8fye5R2duY58NIy96QV3wkVcVBgIeUIac5pQSP5crIj/Y+oGK/IkXM5xmNNYA8W
         VfSWpdlzf3gfMfcTbff6JJ5jcEpmGNjhRZCBzg6OQn9uIQhJi6z+Vn72W/rdWX6P5Pst
         hzWf/3pSp4QXtxOIDhT0eLMuFSGi0PRU2LPoDnCRxGrHLir7N38mLnOZ4hQqQzTeYop3
         39jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn3D1tzq0Zgjho9jFxaTooY0RzTHrafN9kifG8Ztsxx4xYjss1AvJlIsQV1PhSwmZa4Bfc5630pSJayV7U+HVi4g==@vger.kernel.org, AJvYcCX6l3ugsz91tH6Q7z56Ksr/GDQybho5FmKBZ9o8J459NIokQCaJekR0GYfiDj+p8VhJ8wv7/ti3ST/zImI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZ0/7c/nqaB9+L8eb2aF0pncDAGW5dz0osaMiI16dw3/K24r7
	SnHlCiIy2VGYWavgbvn0qmk3GzPJczjE2z5KE44ZwExB68jcSaZg
X-Gm-Gg: ASbGncuReLgMLBaSdC2XAsjG4olGHj0Yjs3q8cHnOCbdtp8AZfAkrTaxLG+FzPeEpBb
	HbnmTbHcEdMOTfv0EBFtt9zveghY6doc5/fb/cTafOxN+xjiCSD+hYJTxjbFejz9qz08U0Hzgk8
	G8obKmj+7AnLHwBgsTUTvh9O0JvrXiSlryo90JMwIHhEj6kT+bcZQ0YO3Or+tTsgz3Rs8fUbRkJ
	Zk8DJdXNToRGwXyrSVIFHE8LjEZ/wuTB3Hm7q92kEW6yec1F8KEXPVkCKu5hR6wyRVfHf5jHsXj
	URJMCrgtrOo=
X-Google-Smtp-Source: AGHT+IEvkl8b121Oy2EbR9pWVKg0XmpXwfOCaayi8B23Kl593VNXYmXYy8f6bZaEcIi8x0156KOAHg==
X-Received: by 2002:a05:6a00:3d47:b0:71e:4ba:f389 with SMTP id d2e1a72fcca58-7253005632cmr981330b3a.10.1732660380612;
        Tue, 26 Nov 2024 14:33:00 -0800 (PST)
Received: from mbp.. (157-131-33-111.fiber.dynamic.sonic.net. [157.131.33.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc406de3sm7948861a12.81.2024.11.26.14.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:33:00 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v2 0/2] perf trace: Add tests for BTF general augmentation
Date: Tue, 26 Nov 2024 14:32:55 -0800
Message-ID: <20241126223257.22465-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous version of the perf trace BTF general augmentation tests
didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
<acme@kernel.org> for pointing this out), this version uses bash instead
of POSIX shell to pass Shellcheck.

This patch series also adds documentation for the new option
--force-btf, which is used in the tests.

Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/

Howard Chu (2):
  perf trace: Add tests for BTF general augmentation
  perf docs: Add documentation for --force-btf option

 tools/perf/Documentation/perf-trace.txt     |  5 ++
 tools/perf/tests/shell/trace_btf_general.sh | 81 +++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

-- 
2.43.0

