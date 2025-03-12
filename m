Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C73D76;
	Wed, 12 Mar 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795620; cv=none; b=WsLSSE2FVVGvI9y3hSw7khS/KgOzswq0Ud6VHKFM+/T79jcYP5lGc8w+EvIe/gRkkY6LkfSpA1+j6nGqmi5v4SnQSfFNjwyBuDhM3bON7vAkL9H6oqlrzdne02E2zZtlGSldNaDppTFGFgnl4z1OKStreKiJk44lJqdQqsmvbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795620; c=relaxed/simple;
	bh=9z8T3e/B6ue5UlE1EmcIlYANBMvmwiw6Qss3+xQ4mig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BbJqE3qRfjMcD7ZT/BxXcfHeAeCpuyhG79IRmCDdqyAuGYr1XPWXWggafQl2sDNDheU5Yv1fRaoE6MAtt0yYfhhnAm0F4UMf0L+pE15o6QuX7oZqSmwXkvOYk9Qcv5QMWJ5+xfnNGqxrA+ElKQTsEpy0E73DnpMlSeJ18eC60RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHA+s+XH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHA+s+XH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9E4C4CEDD;
	Wed, 12 Mar 2025 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795619;
	bh=9z8T3e/B6ue5UlE1EmcIlYANBMvmwiw6Qss3+xQ4mig=;
	h=From:To:Cc:Subject:Date:From;
	b=qHA+s+XHvR8j8whWOnOEt9q+vJiG+JFqJoNzWjrBu3/XVEYJoarUUoE2n70Imr3Yx
	 WgKJ+q9COlXiI67LL9QhD0n5PjgK390SPALHpGTZZntkHMoWjgLZIbBfGkDdeJCba3
	 Hr7iwAgpG4LoxAvUAcAqNZN5SAbWzj9dvOGsGl/QRZK3WKgmFHrFEzTmL5KV6x86Jx
	 vZlTQ5WATZY688LFRrw+qNH+hQ7AFE8AGSKIRTKax9U6HBxz9L3nFXAvAWcNAqltuo
	 3q3LWBrMvSUS65Pp+24cx+Lq+/Yzg60cFTDrRkAsWeh4R5ixk6K3UUfOyDdBsswTTa
	 7Ked5KtdL408A==
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
Subject: [PATCH 0/3] perf python binding fixes
Date: Wed, 12 Mar 2025 13:06:48 -0300
Message-ID: <20250312160651.280817-1-acme@kernel.org>
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

	Please consider applying to perf-tools-next.

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf python: Fixup description of sample.id event member
  perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
  perf python: Don't keep a raw_data pointer to consumed ring buffer space

 tools/perf/util/python.c | 47 +++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

-- 
2.48.1

