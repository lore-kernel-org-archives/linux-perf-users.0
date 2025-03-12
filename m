Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47361C695;
	Wed, 12 Mar 2025 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811507; cv=none; b=trd8bwrQg7ebWkD640H5HLivCT+1eIdpJbKcfQiFkNXfbijsgqhd4naRBMp0nXAHag7fRLVGU6w1tUq2AEmpnwIoHzzkcDO5EzdLIE2XgfK22utBGl/Y9biGGZNDkuYVbR8igwANA7CA736wOAJBU1+fT0FiQ2pWN/VYCLi7YAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811507; c=relaxed/simple;
	bh=GB8KFaUu/1dTZ1Oo92BRSTxzePbliHZzstxfZLcIWxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kP/HloCcjHq+9hGDI4QMUt93qyY0oBYs26vGWKbncw9Icxy06zVgZLf53KEheSiLPuihLvKDrcnx1TP+de8q7yokSzFL26BE4AMv8e/eGXrqDe+tvqGFftJ0o5m6YonHfu++Z/Wip9g5zlqRwi0gTDBiolVGa1OCldX9C+Owe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgbALUe3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgbALUe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D323C4CEE3;
	Wed, 12 Mar 2025 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811507;
	bh=GB8KFaUu/1dTZ1Oo92BRSTxzePbliHZzstxfZLcIWxA=;
	h=From:To:Cc:Subject:Date:From;
	b=PgbALUe3z3q2Z9eNiWeAiP0vr5cigx9b5E4+fXOWUOvJwcj3fSWbLpPCEsGpsaP7i
	 mRZordt8iTSZVtkrf21//0+6FID3B8JH7l9T121Gt9D8xSpSQDpH6+bXnpWKEpexbr
	 zwrgAkK+RtuQFpEgZ0O09X37lYcFpBv7NFsYPDP5KpL/njbh8sz57i3vsd/lwGCqXe
	 mmc/89hbndiER8UN/f/rMnGW5vpwwX/f9kjonz3mpGtRc6ASo6sXgNPtJNbzEIGQGf
	 sl/hU3LiYbRgo2ivrOKSkim+iUR73KGSGisE4BJEHSRjySpU6Tf/OJ7H5Fm+sU+4ao
	 gXphNyA2AF6nQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 0/6] perf python binding fixes
Date: Wed, 12 Mar 2025 17:31:35 -0300
Message-ID: <20250312203141.285263-1-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Namhyung,

        So this simplifies it greatly, it almost ends up as a one-liner,
but there is an improvement as well to mark the event as consumed to
then parse its sample, because the copy of the whole event was done all
along.

        This is brittle, as the header size can be bigger, than the
space we use and in that case we fail to parse the event by bounds
checking it.

	Supporting larger event payloads can be done on top of this,
possibly by deferring consuming the event in the ring buffer by parsing
it all instead of having pre-allocated space, measurements need to be
made to see whats best. I'd say leave this for when it proves necessary.

        With this series I managed to run it for a long time without
crashes and 'top' says it doesn't seem to be leaking anything, as its
memory usage stays the same for as long as I looked.

        Please consider applying to perf-tools-next,

Best regards

P.S.: In other news, the syscalltbl series from Ian built on all my
containers, I'm now trying to go over it patch by patch.

Arnaldo Carvalho de Melo (6):
  perf python: Fixup description of sample.id event member
  perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
  perf python tracepoint.py: Change the COMM using setproctitle if available
  perf python: Decrement the refcount of just created event on failure
  perf python: Don't keep a raw_data pointer to consumed ring buffer space
  perf python: Check if there is space to copy all the event

 tools/perf/python/tracepoint.py |  8 ++++++++
 tools/perf/util/python.c        | 24 ++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.48.1

