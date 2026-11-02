Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607689;
	b=vXJyVSAd1UmAs4j8rqP/u/3DTyiHxzv8s5yrU4LhJy70RecaBb+ohAvPuoHSsdIcsdVD
	 vjEknpXW7maTWGdq6AV1EbZee0B3R75Onac2c4W+vt5zpMb8UUt1cXRMnC6Tlq0JBiRBF
	 +R6+JVsgsOllM9pOiJ9aaOtsI80rMT4Cp3GUXcEHhSbJh7MoM3L10LvcWyhz0h9Nx9pah
	 aG5+UZ4OgSEHUCgS6is9J2LYQctJLRgejAy/wQGBVRb2uAqexZnNcksjRkdOKRlMBU9G/
	 YBiS7LyYPw6kgRFNyymQfFvCLQ/CJNlCI0j8jwJf3s4J55UOjaSUVuzNsWuwzwpGyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AvJtfbiV6SfMnq20pOgeXr9a5dTB4ppz5wJgI3CXFy0=;
	b=wcAf+VCZlAZtHTi22D+osr7nG0AvVO/hPBTaaIRBpWHvlHTti93wqzKn0l6hrlb6Qzk4
	 K1DPte4Gydg/+n/bg4BGPbKZnu98E3dsnY/X8yg+kEvIbo8VJV6nop4ZDqUx9uGqk1Fws
	 0VTONGx1PRo/3Onnc9ChUOjxRM07hYrfyHY0yDruhUZUOmN3Gk/apNF7JoewMrksrbCRv
	 1FT9R3VW74Q5XGDo0yL/p+TkxE/5QMZo4wCrXmseWWbTS0Aq0PLx85XX+7Ffo0EvpUoyr
	 coqnXQWM5zQphg4FANsGRjU1R1DDsYz6aJEEXh8dypP1nPyRuPU3V/UlKWfrKjhEBAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8W3Fa6n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381860A2611
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8W3Fa6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EB71F00A17;
	Mon,  2 Nov 2026 08:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607688;
	bh=AvJtfbiV6SfMnq20pOgeXr9a5dTB4ppz5wJgI3CXFy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8W3Fa6n0lMSA8SK5GoC4/PatsM8z5cX3DXZ/qvtkzbuoFCk+LxgU5iAP/UfZZzIV
	 4TirUVjOKsq5SNFpA2sZWxtHLhDtc0tnFtUBJWZ8B6KdllKCmmeBa3Cg4IU6W9X/gn
	 AkAwj2qHlBHSKj7lTfTywbt0epW+brm8BWo2AhTRrhyckySfYPl7MRsNMepVUNRp2M
	 JWlcU46HnYJgOdCp90gFNTONqz2h0v9UOyA7uljuG9DY4fnw5E8g/UQYR0QA2O94G6
	 mnuFy9OD+7X1F62Dr4d8DLxrah1hoIJQzwBqKgIkEuhwGgSGZ8tay92FKNDgBIWXAl
	 ZLXiXuFDTTlvA==
Message-ID: <sashiko-outbox-193098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] perf/x86/intel/pt: Clear TraceEn in hardware in
 cpu_emergency_stop_pt()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-5-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-5-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:21:27 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> cpu_emergency_stop_pt() stops tracing through pt_event_stop(), which
> assumes the software state accurately reflects whether tracing is
> enabled.  That assumption can fail when a crash NMI interrupts
> pt_config_start().
>=20
> pt_config_start() sets TraceEn in IA32_RTIT_CTL before updating
> event->hw.aux_config.  If a crash NMI arrives in that window,
> pt_config_stop() sees TraceEn clear in aux_config and skips the MSR
> write needed to disable tracing.  Tracing remains active in hardware.
>=20
> Alternatively, an earlier NMI in the same window can stop the event
> without restarting it, for example a group throttle calling
> pt_event_stop(event, 0), or a PT PMI for which perf_aux_output_begin()
> fails.  pt_config_stop() again skips the write, so the event is stopped
> only in software: TraceEn remains set in IA32_RTIT_CTL, and
> [ ... ]
> Fixes: 8e105a1fc2a0 ("perf/x86/intel/pt: Factor out pt_config_start()")
> Fixes: 25e8920b301c ("perf/x86/intel/pt: Add sampling support")
> Fixes: 08c7454ceb94 ("perf/x86/intel/pt: Add support for pause / resume")
> Fixes: 2e17bf3a469a ("perf/x86/intel/pt: Fix stop/start with no update")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D4

