Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC87B3E1;
	Thu, 20 Feb 2025 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740011924; cv=none; b=tnbbvrSPdS0BNEzTJbq+o5yrSLyngQiBNWwLIE/3cbq3ph33/h9xqts1bjv6QGLVH8ULrm4R7pFnUp8TK0dhoK5x8LP+mEY8SVlsElbnWCtpO4W7Yu6J7eDqK6xBoMclOls8STkRA4jFcT/OoGBmaKGx8hmrsuYsWWOvwJLOPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740011924; c=relaxed/simple;
	bh=P7UsRUcwKSD5flekPSIZ6XPWnnBvbQuqfzc4mO/MnxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VgSiepybUtEEYwmydrrUfPAnHhSDpBNXU1tW2J1lw2OJsWBiPOFz4QlbxQKUP+yvv6bZGkZ10ABqcV/Xk5dKted28AIm3NpX1Pi0fwvRoDZWIVEZWlDA6iu+87nIVJDvqqVegGvnyBPmMUEGUyTQHm5E6Ti6oh7w7xPaW/VAy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNAD4h9G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNAD4h9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE7AC4CEE9;
	Thu, 20 Feb 2025 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740011924;
	bh=P7UsRUcwKSD5flekPSIZ6XPWnnBvbQuqfzc4mO/MnxM=;
	h=Date:From:To:Cc:Subject:From;
	b=nNAD4h9G4Fo+MiRF7hX9xDibiQ34fR6gGVJeIkQUJy5aMIsD58cA8/cME9qDmhTHO
	 Dk+oLITZNVNaOLdV+8bLofHCbTRNYWOggNI26N9Ow8R0F4QBQhtGm/m2mUiYIELBMi
	 k/C+3ZrhKhLeF9BxOSXe8yp4AoBakNt0Q393CoqmJXaeJUj8jUP/ApLc8LcjhPiaeK
	 DzQQnQH7+83WOWYreB58rZHHKv7VXkfvIxIlomQwtKE3aHdytMgdkD2jzbkYTzI2b1
	 FazOUhfzdIMHWdeVNAhinlmKQKbhPofewutO/1W4JNJA464QJwVbms5lTUK0cDUVmr
	 ZfGMF/C+BvsLg==
Date: Wed, 19 Feb 2025 16:38:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [RFC] perf tools: About encodings of legacy event names
Message-ID: <Z7Z5kv75BMML2A1q@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello,

Ian and I have been discussing the behaviors of event encodings and it's
hard to find a point so far that we can agree on.  So I'd like to hear
your opinion to resolve this.  If you happen to have some time, you can
follow the thread here:

https://lore.kernel.org/linux-perf-users/20250109222109.567031-5-irogers@google.com/#r

Basically there are some events that were defined in the perf ABI.

  PERF_COUNT_HW_CPU_CYCLES, PERF_COUNT_HW_INSTRUCTIONS, ...

So perf tools use those (legacy) encodings with the matching names like
"cycles" (or "cpu-cycles"), "instructions", etc.

On the another hand, it has wildcard matching for event names in PMUs so
that users can conveniently use events without specifying PMU names.
For example, "event1" would expand to "pmuX/event1/", "pmuY/event1/", etc
as long as the PMUs have the event in sysfs or JSON.

And there are platforms where "cycles" event is defined in a (core) PMU
(like "blah/cycles") and the event has a different behavior than the
legacy encoding.  Then it has to choose which encoding is better for the
given name.  But it's a general issue for the legacy event names.

  Q. what should it do with "cycles"?
  -----------------------------------
  1. just use the legacy encoding (PERF_COUNT_HW_CPU_CYCLES).

  2. expand to (possibly multiple) PMU events (like "cpu/cycles/") and
     use the encoding defined there.

I think the #1 is the current behavior.  The upside is it's simple and
intuitive.  But it's different than other names and can make confusion.
Users should use the full name ("cpu/cycles/") if they need sysfs one.

The #2 can make the parsing code simpler and the behavior consistent.
Also it can override the (possibly broken) behavior of the legacy event
on some platforms.  No way (and reason?) to use the legacy encodings.

Also Ian says `perf list` shows "cpu-cycles" and "cpu/cpu-cycles/"
together which assumes they are the same.  But using #1 can result in a
different behavior respectively.  Probably better to make it consistent.

I tried to summarize the issues concisely but may miss some issues.  I
hope Ian can fill it up in case I missed something important.

Can you please share your opinion about what would be the best behavior?

Thanks,
Namhyung

