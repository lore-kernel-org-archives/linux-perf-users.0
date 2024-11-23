Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7A29A1;
	Sat, 23 Nov 2024 00:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732323317; cv=none; b=DeYASt/UaRMqwCRgCX9qvNvhCNVd0JhVVqCTn12RPh6k4/0oDG9mVavnL3jg4NZBCJshAxZjR9HcDlLJ8mpC1OlfqtGimb1F/mI/vgd/PqoR2qJ17MTTOLDIwRppswyd5nBUoAEOn8qhtkAmYgIa6O6RkwhxRkITFiARH45+0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732323317; c=relaxed/simple;
	bh=iDERunhSu03m5vAyZ4GljsZGsCR+M5m9RkipDCEHfU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBRaRdJWCGM3lqjIufl0Nrtl8GJNFQUwRQcxyueVrosUfkCiT0q+Rq8GzvJ2zcyzJwqmsqxhsA/ZsCEBdpSLYuDePh1ojX5BoMdbmuumW/GsSwHA3ik9vOgrJcUlUySDyb/m/89NecYk75gx6BTJ0cwqcVGKclFi9ND5JmpeWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqqP6ihl; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqqP6ihl"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso2097113a12.3;
        Fri, 22 Nov 2024 16:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732323316; x=1732928116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzZqsNFKcBl3d8anhqvd72az0uxGft7JpQJj7xlzeOM=;
        b=bqqP6ihlCBIWy+epQmM0MoAxIrMwPYbH5AbyJZ/ImnCbSVkYQnsdOL6QGH0bkfBXmE
         pEKlMJ5BRTQfS4206JNw5yMEuJu/s5J0ZAPKfoby2ObdITwRAOGJ3SVSIrRzNqpaBKHR
         /lrJtrYrP5PFHAPZSfNnrmmA2Ub31Pau8krxvV0avFxSqUW7/iaKewsOzmau4x1CrFi+
         kBD2qU1kr0q3GCNo/L0RGe74W9BSa5VhdIuJGub2ZIdcn9wHDqNCESB0Wy34IGPFx03C
         j7pPkP6p5cLAMywMK9zbQbcKtFR+w/eqFOoIn+gMrOjOxXciNQ4gjZTW7QDuUs8CsQ5t
         Ym/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732323316; x=1732928116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzZqsNFKcBl3d8anhqvd72az0uxGft7JpQJj7xlzeOM=;
        b=nkW9ahZfHjLOMThYYH9VajprP//otwmv6KnhSHQmRhurXEpegdipmHFY4IyApbPYpb
         55CkoIU8GtWDace3UTuUZLiaTDHkGyEzY1YR4rYQ+2RnoNIS1K0pNJ/TKm/m9/+MXte/
         UJYM3zxWV+3PQKYVYahHFm0VhHslEWVO4+hCbQyYIS1OXxzLuoXup3h80fheE1oxiDmh
         ddChd9MYgiQH+vNVZXuws226zKjtzS+NEfaNm51LgLGlIRJfNb7W6JuOGJaxHvqfP1ql
         C1zJZB3pXVGyh4DsIDgpw1Q73FbQ8EGSryjQ7SlbEgNf6otsUS7bipprHof4DjEdKYfa
         R5RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO6XK1Po8mQJU9DrMhWAwQEEOOFAL15y9yWtPVffbRnfdLq8x1lHuT03+p9nXdbzi+JWSqJ30Ym/SBl2g=@vger.kernel.org, AJvYcCX7cPcF8nv8mJ4oZ/pkyo72/l5aArwfXhUY4t6SniSj+fXWiTUg5h6mJ/AMLEQQcYICIxohihiJbk6seZgD9N9EKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDwNdagOm2Kfp9bUi2Wgb1wBDb9Qg1wivsB4OaCr2NGWD2xyq2
	Dyh388cYSJqqHrZVSbyrKXo7+gbO0Zxm7dO+ZQcdu+cN7GZv91zI
X-Gm-Gg: ASbGncvjomuhsDogDYC3lmN0KsUgxWmWv5x4YjIKdKlT3+QQUuGAZNfp0/vPQrBQMm4
	7QTt4KVjiAWEp1GHDtZ9MUk8ucx2DY01/aLRQbEvb9g+dhy8Sw5I126BwMr4qYS2DS8oEW/N688
	fPUEXgJLLGKJxYPyoFpa3MVqVbbNCLmYtyGbGkjWRMFkwVabFCwCwGJ1l++MXpyDtE2rdj83dIY
	Te93H8BiKYkcV/elptVWqlkukZIlGrARtJYpwwP+A3L8GY2aO/2+Z48sw0Kzaq31dfQlAw6Ol9h
	o9y1H46aTEY=
X-Google-Smtp-Source: AGHT+IGgMXBR/fvbeNT5SZ8Ap4QH0+jFyiXo0foPjEy+Mgs7o6Ma+k9AlxhTMFDvYp5aDK+kNhSmgw==
X-Received: by 2002:a05:6a20:a107:b0:1db:e509:c0a8 with SMTP id adf61e73a8af0-1e09e4575a1mr7038827637.21.1732323315536;
        Fri, 22 Nov 2024 16:55:15 -0800 (PST)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e0fca304sm2082867b3a.175.2024.11.22.16.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 16:55:15 -0800 (PST)
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
Subject: [PATCH v1 0/2] perf trace: Add tests for BTF general augmentation
Date: Fri, 22 Nov 2024 16:55:09 -0800
Message-ID: <20241123005512.342079-1-howardchu95@gmail.com>
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

 tools/perf/Documentation/perf-trace.txt     |  3 +
 tools/perf/tests/shell/trace_btf_general.sh | 68 +++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

-- 
2.43.0

