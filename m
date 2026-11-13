Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534772;
	b=rgMN/X1DKAcwkNzMBQqQXzQVLWBzgz+NQtZq4SH797pnB0UrD85IxBAy4feG6mZYWrbQ
	 CSqnWqsJiS6f1jMaXW+okY/6Grs/qV7C84bZhGkuI7S7XL0j+X2VO8y9p2qrDLaEFKHog
	 YAPy+KVWldJxToGXdG85pU4gyfJV78X04rw5hAT3/uxlLum1n8dus1QLuQbS9dUaXE86x
	 qzrvXvl5h3gDaI/EtOGwkYTBGg0n3FDRqf2K9AbONA29dJn73yCcYC8fqTaq6E6I8enVu
	 vyJYU9nWB2Rgg5IN+S7SsXJvILmMhlK3fYvUXC0dlTMj0xlERLCkWD/qw7CDXEk3/UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534772;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dUzo3UGgXY0oHBScVAe5t2TvKWuG/rK4hhPW0dEbd48=;
	b=zg+hBd12u64A8n8jseO15PlH5tQNMNoCvWA+ptoB/jE4HoyLOzSe+8HeWTxvoNwhXKMO
	 tacdcJUYMahu++PKsTshnR3h1eLhauC68VkBxboGUL66LhAQLHoXz27Ey6QjDGN8L5mwl
	 GJJQ4gIIY5xJSGLUcHcdMgyYaqqxV7sjIOnB+50RLEBua5MbeZijVpJeyeYEEGDG6ZB+N
	 ktY9i/cdrpETyCPriVAzPFmBR9jBGHQ6ZhhpM9vXTOgKVS6rqfu+IhzAQRayfFIpE998c
	 Ui975xVjqcS4nhbP/zhmRwaVb8zkl/maktUyTBU59juDe3UDKSOgpXdQwaPY1b42z9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUjgymgh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1131B606A31C;
	Fri, 13 Nov 2026 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUjgymgh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153521F000C4;
	Fri, 13 Nov 2026 01:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534771;
	bh=dUzo3UGgXY0oHBScVAe5t2TvKWuG/rK4hhPW0dEbd48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MUjgymgh5PvB1DM1usyj8GMmNXD10UuhNp+4Xs50YA+7I9tsciAQB0BGg15x8CMRy
	 ChNyD6HtWLGBUAnBZq1azhDr/UFLyjLkUrN+rGiojt3wrAEpu/s337md/xtgj47Wy0
	 i8fq2kWd28/4TQxIPrNBu+Sc236HRhY5zXXMRNU3BY8f27hY4r9kG9QnsnEKdV63mh
	 iJ6hEl7nKGtbAGZ1xwFVv9Ofhp2HJYrmCtwZl2Klth+edTIgI4ezmQt32pBHLRtoLp
	 DYP9RzNADqpk9Zk3PwJEZoAPQRXzHkNP94wlDk+UFe4uDzch44rBSOD/aTCdhpBCDi
	 HXMQLVyn2nyLQ==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with the kernel
Date: Thu, 12 Nov 2026 20:52:48 -0500
Message-ID: <20261113015248.777097-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org>
References: <20261112195427.3411746-1-sashal@kernel.org> <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 12:23:47PM -0800, Andrew Morton wrote:
>So the 20-odd selftests which build modules and then modprobe them can
>find that some of the exports which they need were zapped by
>CONFIG_TRIM_UNUSED_KSYMS, so their modprobe fails.

[...]

>Does this patchset fix this CONFIG_TRIM_UNUSED_KSYMS-vs-sefltests thing?

No, not yet, but almost :)

This only builds userspace, and the selftests that build their own modules
(bpf, livepatch, mm, net/bench, sched_ext) aren't there quite yet.

It does get us closer though. With this in, a selftest is a Kconfig entry, so
the kernel build knows which ones it's going to build. For the ones with
modules we could then either build the modules together with the kernel's, so
modpost sees what they import, or generate the whitelist from them.

I haven't tried either yet. I can look at it once this foundation is in.

-- 
Thanks,
Sasha
