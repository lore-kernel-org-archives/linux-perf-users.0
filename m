Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4637E2F3;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753206; cv=none; b=aUlkYc/mRK6yKIRwKg5EZsAOpRUJPOeSteZwXHtwjbrRoCxByFUDTUex6nSmvDjQfDGg2sar3pZZ/DzEUyIQ8UrVmoxh+ljkw06rkyscTZ/ez+MOdTrNvwQctw8Vt+ddnNvuCFSWHdHvxUs8CLMEvnEz6QcjJodnR1pEaYQnh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753206; c=relaxed/simple;
	bh=2emraA7vYJ+V/gpaYUlHVZOozsNY0erxhiZGRizAnRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tcYYJE+Hh1fKl0ZTXKA4Vs/Hs8hXc87mAoVEmBUCaAGQefgZw5uQwqVFqsUbNLPob19tc++R5/ITygxz/kGV0TWUotyTz7L8NLYeB47D92e9gFHCodvzJSGXyRfvDdq2P4/KmaLaQspKWwYkiRj91/cdTkRZL+CfLY55ED+1yi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUAkQtfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUAkQtfG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0D8C2BCF4;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785753205;
	bh=2emraA7vYJ+V/gpaYUlHVZOozsNY0erxhiZGRizAnRk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QUAkQtfGhaiKN/PJfIE8HSX89fP9PdfmX20m1eYo7s0Rshu1paxlIeaMOomr9x7q2
	 mnGRQuFvxVrWMksrRX+kz9+T9ffVM97lwFDF8ghO3fLfROFlI9kJuHdG8JRzGld5Ck
	 NjG8C547dD+0vYKyru5uWVM7Y9SYDp+nw7gZ0yOgZVtFuLLJTMG2VKmd/oVqFXW9a9
	 dbXtwXXc8Rh5hkGJZEyz2cjqRR/zDgHOlhUS7cbYqrE5hF0DkPHsCzQgDHsP1xQJS/
	 I15oqRbKfGNVbA+wNQulPoQLJWGgwzHKMXmJvB7lApYbvgJ1lgiFWqa6ODPuBsC3ll
	 HwgUpZIgjnShA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F6AC5518E;
	Mon,  3 Aug 2026 10:33:25 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Subject: [PATCH 0/4] perf tools: Fix memory issues
Date: Mon, 03 Aug 2026 12:33:19 +0200
Message-Id: <20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2ND3YLUojTd7LJc3bTMitRi3URD8zSDxEQDE4vEFCWgpoKiVLAEUE9
 0LIRfXJqUlZpcAjJFqbYWALrZqrdyAAAA
X-Change-ID: 20260731-perf-kvm-fixes-a17f0aa048ad
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michalis Niarchos <michael.niarchos@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753204; l=929;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=2emraA7vYJ+V/gpaYUlHVZOozsNY0erxhiZGRizAnRk=;
 b=mlRkIPLQJGuCelVBWP8Yafg9cbOuJNC/9/LKkM2UYzC6TGgngfUOBDVIoFb7Eqqp1ysT6e9mn
 Z8uOaN264rJCHl/X3YdFpQjWYORStigeIStyKlKrrBPU5NdRXW/u6+v
X-Developer-Key: i=michael.niarchos@gmail.com; a=ed25519;
 pk=/LBZRQzfuxTnSaZhgZE8EP7mHr0poyqlKeFssNqkzFE=
X-Endpoint-Received: by B4 Relay for michael.niarchos@gmail.com/20260731
 with auth_id=912
X-Original-From: Michalis Niarchos <michael.niarchos@gmail.com>
Reply-To: michael.niarchos@gmail.com

Running:
  $ perf kvm stat record -a sleep 10

gives this output:
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.361 MB perf.data.guest ]
  double free or corruption (!prev)

In the process of resolving this, I came across some memory leaks.

Signed-off-by: Michalis Niarchos <michael.niarchos@gmail.com>
---
Michalis Niarchos (4):
      perf tools: Fix memory leak in cmd_kvm()
      perf tools: Fix memory leak in kvm_events_report()
      perf tools: Fix double free and memory leak in kvm_events_record()
      perf tools: Fix memory leak in cmd_kvm()

 tools/perf/builtin-kvm.c | 63 ++++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 26 deletions(-)
---
base-commit: 2162d9b24ba1a9a402baabe5382b33e792aa074f
change-id: 20260731-perf-kvm-fixes-a17f0aa048ad

Best regards,
--  
Michalis Niarchos <michael.niarchos@gmail.com>


