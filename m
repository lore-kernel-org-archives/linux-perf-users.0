Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794715972;
	b=OJl4mZfed3DvbRPL2dWN1mOSurvdJDTpteLuvP1g3JfH6zeSghhyX1f+MXnudGWoeJu3
	 d+2AECPESk1tcrvCezxrsrDoJPfsnFzSmXi5j/d9WtGmcFwj1vjpFlfT9RNm7TVvZU+fS
	 nOSQqcf4XsOMX8x5lfOXTNgwIVzx9EEtfCO+76gPwtn7mXwKDW2d7km8j/1+KF69zPdcC
	 7577doipWrlH9FMCu2bd5NSlmIROIdOBsB5r0NVl6h2Bcmug0WKCT/Z8DjeYsxd/gBxjC
	 seThsQx/eGMFeon6Ilt73vYO+ouiJNh/tOKkRLvbSmX6RQ7Uapmb0tOkh8WBEegEJyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794715972;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=TDTaK0MxY2hLLLyGWU6B/kE7alAJITtZwVfU5ihG1cs=;
	b=FhH3y/CuKw4Ck27xR5YzptgY2brRDEvA/UFZv6tYdj1RZrrGWurRmP5thJqcogr9Jji6
	 wKSrPJGTtG6wJnCy/uppiy/260bSeIJ2JcPmT/lK1bplISJYq5OFGVXAJ9PZiUTKmWMuu
	 M263yLPOTbArxO9DQceuwnb6VwtOivdGe23P8y6TN0r8V4SKeWm6sCcmgb9JFwgANAfi5
	 vRIklNCQu0VkiZrmI6pz8NC80XunIZg5qAXiy7xK3U3O9FRmlK40PYvoosZ5/+7aAqVNl
	 ujypve4Kd2YlY8+q0i9OwoEjp3nezn6eTM92rZ5tW70It2uKq0VoqXi5bkF18bvfK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf5P+iSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53316606A881;
	Sun, 15 Nov 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf5P+iSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB141F000C4;
	Sun, 15 Nov 2026 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794715972;
	bh=TDTaK0MxY2hLLLyGWU6B/kE7alAJITtZwVfU5ihG1cs=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=nf5P+iSuR6OY8LHmX1z66kkiW618AGQr1wnRZo/xBPkzilTtd2aifNtt3iY4J2kep
	 TMZRYQcD3USY1zaUjIwnQV3evdUUYWEUUKSdIA9yUOMIEJCKUFwqImamDl0G7xB0kc
	 SKrgrm5xnLp1k1J4OoMlkhQGA8PMI82S8PKcfFKn81BU4Pigix8OTyvdvmt7UsnRRy
	 gtrjWuJ22zSFkdd3G+KJ/S9n9MQX+mke7qbQGJpu0aQDEeqd83ZGjfCwOzIEKBCbGr
	 0501R7mgDslNROJWK4ebjWrs4L+NGM/ZJTOVNoO3WgerKRVZ+Vsym+QC43zPNutU+y
	 zG96goP9uKoQQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20261025214928.1225895-1-irogers@google.com>
References: <20261025214928.1225895-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test task-exit: Fix POLLHUP busy-loop race
 waiting for SIGCHLD
Message-Id: <179471597030.616307.10950093888605247373.b4-ty@b4>
Date: Sat, 14 Nov 2026 20:12:50 -0800
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

On Sun, 25 Oct 2026 14:49:28 -0700, Ian Rogers wrote:
> In the kernel's do_exit(), perf_event_exit_task() runs before exit_mm()
> and exit_notify() (which delivers SIGCHLD to the parent). Once
> perf_event_exit_task() completes, PERF_RECORD_EXIT is written to the
> ring buffer and POLLHUP is set on the perf event file descriptor.
> 
> In test__task_exit(), once POLLHUP is set on the fd, evlist__poll()
> returns immediately on every call without blocking. If the child is
> still in exit_mm()..exit_notify() on another CPU when the parent reads
> PERF_RECORD_EXIT, exited is still 0 and the retry loop spins through all
> 1000 non-blocking poll() calls in less than a millisecond before SIGCHLD
> is delivered.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


