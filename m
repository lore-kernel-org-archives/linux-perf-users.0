Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3815B54B
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Apr 2024 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083786; cv=none; b=fhfNxHPJucekpw6p/xNNlkjXxw4US7TYlfGntiR6ocJzvrJ5zxm+dXC1XB3Tmt4RewMxdzSfrFgjW12ju8egH0byRZCJ8bcUKSCGdj8/D5Xe+rM0kou9gd17Zwqd17E1wVjkBu7bYS9E8Vu8CuHp1FhpHw/oU9oY1iiuanXqXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083786; c=relaxed/simple;
	bh=weISqq2A6RI0H2LbwN7F+0X9UdQ8TvO+tJz9Kd/Hf90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/ew3Lxtj9SYzdYgi6h1/3cBvvs/jQAsBFc19d21pKKdqZmvhZwbK4Qzsb9wu8cWz4LtnDYzvX7Jx8JqK1GtAvXhxx+WxycslN1y7dMBPyB/VZ37yF/QbKDcAJJ/nItUROh+geIu6MwwxlVtsSmh/URFJT3EAm/M8RC3A5vEVt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wis1wMJZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wis1wMJZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e277154d4cso24935ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Apr 2024 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712083782; x=1712688582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=Wis1wMJZR1p7IRF3wzWLzAY99c3OMVlVZ1BsD8n3dNZRnv2JH3OoM1UohlshGO673i
         zNcss4wVhSFndY9Ed5t99BfPy4Q9h7GLrhjnxyD9dns8M23UDz2J7NWW4Nzs34aH5Ldq
         Lyk4lsF2naiZDlWvvbPDCIZaqxMRRqVANJFQ7w2UYmjmY5Gbas9iYIgGScewVO8g3FZO
         GLfZr5zjTzFtFIUoMYGp0RXoxI+KpnZ/kwt5qi/jG9L7MNfSwJU6crSWPpk3W7ivxlFh
         YOn6nl9mdd4pslTDxLNtGw9r5/OvKZ5hSCBQDNjsp6u03lo9jWOaIPUkG4tOYUBzkfHX
         OBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712083782; x=1712688582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=588W+WKWGCHDk22Ud5hS9stI2LC3FAq1GuSxHQ/M9as=;
        b=XND/mEuUkf0I2yQfzhuJAYpsnac4klXu2JpBfQVqIUQNrjwN/3wWx3BqHKDb4WLmX8
         SdSefJNMuAMC6ZJtiJtYk/fPLQ59gQX370afkKfOTYGgkjP+pPNcaSrE9vx0kavUwdAC
         IGMhqxg5QUrytu7/v2Ho5kpF9ws5k1R1aWA9RrDEhNiH8M5NeFC5qBXJbNy3eqA0inpa
         65GiAhnnYSxUscW2vQZjXWlIN3CvoS0mMruwnYUD20NvvVesaUPvsSlbee1pzB0nR9cG
         8EJYJzDL06ZXqLZp4OSnqJ3kOf3XOQxjpAV3gh0SA353aft1xbZMsp/fcliTCY9TIX+Y
         eT4A==
X-Forwarded-Encrypted: i=1; AJvYcCV8flGFCSANA3wMUj64Iq6eSFgN1v3k0XoUyrSilu65V0v4ud9D4ZWbDbaGV2OkW5IVRhGqQeNC6Vsw6+PUec01S9AGGq6A+aOVSy3lD22/Ew==
X-Gm-Message-State: AOJu0Ywdyig+iH2vi+Wd/FLFDSBrHK8vwE4F7na8uwwYoKsTtKfjrdR2
	SQC1s/aptM69Ya9jB7Oi61HbxsJTWq4V9dgCK0wbudGzoehy0NUD/GP9n6r8fc30lQflOujmMNi
	Vsn61rox5Sr+HXm802pTYYCOOLxjcA3N1w5eU
X-Google-Smtp-Source: AGHT+IFqE+UQS0RbhVUDfvVWh1jxlaucrKVTE2OWHdxUHvFSzVEw8wbwfhObgRXrJ5KsEFLTxz8yLY320Q5s7zmUQM4=
X-Received: by 2002:a17:902:f645:b0:1dd:8001:d239 with SMTP id
 m5-20020a170902f64500b001dd8001d239mr29669plg.14.1712083781959; Tue, 02 Apr
 2024 11:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402184543.898923-1-namhyung@kernel.org>
In-Reply-To: <20240402184543.898923-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 2 Apr 2024 11:49:28 -0700
Message-ID: <CAP-5=fWh+nrZukmvANf0rmG_Fw11hMgm=dPkHCG79F+tdzsTvQ@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Add a missing NULL check
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 11:45=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I got a report for a failure in BPF verifier on a recent kernel with
> perf lock contention command.  It checks task->sighand->siglock without
> checking if sighand is NULL or not.  Let's add one.
>
>   ; if (&curr->sighand->siglock =3D=3D (void *)lock)
>   265: (79) r1 =3D *(u64 *)(r0 +2624)     ; frame1: R0_w=3Dtrusted_ptr_ta=
sk_struct(off=3D0,imm=3D0) R1_w=3Drcu_ptr_or_null_sighand_struct(off=3D0,im=
m=3D0)
>   266: (b7) r2 =3D 0                      ; frame1: R2_w=3D0
>   267: (0f) r1 +=3D r2
>   R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it fir=
st
>   processed 164 insns (limit 1000000) max_states_per_insn 1 total_states =
15 peak_states 15 mark_read 5
>   -- END PROG LOAD LOG --
>   libbpf: prog 'contention_end': failed to load: -13
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   lock contention did not detect any lock contention
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/=
util/bpf_skel/lock_contention.bpf.c
> index fb54bd38e7d0..4e5914d7eeaa 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -305,7 +305,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32=
 flags)
>                 break;
>         case LCB_F_SPIN:  /* spinlock */
>                 curr =3D bpf_get_current_task_btf();
> -               if (&curr->sighand->siglock =3D=3D (void *)lock)
> +               if (curr->sighand && &curr->sighand->siglock =3D=3D (void=
 *)lock)
>                         return LCD_F_SIGHAND_LOCK;
>                 break;
>         default:
> --
> 2.44.0.478.gd926399ef9-goog
>
