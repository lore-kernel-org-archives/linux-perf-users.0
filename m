Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AA3D57E
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720380756; cv=none; b=FCcmlYuRUv5Pk4tZUCZVayq6qVh6JmqCeedOHrvYJAMfYo6RBwrJtQKDGvF+0NGw4XBIQTpU1d6Nh8VKM42jCrPtt5DCDbMZpZE4gh2zIdZgFCo2eIP8MSmmngTDaC5vOGvvDuEuEjh72RDs1r31wLzOL6OzHfGBeSnIR65zmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720380756; c=relaxed/simple;
	bh=N0nt7om0Z/okEAHsYJLTuYM83C5o8HaLAE0ebGn4IPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k92VCswXn7xD2JikkqoWwYVUAUQbsnKtTlxCp7RxqJrXq5WMcH3Zfxb4JgMT8/hR3uMsX7JRYjDZpZ9CA1NLkRZL5sjjlXuWqg1Da7jqzg9035tP3DyhVfUDyJj0NLpbCST+wch/9w/P8oQu22RQ8r8RWfXEj69EQ1ghXw9Bo+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SXQFi1IJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SXQFi1IJ"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so35225541fa.3
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720380752; x=1720985552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xp+muDlA5jI70YwBDylM5jk8zaYRc4AwtYfuaR0RU24=;
        b=SXQFi1IJsS4V4FIrmpvwffs2eA20OfTTsMPGkFMsuOjJlLQVBI/UqKrVGVHkV8MKeZ
         KLJhnbHFbpb3zoe2J/WmXt559majdHMk9vuV5qc9lgBZVBjS3vIOwxVtJVaQU8okXooh
         EPEk8DoH+VnvELIX34Mu8LjFbA9ylqF9+kpps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720380752; x=1720985552;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp+muDlA5jI70YwBDylM5jk8zaYRc4AwtYfuaR0RU24=;
        b=hr+dcb/ktEcLrxy7crzuNZZRxYIKBCVgZIioOSkolQIpTjKETz/BY5BlYoJXVYvWkS
         OBpE3qd3xPStpiq2Lb2nZT6XjtxYs528ACR+u6NCU410zW0eAQQtf1fz11oUg677blyU
         1HJwB6SNTHsqhM7v8xd3N4RhViRgNJGHHI7JDSxa9S8LZXBq1tjEixHAU163xnF7Zrws
         bOvTZiYcdQbZgi1gxRD1cUU+dIS4qtWnERs4a3Hxvy5xSziZaP/AxuNE1evaDGsBBANV
         +fPEps+fjPS9fecf5b3SExml+THiIapRuJPW6/svBRxdJ36X41w4jCTYf7m/x8n8GODe
         CLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7B8qNxh/hYbBbVdrhABph6EzJt/MaVNkwzEqE4MPfheFFT/VyZ0sFUYzMBFFOW2S29f0Do4Rb8sCxlGbCJcXpqZIzUt2czbywxdsPT3SDSQ==
X-Gm-Message-State: AOJu0YzZL2WkH78weVFmapgf171BpmhB5BMOABmBU4q8iEFluOey5Svw
	l4uVesNJ6yIuNVmjSvU5RgkCIXxmUFgBf0JcFSwnZDFFkGPsczAOE+gkN3OKRYpiNgRdzGVb6tf
	yY/8KWw==
X-Google-Smtp-Source: AGHT+IHKh7qx7AGVx70GzO2nYBPfrDwJP6UTRUN3+GHL/PmzH2qjnN7fhbxGYBewZVQFA5/7N2IXmg==
X-Received: by 2002:a2e:9f4c:0:b0:2ec:5f85:61d8 with SMTP id 38308e7fff4ca-2ee8ed426a1mr63742571fa.16.1720380752088;
        Sun, 07 Jul 2024 12:32:32 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58f73d32895sm3302239a12.26.2024.07.07.12.32.31
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 12:32:31 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a728f74c23dso373018066b.1
        for <linux-perf-users@vger.kernel.org>; Sun, 07 Jul 2024 12:32:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUr5SzvuMZ2qLBKOkCbyrL141Tl4VEyNd1cysZumNAG0+ET0NTw+RcSirXwl2XElZNKigS47FeFbbVHLDQwQTQroMgqzQulLUmd0X9hLiubA==
X-Received: by 2002:a17:906:2803:b0:a77:c548:6455 with SMTP id
 a640c23a62f3a-a77c548654emr571114066b.76.1720380751092; Sun, 07 Jul 2024
 12:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
 <CA+JHD90fGLdbxno37FwVQLrtAiiZ=PZ7Wp5+1Du7SWBxTd3UJw@mail.gmail.com>
 <CAHk-=wgb-vX8g+WV16u53-yTp0dmMkOybndsWt=LMH7A8CMcPA@mail.gmail.com> <CAHk-=wiy4VxGqeExovNJ0CdznSBOhKD6LHpfBhbo4fY5Pkjzgg@mail.gmail.com>
In-Reply-To: <CAHk-=wiy4VxGqeExovNJ0CdznSBOhKD6LHpfBhbo4fY5Pkjzgg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 12:32:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_WhT+_89e+fc=N4XH90c_xgwOXSfsk7qZ6Hd9O9Bytw@mail.gmail.com>
Message-ID: <CAHk-=wj_WhT+_89e+fc=N4XH90c_xgwOXSfsk7qZ6Hd9O9Bytw@mail.gmail.com>
Subject: Re: Performance of 'perf'
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 12:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe something else changed too, I only did the before / after cases
> once each. So it *could* be random happenstance, but that sounds very
> very unlikely.

Oh, actually, maybe it's not all that unlikely. I did mess around with
debug info settings on the kernel I'm too because one of my random
theories was that it was part of some debug info lookup.

So I guess I'll need to do some more sanity testing, but if you don't
hear from me, you can probably assume that I just couldn't reproduce
the horrible performance.

              Linus
