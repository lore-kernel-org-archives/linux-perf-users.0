Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6F3E488
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jan 2024 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so3076973a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jan 2024 15:53:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844385; x=1705449185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNLPWreB4Ml92efL1PnE09wgSVqVn6Qv28XQGdtINUA=;
        b=Dv7UY1qpP5JRh9gCEQTbA++GBnoBHTTV5JPVd+oN6yEqKK0aWILZVke6d6eyQhs1Uw
         5/2VsIRR4yCkFlUmrhjZRDmYqR89w0nyZFdajF2gkKIrEfL7liIe9zbAsA4TTMni02F+
         kOXcxoa85eJgQDB5Ee35CyHpPMmhaVvaRajTh/h8XS/kpncl9WgCBvosrzmcLyhXRiKO
         ajs7cjWoi766kVcRbCuXwKZRkX+cf9B6LKvwVthyofxAZLM88jVoFVmBEWZ4v/+0iR3D
         vd7FHJUE50+8ORPcKoVZTovWWteV8mVE+Gs3b4kXAsFwk+yxTcSL/Pnrqy+8qQP/464R
         Ym6A==
X-Gm-Message-State: AOJu0Yz9yVh31auvHE8Ha3nsbYqLb7O3CPsK+vscdxtm7Q3zJnPDJK9e
	FTlmZCEDXWMQoBVkkraNkM3IiG0a5UjojUeXLnbNjzrB
X-Google-Smtp-Source: AGHT+IHobxzpFDZppDKNeXnU5U195fh2Z/A1HZ8UcKPkLCNUwA1rbhPjlJ5kYogD343fn0APf8uBvtDRcUvsLqRCni8=
X-Received: by 2002:a17:90a:d10:b0:28d:3964:9f2e with SMTP id
 t16-20020a17090a0d1000b0028d39649f2emr82519pja.27.1704844384680; Tue, 09 Jan
 2024 15:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401091452.B73E21B6C@keescook>
In-Reply-To: <202401091452.B73E21B6C@keescook>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 9 Jan 2024 15:52:53 -0800
Message-ID: <CAM9d7cjBTw0RDv1LKNuiHZgTivW+jjnrtmWjm9Z4ekspWtYmrw@mail.gmail.com>
Subject: Re: Getting PMU stats on specific syscalls
To: Kees Cook <keescook@chromium.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jan 9, 2024 at 2:56=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Hi,
>
> I'd like to get PMU stats only on specific syscalls. I haven't been able
> to figure this out. i.e. how do I run:
>
>         perf stat -e some_syscall_name_here make -j128

How about this?

  perf stat -e syscalls:sys_enter_<syscall_name> -- make -j128

>
> I can't figure out how to limit collection to only time spent during the
> syscall I'm interested in. I tried building synthetic events, but that
> doesn't seem to work...

Hmm.. ok.  it seems you want to use PMU only for a syscall.
I don't think perf supports that for now, but maybe it's possible
to attach custom BPF programs to read perf counters at syscall
enter and exit and to save the diff in a map.

Thanks,
Namhyung
