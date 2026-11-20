Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146846;
	b=uADRnbr+JtsFrPqm7mt+bdadNka3P64dm5Nphxq53igFK3dY15mN07ZNTRQ97iEWmJmy
	 fq/692RaemwPlnTUW0BV8wIvcAAnMhuTbrCqUBxTVIa3PWSqbF4Ylf/ecmQS2cgGgwQs0
	 LmuLKggZPilc8AchgBL/prEZ2jm8dAkOK5esrz2i64Y56Q9lvzWyRPzVxjsmKyNlXeA+5
	 S+CEGVY48HvntTnS5mLtV7EwG45VJn7/KOjyDvxs+L/0GPn2PIOCLfT5DC14P73b+CfTB
	 sLrmEJZpMy3b8Pn6c0JmXqC6yyzQBNI/ESzfTHKuWXx9IL8VyDxvlMRMGBzA743B/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146846;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=o+VkAivF/sHJR8B1grpHPODBgXDhwTafCbQ4YmeMSR0=;
	b=u7ObEQDBK0nPn39fMGAsE1lWJXtE0upkY6cBIo6znCMG49EvpKAY45UHhlYIeQl+GTVQ
	 Zk6AeSPhPztsxQsVnTaGH70eUDY5PNX4waFszjOSt8byi2w9gRR9Li4LeTMHwI3MroP0q
	 v81bLR88Zd6KTlFo53W9gsKsBwX9i/MM7rcmtlvNXr0IwZaXtr7FUNgEAiReQRB6aDdZe
	 69lzNEyIU8ZwlmoMC/KNUkf+8MgXAN78PCDIUYepUrXn82l9wY8MjhdTRLwAsbVAL8c4l
	 OWMyzXRuzP+LrkIbnMVCKwsBDnoZ9GgEZ9xgrM5JP5+M78mvselCZ22HOY0Z3i6nstw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVC4zJFE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050E60A2606;
	Fri, 20 Nov 2026 03:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YVC4zJFE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAB41F000E0;
	Fri, 20 Nov 2026 03:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795146846;
	bh=o+VkAivF/sHJR8B1grpHPODBgXDhwTafCbQ4YmeMSR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YVC4zJFEjFRMG29J0yM2u0OUqA4Eb3XasNLCBNpy71rTVZ8h1U/PIJh+jkFVoOHG8
	 OYpabZ9C7OoM7TMi81lEpbnem8OlutGki0nduhvfxlqpY2th+XtLgBJYx09DAjF8GJ
	 7frcvpAnPn++1flJaWh85+jc6uWuhx/PNLb/HH8B3iulwuOt3oGTvN3anIea5k12e7
	 ZMHpcoLZFUSf/L1DLfwZkDeVxfS5G3s233AyHnnroOJhxDUsIuATqZi0wWKEoXouh6
	 YolX+7tOPQeQDRHHOzb/Y7SVaaamTy96BHrVxOkbTjjOBMoerzH2x01ySPq/NkqPVy
	 l8X5ZC4LAvpBg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Casey Chen <cachen@purestorage.com>
Cc: Ian Rogers <irogers@google.com>, Matt Fleming <matt@readmodwrite.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111234156.2276500-1-cachen@purestorage.com>
References: <20261111234156.2276500-1-cachen@purestorage.com>
Subject: Re: [PATCH] perf hist: Don't update the map of a hist entry to a
 NULL map
Message-Id: <179514684487.638421.5854699398034944356.b4-ty@b4>
Date: Thu, 19 Nov 2026 19:54:04 -0800
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

On Wed, 11 Nov 2026 16:41:56 -0700, Casey Chen wrote:
> perf c2c report, including --stats, segfaults on c2c data recorded on
> a loaded system:
> 
>   map__find_symbol
>   hists__findnew_entry
>   __hists__add_entry
>   process_sample_event      (builtin-c2c.c)
>   perf_session__deliver_event
>   ordered_events__deliver_event
>   __ordered_events__flush
>   perf_session__process_user_event
>   perf_session__process_events
>   perf_c2c__report
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


