Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD24A2A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083235; cv=none; b=eUPL6XnMNneWKt4MLAYNpqHSHXbSchqP4/syJ0H5lw5W5jFolfPTARRxB/RGX/Ikn3V2B9nSftlq7GOIxwGTzISS2kQ/UgGAht9jQNVsoCu5AWmQEfadxki/7oJp0L65jzzO3igMHFOUlGUI6evq/we0kqeKxWi9swW51Nz8faY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083235; c=relaxed/simple;
	bh=f8TZMnSkvdvr8lU7/b4OziAB9m4g7TVwlFVIH7WadGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URBFRppQcy3WWRzcgmzM36xYDxeG694BoK8U1FK2C/SHH8Q2w5XvLdGoQ+ykI1yxciuWArIXNCAyGFcbzdXBDFvo9rjdY/UYKHtguWpwSp0WtWVqMUpH6PUyOkbyptMPkD/Cev63kySWMvCo7ncWvjeOdWGSLzy4rK1/V1Gzx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtnjBG4u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtnjBG4u"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dc744f54d0so92805ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Feb 2024 17:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709083233; x=1709688033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdT0x3HibO/pzSmdrgIYWiv8FmuIQF8zXY+TeseC7sM=;
        b=GtnjBG4ued0/3Wglc80zQFw7gd9rH4lN4TWnRIzyjBJFQgPy/PL5H+zyz4aWoQkES9
         iu5PewLUB+eGkhqMCuiJstyqj7bW0M7fNuUuBRRW5M+tkcm4elfKNeOX37CMTtpsBn53
         3VL/JGFX8CNMvfVKupyl7luFYtn4hF7j1U3aksxS5ALU3tr2hLF5ergj8hWcL7gcoPLe
         QYv7/TWICuu6XeWN+IJglD2rJSl83D6rs5mhUZcbav2PB3brDnw2/SK/VOb35zFx6GFX
         PNcqTNSrM668Mm8aQgIBf0uw0ESlitttZ8JhUUgJul2H4IM2Fbw1GABmYzf3NwwyCJc2
         wKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083233; x=1709688033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdT0x3HibO/pzSmdrgIYWiv8FmuIQF8zXY+TeseC7sM=;
        b=L6rymfzFLzfDy+A+2jq/70OP2YaUJ9wI9QTyW1H1FRqpVtOyAgeeQMqRhn/DhnRV0o
         8AKIe2pbkpjOt316mCEohQVPA0iKRH1/vIG99kYiV2Dq0uJXqLZNK+7jQ7/EAOEiIDHY
         sA/JxOwa72I8ZOkFdbARDm/GgwpnvPlguv/xosQP9KCBrJEVrCiJQXiMMtSwgCSsX7bS
         +QKIfUcuFAi/LPL02EqBEt1yRXK1AEu7cJRQwBkb1emlWGwFa3zrnc3vM8WxwcGKPMq+
         wMdwF8p581KjVzuVk8TRKe92y19BBoD6MdBfEv+rZ5hhjEZRq8mYuL151uByjXa2Ypdx
         W5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVi/u4gKdsputvjOQ4E/iDPXGTuLGp+zI0MBR0O+CzXqP61sVGVcGXmNBtLLsG4Iwj9BATN2o1dgCVLM71pz9trZGgQBarPVSInQ+McDzeIsQ==
X-Gm-Message-State: AOJu0YxOtrtI4q5GW0aRKAIojkxF/t6BOEVU/mW9PPkYdG2v5rfS/j4U
	momiZefjMwBQic4vLTuntD5+4zrHk+gSqtMIpm9g+12AzTHSOMezbTQYNwqdK8HaR6ZbvqKExKH
	qfZh8qajNsc9RMB/EyNVP7MxvDoTX9f6pc87a
X-Google-Smtp-Source: AGHT+IExJXBPQ3GF+J+ug86UWIg39ZhcnQ8sj9sPYlXuoBEeaVUgwPP/10AdRfGAu/tgNqj+8duppB4y7xFFMF15R7E=
X-Received: by 2002:a17:902:fa08:b0:1dc:8fac:929b with SMTP id
 la8-20020a170902fa0800b001dc8fac929bmr9738plb.15.1709083232928; Tue, 27 Feb
 2024 17:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228005230.287113-1-namhyung@kernel.org>
In-Reply-To: <20240228005230.287113-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 17:20:21 -0800
Message-ID: <CAP-5=fUK-P-4n46DjjGt48z_sivJ+HawsFP3e_C-mx5dW9JP8w@mail.gmail.com>
Subject: Re: [PATCH 0/4] perf annotate: Improve memory usage for symbol histogram
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> This is another series of memory optimization in perf annotate.
>
> When perf annotate (or perf report/top with TUI) processes samples, it
> needs to save the sample period (overhead) at instruction level.  For
> now, it allocates an array to do that for the whole symbol when it
> hits any new symbol.  This comes with a lot of waste since samples can
> be very few and instructions span to multiple bytes.
>
> For example, when a sample hits symbol 'foo' that has size of 100 and
> that's the only sample falls into the symbol.  Then it needs to
> allocate a symbol histogram (sym_hist) and the its size would be
>
>   16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) =3D 1616
>
> But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
> get worse if the symbol size is bigger (and it doesn't have many
> samples in different places).  Also note that it needs separate
> histogram for each event.
>
> Let's split the sym_hist_entry and have it in a hash table so that it
> can allocate only necessary entries.
>
> No functional change intended.
>
> Thanks,
> Namhyung
>
>
> Namhyung Kim (4):
>   perf annotate: Add a hashmap for symbol histogram
>   perf annotate: Calculate instruction overhead using hashmap
>   perf annotate: Remove sym_hist.addr[] array
>   perf annotate: Add comments in the data structures

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/ui/gtk/annotate.c |  14 ++++-
>  tools/perf/util/annotate.c   | 114 ++++++++++++++++++++++-------------
>  tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
>  3 files changed, 158 insertions(+), 56 deletions(-)
>
> --
> 2.44.0.rc1.240.g4c46232300-goog
>
