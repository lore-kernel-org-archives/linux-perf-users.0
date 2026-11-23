Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458003;
	b=lIFMyLQEh5eksnuKWulA/FI60MspN5gCW8K/dw4OqbsMeb0W2paYrHr/8D1ucEUEMWMt
	 8MxCd7MgqJIPI5h/NXYfI0wkqU4zg1bmW0CsyDciH54/z8U5Xd8QMn5EFilweoNhPLYKT
	 kmC82nc+ait7i+GpWO4Q1MH0N6blPiLiD1gXRt/4b+PgdAwKEWW1K4TcIdjC+IpgvXJse
	 ntAOSYJJLC13tND3cJnmMdPvyK1CR0DuBKDjFIuUMAh2n4f0cEk2/HVVGxqmSGaj/mQS+
	 +/GuzW5241+jc5YW8xSUPbjVFBl7GyDv3Z7nMOj5AvAMe+2aoxjTiyh26/nLQC8yOxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EO8eu0bYnAh1GOQsDCl+dlLUeJkRh0/Dt8ojn8au+KU=;
	b=DJD3HIxSZ9wXnmOkxTxZgndh+LqU685J6cps5NEg7pI42iupqn71l83MRpqyz0cQn2Os
	 xrOHIR2FatfheXf3wFH/QH4LVuwKjXjhL3Y8bwEuWjBgIMI9jx1qKGxRrhFBcN2pHg5+4
	 JVarmVmL3qeCiW9LDHdck9wNuWCf5J/0q8X4fVVlqwP1ePUzjQd2H+Bx+JMv0MQ7yQ0el
	 TLOV3XQ5fhWZ5Ed62hu61PpzZ1hYH3XXXdPmPjPTyc/mjXCH+bOWVbjeddrJCAeL94vLb
	 JWW61AT6ZSPWKhdxERbowb/Oqs7dsSTxk/Dy8HYWFt/zfUtp4KbZzaXWxv15vTZbIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqKijzK5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADD606A32C;
	Mon, 23 Nov 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fqKijzK5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B0E1F000D0;
	Mon, 23 Nov 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458002;
	bh=EO8eu0bYnAh1GOQsDCl+dlLUeJkRh0/Dt8ojn8au+KU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqKijzK5AXg4g1a8qc8syLJ3Jrh8hBZ5e/ujXw4qjoFMmoybocWgPyekz2Uk0wsdn
	 2RcF7wa6u94aqjFfYfh47DR1rMd+yVYCCiz0iOh4tlFCFPJPx2p1AD8XbS6dZgdLqs
	 CJhQRlaqE75vJ9KmjE05hlDTw8Mr/8KvgQBSzYvJPqmtiO85uf3byZiV+rERmn7FyD
	 xZFxb391h8nx0WPxlqwUNIOWQ5c+/XI4d9Y4j9RbR2nC91XMejAd0U7eA5A9rAEpHa
	 GI9QDUe6z3RGw8zp+y39UsLKGvtZjq7QDTE/MRPtxHT/HaUCZ0tFgkmodqOXsO92bM
	 Tt+3EW6pr8UeA==
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
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
Date: Mon, 23 Nov 2026 13:19:58 -0500
Message-ID: <20261123181958.2032855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <awCzNfN-OMesd12z@levanger>
References: <20261112195427.3411746-1-sashal@kernel.org> <20261112122347.dbb972627dc856c50eb01cd0@linux-foundation.org> <awCzNfN-OMesd12z@levanger>
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

On Fri, Nov 20, 2026 at 09:53:09PM +0100, Nicolas Schier wrote:
>As mentioned above, the tools/ tree is not part of Kbuild but
>re-implements some of its features in its own way, cp.  commit
>6e6ef2da3a28 ("Makefile: add comment to discourage tools/* addition for
>kernel builds").
>
>I am sceptical about integration (up to) the whole tools/ tree into the
>regular kernel build, even though I like your motivation.  I try to
>review the patches within the next week.

Thanks, I'd appreciate the review.

The series doesn't change that. Every tool is still built by its own
makefile, and tools_build only runs "make -C tools/<dir>" for the
directories enabled in Kconfig. Nothing in the kernel build uses the
result, unlike objtool or resolve_btfids.

I'm just trying to create a bridge between the two.

>Why _are_ the selftest modules built as out-of-tree modules?  Might it
>make things easier to build them in-tree instead, or is there a good
>reason to keep it the way it is?

Some are in tree: lib/test_firmware.c, lib/test_static_keys.c and others
are built with the kernel and only loaded by their selftests. The
livepatch ones were too, until c4bbe83d27c2 ("livepatch: Move tests from
lib/livepatch to selftests/livepatch") moved them out so that they can
be rebuilt and packaged together with the tests.

Building the modules in tree would fix the trimming, but for livepatch
it would undo that move.

-- 
Thanks,
Sasha
