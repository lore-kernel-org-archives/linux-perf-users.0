Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F03398A;
	Mon, 12 Aug 2024 04:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723436469; cv=none; b=ifLzRojkUAitN5bJk0+KADbvj4OhfXng7IZtqoUjGycGU2eSMkzlZF9Xv1r4gw7RNQiwBvU9CUmeqbHTW6ROJowrvgt6SAf9w5sal0naZh2JqK5grsjsKuHbiKEUwZ//3PHji/xmQwkHKD0fWJa+kJg5MfgWMQCdGzKCTFauEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723436469; c=relaxed/simple;
	bh=i6Z9QOF+wXpHhshCsztokE7Qyta1vVDcz+yTKbS/qus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHmWovr6er/fbaMbsXID7S+0TOAsQdbOR9Shfz1XxD51Ix6KrehDpFP8qclUlUyhSrbAG0Xh5RYXOw/319gUac05oSmvxcH/uFSyQ7GpBwkUxl67GZmZyorNzb1crRfWctOYdO/HUSK+FTuBVDpIc7gNOhehBl3fmvgX8DS0L74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adnMxyrU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adnMxyrU"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc569440e1so35927925ad.3;
        Sun, 11 Aug 2024 21:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723436468; x=1724041268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVDrxjT+8nm8KTZI61JkdreIkVU4lBBy75kFdM495qM=;
        b=adnMxyrUV36PDA1VWMf6MEZUM9gA8+/3xdBAob6+S07OtIheBNL+4GyUKwv6z+87p9
         vO7QaoQlRnEe7TMuwBriv5xOBMUrnknekezv8zdwsPt03zgo0y31NGv+IPn9SJ2US6Np
         6uwKJ9YuEohsx+vnQnGmqTIvSYYmQAOmlrVu+y0bmOnCVYlXG1k2DFzLsP4q6gCty3Cm
         WWHXiBRCSVEUoo4Px0TbPgf7popH/guJ8jRrmVPxuRwHCnF6j7sDijgosLOQ/AxWoNPs
         tsPy94Mu2lRtGlY5D6UDob9jI2BzlYOCc27LCYoLbyMuOXnwFEi4HxFuwqow2QaoJQwK
         weUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723436468; x=1724041268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVDrxjT+8nm8KTZI61JkdreIkVU4lBBy75kFdM495qM=;
        b=wuNxu6suyxDw6fd5FE81+jh34YiWIr8cFdPmCvjJONK00t8uR9bFrRIey+o7EVevuA
         EUx6eAdjTtS40lfyUMozT0O+wJIRqu/ibTI7g0VqT/MQJOxgqaX2DQelPAX+F4WhEQKT
         qLE05ikSXo4zBzWiDhxa0IdP1jRQkLhHHcBgxN/I+IsMpq29LpAvD+KmzZQDBmlyaOYw
         SjxLD7WU49pRltnpYSceaibDpu5oA+w1kYYTlyv1F8H+wjs/hV+fl1uGGCpPlRSbxwcO
         cH7Ze9zLHISKDfeKBT4qk3duSUNoUsxkuwMYysc3xcNjG1k9GPRGcSZg3qTRcFmP/rlG
         BDTg==
X-Forwarded-Encrypted: i=1; AJvYcCUjLN6ngmA3v6qNwB+GtnkdEBgRDLVTs0Sb9mrOmPyvhdOtU4MyhiGqLimc2qAh2lxSsRnHVydlly/BBjo=@vger.kernel.org, AJvYcCWF+WwjO00R8SYWPIidGx+JGPCn1iDt7qb6Zx7ZGKTxEpo9M9S7MMScnpgZ9ZuAEtop/tUp7EL6an64oP5RX0YJ3Q==@vger.kernel.org, AJvYcCXkSgeJXi04iW8bXBAFGy0nmfdkpbsWLoF62ivhPsy6e/Mc7tu3m1b3J1tVuIPYSRB9IDmjrOKlPZVSHO6elEJT02E2@vger.kernel.org
X-Gm-Message-State: AOJu0YxgzW/jPtSivoXR2Tg/ejjorS/NdhRWknTSdO4WgLxdfGetxVWR
	sAvegvYZF8Pr41/32plvkxo/YnNxpxAMd1DVhI4pj4d7/yC1OVJDKVAa9dqodWdFw9/fqPCjiTA
	+dyShJcLFpffvzzjoOnPbHa3/Jdg=
X-Google-Smtp-Source: AGHT+IEWPDAYmSAPMQYVoUcRGrmEI9ad5GDG8PWnRZlz5I/qjCM2d1Yn+agRrO59Un5QLOxI6B3/meqUgBEXA0Q7NRg=
X-Received: by 2002:a17:90a:5647:b0:2c7:c788:d34d with SMTP id
 98e67ed59e1d1-2d1e80798f8mr8798212a91.38.1723436467612; Sun, 11 Aug 2024
 21:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000382d39061f59f2dd@google.com> <20240811121444.GA30068@redhat.com>
 <20240811123504.GB30068@redhat.com>
In-Reply-To: <20240811123504.GB30068@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sun, 11 Aug 2024 21:20:55 -0700
Message-ID: <CAEf4Bza8Ptd4eLfhqci2OVgGQZYrFC-bn-250ErFPcsKzQoRXA@mail.gmail.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
To: Oleg Nesterov <oleg@redhat.com>
Cc: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, jolsa@kernel.org, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	irogers@google.com, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 5:35=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/11, Oleg Nesterov wrote:
> >
> > Hmm, bpf_uprobe_multi_link_attach() looks obviously wrong.
> >
> > bpf_link_prime() is called after the
> >
> >       for (i =3D 0; i < cnt; i++) {
> >               uprobe_register(...);
> >               ...
> >       }
> >
> > loop. If bpf_link_prime() fails, bpf_uprobe_multi_link_attach() just do
> > kvfree(uprobes) without _unregister(). In particular, this leaks the fr=
eed
> > bpf_uprobe->consumer in the uprobe->consumers list.
> >
> > After that another _unregister() on the same uprobe can hit the problem=
.
> >
> > I guess we need a simple patch for -stable...
>
> Something like below on top of perf/core. But I don't like the usage of
> "i" in the +error_unregister path...
>

Wouldn't the below be cleaner?

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cd098846e251..3ca65454f888 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3491,8 +3491,10 @@ int bpf_uprobe_multi_link_attach(const union
bpf_attr *attr, struct bpf_prog *pr
        }

        err =3D bpf_link_prime(&link->link, &link_primer);
-       if (err)
+       if (err) {
+               bpf_uprobe_unregister(&path, uprobes, cnt);
                goto error_free;
+       }

        return bpf_link_settle(&link_primer);


We should probably route this through the bpf tree, I don't think it
will conflict with your changes, right?


> Oleg.
>
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3486,17 +3486,19 @@ int bpf_uprobe_multi_link_attach(const union bpf_=
attr *attr, struct bpf_prog *pr
>                                                     &uprobes[i].consumer)=
;
>                 if (IS_ERR(uprobes[i].uprobe)) {
>                         err =3D PTR_ERR(uprobes[i].uprobe);
> -                       bpf_uprobe_unregister(uprobes, i);
> -                       goto error_free;
> +                       goto error_unregister;
>                 }
>         }
>
>         err =3D bpf_link_prime(&link->link, &link_primer);
>         if (err)
> -               goto error_free;
> +               goto error_unregister;
>
>         return bpf_link_settle(&link_primer);
>
> +error_unregister:
> +       bpf_uprobe_unregister(uprobes, i);
> +
>  error_free:
>         kvfree(uprobes);
>         kfree(link);
>
