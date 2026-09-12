Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C4326A0D5;
	Sat, 12 Sep 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789191432; cv=none; b=HcB1SHJHKGl5IgF1P7nhBMOEa8vESZIOdcrtSycnJTNt72XU3+GQcE8SGdTUVXY34dNaASfF2zlX8ppt8Y7P+EGE/kLymtalkJAZJRV4v8yb79B7ZNRB7IAvYohiknx3uoI9L4bmuYTuChrskQUZwFUvCDhw2qhkPYp3G/gdROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789191432; c=relaxed/simple;
	bh=2uFdiYBDkzeiQCG8W7bpoCOI2easB6dg+gGltrThoWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3RgKsewQknGYQJa32n8/Gat7QTEN84GQbkj7M4OPOkq6waUWUI0ZuAROkMCWVDlSR2ItpiW4X51zCIvPtqPD1IGzYPNAoc/WqT9CFHsiqDq0aK9JtWI/6Hg+PHiZMcHqwbVVhkrPSNV7aN69yeADMedqRYlT735kPU7tU3FFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ej+92Dq8; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ej+92Dq8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=P1
	+b3+TE4uR/tlNMgI8Ii+7W7xKRJFb/bywQznYnCfk=; b=ej+92Dq86Td/1xtcaG
	aIQLI6Hr3+34JhopFE8LQ4+oQlIzTEc0drIJsVoQ58ELO/hWtSYXu9WoDhP0p0Xw
	SqwkbJMd7c/y8ooyxlA13eeqpxQAeEkwYXP0QBsqy1r5tsm0lLvjgZN5wfGHRbcz
	Xibf7pLZcw0MlOz1ONYQ5QysI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD335Tk5KRqr5rKAA--.16369S2;
	Sat, 12 Sep 2026 13:36:37 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-bot@kernel.org,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: Re: [PATCH] perf synthetic-events: Check schedstat domain allocation failure
Date: Sat, 12 Sep 2026 14:36:36 +0900
Message-ID: <20260912053636.2242958-1-sh_def@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912032114.A02C91F000FF@smtp.kernel.org>
References: <20260912031112.1814574-3-sh_def@163.com> <20260912032114.A02C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD335Tk5KRqr5rKAA--.16369S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr45Zw18JrWDKFyUtrW7CFg_yoW8CFyUpr
	WrWwsYqFyvqa4jgwnxZrWUXFy0kw4xXrZ8GF45Jr13Zw15Gr1F9FyftFWUu34fCr4vva4j
	v3yYyanIv3yDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUx-BtUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbC6gU2lWqk5OWwQQAA3y

On Sat, Sep 12, 2026 at 03:21:14AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This isn't a bug introduced by this patch, but there is a pre-existing issue
> in the caller perf_event__synthesize_schedstat().
> 
> If the loop in perf_event__synthesize_schedstat() encounters a line starting
> with a character other than 'c' or 'd' (such as an unhandled trailing
> newline or a new record type from a newer kernel):
[...]
> Does this check incorrectly assume the event pointer is NULL if an unrecognized
> line is parsed?
> 
> Because the event pointer is freed at the end of the previous iteration but not
> reset to NULL, it retains a dangling pointer. The check if (!event) will pass,
> leading the code to actively pass the stale pointer to the process() callback:
[...]
> Could this trigger a use-after-free and a subsequent double-free?
> 
> Would it be safer to initialize the event pointer to NULL at the start of
> each loop iteration?

Good catch. I confirmed that this is a valid pre-existing bug.

After a successful iteration, `event` is freed but not reset to NULL. If a
subsequent iteration starts with an unrecognized schedstat record type, no new
event is assigned. The stale pointer therefore passes the `if (!event)` check,
may be passed to `process()`, and may then be freed again on that iteration.

While checking the event lifetime in this loop, I also noticed another
pre-existing issue: when `user_requested_cpus` filters out the synthesized
event, the `continue` path skips `free(event)`, leaking the event.

These issues were introduced in the same schedstat synthesis code, but they
are independent of the missing allocation check fixed by this patch. I will
keep this patch focused on the allocation failure and send a separate patch
fixing the event lifetime in `perf_event__synthesize_schedstat()`.

Thanks for catching this.

Hui

