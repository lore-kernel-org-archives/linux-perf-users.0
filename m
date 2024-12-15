Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AEF9D6;
	Sun, 15 Dec 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734289640; cv=none; b=t4KcH/pDitsUOv1scMaox1G+6+2zpImWLnc+toND/WU3506uspxGZjmQfsZxsZeqEWIbVkosNlxj9YLW+Jbbrw30aqfeZVAw1wVfZMFr1OIocKRlCoRCVCgd7IrEoZAhcw6J/llGTCVKQP+cdZH+2C/DxhSCNLk7KQG0eB/sZ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734289640; c=relaxed/simple;
	bh=Dl1dA56S4L/2Lag+YwQYQEp6RMwTifYBWfwOl/YnXuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFcL3GWWp0M3UJXYtkjeK5Aei9eAX7kMTR3P50UECDS9psVBd9BnOc0DHcWYCUNvnOdhMSq16lkjZc39vXGNYr6B08FpigE/LzEpdXpUkB2gy5nj6F2FqSc4IoKvM25M6wn0Ub3dBFzoqtrWXeYK+9CGzYNA7dNfWsVSf0UwwyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuAiGJBG; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuAiGJBG"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso2471099b3a.0;
        Sun, 15 Dec 2024 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734289638; x=1734894438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoq9Rfn8BtWTTtsv1S2ozXi034JXmHkpMcBK95CwKls=;
        b=KuAiGJBGb10CP+4PAJaA5FjCtlK8fWYofce9SmrIW3RJOpTIHBjxOpJZIKqcukxVv8
         AT6YsKxGLbVcnT+BteAo9OtqMoaf6bqEZ86T6+71anOBJc4kxdGx1xkCpxK9QID0HZgK
         nJKGOYbH8UMAHaa32WLiHQSq/TUpBSBPcxD288kH+lNoJH7U7m79zseW1bqE/kEa0yMK
         XVV5I7Dqcs/+aOmtaDyHcvvZWYZvFWcL3xu3TbQxWarsxVJ/IPmmQe6AF76Wu5EZ+Qrs
         5bdzpdOVW5U2soXmhHBRut5uBzYzktqzvzhW+xZ3EI4b8Z9/G6pcmDYgzidlfNPq5Yzh
         YoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734289638; x=1734894438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hoq9Rfn8BtWTTtsv1S2ozXi034JXmHkpMcBK95CwKls=;
        b=OZyObqjfWONrk0IRiy66qdaAMMlW+CF1EvmL4wHvXzg+2My0GN7GCCN3qLxeDhM83S
         Ke7Gyn88EF3o76/L/IZIWPPELZFlu8dqdkpdMhjENO9G5zEZqGrRGeLuIe0I2GdxYxDF
         yMnwbdyKhYetdW388Iw0BSGcVpfZT7elDkCgQQClbq/DrZEayKW9IPojonxr1XBbqu+h
         EvFS/pfQ7KdWcuQgFXQKHTJpkaUvkC7njz631gwJ1vKrkV5KAzT97IlEizID7cr/Qt4u
         e5fSqbNQmxnW50T4or3tW/gvPNzGqCVuBMzlWqv5pjCuhANxdrSijTUEPl5PwPy7POSc
         q1BA==
X-Forwarded-Encrypted: i=1; AJvYcCUYi2rGOLEpi3X4XiKaVtfJQX4NvxHRkDD9otE23PuVHNTJMZ67+dQ9brChf/TBnla2KuWFzRuVDN3igM8=@vger.kernel.org, AJvYcCUq/1tMEY4GQnTxTQhYgi+GzupYOsVu9VJRMcrQU2nP2QvLKXq1EzXiqccVNkk9qSJAiPx5/AlOe2ed6EdMmYKsVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcwAsgPpUy5lRAWFXsSaEgNyby3AJ3kwPnfBmDkLupkXWqn7Gb
	5wAwYN60WTBG1qOtsn8zbFkG3eUPVngJesA07+syFzoqUyD1+iW3lJNOKFjl
X-Gm-Gg: ASbGnctlARXHvEr0PjMaHWdFF8A5lbiT+zyYR3PFHK4aGvDozZ+QjQm9OnamEUXguCq
	VyAdu3IRvnB1y2/pWqMJDPCM5nsfhOiUw3lDt529HTmAAUTFFOXev9gZn6cJZansaNqyM1+3Sn8
	bpT53hLL3vyHdIemyATWYdloFUrhKzsA38t9IIS2yy+psOMQeRuzvNbcfluT3X+U47GaflQ0tgh
	Or09VTDqAHquEq/mep6Q7pgFsliWiwzhBA0XNwgge4nKemUgExpMHf9ee8HEiuVQyTundwGHh6J
	MnLbDExtaW4J
X-Google-Smtp-Source: AGHT+IHzrwDLgjsd1WVxav7zg0Gily+qlodjRduYR51Vh7E1JGwTjZs8KjNoN/lkXH3LLh/GEXC2VA==
X-Received: by 2002:a05:6a21:9994:b0:1e1:ae4a:1d50 with SMTP id adf61e73a8af0-1e1dfd97f2dmr15120994637.25.1734289638439;
        Sun, 15 Dec 2024 11:07:18 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf3e6sm2800453a12.23.2024.12.15.11.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 11:07:18 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf trace
Date: Sun, 15 Dec 2024 11:07:09 -0800
Message-ID: <20241215190712.787847-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Use if -f to check the existence of vmlinux BTF, and exit if it
   doesn't, so trace_test_string will not overwrite $err, and keep
   running the test.

Changes in v3:
 - Add vmlinux BTF check, and skip the tests if it doesn't exist

v1, v2:

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
 tools/perf/tests/shell/trace_btf_general.sh | 93 +++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh

-- 
2.43.0

