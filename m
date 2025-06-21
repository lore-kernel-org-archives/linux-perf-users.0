Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FF31F8753;
	Sat, 21 Jun 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750528883; cv=none; b=Eznp7c6kppMp6lrPrhLljxn5DbEjnfJ1UBmaslmzzgQpR5TWfTXlMY4RJYvN0nqKhHs0/etByIx0+AIZpCqGiYM0JRdQx65FYQ3XXTndqYJARyGxV3RS1013oC5/fWPrqAkJaDFA5VknVA9SYqgKPF3Iryxhu1L/hf4iT/61uFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750528883; c=relaxed/simple;
	bh=cgKZMrdaREWLFVQ/3rxzvJMlSIIgdA9YBDueSuzt0b8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BDfkde7TG4o2aCI2NwmKXN3639huKmKUKJ5qt4CSEusgy3RA6KiogR7NB30Oz8JWdNkiTLyvV5y0+qCpRgq833CQtQsvuy2970RbfSYm7a3Y7iP+VFgb9cujM47k0TGUYTzo9jwFr4Ypv30plGvO+QjINrSDJWC/sEchqlh00PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0gBrQJG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0gBrQJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC10C4CEF3;
	Sat, 21 Jun 2025 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750528882;
	bh=cgKZMrdaREWLFVQ/3rxzvJMlSIIgdA9YBDueSuzt0b8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=r0gBrQJGpDsT2THjNjeSJJD9J3y5qSAwA0HOgaSeBCoS5A7a7ZR5CFmS6T2gQAIar
	 SsZWGpo8JaM3dJuIY4yT+8lW14vQnhfMoAtspXEH32GRZ3lvpR/rNRJjuafO1R9rhm
	 IbzJeQjW8JEkk3Fma/0ZbJQAKw4o3DFX4CLiFVFgoUYYbSkR608896CmxY6o4/Ca68
	 YwJooL8dSt2VG3CbbICpZeR5282b2QbwrzUm9KcjSeI0IYMyicPikfMyFD1SGvUd5D
	 vgINUkoI94Xj4lreS1gx0km+GX63ocUBJKi8moyh8L8xlGGiTLdKUINzVEyEjIR9Eo
	 9Sz9ebtQEgHGQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Kan Liang <kan.liang@linux.intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Ravi Bangoria <ravi.bangoria@amd.com>, 
 Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20250614004528.1652860-1-irogers@google.com>
References: <20250614004528.1652860-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test: Expand user space event reading (rdpmc)
 tests
Message-Id: <175052888239.2250071.5449360979148529294.b4-ty@kernel.org>
Date: Sat, 21 Jun 2025 11:01:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 13 Jun 2025 17:45:28 -0700, Ian Rogers wrote:
> Test that disabling rdpmc support via /sys/bus/event_source/cpu*/rdpmc
> disables reading in the mmap (libperf read support will fallback to
> using a system call).
> Test all hybrid PMUs support rdpmc.
> Ensure hybrid PMUs use the correct CPU to rdpmc the correct
> event. Previously the test would open cycles or instructions with no
> extended type then rdpmc it on whatever CPU. This could fail/skip due
> to which CPU the test was scheduled upon.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


