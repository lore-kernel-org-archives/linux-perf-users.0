Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAB1DE894
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055182; cv=none; b=ZCDuT3ay4ru6aPsGzqCh8NBTy3G/4i6gneESU3gV2mnWNUwZs7J0dYzILjdqw837S/ycElKqUrprC3cwpuZGpw7Zg/zoJPTAWMA08te242B63twQncPe1qsOMY7bJnJoXLTlKaVbjV8c3BzTH/4C7saPkDwnXf296AuJ5cIQUOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055182; c=relaxed/simple;
	bh=ItsA9WAJW3Z0yXShllb7DAx8lDn67Fd29vJcuLxBrIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m28FgEn6NwawrNFLOZhkN/FSw7PkEK6hY9bf7OF2t2fiSat6O9rVYq8elYEQk4nioG06CEcUMz06afJ5VV3F4bqo383Oh68zX0+lUcuM7TmRCj8MX+mOEQzIhDrwSRT+eQUPjqgpUsG/9AL6zbaptYPCTnvPF/hPk65HufSNzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DTXP7Ama; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DTXP7Ama"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa679ad4265so482674466b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737055178; x=1737659978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gcQzKPEsH7SJLFz3SKJ8LnmQg3nduMJmA39KnbM02E=;
        b=DTXP7AmaJ3CXkj1otgOKqdDCbAW2NqhcjpbszE0Kt6Xfz8gSKsnFf1VYldrTWtuzht
         uMXsEWWhnSQcs0uj9xKy0CV+ijrSU935GWtIUXHhcksGmJO9slDWq+MjLXw0HOkampwQ
         7Nsz/5tYc45+YbC7aPPD8G5ZCDivhQdo0IvjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055178; x=1737659978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gcQzKPEsH7SJLFz3SKJ8LnmQg3nduMJmA39KnbM02E=;
        b=LTCLd7YrNU9G+UF+Kh7O0uqnOe6TRxP9Yb3sgEOWbb24BWP/NaT9iJ6jNBiB9lf08b
         P+2coQla1Kpm+UYMLE+su5YDP0QddzzKBeuRznOnBLr5rXSDFRQdT1KbEnjUtRPfGxs0
         Oq8vZVnutfB37000o6lQFiit6TJR2zLGpiQf7/BmY2KrGgLRQAydmjPenT9X4vZdNTrd
         k9gCa1o5eDNmYzoE7gmB9imu2ZWQv+itWV29lhAobpzuW8Z2iVERF+ppEiG5DJmHqZoq
         pnmapPCIX/+2CeVlYVq4kt8+gY2xgc7TQrVNBubCs2F1U2vhGSd6E1bPkvC9DMD73o7B
         1mvA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3NbKdwas41FFFbum2qfBFfkpvGW1qfXo3rWMong2LDnXci/ixLxRq8xSr5tU88A1kPKDXpX5KH2o29Tplv6A@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjNbB0jP4+tpdJWhxoRiQv5QwJam6Zygl8kv6UVWuaJOnicKI
	LnkuE8MLgokxlxJko3x8Hhd/e/JJBfYV3uFgvc1qPZ9YfnOTYSdL+9Wl9FD5p24PbM57XZguaJU
	58M4=
X-Gm-Gg: ASbGncv5dHY+V5+ULVv41ZkIZAqrdBN7j8/7xUpBXjAFdpuMvkROAREUikSRi1GtjMl
	9b7JxNEYaEQ71ixYEL4+RKgFDAK88Qn/VVdbzNGZCmJaiqrp9wCraDNONfB6yVWaC+WjQ8WYauO
	P3mLC3oYe41jHcF5rSYIXCqGPCkqKJDi0QggxWB4d0Ybgo2NwHOaZuWqpQryTfUBOVa9npw31e/
	e8a2Ws7qPtZ/zS/i85EsivWbzaz3JtpQgc+i94zdoW7UreQLfy/E7s8aKtZMTYFcs/UTWh6NsAI
	GBrwsyr2CGz6VDbp5+hncmr6aSntE9c=
X-Google-Smtp-Source: AGHT+IF4y6ha3vVwS9lrefWWd0T3pXRGlbqSLg5wHEkxkHTzwY1AZhtjKJyEbXtMH7czXjYJiNNjug==
X-Received: by 2002:a17:907:2703:b0:aab:9341:e1bd with SMTP id a640c23a62f3a-ab36e244c53mr299991766b.11.1737055178266;
        Thu, 16 Jan 2025 11:19:38 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384ce11e3sm38648066b.55.2025.01.16.11.19.37
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:19:37 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso4393957a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 11:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX88jxyT8wE3qh+G6BT6l1ihYfas5q9xdYPi3WWf5Hu88WG5pHwYcaVtmrpPjy/p9DHDdIRtRqnSKp6nrdrqYI7@vger.kernel.org
X-Received: by 2002:a17:907:268a:b0:aa6:938a:3c40 with SMTP id
 a640c23a62f3a-ab36e479602mr443599066b.24.1737055177248; Thu, 16 Jan 2025
 11:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home> <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
 <20250116141800.31d519eb@gandalf.local.home>
In-Reply-To: <20250116141800.31d519eb@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:19:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
X-Gm-Features: AbW1kvYN_xkKuoMBiyXoBE-Yb4E0lys8CoCXX5qnJ0myflXFLJitmhUkkLkbhmw
Message-ID: <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 11:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But they are only defines, they are not created until used. Are you worried
> that it will slow down the compile?

Yes, and the whole "pointless noise" thing.

I *look* at header files sometimes. I don't want to see pointless
noise that isn't relevant to the context.

This is not relevant to non-tracing users.

                 Linus
