Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA191377AB5;
	Sun,  2 Aug 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785680843; cv=none; b=GjmpqgzzYtKvWV1tZFKRjZIYUD45jkgSbvX+i4Dal/DB6Ja8I5olPkkAL6BJiOipcc7z8JhXUTliuO63H+AqjsQ1rUmaHh2eRxLnHZC2Zm9Hu9b9T+rFymVyX3uOwNdYHIaRjsgGQXs5ojNzR8My0VZcLPjAIAmztG3pwjt+Yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785680843; c=relaxed/simple;
	bh=8SS9M7mrsw8ZLAg1Wa/28hCJ8lOUd5IJqUn+xbriihw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkZ0Dpi38TIBw8PIuqyYwGdcLWcQAtRSdyjifyhuE7zNfU7WHH7P4GB1JIcWSC8tjsUcJOjO5lvvJCdcLDcUOg5Xjt27vgmDQFXSI7ENu9uGgXbGLrBJO2DaD+DjzPJqqLJGW0Nkd9jAqikzBbpM0VVucbZ4KMdhYhohIjSsrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwMRJGtY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwMRJGtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67311F00A3F;
	Sun,  2 Aug 2026 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785680842;
	bh=56byXIywza6YZoPY+jg9Rvtsh+y8d7svydN6NwLArlk=;
	h=From:To:Cc:Subject:Date;
	b=AwMRJGtYpufVBy3cuKeQ2bhqntLWtCpbMMcTzLUdMNTIHY0txUoClFJfDNrH318iA
	 h2JotmNBO1Tg56Mk92QAkUD/kQ0W5IptD8GGP1uo8Wgd6OzLEFFZW7YozB5sALXubU
	 8N+OqFiFviXntj4sViutWAATpjVr+OeqnKNbiK7VxktwxIqG7bTp8rhSFuNFvf7TEV
	 dbLPRm03YlOD2lwhQYOpMGTqtFY1i2LXK+swV/h0BvAeXp99hsuNcD5S5tBNAe7Zl1
	 IPYRhE8v9pKINFBHEL4CxBi/TKsSzfMBJgSqP70c3dF67ppbB6gkzp56EWbx44qVk2
	 iLXspYGHtcjSg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/4] perf bpf hardening
Date: Sun,  2 Aug 2026 11:27:08 -0300
Message-ID: <20260802142712.154726-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please consider merging,

- Arnaldo

Arnaldo Carvalho de Melo (4):
  perf libbfd: Validate BPF prog info arrays before pointer cast
  perf header: Use write lock when translating BPF prog info pointers
  perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
  perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly

 tools/perf/util/bpf-event.c |  3 ++-
 tools/perf/util/header.c    |  5 +++--
 tools/perf/util/libbfd.c    | 23 +++++++++++++++++++----
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.55.0

