Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4133B95FA;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762363; cv=none; b=aLbn8Y8iDiaYPtlSiSe3hsnd+Rs7t0fnW6avYuBHXTGK3C/HXvupuTrU9hbkpQ/10bMf3xjBiFUWuxJ2naRpYFpzk1EYE2kT49nw4VhJZncHScdppolLZfe+TD4JanfgjdQy8gVdHyFEHhz2dp4/MvGRoEIP75O6NMPDUfBuerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762363; c=relaxed/simple;
	bh=JLIUbwO1UNZ//grQrD2xUdrkkkBP4WBa5dawTqD1mEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EK/D1jPsdx97Z/ULzFJCVFZle4bBb2r+ZnZH8naER/F0T9GOoYz/02t5/an6Ve2BG8FaoowQ74hUgL9iS9XEvwiyPY2miWHN4YbwDFU3SzKFbixLFsMj3Ad5o1XFzlKZzLAvHU8avh8QHWaZhu76KOVQ2kMhZhcLdwG9DZmEdKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdXgM+Z2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdXgM+Z2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15CBBC2BCB9;
	Mon,  3 Aug 2026 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785762363;
	bh=JLIUbwO1UNZ//grQrD2xUdrkkkBP4WBa5dawTqD1mEc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LdXgM+Z2qL7jhVyRqFQ9cUWplPsXr5acXFUfedq/xab1Q+VjmlOXFTVkjEc0RMaBn
	 JGAlygbTE/5d6rRK1ULD9gXPeywNHbtmw5jIT4cmYc6Q8AIHz60lVcRpVXdatRi+VJ
	 jGh6wEDe+ORHRoOVtJL4q82HZcMQM1jqqBGd79QpWaeq/ExB4dplxo62HbQCZiaZY4
	 EXKyaCEYliRkkuHZtcBdjphaSdaEIZwiV70XpYQD98gfiyWBLIAZQmKnqCuBn6PslN
	 UYE/aCqGNiGxkJsyMR77fquCzgywXKcCf8SzJk55J58XTkaVIyUw9lPXMA5ycbsooj
	 Z1vo2iFHd+dAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EBC55179;
	Mon,  3 Aug 2026 13:06:02 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Subject: [PATCH v2 0/4] perf tools: Fix memory issues
Date: Mon, 03 Aug 2026 15:05:39 +0200
Message-Id: <20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NzQ6CMBCEX8Xs2TUtoIAn38NwWMoCq/KTFhsN4
 d0tcPP4ZWa+mcGxFXZwPcxg2YuToQ8QHQ9gWuobRqkCQ6Sii0pjjSPbGp++w1o+7JB0WisilWR
 UQRiNlrcgbO7Fzu5dPthMq2VttOKmwX63R6/X3i7PVPwv9xoV0rkqsyQnk6fxrelIXiczdFAsy
 /IDSsbn974AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785762361; l=1983;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=JLIUbwO1UNZ//grQrD2xUdrkkkBP4WBa5dawTqD1mEc=;
 b=P0F/aymsVQS2AtCottU8s0vw8KWxMzzX1YSoqBBlKByBD5IQloImy3zVJ06T6offYWbY59Zjc
 EKCUo+1225pBv1EEujnkCi6c30nFDFCvAiWlS9Zi6z6O/7vpoV9o+R+
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
Changes in v2:
- Removed code block that was rendered dead by the
  get_filename_for_perf_kvm() change.
- Dropped invalid free() fix from kvm_events_report().
- Added double free fixes for: __cmd_record(), __cmd_report(),
  __cmd_buildid_list(), and __cmd_top(), which follow the same pattern
  as kvm_events_record().
- Link to v1: https://patch.msgid.link/20260803-perf-kvm-fixes-v1-0-a5db849ac973@gmail.com

To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Jiri Olsa <jolsa@kernel.org>
To: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Michalis Niarchos (4):
      perf tools: Fix memory leak in cmd_kvm()
      perf tools: Fix double free and memory leak in kvm_events_record()
      perf tools: Fix memory leak in cmd_kvm()
      perf tools: Fix double frees and memory leaks in cmd_kvm()

 tools/perf/builtin-kvm.c                         | 99 +++++++++++-------------
 tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c |  4 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c     | 10 +--
 3 files changed, 50 insertions(+), 63 deletions(-)
---
base-commit: a1ed064cb4db70af8c4177b3805ca5b8b0be567e
change-id: 20260731-perf-kvm-fixes-a17f0aa048ad

Best regards,
--  
Michalis Niarchos <michael.niarchos@gmail.com>


