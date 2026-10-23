Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761638;
	b=EaFjG1A8F9ZDysTyfjw9pm/rd76lPzI2ha+6N2emAWpZXi7T3iksaADM68b+AdL1WkBn
	 eYNlZZ81YwhVrlFztZkj4N+lNWxg54G/gHOps9hyk5R3dyZ3gdtBLCqYPPbduJafadi2Y
	 J/3kIo+sGuo0zQUWi9MVE9IO18zCcUM/K0aTTHsjbnhFiRm4+2hpx+uGL9KmR9hHy2PXO
	 ODn79XsUsUbJCrscpf02oLxMdIUlIck7MQ1hWV2bpL4shVYQoYgvv4lKbT9gwjTcoaJjO
	 nHFKkR0kPk9GyJiiUout5syeNmwncKylxT9vu0Vs8FU2kGmBKjtcOmkjKxMJ6heZSNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761638;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=tx7JqVA3FUzSdiK18OVw/NfkiEMje40ezK5GaQ4E24s=;
	b=QxTxcVFNROFB3hI9alX+PosXmhfnFNZSHVlMY4JYktX45yAC3BIC+NVTkTOgws8S5+5V
	 mpPz1yg16ftmDzGey++vdCzI8Y7MnpbfA4wsMabzvMTXeMzFYLF2XOqt5sg39A4C6ZQu5
	 O+29cIozE2SNdNEgzWoBo+ZbF+qoCDq9AzgCoyv0Hw8BQFl/U48qltHxMGGJWgPoAFjPR
	 cSy3LUGJ0L/gfMGb4uP5gulx4RcP6SScbP3khtwjYGIYR7xS5Cz/JbkM9uA2NCjUHok1b
	 4jm4+a1DYtTPAoDIj2OV79z3QRKypEQieR54ASAmi8EoIw+3FshQq7Kc7PlvCvv3Ecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aUjLHPCY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02406606A32F;
	Fri, 23 Oct 2026 13:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02406606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=aUjLHPCY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4160F328E;
	Fri, 23 Oct 2026 06:20:33 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765713F673;
	Fri, 23 Oct 2026 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792761636; bh=kWH9fuk43xDSbnzyHI+7jLKjTx3clQU7Bx9Y/r1e2d4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aUjLHPCY18ScP0fcsz5l+LaJOm73Q9Uyc1jStvyykQma/RGQu5JXUtwqHhn77p7a4
	 alPTdqvQy9r9rVXRzrJT4vUSDKZn3+B836QCUvXPwNyorA6hmUKOSRK0/RZ+qvuAoB
	 g8KUHp1z4HYLZcx9b7rRzl8SywIHUjoEZgx4v3vA=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 23 Oct 2026 14:20:25 +0100
Subject: [PATCH 2/2] perf timechart: Initialize Textual attributes in
 constructors
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-perf_fix_pylint_warning-v1-2-b9da8dae2fe9@arm.com>
References: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
In-Reply-To: <20261023-perf_fix_pylint_warning-v1-0-b9da8dae2fe9@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alice Rogers <alice.mei.rogers@gmail.com>, 
 Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792761629; l=1982;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=kWH9fuk43xDSbnzyHI+7jLKjTx3clQU7Bx9Y/r1e2d4=;
 b=z9TZYIIEAz5DyQ6HkC4vx/D98MoQ0UW2UrTiz++85veK3XQMg/RfxXFOke7a81YnQ76KLhHIy
 jfE0on2vb5aB0TayQN291+gOtvMCPFP3MMK+yzckBEFVVjDfR8yqyc+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When Textual is unavailable, pylint cannot resolve the inherited
virtual_size and sub_title attributes, which triggers pylint warnings
and caused arm64 cross build failure:

  ************* Module ttimechart
  python/ttimechart.py:1086:8: W0201: Attribute 'virtual_size' defined outside __init__ (attribute-defined-outside-init)
  python/ttimechart.py:1422:12: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/ttimechart.py:1496:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)
  python/ttimechart.py:1510:8: W0201: Attribute 'sub_title' defined outside __init__ (attribute-defined-outside-init)

Initialize both attributes in their respective constructors. Use
Textual's default empty virtual size, with the actual geometry
computed when the timeline mounts or resizes.

Fixes: e7a72d691980 ("perf timechart: Add an interactive --tui mode")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/python/ttimechart.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/python/ttimechart.py b/tools/perf/python/ttimechart.py
index 34ecf84e68c1db7f542070dde608ac09d662a1b2..16d2bbbdd98b23d64ab42643db42686cad98f0f0 100755
--- a/tools/perf/python/ttimechart.py
+++ b/tools/perf/python/ttimechart.py
@@ -1065,6 +1065,7 @@ class TimelineView(ScrollView):
         self.can_focus = True
         self.data = data
         self.rows = rows
+        self.virtual_size = Size(0, 0)
         self.cache: Dict[int, List[Cell]] = {}
         self.cache_key: Tuple[float, float, int, Optional[ThemeColors]] = (0.0, 0.0, 0, None)
         self.label_style = Style()
@@ -1332,6 +1333,7 @@ class TimechartApp(App):
         """
         super().__init__()
         self.input_name = input_name
+        self.sub_title = input_name
         self.power_only = power_only
         self.tasks_only = tasks_only
         self.filters = filters

-- 
2.34.1

