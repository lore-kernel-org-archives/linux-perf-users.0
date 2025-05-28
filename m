Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713BE35942;
	Wed, 28 May 2025 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405858; cv=none; b=PO1HmwDhOuetvXWeiC9OzxqieU8USZc7OHLrOtzXISpaQNTjrUe++hUCEJCY2EThe8xhT6ybiM9aO+NaXH4MqWBvJRi/JpqlrS7vXACsjIkFgq7SoqRt54djzjP3xx8OAw6Y+nJaN0V2xu5NjaIVqXkCXpHp4Qm9rGYZKYopM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405858; c=relaxed/simple;
	bh=gIK2jNLj7PiRi/n9fkxad7k+Zo8ms0qzbUkbvTzAz+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/QlquGFW6zLmk4JjNhlS/Hx0y2L8FCWHSx6yZ3wyvupRQgc8y+tjf5WwfRJPTEMUlwX6WnN6UZYwvhEAqJhHu6NnNO9c/QSEDdFsCPYCMR3EvLxWsJbppDij8G8zffJ1ViSy6Cwx97mQqr1/Yr5+Ng3h9GHVEnhNUQzZVMQhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJA5ckYW; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJA5ckYW"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7dc83224d5so443441276.1;
        Tue, 27 May 2025 21:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748405856; x=1749010656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIK2jNLj7PiRi/n9fkxad7k+Zo8ms0qzbUkbvTzAz+w=;
        b=OJA5ckYW6NopUu7hwgwRf6PHa/jMWQqUS7Llb0j/DX2SXt7kftlsIEvzksgjoY5gQ1
         FaTmQjyf0hXTarC80AB5snl+iz8oWZK6ttiMgnLdJHJwxNJV2ir3Ttq3F8SuCuLoLJaW
         kDJPiu/mLExy9piv7WJZZm3OZwhZfdellkoZCsOykw0j7rqnBZlxghNh+u+l0dVBx6OJ
         Ibu8U0NJUVZdbdxfw5Syb4bDTTs/fGdgh7/1tBFxNnhZiakan6HzjRRQemCUUDglBsgt
         djv2k2zL7cDAMzOylLjmS/VY8iZfA2D6jC0k62ZZgixj/LtsOzjBvYd6hFq9przM+khE
         OJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748405856; x=1749010656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIK2jNLj7PiRi/n9fkxad7k+Zo8ms0qzbUkbvTzAz+w=;
        b=wsHPFO0euKzHCZe9TSm9A1rEUMGNHc/D9e3PGzvJ5txh4DVX4t99v/IbRwoI7ASwbY
         01jH02FN9mwe8NM0Clj8YxIvOxjmLrJPItFUwHOABl3H8kCMfdc2lgffI4xDysRmypNV
         uKhwMpq6vn3J1Z4pyPce8rrHeOzf9QmpIPNza4TXyJ8OnOX6MYrwDFKU9QBrbs4dXNlv
         MfYxC5zrvCZFDPMBP5Cjs+xvLB8YRcZsAoj6UqkJAHpowhEfdbl1SEaqeNnVHds8GcVU
         nVVt1DllCEHOJvvNLEB7kMyMaBsjBf6F45g5WqSsqdYe+0NxoMyEXpanVlzjE82flOnE
         n10Q==
X-Forwarded-Encrypted: i=1; AJvYcCV84Oyhq2Qh4ftZKPR4Ee8XINibWOG0v5FtRsx7TrSHsKGU4Nf2Ps7iWsOryIWMbRef7OCVYrqpH+w7UEC91oy5Cg==@vger.kernel.org, AJvYcCX7rT14Tn7+nI1w11ldOBk5pwoyDwiRGgdKoFtQKbskKoCxnkLMzqzyLINUYoq7LJKynmr9M+c6PV0BIKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3sRLupHFi+Rt/2tdH6UauaVraoPhdRclmnTfcuZEeyb2A2fk
	hxoCLnsxWbuxTzLHKocNyHmfhlUZlyKcfo72ub5f5nJ1drB2dkTWGOa3453zU2SkLaQwb9bzqX3
	p67MBttiy9Zqo0vWHPZ8tfn2msKT0be0=
X-Gm-Gg: ASbGnct5Kla8e/pqIQs8kjfxp8wkVzBs52sTJGToDI19uSpOSru7GCyU9FCZVnjAerL
	0tXHIWSJx1PtFMMTA77XQNYMO+Tn+hpjL9BpObHxw/bARQGfNcGgJo1+D+lb+hPyzarSVDbIKEH
	ueMBD1TXVzoFp86D27jsYVPoe1PcD/9WM=
X-Google-Smtp-Source: AGHT+IEexpuRJ1vvdcYophv5hvwFX/OFfNUCCHcz8/hxPY31SkPnhwLAv1nUNkfrrbqW4GU91pvWcm26arQODUe40rU=
X-Received: by 2002:a05:6902:1109:b0:e7d:a7c7:3f2e with SMTP id
 3f1490d57ef6-e7dd031fc4bmr4445810276.3.1748405856297; Tue, 27 May 2025
 21:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528032637.198960-1-irogers@google.com> <20250528032637.198960-7-irogers@google.com>
In-Reply-To: <20250528032637.198960-7-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 27 May 2025 21:17:25 -0700
X-Gm-Features: AX0GCFsByp54ESAL7HTGBpk-ibfmatGCNo6smxv07FCnf_glIPUAnURAOBPmNME
Message-ID: <CAH0uvoiEY0kkz09TavHG-KHqtk7UNHyRLfYC382D_yhvrstBGw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] perf test trace_summary: Skip --bpf-summary tests
 if no libbpf
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Andi Kleen <ak@linux.intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On Tue, May 27, 2025 at 8:26=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> If perf is built without libbpf (e.g. NO_LIBBPF=3D1) then the
> --bpf-summary perf trace tests will fail. Skip the tests as this is
> expected behavior.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
