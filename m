Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD8207A3F;
	Thu, 12 Dec 2024 07:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987261; cv=none; b=aOICERoxVvhXyOy9dCz/5uMvGtftTvKNiKS1mKplvCzJCjpmOBRd2vBD0DkIAasMg4dnWk+fMg5Oz0KOBpLYTcCpwuBv5TV02+hYpeLOL6FhsI5ZpP0qs7qJkErHNuV+T9TDqQlK/NmqmvoCOT4IQtpW4Y9KG8Khg49AL8kdeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987261; c=relaxed/simple;
	bh=BPlTTDNDzZrp2N3by7TZVYWXY230hjPm+o9JsvANubQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iGEEl4IfkSE3rlOVFxmQCjPco2SZYRUuQfBmK9AkjXfyT+JLFbFqgfSzzuwt/LjZuY+OCdzZlqhsWtWh2E/rjTdaIFnfTutSjTqKdks3KSDG0KRrfynM4OGQt8kYYWEGYckzv6F82TT+znVhqXrZk/RU7LTZVd7b+bSrN/XvaqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZs5ksbe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZs5ksbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF1DC4CECE;
	Thu, 12 Dec 2024 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733987260;
	bh=BPlTTDNDzZrp2N3by7TZVYWXY230hjPm+o9JsvANubQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=PZs5ksbeH5KXdOE1XARgM6Gy1gtWiwPlj7cOlo7L0hfjXd4ha7b507N+ENCRvT6GW
	 hHYy/TgKP1cmHNBqukeWWCMLsQEjQr93zhTFKeMsCXkCNZO3l5qW/ANf6P7mBFd4Cs
	 moXR/T8OdAjN71T8n2kSQ2C7PTwIZ6HRQUPnUUF3+ix+imhcxTp/pKNSQXbTWiGf8a
	 bGYqgo6xNIhqIxPhUnSlT1BO1VZGPbVU6mdnYE8uJG/zcbXRcvfAUfz2rAwjdxQt0c
	 sc4CWQcPcKFsfzWKfjq2UCXsENI2EjAD05GO+7xGTz0e0HFO53QeWx9bLywnSgOBpt
	 H9yUh+liNr37w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
 atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, 
 disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20241205022305.158202-1-irogers@google.com>
References: <20241205022305.158202-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test expr: Fix system_tsc_freq for only x86
Message-Id: <173398725978.3728083.17030127353710822170.b4-ty@kernel.org>
Date: Wed, 11 Dec 2024 23:07:39 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 04 Dec 2024 18:23:05 -0800, Ian Rogers wrote:

> The refactoring of tool PMU events to have a PMU then adding the expr
> literals to the tool PMU made it so that the literal system_tsc_freq
> was only supported on x86. Update the test expectations to match -
> namely the parsing is x86 specific and only yields a non-zero value on
> Intel.
> 
> 
> [...]

Applied to perf-tools, thanks!

Best regards,
Namhyung

