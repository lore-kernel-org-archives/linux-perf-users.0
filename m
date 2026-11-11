Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794424172;
	b=vM00X5opqy7pq1BI+qHXNqRNPp0a3sS3HHg09nwjxOR2qbFWqydu0C6niYZkKJwEpBKf
	 nb6pslpZLsOt2IMtUQv8yFtx3dlknnLijqNANHyj1Le5cp92qX+bHuSeV8vRth8Bhek1l
	 vyU5456GtDvTS2zfy+tsYYBI4/jcN1JVTv85rnkUtou7wsH/ENMp4d6BT1uC0kEnOJdt7
	 nQ8ffXzgdr+3iVsTmRPXCA08i2sUhPm9Hrh6izLbMZzFGRFX07dr8BdBsnkFDLsyk8ymJ
	 aKCWKPIs5QtkYBj08yG2iTHJ5Foj1EAzVQ6hcwsGrBbDuVaNbtQ0nHJn7BNxsLN0R8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424172;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=HEVja3L/VjRG6hM6oj72SnNQIHGzvqJq6QKTUxn4iqU=;
	b=QqOUjnqFeqHjMycXC2fxT7JLm2KDvZjLbSRlLOV3benvOMZ0FB/1emM2WJJL8XqGbQOI
	 afRH+OqJeDBdGYXmmmEX78et5rEsvE2HiCfdmggWYGl5N5maIZKdT7CBhz8YpOPdO1L76
	 W49YJ9dGYmSXkcNRvP90dUX/fFXJ4hOcKiF9pc6r5IkLgtVrphr96spxKs1TIxXy22GmN
	 a7iTTN45bxk5Zim5BOUIGf1ZwvVJGsckUKLnSBxK3aPiFRTCYT/3ZqgtvNJQRJmnxUVnU
	 /8/mYdySJQQXu37g2kd8fVOwKnFhP6bpX6fT7WcxD4N1sprLkms3CJ+As+wcgihNm1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWiEPkNr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5380606A330;
	Wed, 11 Nov 2026 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWiEPkNr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE771F00A07;
	Wed, 11 Nov 2026 19:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794424171;
	bh=HEVja3L/VjRG6hM6oj72SnNQIHGzvqJq6QKTUxn4iqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MWiEPkNrPmU6FjfY3z8ffiS/m91fov2oIT0pwveO+U4zSSqbRlx/4ds5IQLxeQADc
	 k4sSMAR85/UbrKFo9pjoEJ8TbtMK2BGZPxgpAxIDXo3ThNtX4Paln0Gma5cYKamiis
	 1M3Q7g0C9bUanjteKO5nU+8Ot4SCp+Zp254a4Bv1z8D3ztdphIcrkN1UUBChNKT0TG
	 O91DgL8eTtxU++K7FPFXgw8VLYlCdedj5h+JS7zoqJNqwOtUI8eX0JRNYylFUnpwmT
	 0FztE02hNLVwj5FjByxTRbTV/fNvDj/qiwmYd8WrAcQgQbdMB1rLmrbuuUEkyq5UGA
	 CYWfbIg0dpuNg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Stanislav Fomichev <sdf@fomichev.me>, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
References: <20261021-timechart-io-no-tp-v1-1-71779e7db01e@gmail.com>
Subject: Re: [PATCH] perf timechart: Fail IO recording when no syscall
 tracepoint is available
Message-Id: <179442417102.676192.413775768456202137.b4-ty@b4>
Date: Wed, 11 Nov 2026 11:09:31 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Wed, 21 Oct 2026 10:56:19 +0800, Hang Zhengyang wrote:
> 'perf timechart record -I' skips the syscall tracepoints that are not
> available.  When none is, e.g. tracefs is not readable or the kernel lacks
> CONFIG_FTRACE_SYSCALLS, perf record falls back to its default event and
> succeeds, and 'perf timechart' later fails with a misleading message:
> 
>   No trace sample to read. Did you call 'perf timechart record'?
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


