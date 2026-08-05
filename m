Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204C38C2A7;
	Wed,  5 Aug 2026 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954498; cv=none; b=PisFG6cKkC+r8Tkl3h3qJrKwKroOzcYHW3o9nehNYW9AMEijtybr0C4tl22N8BW80lPhZJ2uz22Eyi3Zwo0RoLFvdCG7dO4DqRR/Cj3pHzYUxJE3iwb9S+06y4Uq36AU0PUfNlT3H690/01LD8HB1lyjWVGPfUPZd/Pj95aALIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954498; c=relaxed/simple;
	bh=XnNW1zMkgz52YBNYIo7rYLWICQXVBY6OlMPJ2jlk3qE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QAYO+lt+Nok74ilMhEvi2HxGATGZWHjLIgiqmxwD3YWEN3a0uMfgT/OH/mo9e8HfPiNKLNDYDNn+gsk0sCHfIlBNVsOLb8sS79HKEMiJe+/sLzzJGUxvec5/io6S6aEbj7o+YcueC7MzQDvCQaYn+jtdpyL5FANZ7dL+8/bztJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHCJLpli; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHCJLpli"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EF11F00A3E;
	Wed,  5 Aug 2026 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785954497;
	bh=ZKomz0yiGa+onrW6T0Bol3ncbpjQOwlc5AEjvWhQ/IM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aHCJLplijzFiAq2TSu4fJ/b5AD27WxlWgTIZSHW3Aup1VPhsjUHJbKsguU+cLolKJ
	 PSfB3SeoMHDmF9ExZwYkH1heX71Z913+9jfkfbO209DC0fwyuKlOUaNtJVby5M1QeW
	 so5Q625o7jGpQHg5k7GP5DOCenmKgD2JrRaTSN1kt3IHPw4ELIZGmLdmhs1/7mZOcZ
	 bufNUcFo73a1oK/15FXu+JkY6BjV1bJqr5VxGqURVvo8XSqhk/AHaJES4Cn09TvRBN
	 +HbjrrmnupKiZReZNZfsh6Dfu8ZP5yEmraIomYWqsHLTZwIIQBukLpLetFDr/FXugs
	 vNspXX0+Q9iQA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260802142712.154726-1-acme@kernel.org>
References: <20260802142712.154726-1-acme@kernel.org>
Subject: Re: [PATCHES 0/4] perf bpf hardening
Message-Id: <178595449711.914389.1436037347972955275.b4-ty@kernel.org>
Date: Wed, 05 Aug 2026 11:28:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sun, 02 Aug 2026 11:27:08 -0300, Arnaldo Carvalho de Melo wrote:
> 	Please consider merging,
> 
> - Arnaldo
> 
> Arnaldo Carvalho de Melo (4):
>   perf libbfd: Validate BPF prog info arrays before pointer cast
>   perf header: Use write lock when translating BPF prog info pointers
>   perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
>   perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


