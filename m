Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715970;
	b=kSLDBIu3zL7s56iX7N+Mp9FfwL3FHYVtA+gwHQXmSm6jiXWReiPxKZ7ejF2cWV6yAAS9
	 H0u/pFkh+ebXky71WwXRW0EqPjrkx55m5qjUQJj70eRFYLCua8C6hzFKuUHdr7O5OYXVc
	 JNoDBNO3ZilzQI2J+d79rxvWWMVac6bnqaKX0wlRqFOwjasWAymC79xd6rk81ziutZgBG
	 FJRLYOyclMqKdoY63hH172FL6sAOR5AfG+FmQ+Km7vOK5Ya+nPcoEiaPGb7faeq86leFX
	 GTFcWsfSIpNNOCZKD4G0SeiqhwRluXZU+i6IYWClw53rIin8U/2pAfTrlM+X52KpQ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715970;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=9LSITRiQijYSFrT/DvW/alE/qNZS9UkZJZR6baRYh7c=;
	b=oo873mOqe2z/JOwz2kC02Amn4C3L4OG8QuxRLDzYpZ6DxNPGXYJS73rNF8srS0Xaj86y
	 qhC9wOhzmu9FIofeX0DnG9kxT6yuwgg5sl/HOSVZul+41uXf4EZX8fWBXC2EUGB5l2mgW
	 e9/+rGJCvqSt4Q1ObeOcP5708ZV53pXor06XwDGtTUplGgOD3ZgFrsPcfsxdq8BOrwaKr
	 VeQBKHbqkASPMMownHQIP4DYZo4XCc/1EFi5eFZBlo00Ky7zYFmyZdmdj5/0UG0m2BFIX
	 AISJXdKSyRQKxngPQcOBMzlOruo+apffFTWLGyhbjhZfTPYM9j4Lmkr4kzrd7ghL+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Xet/4il+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664A606A329;
	Sun, 15 Nov 2026 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xet/4il+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D0F1F000C4;
	Sun, 15 Nov 2026 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715970;
	bh=9LSITRiQijYSFrT/DvW/alE/qNZS9UkZJZR6baRYh7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Xet/4il+dGcvuGes9tzT4hdSBJrGxUksvumEEHXtXMiBDsgE99lvWgkP5tcIleqrp
	 BaHSwcuTFh2YiLYZ47ChkNGRnQnXpjVkBVEsrjIsKrUJhzriN+MYNjW1F8a6Kl04Xk
	 yHSHHbt/oIXY2cCG8254bgHReOBjxk91W48vcYWiEqozZ//y1/hRMBrmWQRDIONG2/
	 FzIE1XDK6/245EUOta3kwn9sRmLzx9zvezNcIKWU9VzjSSrPqFj0bQ7k4T1kZNQizt
	 Laz3LTs6v1ewixSu1zovzjUcyD6MF2MQfdSA1+qc6lhdy5fTEQ5sABowpYTyYqOtbU
	 +Y6o1+7kkmOyQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Quentin Monnet <qmo@kernel.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
References: <20261104043006.1199857-1-irogers@google.com>
Subject: Re: [PATCH v3 0/4] tools build: Fixes for libbfd -lzstd dependency
Message-Id: <179471596839.616307.5061349136120813335.b4-ty@b4>
Date: Sat, 14 Nov 2026 20:12:48 -0800
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

On Tue, 03 Nov 2026 20:30:02 -0800, Ian Rogers wrote:
> This series addresses build problems when linking against static
> libbfd/libopcodes on distributions like Fedora where binutils is built
> with zstd section decompression support (requiring '-liberty -lz -lzstd'
> together).
> 
> In v2, commit 89d001d48ec7 ("tools build: Add zstd to the binutils
> library feature tests") landed in tools/build/feature/Makefile at the
> same time, creating a merge conflict and only adding '|| $(BUILD_BFD)
> -lzstd' without '-liberty -lz' or the corresponding
> libbfd-liberty-z-zstd feature check in perf and bpftool (so even if
> test-libbfd.bin passed with -lzstd, perf and bpftool would link only
> '-lbfd -lopcodes' without '-lzstd').
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


