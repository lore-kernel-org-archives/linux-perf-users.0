Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119F41DE18;
	Mon, 27 Jul 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172011; cv=none; b=mv8Q3xpUgrfanXjRqcPj4X/vUOoQl8Qkj7GG3eYKXXNu1OcsX28MVAjUD1GNrh6VCNiVvGmz1TEbNAy9N8wZfJP7XAkSRRDJtDIxOxujotUcZhgOKjOdGidodfEe4Vf6ZqVn6O17YTmVa1kXZ9WMRaonwMe5J9MuNHN72dzX1ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172011; c=relaxed/simple;
	bh=Zsi1kZF0unNOVf2a36K9DiRowOOX4Al7A3IktzzcEF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AFJ6/AUFOcucQ+FakqzGhelGeB3hxvoatVI5+V0b3dojBU7n5aF8mrjmsOwEAhVMY7eogaTSPS5A+tS5kd3V8HUzGTumUrbiOdKy66KpeOYWAt5PMHCAGzy0rKHD5yw9ssDJctFKj7K//FeGbMpsUz/TZIPjEFwcqjPJ7MiQH60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5F1CbCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5F1CbCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC4C1F000E9;
	Mon, 27 Jul 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172009;
	bh=PUxiM2q29sYqI0e4J83UhyhQOLBv6Q/pL5tSceU1zZ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N5F1CbCwNE0ldWOX5ySxJMNtga/4uary9c3Zj4vabPQdk4G2JcatbU8bgQo+4CmuE
	 fg8MGcdlbyvt/3HzoW3qANat9PCoc1WhF7htZJa7I4S+H9X43b6xmMRqaZHRQBSv7Y
	 2sgtmZGukC6LHby9qsWzRDP+PgKqti7vlElTQVsEV+fTI6fMmCgzf6778gH3VHsOg0
	 qz974+0Sxr314Hib6q91Mz7/3TyBFvZtfePfY+kVKlghFP48zNhAT2jUsU5jWepyAX
	 HV9GsER29q+pIJi5pc2cbVDOP+Y/SgtZ1QO2G+Aru92JIEKe6GUpUynQ5cKxX6uj08
	 Ff2CbL+EU5coA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 James Clark <james.clark@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
 Justin Stitt <justinstitt@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
In-Reply-To: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
Message-Id: <178517200880.2418719.16918746118553477872.b4-ty@kernel.org>
Date: Mon, 27 Jul 2026 10:06:48 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 15 Jul 2026 15:53:47 +0100, James Clark wrote:
> I ran into the build issue mentioned in the first commit, because using
> an option like LLVM=-15 is a documented way to build [1], but only
> some of the LLVM tools defined in tools/ support this.
> 
> After fixing that, a lot of other tidyups fell out. I didn't go too far,
> for example some selftests include tools/testing/selftests/lib.mk which
> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
> tools/scripts/Makefile.include and I stopped before touching the former.
> Some other non build scripts hard code toolchains and I didn't touch
> those either, this change is only focused on things that already
> include Makefile.include.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


