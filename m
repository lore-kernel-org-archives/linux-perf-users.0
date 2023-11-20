Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99DFC7
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 12:40:13 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdfbd69bd5so4264636a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Nov 2023 12:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700512813; x=1701117613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRF5rVybXkdcsrKHCGQAP3IxXwdrS0UAySae7/HWR0g=;
        b=EBlUizofRm8G4lUASni8KO8g23UZaOLrfgcmXJkrLxc93NTJZUarrPQFyAOgUCk0uS
         nDzUV7QG68Kp9gAvVNhf0s6S3y/uDMAww5vcSjlRt8oXP3LD7vR9R4/lQMOxpStQjSmQ
         SEKp9gntQaN8m7rsGrbn2bULzXzTR+4AuSgg8r7sAKec5Xk60c28778xla+3UAHOpP/q
         ZOcPRJCUMkTE2lR/NbcmyVCQBJxB9u8I8XEoUlfGVLVObP93xS7ZA9DvYfidRAOE5wAn
         zh6BBHPdKY8vEbFMmxdLeR8T3ptsbZEaaTVcwFVF9YzY2eVjPEEcyIVpfHeiI36QEplf
         WNqA==
X-Gm-Message-State: AOJu0YxnvAYzkRK6fIZS+B7rOGNPRQMf4sojt4622sMnUUcuoJJKi5ob
	SXadv2GbLJQw76brohZZXzrWlp6vr2aj79pQZMG1kUxH
X-Google-Smtp-Source: AGHT+IFJJrGhG4dEfYwak8+anvmehsd+QknMeG0WrhXHb4j2/y0t/70y8lAHscT/xjvJtOKTWw5FkYjWyugSKZJcU04=
X-Received: by 2002:a17:90b:1c87:b0:280:a002:be85 with SMTP id
 oo7-20020a17090b1c8700b00280a002be85mr886338pjb.20.1700512812677; Mon, 20 Nov
 2023 12:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfuBxyYPdKtA_XCmpdb-qexM0ux3mfNHxCTJFimQ_MycCyeqQ@mail.gmail.com>
In-Reply-To: <CAJfuBxyYPdKtA_XCmpdb-qexM0ux3mfNHxCTJFimQ_MycCyeqQ@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 20 Nov 2023 12:40:01 -0800
Message-ID: <CAM9d7chnAQ1gHYGTL+bYR6pFnKz9fJ5rAP+qe2pktsKr4Suzsg@mail.gmail.com>
Subject: Re: how to measure cost of 'cat /proc/dynamic_debug/control'
To: jim.cromie@gmail.com
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Nov 11, 2023 at 11:49=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> hi all,
>
> I have a patchset which "condenses"  module, filename, function-name
> columns of the __dyndbg section into 3 maple-trees.
>
> This reduces the #entries by about 80%,
> so it seems likely to reduce overall memory footprint.
>
> accessor functions replace the raw field derefs.
>
> `cat /proc/dynamic_debug/control`
> is an ideal workload to evaluate the added cost.
>
> that said, this doesnt appear to be seeing that cost.
>    perf stat -r 200  $cmd
>
> bash-5.2# uname -r; \
> time perf stat -r200 cat /proc/dynamic_debug/control > /dev/null; \ uptim=
e
>
> 6.6.0-f2bi-00037-g078217875494
>
>  Performance counter stats for 'cat /proc/dynamic_debug/control' (200 run=
s):
>
>       21.73 msec task-clock          #    0.628 CPUs utilized   ( +-0.45%=
 )
>       44      context-switches      #    2.025 K/sec              ( +-
>  0.12%            1      cpu-migrations         #   46.020 /sec
>         ( +-  4.32% )
>       73      page-faults              #    3.359 K/sec              (
> +-  0.11% )
> 51894505      cycles                 #    2.388 GHz                ( +-  =
0.34% )
> 165896      stalled-cycles-frontend    #  0.32% frontend cycles idle
>      ( +-  0.23% )
>   83546      stalled-cycles-backend    #    0.16% backend cycles idle
>        ( +-  4.23% )
> 144663807      instructions                #    2.79  insn per cycle
>                                   #    0.00  stalled cycles per insn
>   ( +-  0.28% )
>  42439211      branches            #    1.953 G/sec             ( +-  0.2=
8% )
>                  0      branch-misses
>
>           0.034600 +- 0.000119 seconds time elapsed  ( +-  0.34% )

Looks like it's too small to measure.

>
>
> real 0m8.994s
> user 0m0.120s
> sys 0m6.888s
>  14:04:11 up 53 min,  0 users,  load average: 0.15, 0.03, 0.01
>
>
> Comparing that to master, I dont see much difference,
> which suggests Im doing it wrong.
> (adding > /dev/null  does more to reduce work than the kernel change
> increases it)
>
> Can anyone suggest a better perf invocation to distinguish
> the relative cost increase ?

Do you really want to see the difference in CPU usage?
Maybe it's better to check the memory..

Thanks,
Namhyung
