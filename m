Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4E30F55B;
	Fri, 17 Jul 2026 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310397; cv=none; b=Ta4PC5Vt5eJnpalVK5ncSOdAYkcovuS3vA0UPERI/XO0+zubgbqt3DLKXUPxWP+R96L2mnbOlEId3TtfjHpXjZhBeeKg1r/tFecJUOsZ8q4sr5OlrNdLPZdjBDYsAOjVZTxjXVYhGrT3HPty3KDyRmvfF4UvTNWtMZ6/icHG5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310397; c=relaxed/simple;
	bh=O9bNFQr92taWS+CiuMAbyFjAxRkxw1NZBMF81HwlJYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gLQSfRIEGeTrNoS1ZHUVGJmVWlGdCD/Rg5eH6euxFyvdMMjSTo0ZNxr/gsi1xhKUrfRB73ctIz2bPmaj5bxcqCnjvVbI8nIdtf8wfp/U0ga/VBuEMmP1dHFx/cQZOdlVZUAjP0nMBU3MZ1GJzUx/0WrzixpAk5xGx3R50LWr8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIc2fQSW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIc2fQSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8EA1F00A3A;
	Fri, 17 Jul 2026 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784310396;
	bh=MAVAf0fF3ZSdc01oFogmrudkte5kmwkGFQI/QVIUOCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ZIc2fQSWGu9uHqLGsLRcVqPSXJbl18GLgVUCpkgPr2XjmYtz/Gkq5q6ukGIhA5HMl
	 sEOxmPOaHJ5UpRMR1IAollUlBu5VSFwd46B7KeLS7BOIzwBqWNs/8SH6Mx6/w8Lx+K
	 q8MnNwN+lgu/eTdr7vdAwH7rgaA0mBimiLI90uH3KWpRyU3yLmsUaNbltI5cfZCKM7
	 nbJN90KIg1/T3E5e3sR3YmxahnAkafbcPtfYjMo1wjBuBdWb3UsTaCxqs77Bsjpr4c
	 FqjWPfnHbCQWHEItDrZZZUtEWq6TxpV42UgWc/3iNGFs5trI452KRNa35R37w7lX0H
	 CzafGrNviZi1g==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, Viktor Malik <vmalik@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Michael Petlan <mpetlan@redhat.com>
In-Reply-To: <cover.1783406979.git.vmalik@redhat.com>
References: <cover.1783406979.git.vmalik@redhat.com>
Subject: Re: [PATCH v4 0/2] perf trace: Refactor augmented_raw_syscalls
 using bpf_for
Message-Id: <178431039627.131573.9801415792020925328.b4-ty@kernel.org>
Date: Fri, 17 Jul 2026 10:46:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 07 Jul 2026 08:52:45 +0200, Viktor Malik wrote:
> The loop for processing syscall args in augment_raw_syscalls has a
> history of breaking with Clang updates. In the past, we've seen it break
> (i.e. stop passing the BPF verifier) between Clang 15 and 16 and now a
> similar thing happened between Clang 21 and 22. While the issue is
> mitigated on the main line by a recent verifier update, it remains
> broken on the 6.12 and 6.18 stable branches, effectively breaking
> `perf trace`.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


