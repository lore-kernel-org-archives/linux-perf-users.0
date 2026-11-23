Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470140;
	b=cIZQY4HerwkQ+b+QRkQ5exWuvhrl0YehK4A5Jx1nKzW7C/RLcuKPAQDgTJFrusKt8hOV
	 I8/0bR1KDG2F1BRrjw50xy8Fkx46EOYTZxThvTRJB+/VD0cllWn7iZAl1NnTOPqqX5dAH
	 U6fLMysacQK+d4MEX5GVdQqUrEwcwczEiystHZASE2wROzH0JyQmD5TnfQSIMxgTUOdBR
	 Rtslt4CWmCm8ysboeBpEDrrY3lBmVCEEL7zcCS9sqzSiCyHMtyZERTtfUosIHi6bUoHLL
	 xRbv5mIxNHRfOTOHalf5ztr/Oqfila63N67Sx/i28nw0IcBD5Dk5p+sQGNhrg6dmZ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470140;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=+AAwRjxJmqdbBh0bAojvV002+8F1foY5LnqhXmP6M1E=;
	b=o9s04xtZataTDZly43n/4fqlH8KB2WNGgbana9CWHgydY5WkO24vNnn4MWwfQY3G7ID1
	 cmtbc8HixH1UGK/HfFw6DgnYOXdIfXM7NhUner9LCEwzW4Hxi6BDNoqurp/f6Naf4v8O4
	 LAGCoFMPNRJ1eICbsQMkTuA/p+SNGFJMO+qgUrovlKzrEuFFSNjpqO1kEZ1Cf5gAA/o9G
	 +xePXPGrvhxd1pScVEbL49jZgga8k4osY+CkulsfsoqQfG3eMBcp9kyBpvPj9M+fak75+
	 rKjN0bxbAtbLkdMPpHAadaYD6Oj9nrvB9B/tY6kFujz1sQiL2vWIUYHP51mLmFv9dfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqXTzp9V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD83606A331;
	Mon, 23 Nov 2026 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YqXTzp9V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF531F000E0;
	Mon, 23 Nov 2026 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795470139;
	bh=+AAwRjxJmqdbBh0bAojvV002+8F1foY5LnqhXmP6M1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YqXTzp9VMPfLb2HDctjs8ZF0+NgOkiSRs399hOr78f0zEIfEfb5t3Z4GBFk5NG+Qv
	 Dcqe2kaOze4Oz9iML4UTA8bLPWAAb7VmnLaescYHjbBPehXw46HZT8sDT7kW4rhJIE
	 bMbT1Pxk8oPFp067BPNrSBRY50jqCBFvM+agw0zINeNO/psH+rF/m9mA3h5Jee4rHu
	 tuXiVeDSUtv+2QHvN48igcB4J1CBf5TqI6aThHNVe4d4zVGvYcS9CcKe6pu9n3XnDx
	 Oas53bP7BTG9KGJF3O2EYTD4m4an9rExbZXVyZ/m0x04QYxECNPTa8+EqwlikjnGYX
	 lxkuz0MKwm27w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alireza Haghdoost <haghdoost@uber.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261121-perf-dso-ns-fix-v1-1-897322ddadf8@uber.com>
References: <20261121-perf-dso-ns-fix-v1-1-897322ddadf8@uber.com>
Subject: Re: [PATCH] perf dso: Stay in perf's mount namespace for cached
 debuginfo
Message-Id: <179547013926.1307628.4749401160459026214.b4-ty@b4>
Date: Mon, 23 Nov 2026 13:42:19 -0800
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

On Sat, 21 Nov 2026 14:25:23 -0800, Alireza Haghdoost wrote:
> When perf reads the data of a DSO that belongs to a process in another
> mount namespace, open_dso() enters that namespace to open the file. It
> does not do this for files in perf's own build-id cache, but it only
> checks for DSO_BINARY_TYPE__BUILD_ID_CACHE.
> 
> Cached debuginfo files (DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO) are
> in the same build-id cache, yet open_dso() looks for them in the
> target's namespace. The file is usually not there, so for example
> perf script -F +insn prints no instruction bytes. If a file with the
> same path does exist there, perf reads the wrong file.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


