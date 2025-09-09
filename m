Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4014931CA7E
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Sep 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415474; cv=none; b=QjAeW3g8XpP1OMrl71zaSsagGCUILjWE6sL5KbpuPQjJwFik1DMRy6q6yIvAmS+Cw7jQAey3REfK8yRBXhgId7D/LOpvRfRj2uOQ9Jqw/Baz8ZvBXdiG7raSOjEqBM+rKHRyT3o4mo0YVm4Gizd4SHXZ0sdAroASCnSBVThBs7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415474; c=relaxed/simple;
	bh=2qJii75iX2H9ZNmZHO96TRyyefKym2oMcBVinEsMC3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m69YnyS9bfARW14uOso6THRnQPoCuSl3mBzFJhoOuR0nxlj6ZYa+fQr3AEg23di8CXtauuEenv0NcYrTDWxAJV5y0MdrUlYo1yKNWaeSwcgL3uUSPfonpia7eoNZO+CRDdygW0GW2GuFPVeQytKd4jWqR3hewXgx/lN38tG0dtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHrtPiqS; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHrtPiqS"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32baaf13944so566944a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Sep 2025 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757415472; x=1758020272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOj657j5Mnz8nVz+aHzr8oWclDauOAy9FeLA5tjE16Q=;
        b=dHrtPiqS1VZM0UI0SiB0xsl+itFnqtwkkrVklzKNexbMHFJLuOXKzgY8LxTDtmbIt6
         GhY0HV4pIFIdU8D3/2gA8OWldM+gV9KFerqT4LZ+2YSdRveymIoZrRW2flPrsTHZF0C/
         aDnUpsGxmgiZlSP4kDnjIytEO7V/H+jCQkakVc50NoAm1Z0IE+j8vFLVR+uWPvr8Zy9N
         lMURjwcvcbvzuhFqd0v0lhTmRq1eBEzS3VakiEOY0lifJjWBWZlKStWjSDN7G+Xj5KLP
         p4isBv2c8hS4BqGXGimtmTqtJCuKTVRATYAvPtvF+jQ3cA9KoRGOLHTQbpHLqgkLZ/nT
         Uoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757415472; x=1758020272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOj657j5Mnz8nVz+aHzr8oWclDauOAy9FeLA5tjE16Q=;
        b=JQcJlNXGW3QSn51LrH2mvsVKp47xBIA7GjcTp9QZQNae3gp1BftRLc5emH5ZwhpI3w
         mbqSUNwtXo67osk4emgC2NtLWJbgTDNdkqPUR/M2D30A47O+gTnLMfXGkgyLkM+wEAE7
         989h+if9cenZsPgGl7QPxzt0HwzDq3LnbdiDt/qK3arj66l3PPbU0COgd4cO11EwZ4Fb
         LsIrQvY2eBrAdA3CO/3yLQKWn1cTD79+UC+0zI/GhlPmtkyadflVwAFIiNvt7ejQRRc4
         G3bhBa0WdEmVXJJ63BnSgNiWxK8LtRMZ1hDUvyeJ1KKDZK5CTV3rQY6cb4vDWsG3zEgD
         hxLw==
X-Forwarded-Encrypted: i=1; AJvYcCU6yaeNGvqC48CnyGzDHsUoUiXlqi8gN7FfW1g0NyMDQSpOYWuO3e6tPmfk4lbWR+VFZWQQN4w6nK8DQ+wyak3X@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMwcXV4wH5Nm4W//BzaDKcsLU4jnzq8ZwF9vp+qvZU06h8UW1
	glcNE2wQwyJrQsBvKOrhvRynkda0WrY5OGFtEn0lJvr2ySpeEwjyGVy8R87NtwlnK174AsD+Le6
	Ra/N9J1qzcSKml+ZHfdbpZETrj1dvecc=
X-Gm-Gg: ASbGncuq7sJ9I8ks4Sfa6AXarRQAZhHz6ndMu0xjUtjqj/sib8PwuRvc+xjgboBQP9Q
	hH9HM2iWtlpjPQ03jYQmxnyaSjRYOCHQcG3eS3rifxYPhUT0q298QHbtIGoQJdCtlqJxrgEG8U7
	FIKDJrHF5q1ABh7/UORVk9/I8jlC9u140XBrLoBhaviu3FuIaaaSHNNoYVWHDej0NFQ5iBx17TB
	Z2GfLhq9Ssnnx1eG+4HHo26UKV6QrWPsr5Syc0s3AUxktcMRXXuyIf6Dt9DHKfXE2q7KgaLAS/Q
	ywyfQ1Fvu0VVBDntlz8iZv440eljHiAKVcPf
X-Google-Smtp-Source: AGHT+IHmJSD9mvx32JMCMKUtj+A6Iea7OUmn870TZehtVnrYC8OSU5oHqTLumOjvLIOX3eQTIcrVZlGUnPI9cim9tKY=
X-Received: by 2002:a17:90b:1d12:b0:32b:6abf:d94e with SMTP id
 98e67ed59e1d1-32d43e2b577mr8427871a91.0.1757415472504; Tue, 09 Sep 2025
 03:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aL9Ch_XaYTxMzFXK@x1>
In-Reply-To: <aL9Ch_XaYTxMzFXK@x1>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 12:57:40 +0200
X-Gm-Features: AS18NWCGswd-XFUKG33qMZwlodKSwmA-15DaQhSx_nbEJ5Xz7_FyaFy_GrM1YqM
Message-ID: <CANiq72=6yb5PZnuPYX3xWAms6pfYmfpoPj-GE1AZv7OfxcROJA@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf symbols: Handle 'N' symbols in /proc/kallsyms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:54=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> +       // a seemingly Rust mangled name

Yeah, it is a Rust mangled symbol:

    core::iter::adapters::map::map_try_fold::<usize,
drm_panic_qr::Version, (),
core::ops::control_flow::ControlFlow<drm_panic_qr::Version>,
drm_panic_qr::Version,
core::iter::traits::iterator::Iterator::find::check<drm_panic_qr::Version,
<drm_panic_qr::Version>::from_segments::{closure#0}>::{closure#0}>::{closur=
e#0}

From your `grep`, it seems that is the only one you see? If so, it
would be nice to understand why.

Cheers,
Miguel
