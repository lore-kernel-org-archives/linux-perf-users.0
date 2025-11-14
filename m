Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68E2C21D3;
	Fri, 14 Nov 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145331; cv=none; b=r1KvHrzGnjHHuaN45jYEP+bMmceAp2H+vBjXJGUGR/Lrh+OlcclmpIv5U5BaM4FmpJiBJjxrN2LOEifu4lWKuiDH7Noi0L9y25vCehriK+ettn4Dp0JGYyPi9ikYuHFZ5zZdWQkEq+ONqkI96qwARvGeN6wU4DqpmPlBDDDuPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145331; c=relaxed/simple;
	bh=FnaA1dbeActCeQF+u9yJgz4wf8INpnCl6AGKObwvoSA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n6FZIn8hoJSMy3W1N5Pql7osNspouxtcXfDQpEQ3L64LuabsU1/oy93LyBPWASrvEs4QT91vOg4HZgDDYgfoNKtFzZ9Ud899lXZI7qPWvdYO/IOGQ25zMr3Dq4rLIvfRHyZ37impl3QtKBmU3qRw2NPjvCimPiXhkJ+UGGWmJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVF44Iud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVF44Iud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F761C4CEF1;
	Fri, 14 Nov 2025 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763145331;
	bh=FnaA1dbeActCeQF+u9yJgz4wf8INpnCl6AGKObwvoSA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=rVF44IudPsUU42aoyWt5V4zog9/z/MdTGtpPJ0N1jRLbd0TVnM0hvd91N2rhWW68a
	 Zui1NTy6eoVyDtysw6/VBhdYZI+451QaDzeWN6C3qab9W4/h1kou21kjU06B+clNbA
	 FIOonMdDMuP7yVYHYkzRjkN6ZuGwHRPt3FdhTykueP2k3KNe0/cdN0PN7Ze/nqZRgY
	 hXmIv6Rq0YC12lIXEk1Xy0UGDqBQEUJfwywnPKRYDHJFaoudZiRjvpjHQqAYl29xoD
	 pbBx5PO+Tn+jWjxV+mo1Hrfvqq7nbGIUtSTnDWYyr9cYos8FrcoGOF9N/GQb8dxTEM
	 1Zj75BDrlzYWQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Yicong Yang <yangyicong@hisilicon.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Tomas Glozar <tglozar@redhat.com>, Quentin Monnet <qmo@kernel.org>, 
 Yuzhuo Jing <yuzhuo@google.com>, Blake Jones <blakejones@google.com>, 
 Charlie Jenkins <charlie@rivosinc.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 Athira Rajeev <atrajeev@linux.ibm.com>, 
 Ravi Bangoria <ravi.bangoria@amd.com>, Collin Funk <collin.funk1@gmail.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Thomas Richter <tmricht@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Andi Kleen <ak@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
 Zecheng Li <zecheng@google.com>, tanze <tanze@kylinos.cn>, 
 Gabriele Monaco <gmonaco@redhat.com>, GuoHan Zhao <zhaoguohan@kylinos.cn>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, 
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, 
 Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
In-Reply-To: <20251110013152.3099080-1-irogers@google.com>
References: <20251110013152.3099080-1-irogers@google.com>
Subject: Re: [PATCH v1 0/5] Remove NO_AUXTRACE build option
Message-Id: <176314532709.3522480.3588024269279229588.b4-ty@kernel.org>
Date: Fri, 14 Nov 2025 10:35:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 09 Nov 2025 17:31:47 -0800, Ian Rogers wrote:
> Switch the __get_cpuid feature for intel-pt to use the provided cpuid
> function in perf, this removes the need for NO_AUXTRACE when the
> feature detection fails. Remove the now unnecessary feature
> detection. Remove NO_AUXTRACE as it just builds a more broken version
> of perf and isn't guarding dependencies on any libraries, etc. Clean
> up headers files for auxtrace.h.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


