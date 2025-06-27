Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73174502A;
	Fri, 27 Jun 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050386; cv=none; b=MQHp5v+MZR2g5rWxmtL8O5EPn0EEtOpvx/90HA+3rrNnobqRQuIzNpmA8/gKqraaL1Isj4Xhtvgmewf+2W+dhzW0R5i8O38hIkSVwHMUhPAOAnTqI+Iw8V8Wp/EBsa1ZB04RnAvZ/1SSoT6GD0iqs3lmcwN/4z67QgUkKBIurvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050386; c=relaxed/simple;
	bh=Azf1ieY1t+Wv+7lxoZj0LGZMHSX7KgNTQ2MC12HaTBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oEL4BbQ4GB8tRh83wODlgFKRXpk2r14na+Rp8dzuZmirMCQDFqiNbqbbJybcIRG33VmsdNJK2/o+J0l4vUFWRtqhowZoK/y3CtmTR2OnSYtvFzzDca9+RxMaC7By1rAfMrmcS1apMidy4vdngvYZ7Otyh5/sRO2ReDnY9kxEycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMq/wrST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMq/wrST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567DDC4CEE3;
	Fri, 27 Jun 2025 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050386;
	bh=Azf1ieY1t+Wv+7lxoZj0LGZMHSX7KgNTQ2MC12HaTBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hMq/wrSTE2lpQD/C4bACLE0iBL70iv/dtpyjDnp3OcutmFWYQFyg2RM4oZrSBjS9z
	 8nn9BVx7h35MbTSRb0qDCnzhxP1R+vO3EfW3ge1VFi2Y9p/Rx5WluPGS9mSuOtCPea
	 9CWYJgRyfWStAHTglwe/KUzH3AWDACuJ4QVGee4QTF0E9sjuEHIWAHzvxSfwhCEcTE
	 YbqiqS0FXbdrK66qMLVhmnUuLMb11G+sHZzE5YTdrkaf+m5aG4SVOhZf/2DKlSad8h
	 cs5nGdlhj2VRgdCNGGEOsSNPA4AYNrlg6LroKmuWvWLdJPbu8hK12wgzkHASkuKpl5
	 R9cSVuFeAjl4A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20250612163659.1357950-1-thomas.falcon@intel.com>
References: <20250612163659.1357950-1-thomas.falcon@intel.com>
Subject: Re: [PATCH v4 1/2] perf: move perf_pmus__find_core_pmu() prototype
 to pmus.h
Message-Id: <175105038629.2492671.13622908077409812464.b4-ty@kernel.org>
Date: Fri, 27 Jun 2025 11:53:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 12 Jun 2025 11:36:58 -0500, Thomas Falcon wrote:
> perf_pmus__find_core_pmu() is implemented in util/pmus.c but its
> prototpye is in util/pmu.h. Move it to util/pmus.h.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


