Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2322FE0D;
	Fri, 21 Mar 2025 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581809; cv=none; b=WY7y3rpcn21GZLhyjAoeJGrB6J6NLA98iqAU/xuydMGGNu1qUVpI8Xy+Z+pKKJMm9OBR1jaS+BleMKWrSLk46H+nUxej4BoQWfj9oMK9QgFOx59EFoEHkVlWLF8t3a6uGIFq1E4CuisjYkNMGjcpfKCF321kfrZMWM0gfXfQQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581809; c=relaxed/simple;
	bh=Aon3MpuqI2KphyJJxW/mgSijVLrvb2iG67m72HH1MKc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sr5XN/5M3DNGy+3dJkTWNWlMhOrpri5ClSemwK/vybTXufqYanSOn5adZ9HB6+zCqwF2d6EWcmXO4Swl6a8Hawy/YoTOwJV6Xgsq5G1D6Kt+6zEkgMI5sNi6rp41pU6XF89mz9yu6JFaLvsecfeva57k1cuQSdH76OG4RMGbE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=da/wdTBU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="da/wdTBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EF2C4CEEC;
	Fri, 21 Mar 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742581808;
	bh=Aon3MpuqI2KphyJJxW/mgSijVLrvb2iG67m72HH1MKc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=da/wdTBUJ5ngQarDW94IRkO6+fhSqJjh3qAwgHe0AJCeraT/nuof6vKiDPfEldpB+
	 Ev9nJ+X7z6zIQr7K43miMJoSW4ar1pZoxHfE3vTdbXIrfafARUt0OxKYL7JS5+0JUd
	 +5ErgfRoLQgGUHhut1mQqpofgYCAvW8xIKr8iQ+DocDidcBTccppwAHCTQBZ87zcKH
	 UCvJ5M8VlfE0l/vmF1WL1aA7zGrFk5YtcIABNy2L0PI602Q8TvRekFkB08FDXcd9GV
	 7591axIwNbAESKy5nBIYVWl04wD+RQF7MHRGuQta6/mYx8tEarXLlWGXzClqbL8fcD
	 6fFNqXKe4IrCQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 guoren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Charlie Jenkins <charlie@rivosinc.com>, Bibo Mao <maobibo@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Arnd Bergmann <arnd@arndb.de>, Ian Rogers <irogers@google.com>
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
References: <20250319050741.269828-1-irogers@google.com>
Subject: Re: [PATCH v7 00/14] perf: Support multiple system call tables in
 the build
Message-Id: <174258180770.163787.17026526140964969734.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:30:07 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 18 Mar 2025 22:07:27 -0700, Ian Rogers wrote:
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> 
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


