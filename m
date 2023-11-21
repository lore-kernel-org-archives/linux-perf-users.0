Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AE9E
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 10:49:51 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5b9a456798eso3586079a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 10:49:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700592591; x=1701197391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P1XgNf9jVKFXF4Cdh5edzzgpqEPhQFgwrlcoG92ZBo=;
        b=qGdFGd0TLC54TNkwxdIMDULAaE9lXgKrbp3wDSa4x/Kn65A51yXzVq/iGAo/kAPduh
         KGszynAWsQr77T0Uda27Ht4A/mzBqn7oqnOaim6wVQ+F9XsXUcqHsLx5SOkuQyOAwzL8
         TFX1+9kX5/Q0ByWF/sNNQ3Bb3z/8c0YB/y/t3FuSHadz3300IHdFIyzJ9OFxC7CopKr6
         KyAM1PB+h2GrvgNvPUa1Beqdkv/DXYflv17o6N8R0rPrA44JaVYpfg7Ey64+SftQ4C+T
         r4WXS3zT0gicWSGPHoqIJFZTWpQCD6qGHJEKBog+kByk1l6nTdEXKRxQV0iiez7U6H1h
         Ic3g==
X-Gm-Message-State: AOJu0YyiakUQbMtdHmNvrQsFCldzRhFfKOeMebW9ZYgzChaFAi2nz/Tl
	gCIwhynukoKOhEPxrEM5KFE+4WR/x7r/4Cri1CxDB8u7
X-Google-Smtp-Source: AGHT+IE0W1iiySkETUe9z4LFqtsalomgb/mtGP9Jxlc8bFQUR8kcG6+vlQzpJ91qEvIiZUOz4FM1ptNZ5mVAGERvJ+I=
X-Received: by 2002:a05:6a20:4f92:b0:186:7988:c747 with SMTP id
 gh18-20020a056a204f9200b001867988c747mr8862681pzb.19.1700592590878; Tue, 21
 Nov 2023 10:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <CAM9d7cgXWTSKTVCbSTdQnPqoHqu50UEKdPZ6nfNgdmTZPo0Cug@mail.gmail.com> <CAFjbc8Hh6o4-7VHDgozmMdqvcEz+9ysqk5JBLdfJW6uKazMYLQ@mail.gmail.com>
In-Reply-To: <CAFjbc8Hh6o4-7VHDgozmMdqvcEz+9ysqk5JBLdfJW6uKazMYLQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 21 Nov 2023 10:49:39 -0800
Message-ID: <CAM9d7cjt+xNZdORzVZ=uT2aOQPwAwmzxV4waq-=OCO7CVQaJuA@mail.gmail.com>
Subject: Re: Perf support in CPython
To: Pablo Galindo Salgado <pablogsal@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 10:30=E2=80=AFAM Pablo Galindo Salgado
<pablogsal@gmail.com> wrote:
>
> > I'm curious if it works well when the compiled trampolines are reused.
> > IOW what if two different trampolines have the same address (one used
> > and freed and then another came to the same address later)?
>
> The compiled trampolines are never reuse. As all the trampolines have
> the same native code
> we have a pool of copies and we assign one per Python code object and
> we tell perf of the assignment
> by writing in /tmp/perf-$d.map. Trampolines are only freed at the end
> of the program.

Great.  Yeah, that'd work then.

>
>
> > Looks interesting.  Let me take a look (after Thanksgiving).
>
> Fantastic! You can read about the integration here:
>
> https://docs.python.org/3/howto/perf_profiling.html
>
> That has some examples that can guide you to ensure how it is supposed
> to work. You can check the link
> in my original message to explore where the code lives.

Ok, thanks for the pointer.

>
> > Ok, I think it needs more detail..  Have you filed a bug somewhere?
>
> No, I still don't know if it is a bug or I am messing something up,
> but it is certainly mysterious so I need
> some help figuring out if it is my fault or perf's.

It's hard to tell without seeing the details.
Maybe we can talk about this later.

>
> > I'd be happy to help.  Thanks for reaching out.
>
> Thanks a lot! Looking forward to working together on this!

Thanks,
Namhyung
