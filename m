Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE5823F38A;
	Fri, 28 Feb 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777462; cv=none; b=QejyhjPb4WdigEvLhhhTl2uW6vqYGLFSEN3QBXqWQHal7KrpnLGCjMFa4QqKzhJgqsp9QEoO4qZHvCnfPN8AujhNa2y6Ft6eeBCMOuhJo6adP0o3W+ygC7k61MRaQ74az/AXgo7gsswqKgEYhBOQVrN1fSDfvhtwqA/qeWhF0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777462; c=relaxed/simple;
	bh=V8gHM1ZhUdCQJV455uVJTz2023zQeFUl8Y1EfVDP/EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxfB50o+NXdybsH9/By9/fbmaRwQQ2svF8f8scj03BpqqHr/uvRzQgKEOMohs3mb6MKQ8+ENFpvnpZ7533ghcZyMFdmOK/egI0EuT8m4DdVjxUfos1e74X/N7yJKMUQG0PopSiv9Z/OgKAuZOxmOWSkXV2/mW+BedYpuaxpDMnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS4Za607; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS4Za607"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FE3C4CED6;
	Fri, 28 Feb 2025 21:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777461;
	bh=V8gHM1ZhUdCQJV455uVJTz2023zQeFUl8Y1EfVDP/EY=;
	h=From:To:Cc:Subject:Date:From;
	b=eS4Za6075WR7+yHKDqwifRhH1QBxsJ6FFkFdQvQDEIWbA+SEGZ6QmJF+uR7y1/Qf5
	 5dpsRFt07dUspphjKRJkX5Hi3VZL421fmTAJUFn+7lmdbxTPymWJpGVG81WoJfbVqQ
	 qEzJAF3vgHBGu6L2q6i25vkC0oFG5CCb4LAhwgTPQgbsdDH3k779ahTRYVmfD6mGfi
	 bOvddFGbdyt7PraBIV0otCcfBcJ7gS/oeeEmEUlvG/nA20LEl7f5mH1d2OJ8U2WBkS
	 c7IF3YJn0RblyT4Q+IlJgObWfiL12UWO/FJZ/wrkg7XVfptq1lbXM6mQck3vHXXoir
	 b3dcubYnRcxcA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/6 v2] Fixups for kernel maps insertion
Date: Fri, 28 Feb 2025 18:17:28 -0300
Message-ID: <20250228211734.33781-1-acme@kernel.org>
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

        Here are the patches from the recent session on fixing the build
when DEBUG=1 is used, please take a look.

        I think that since there are no reported problems and ended up
being a sizeable series, we better apply it to perf-tools-next,

Best Regards,

- Arnaldo

v2: Use map__set_kmap_maps() as suggested by Ian.

Arnaldo Carvalho de Melo (3):
  perf maps: Introduce map__set_kmap_maps() for kernel maps
  perf maps: Set the kmaps for newly created/added kernel maps
  perf maps: Add missing map__set_kmap_maps() when replacing a kernel map

Namhyung Kim (3):
  perf machine: Fixup kernel maps ends after adding extra maps
  perf maps: Fixup maps_by_name when modifying maps_by_address
  perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps

 tools/perf/util/machine.c |  6 ++--
 tools/perf/util/maps.c    | 58 +++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 12 deletions(-)

-- 
2.48.1

