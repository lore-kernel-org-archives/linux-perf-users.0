Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39D81F4CB3
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 00:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782261801; cv=none; b=SZsXxIirzDp5ac4OobkBJTjFGhGlcMOz5jbH+b1d7o4FiHdkCdQ+WqfinltFWRdIqa3+Y1zpYfNp/sWmGKLOlqQt1uv/0ch1tT9SrQPTim45jpW4caKcs+HoSdjp1+KgUTbq2ZQOimxipvG+Hb+UClPRAjOAYPb1+ZSRbFVJIQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782261801; c=relaxed/simple;
	bh=H0+N6xqiaMIM6SnB6nrzz8JtnxyTJCf+zosFyuY6QD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwU+K2LOus5UsYlgrzQyvPKB5fzQ62o0izurCY2aqJTQQwHKSRjccBpHFGC2p7ussEuEYfVZo6OOoAXf/4mRnf3lWcf1LZVBxHNGNDQEZV3G16LT+Cwv1VF8c59EvE11GivVPJfy0FBhnh08ZxCQCdMZ6FypNVUETQC18a5xYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Lir80czV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Lir80czV"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c07d76ffd0fso49082966b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 17:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782261797; x=1782866597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q9VBsCjz2FWaWj1vcveAPvOGmt6jDW1p6lZdH9KtCZc=;
        b=Lir80czVF6a5Y6Kdf4dU3QPkZO8QX/aBGaWYP7fDyXLZ7GlOJO/GxTjI5TAaoxOfiF
         6ZSjMwq0foiyZPhNoGGPWfT+qOC8R+JWftga6apkOzLRmWyP2VDoF7/25uCKY46iH1w9
         6doIAKtm5dA5JO5nwhrDlSYu8YV6ewVtefJsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782261797; x=1782866597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9VBsCjz2FWaWj1vcveAPvOGmt6jDW1p6lZdH9KtCZc=;
        b=p+6aY1sTXL/EZXNaQp5vEjlBURuRBnGpQdFi/l91yF7tArxvoQ6+O4SJgWC5SBYf2s
         U5qH9pFd1m6XYHFPqUtRpqENG3gNWPPEZGKSMcWymfV6lq48EvsAaErbESmlfxczyig8
         HQQYViGdGAKXaEM5hcaY7+X+iZ5ZhmzIptFjmsmvDJkiBg1Z18LY4gXT70mzb403cXQo
         3BxhPBTTmz/Qea9v8BiXYDXnzFT5pOL2DhxLugdRdzxQnPuWo8RYU/jb0NQJN6fu43iV
         A2atYbqg06y9lxRoBFSl/WxzkQcNCQmNJgsGL4E0S8W5yspVdnIyXpndgPVCcM3TNNMZ
         ACbw==
X-Forwarded-Encrypted: i=1; AFNElJ/hP6Tmbp7jm8VoIZVqfjYBbnw1HKNF18g5cCteC2on7sWhQxjrf43n3lkejG0PVElMoSZdUEuiSY9wQRrX+VPr@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLti/Wr3bTwU5fXbFScEpVA8YgB+DePV1wrJzlAjLbYh8tkUd
	YWimzE0FlNFD095l1F+Tv6Kw05jY1rX5xfp5Qc/fSmFZUeSbB6egJBF6TEOqcggelyfmYq7YdDH
	wBAhwH0I=
X-Gm-Gg: AfdE7cn4cG6C/KYsp4O94ZEgNjElzsqN/um8GZSJSdBsJWKDk0DjvB3fe7CONIbZ+ZZ
	CFOSAQqdj3IstQgGEJjxE59OZQYFnAQwRNSwJ2Qd6eMiBhfc7yr2+9wuSQjNqMZg6b4VRSoNwpg
	O2VfdRX/Y/PjxlmJZhEIHi8LbxCWrPmWN8NhXkLctvLEbYYm04Y9SPBueax/sajkNZWu2e797CB
	lG4MlQDycA7rqJNp6642yCPI/79XgCynqMGbbjdWm6IeXzmO3rg2seeBhIkolPsj+z7gBWE7J/5
	W5xIfBOB8Kj/hQT7T5QcqpXRCeitt++CsAL2llDrV4wEqEKC7GGCgpi+A7IoryW9RCvsaH4St11
	wZu0nzHghibStrp84Efm6xuWr+bxZRWFNmZK5/o35STpIplSArVNkGtPDPDYlEDxZUyiLlhJH08
	oEK/RAzs/WPlUc99LmensN9WFgOnjQz4KBG/D6heIm0nUKWuXeVs0tEkipACrbw3nWwY2UyZLE
X-Received: by 2002:a17:907:c448:b0:bee:19d0:db92 with SMTP id a640c23a62f3a-c10803b52e5mr286961466b.49.1782261797292;
        Tue, 23 Jun 2026 17:43:17 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c6160f7a5sm583024666b.55.2026.06.23.17.43.16
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 17:43:17 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697b8540279so681478a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 17:43:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+BhgokPV74VAcO6ZOnlxdDVmzmo4STZrSNocFD9ZXeZeew6cjacxaCpHzu3HEQQa2J6aWYoW889lECR+9I4W+@vger.kernel.org
X-Received: by 2002:a17:907:a091:b0:bfa:544b:162 with SMTP id
 a640c23a62f3a-c107f4b68b4mr243707966b.36.1782261796306; Tue, 23 Jun 2026
 17:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajsfSkRm0T7J2eF3@x1> <ajskevFfXGkVt-si@google.com> <ajslsBPoAPMioSeW@x1>
In-Reply-To: <ajslsBPoAPMioSeW@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jun 2026 17:42:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjntSyV0sZvOU4wAKU83GiBWQ0Y2bbvtg84QSg6SbpgDw@mail.gmail.com>
X-Gm-Features: AVVi8CfJT7-If9ykGQyhQ4JpWKhXN31bF2SZakG8QHYyk4YM33mOIfEOyNxfyOE
Message-ID: <CAHk-=wjntSyV0sZvOU4wAKU83GiBWQ0Y2bbvtg84QSg6SbpgDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf bench bpf: Add missing .gitignore file
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 at 17:32, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> .tmp is created as well.

Note that the top-level .gitignore makes sure that we ignore any
dot-files by default (along with a lot of the usual patterns, of
course - not just object files, but various other binary file
endings).

( Yes, gitignore files do allow overrides to "un-ignore" files too,
but almost nobody ever uses that, there's seldom any reason for some
top-level file to say "ignore all generated files of this pattern" and
then a subdirectory gitignore says "but not this pattern". Some crazy
directories do say "ignore everything" and then they explicitly
unignore some patterns, but honestly, that's a mark of a diseased mind
)

                Linus
