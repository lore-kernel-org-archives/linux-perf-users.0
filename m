Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972E40F73E;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785765120; cv=none; b=kxQpruMqDEDcnH2KutNtr3nGwKyVemT0PpiAJGQ+OAWak58P9Hm9qTDBNJ/rbF44j21jnKXGSvdRmAksaVP00tU0ZsSYoi8Jkg9O6MBbQj8vUYImIhLul4CB6V776UkC5uVw/vaNvZwk279xkYrbzq/T/zhiLQjASIOYls6sp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785765120; c=relaxed/simple;
	bh=de1kxqA8d5DKcqsyDmns5DBbAlbhCSnEvCt61EciqhY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PAsr8b71QMAF5U9o1O4fWjdtLyb3VILxzOci74KXHg+CNqqC8VVGJ/2ouWP2I317Ls5RsAUgvUodWCwIRPnqCmS+uA1NpV88qqw1lpeXogIeFkCyjAO/YHetW2u1icFFoGlZV5xTUOaIZ/+aj+1iSZUZTjG7fYeR+AUr7uIs7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnedkFjX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnedkFjX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A74E7C2BCB9;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785765119;
	bh=de1kxqA8d5DKcqsyDmns5DBbAlbhCSnEvCt61EciqhY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=lnedkFjXBQ84ovPlB0NN53ioPJRyIRoAUZomfdTJ+eTBU+t2QNroUZV4+1kfDpqi5
	 +9wTYn9BLVkPC/uvHYHwOSpQKtrHR8r7yq4rjNgh5zfix+YTRIM9OyDrp5a+bqsTUV
	 rjfjWBiFdAdBgHRJNc/QdcKwuo7FW73z9iY9aTZ4h0B9SDLVlqRuQuYNMVijwBSuSj
	 IFwNLuCDKZb+lVtpILuZNWd9CtroEGexifw5P3sYfqIPFnFnbcsvDzLH8W69pt1pAV
	 8rUN+6zerjDkX0kQK4KaQqdrZlW2N1iNRUWEgOOpumJeX8QfcPlL31u5n27b18G6pm
	 pniC3cqwhuMZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C0BC55184;
	Mon,  3 Aug 2026 13:51:59 +0000 (UTC)
From: Michalis Niarchos via B4 Relay <devnull+michael.niarchos.gmail.com@kernel.org>
Subject: [PATCH v3 0/3] perf tools: Fix memory issues
Date: Mon, 03 Aug 2026 15:51:51 +0200
Message-Id: <20260803-perf-kvm-fixes-v3-0-e06268ec06fa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBBFf4V0bU0fKMWV/2FcDGUKVXmkxUZD+
 Hdb2BgXLk/mnjMz8egsenLKZuIwWG+HPoLcZUS30DdIbR2ZCCaOrJCcjugMvYeOGvtCT4EXhgG
 wXEFNojQ6XA/RuVw39s/qhnpKlbRorZ8G914/Bp52W1wx+RsPnDIKh7pSeQm6LOS56cA+9nroS
 IoH8V8XUeeVlAVXpTFGf+vLsnwA1eAdUP0AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785765118; l=2152;
 i=michael.niarchos@gmail.com; s=20260731; h=from:subject:message-id;
 bh=de1kxqA8d5DKcqsyDmns5DBbAlbhCSnEvCt61EciqhY=;
 b=783VwVM02QH6oEPgnq4OpaH7Ap2E9GdY7TNM0t624Qj1NtQdb2+KiuYnQKK9ccMUhON+euAvn
 qg9J0eRQ3OfB4inSRz9zumUImhSh7EyVd331E3hsoomdMh/6zA2jHTm
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
Changes in v3:
- Moved dead code removal to the correct patch.
- Squashed double free patches, as both fix the same rec_argv
  double-free/leak pattern.
- Link to v2: https://patch.msgid.link/20260803-perf-kvm-fixes-v2-0-1b337189fffc@gmail.com

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
Michalis Niarchos (3):
      perf tools: Fix memory leak in cmd_kvm()
      perf tools: Fix double free and memory leak issues
      perf tools: Fix memory leak in cmd_kvm()

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


