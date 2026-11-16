Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853470;
	b=Xpg3acrW2hN4d0pLgMJGfasD7xEj6KHBp7m6tp/R5wgRUR29Jv0o19rx0sM8pNK9kj82
	 9+lEMFYh2BA+tSZI+ozNBf2YJZVG+7dznPuy3YaDU4PafB5lIuMLqjKgHVfXXBH3uJboL
	 6EJJLKCNGbi5TCuZvUa4lhLxUH/m+Dp/HcfbIOrORVxjfz0SaWGPV3S7dXhrYC32x1jlC
	 cpgElJy2bHnipcVpGQBiPw7p44FrL+iIDwpQ9EcUmUF2/uKdf/7oDYmYwZmThGgFrEkpw
	 9WrWMhuQ7lcXPfW3UFg3UnCdY/Kf1WwXzfF2cyEvOzj2U6rW32KIK2Q9kyaHQ8TZzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7dwI6ryF/3LHmK6v1uh53NgSfBQ1URZHRSTZWrdo+p4=;
	b=j4rNS6cp/q+53U18zunSP5ev9OL0dH+Rh2DthMD7pAb0QyPWFZaplXqp5pZrWpYGkqrO
	 gozoMTTn9uDY9PkJlj5WlB+lynEXZIOjPx496ZbL/L0PcH770PGaEEx8TzLSQnrcW8HtK
	 adfxMx+XYR1+2mU5/ToCbCjEE6BQhDjH5ZFwzgMf5218yOMRsW+4OqbJPbq0rgOyXiHX7
	 t/yh3O3f51/nMdJNtLvqkLII6jF5ua3VlnxqT7fzqIUJlXSoS1LRzhC9idB6t6HwhTU+z
	 ynmbbGul6TEkbZcScYr7f8+pMIM/6O8nzM2Fa2FxcDWGjUoi5IIqEh8lmB+7/8Ri1Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZSmfveI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D07D606A31C;
	Mon, 16 Nov 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZSmfveI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBE51F000C4;
	Mon, 16 Nov 2026 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853469;
	bh=7dwI6ryF/3LHmK6v1uh53NgSfBQ1URZHRSTZWrdo+p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZSmfveIbFEBuSWud/WrPK90qeqJ18EqcgIAs6QQVgXWC0CaWqBtEb1k68VLGQzbb
	 Jv5WJQHZWcnjaBY5MD6eYSsnRhMPrxJFIUYIDf4RX/0o0zElCcsLmMegGRxxFsYuS0
	 vqqOXT0jTysRXPf/Y2vSFjcNmqDBXVH3dby8hOgLyrhXVHik2d+YMghS8ipT3BoAcj
	 Li+1lQ+FjSFnoE+pKoLd/35wu4TIhWL1j8WThwUgO0QTrtLEDzRlBXJGHnnS2SR6KU
	 bwCwXWY5V2w/uXYXv7r8e/9mQkNL12tnz5wnM+yjqwtzV34dDhqX2zO+QrBzeABSqj
	 uSJWDXT6eXgig==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org,
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
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] kbuild: build the userspace tools in tools/ with the kernel
Date: Mon, 16 Nov 2026 13:24:26 -0500
Message-ID: <20261116182426.3440056-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112195427.3411746-1-sashal@kernel.org>
References: <20261112195427.3411746-1-sashal@kernel.org>
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

Hi Nathan, Nicolas,

Will you be picking this up through the kbuild tree?

3/7 has acks from Arnaldo and Namhyung, 4/7 from Namhyung, and Shuah and
Thomas reviewed 5/7 and 1/7. What's left without a review is the kbuild
side: 2/7, 6/7 and 7/7.

If you'd rather see it go in some other way, or want something done
differently, let me know.

-- 
Thanks,
Sasha
