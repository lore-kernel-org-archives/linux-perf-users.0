Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0282BB13;
	Sun, 26 Jul 2026 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109221; cv=none; b=hRxoasu78b1Vl1iud9V7cf8NKnW4PUbSkPc8em28pYGwLaalKQWsrWqYP86xqLa0Hl087DO0bbqizLx87xpROImh5FTw//BXVg5UvV3Dq65/jQMxwldgt03E94CXtRkSe3tK81Zz3EfBLC+zNgBtIk/wDCxS66AIYGvYQqA04Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109221; c=relaxed/simple;
	bh=9/c/aWxAFNlJqxA7KonSYh6Ms8MA5c6S//SiEOf4yH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BCnH57I7kC/Fexn8h7LpORHIWPnPnGD91JXbm+w1s/zbGbxNK1DVspgGvLoXKJf/QupTOPrML8Z2yxfuWJ6wV8NAhWD1IgG7W2TQsLAVFvuxAMx0qXoXgkfscNcKIy7bvbw4p4QF4zlHGF6MJ2Aghd3lcfeboebDUHc6H94YlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2alZEcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2alZEcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17C51F000E9;
	Sun, 26 Jul 2026 23:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109220;
	bh=u8Tve/o33WGMCkIdjxdOam2z5LO6YjuuORGB8oJF5qU=;
	h=From:To:Cc:Subject:Date;
	b=g2alZEcO3cgV24EV9lpqNSwaSbBmDd/2Xla4rN10GDaV7zqqfG3nxTcTmfUXNC03w
	 ZuugqldVapW7x68WeHHgx/KwOnJW+K+/HnlIGocMUK7w4NjlcTXEBo9K6UHUDGbUaT
	 J7PG43AJ1DvcgKpOKcM5NyfYOformG/qlFW9eQuFqJBFtmCGNu7xMx9NQLoVpJwccR
	 +ZiiClgynu4f5P7w4WPzkcOQMIl7omcx+LnoafQeueutJjo1yJZ3+GcJ6b9o1xcQRr
	 QN1+1zZR3MUzdO2paTUG0Z4BQGtoxJBaKHF/m03Qbfh5izzhrkPGLByXG2HpsER/vv
	 kY3lnyNcm397w==
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
Subject: [PATCHES 0/8 v1] perf machine fixes
Date: Sun, 26 Jul 2026 20:40:06 -0300
Message-ID: <20260726234014.63111-1-acme@kernel.org>
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

    Here is a series of patches fixing issues with the 'struct machine'
methods, please consider applying to perf-tools-next.

- Arnaldo

Arnaldo Carvalho de Melo (8):
  perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
  perf machine: Fix NULL parent dereference in fork event processing
  perf machine: Guard against NULL strlist in machines__findnew()
  perf machine: Check snprintf truncation in machines__findnew()
  perf machine: Don't abort guest map creation on first inaccessible dir
  perf machine: Reset errno before strtol in guest kernel map creation
  perf machine: Free scandir entries in guest kernel map creation
  perf machine: Check snprintf truncation for guest kallsyms path

 tools/perf/util/machine.c | 43 +++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

-- 
2.55.0

