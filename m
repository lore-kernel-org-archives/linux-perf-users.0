Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D33622EF3;
	Fri, 21 Jun 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980559; cv=none; b=CYZoaPkn8KP+Jj344Eitah8PRNCUqOtMgqzU8vj86AQA7bS9SFGdGefGTuWU2rKwzn65EWV8q0ckdphlmmFH4UqvsGjrMhUgZ5YfFnN6bz+oPvjqtu0w8t1uYbPqQdclDJn91pnd3xctGyQUCQ7y1oYUfk93EESK0GohrlX0krk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980559; c=relaxed/simple;
	bh=YPWIE4APKjhewzN0WvymUj7Rt1lhRN0xQEkZzkVttIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzdpIRhRHZ2pncGGFSTLuuzNCATRv618GptLzlfvay1TYtvCNgcO9t8qlITjmrGktsoopVq6v78VxidGFi/ODUX9gzzTXhqpQ73Bk/AMt/agOqCLptxkbWPmWH65LBnAr/15stj32VU9ALgQ3qAn+adciS2TqrVlQ3AAIHBK9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTJ8YiFR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTJ8YiFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976DCC2BBFC;
	Fri, 21 Jun 2024 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718980559;
	bh=YPWIE4APKjhewzN0WvymUj7Rt1lhRN0xQEkZzkVttIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTJ8YiFRfkE1PQMkvhJVf25rvQ7pR4jxO0o7vKhw02g/0BOO4o2ZVWGdv7vEDlut/
	 h1GBC+eygp/IhW+dg1f7BuKEF2EUaNXA2Lp0aimcSpn/nSvQue+AfNRfylHy3cZqMP
	 HrhsNsbVSlt00I8qxHu9funb6u2oeLkphgtT3bREJle8m2MVhYMKuTQEabSR3RE6vc
	 0nWOatW4mjQvO6/vFS/kftRqNZO0iGvkDE8gcqWtDXN/sO+6LvH6bPj3RdP4iWUP1b
	 Sg5AQvxYZYGnhXlggcBXUvsROcv85if1MDvVG2EvdO4HA76GEeFjJD/lHWmhVpYtqQ
	 6aa+tn+BwanDw==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: Weilin Wang <weilin.wang@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v2 00/37] Update Intel perf vendor events
Date: Fri, 21 Jun 2024 07:35:57 -0700
Message-ID: <171898054728.3878341.620083012448507466.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240620181752.3945845-1-irogers@google.com>
References: <20240620181752.3945845-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 11:17:14 -0700, Ian Rogers wrote:

> Update Intel perf vendor events from:
> https://github.com/intel/perfmon
> Adds new events and updates TMA metrics to v4.8.
> Add counter and experimental event tags.
> 
> Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
