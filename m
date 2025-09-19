Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A891D54D8;
	Fri, 19 Sep 2025 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316025; cv=none; b=WeBrtMEY/MrqPQTHEX6Jh/O1iad2E5LyWTAlrC2BmnL+gIbsMQFSRbHu6DEavXbiuu786dS22rvQ55gr/E7QrGZbi139a9j56h36TaJS3noX6UmCKUlHLltp8pi+DOSUuIHqSXVTPvMifz4B29O13GuwiKwumKcZ9TgTGOpV3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316025; c=relaxed/simple;
	bh=ZiYDg642Gq4D1UAbZXmgc6ZhqVXL/p9B8S+mHkUwovQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aocETgeYvKw1BgGPITFvyydCxGCBW4g2FHyjc1En9nGDhfOoxHVRmZ+T9rBEt6aDtikbrYC+Y1nMYwqNbrWbnQ9eALghQgqaDZJwwxuN9j3FCqMbGuVnvemcuo5zhYYYM6lGekAO2elmLq+ufJ20VTfbijri9ySQ1RhPpyPhMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt/A7m+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt/A7m+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1186AC4CEF0;
	Fri, 19 Sep 2025 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316025;
	bh=ZiYDg642Gq4D1UAbZXmgc6ZhqVXL/p9B8S+mHkUwovQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Bt/A7m+WP2iBo7W1s12LKEpw5gDOKbVdy96eUSV1FlhkWEbHR1HAyHe/VQNTr5Ul7
	 G+tPxxAMjACI9Qyz/PKiyr9lgUNyd1GUhs2k7Gucf5eMSco0HRXJPq4OgN2R1M4gra
	 8d9jM9c5tLkyGxsOTIDeR3NfbyVKl+GhYlV9ZgNQjMji0j9A+JmyEz76Y/tLSI0d5Q
	 US9m7haZ2PSYerNvFzv9D1UYoNL6QfdAWgoR3QHWAEni7B462Ph2ire5MixPZ+lwtN
	 SJbfiRGMUKwMxVeWE6ANqoWFaTj4mtViz7v4bITl7appqXnEK0fGCNCJi/btrbZ3QE
	 9SgeZ1jQ3wUaw==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 0/2] LIBBPF_DYNAMIC=1 fixes
Date: Fri, 19 Sep 2025 18:06:52 -0300
Message-ID: <20250919210654.317656-1-acme@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please take a look, noticed after processing a patch from Ian
for another such issue, on a hurry now, haven't checked when that
emit_string was introduced.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
  perf bpf: Check libbpf version to use
    btf_dump_type_data_opts.emit_strings

 tools/perf/util/bpf-event.c  | 2 ++
 tools/perf/util/bpf-filter.c | 5 +----
 tools/perf/util/bpf-utils.h  | 5 +++++
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.51.0

