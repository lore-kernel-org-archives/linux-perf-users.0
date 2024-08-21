Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259D26ACB;
	Wed, 21 Aug 2024 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282790; cv=none; b=qmP80FSxaWhyd3iW9+YZMagSQ92XkGFVOxD8YbI9J4sceYPkB7h2QIFM8UM/JadFuI+9z+PzRVE6/pRmHtjaNWWFUHs3hGQ+DcFl5c6QtKxGX9SXDMmsvs99BooCF6DvTcEHq3vLeuOoftH7+XlLKodWbDmuIwFgVSfNJYFjLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282790; c=relaxed/simple;
	bh=sdtmAYRaSQyFzyxiZhKYSHqvUMrR2fuTBoJ81TsXhx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIgWZ1h+NWpR4jBD9DzFCze7g/kVweKyVOzO0wb94sXbexMVXJBU5rAB1c/Nit8QjrJ5bl7xtCtkpeWPZEr0GuxCRTglPYQHnGQdizsULVN1P7gZpwsQJAdvCTT5/cOwQ0qaIwZbVNmWD30axe39F+Gim9JDWcMQbYqVC6Rix+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTELkQhy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTELkQhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC97C32781;
	Wed, 21 Aug 2024 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724282789;
	bh=sdtmAYRaSQyFzyxiZhKYSHqvUMrR2fuTBoJ81TsXhx4=;
	h=From:To:Cc:Subject:Date:From;
	b=NTELkQhy0tqAG8Bf2PTE6Wi0UbldtPUE4gHPEVpk2o0XXbzOZItNGfrfziRx1NckK
	 m3ykTRj+dESHIPEIsXKSwTrcXBzBROucy7lL+Z5WQFp1I5NOqSnoeeSbJIHunSxNKB
	 smcA77M/du0GSEBA9LFAQekkuplJ62p/PsuCcfthAxTHjLfUDcb3422DhG08AWrzRE
	 bxM4i94NDD2cWm9t4o9vCMsZr+JytPesZHYGmkizpTpYUNZrShVDtlWh/4MQufP8/9
	 UgZJXLGYNhPHmq2JJwjnyRsxo4Ykn64vyshr3eO4gTFGtjJgA3S1Alf7Qm1bfxeiLg
	 7Ad3rynLl6JbA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCHSET 0/4] perf annotate-data: Update data-type profiling quality (v2)
Date: Wed, 21 Aug 2024 16:26:24 -0700
Message-ID: <20240821232628.353177-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is continuation of data type profiling series to improve its quality.
I've also found some more bugs and room for improvements.

Acutally it depends on the a couple of fixes I sent out yesterday.
But as they will be merged to perf-tools-next, I omitted them here.

There's no dramatic improvements at this moment, but I handled some
corner cases which makes instruction tracking more flexible.  One
change is when it accesses (stores) a stack slot for the first time.
As it doesn't save anything there yet, it doesn't come with a type
info.  In that case it can try to process the instruction with
update_insn_state() and get the type information again.

Another update is when compiler generates the debug info inaccurately.
A variable information is there but in some cases it was using another
register to access the data and it resulted in no type information.
So I tracked the (direct) register move and update the type info for
the source registre as well.

The code is available at 'perf/data-profile-update-v2' branch in 

git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (4):
  perf dwarf-aux: Handle bitfield members from pointer access
  perf annotate-data: Update debug messages
  perf annotate-data: Update stack slot for the store
  perf annotate-data: Copy back variable types after move

 tools/perf/arch/x86/annotate/instructions.c |   8 ++
 tools/perf/util/annotate-data.c             | 105 +++++++++++++++++---
 tools/perf/util/annotate-data.h             |   1 +
 tools/perf/util/dwarf-aux.c                 |  11 +-
 4 files changed, 109 insertions(+), 16 deletions(-)

-- 
2.46.0.184.g6999bdac58-goog

