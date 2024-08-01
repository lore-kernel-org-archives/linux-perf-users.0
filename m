Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D902F1B010C
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Aug 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526278; cv=none; b=JGKcF9iK0aH9ri7LfmL/RrqiO5ho/B9nX/ZpnzPch/3OpTHffIQkKa4lkYNkB9qyzuhDEpV8AJALYF3MUITRk9+aM/ycjKH9GeTQlcAzcpaats1g37FZb/a3NGOEmR5ZexiRSsWu6kNN++wcDUIoywZlQJVxhvk7ZP2iqY2TQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526278; c=relaxed/simple;
	bh=tfbxhIpqq334Pll0B4Rk1MQgw7OMoQF/Fi+CR9uxGXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwRGPq50cCbaOr9V5X5YAua8JDQnDF3Yq9rju0TGyV4IqDqZFrLE8Yo3MhfOvBi/8GhVM43V506yEYgE4oSKIrP4Fn8MSgdGZfHk+JmCkBBpsRTbB7LSwzymRFijXd5MxYOWXCKOGLP4YUnuXnSHafqMMBPkuY9mhWqgLmuOYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uN7zV38M; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uN7zV38M"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45029af1408so634721cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Aug 2024 08:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722526276; x=1723131076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqGu37sLxEdk0yBaV4kFtF/K8LvW18aSWC5wLXya8Jc=;
        b=uN7zV38MKwCkqEidLLVPBOG41aVg5K2OjaTqpiRSBTDHHp/wWqJRXWLjEox9qTXnrJ
         Q5o9+k8KIsorUFvhwi3BaR04sdnQ/Mkyo6Z5rX8jyeaRh1xB10sUMVAGk/Iae14sLmV6
         E7FlyzL/JtXlAt78Q3Z6978m3ZstnH70x8Xd5oEFmrhq3/+qUGqBqIa7lrck0RxHb2/J
         GPa/nnIPlKQHuz6rMugt8kq7oGCTMtozdc7qLcR4M414xB1B366WpC8GRU/taR22AmZq
         u6FwuMuPSmZyI23Z7g/ohJR19NOeXjCR/QZS+A5r/1JiBOF6VXjR+GsrwoCOPU/mSsev
         dcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526276; x=1723131076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqGu37sLxEdk0yBaV4kFtF/K8LvW18aSWC5wLXya8Jc=;
        b=lMjV7ZnVyQmvHFudlNqGAjq5LTl1t37hiZqQgFi3AAlHIBS4OXqa1ziy/rXfdHigjg
         3Hp+1dLcA4JH13hVNveOeHyDIDO038BAOIYf5GPrKzu/xeWLppphQzHIO4xBm+Y4xjad
         5FkKr8nPCAykIevBVUic4iaa/Twcrk6bZVDD7K3GjGMbB63jLxtqsowaHv4aO3PwscsE
         ENlzC+5RZt/C8TqrMJW6vNVRXB4i+boa47JWwCfKrf7vvRdcu62wGr4L9kUZt46aOJhr
         KbiUT+3MHQsjOFGBnaQwIDqgMrhdYRUZ6KQ0rPwxWEJS4lJrB7wlVSaRgm1JhGdF09sR
         vC7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUc4RIjRrjfBM9noW9n7rARsrG+z/uXvWbdPvc4V+ZfPYtUUefSxwSV2VBNEg59IFHJWq+kQ7evCLuX1tFBHJ0cSxjZ4ihic2lJSOzOFBwFg==
X-Gm-Message-State: AOJu0YwKQM0NTy7x3BZp3pznse5z8nv1eU7DRZZnqm+D8WpjSmk2BHdn
	dQ/9oyJFmS6/6cKZOGs+cj97OZkq+Is9zPdX2QNckmHbCqS/2qV3hrPctKmf14wIzKaOKfwmA7B
	1sLCqeh31PKEj7oCIwyXhRYnd2ww91NZlsyCP
X-Google-Smtp-Source: AGHT+IFSEF/SAMcFQLFt4fcOVaB9veabd6tavCI1baWunu+OqS08T5U//Ohdmqdruq4WGmDA/CE+H5Ah1wS15gU81HE=
X-Received: by 2002:ac8:5d86:0:b0:447:f5de:bd18 with SMTP id
 d75a77b69052e-45181e75e80mr2142101cf.9.1722526275507; Thu, 01 Aug 2024
 08:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731194939.4760-1-howardchu95@gmail.com>
In-Reply-To: <20240731194939.4760-1-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 1 Aug 2024 08:31:03 -0700
Message-ID: <CAP-5=fWbfFksAV5rtssgKdL-i9bPjAP6JXRWnfaYgt8fK3vh3w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf trace: Augment struct pointer arguments
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:49=E2=80=AFPM Howard Chu <howardchu95@gmail.com>=
 wrote:
>
> prerequisite: This series is built on top of the enum augmention series
> v5.
>
> This patch series adds augmentation feature to struct pointer, string
> and buffer arguments all-in-one. It also fixes 'perf trace -p <PID>',
> but unfortunately, it breaks perf trace <Workload>, this will be fixed
> in v2.
>
> With this patch series, perf trace will augment struct pointers well, it
> can be applied to syscalls such as clone3, epoll_wait, write, and so on.
> But unfortunately, it only collects the data once, when syscall enters.
> This makes syscalls that pass a pointer in order to let it get
> written, not to be augmented very well, I call them the read-like
> syscalls, because it reads from the kernel, using the syscall. This
> patch series only augments write-like syscalls well.
>
> Unfortunately, there are more read-like syscalls(such as read,
> readlinkat, even gettimeofday) than write-like syscalls(write, pwrite64,
> epoll_wait, clone3).
>
> Here are three test scripts that I find useful:
>
> pwrite64
> ```
>  #include <unistd.h>
>  #include <sys/syscall.h>
>
> int main()
> {
>         int i1 =3D 1, i2 =3D 2, i3 =3D 3, i4 =3D 4;
>         char s1[] =3D "DI\0NGZ\0HE\1N", s2[] =3D "XUEBAO";
>
>         while (1) {
>                 syscall(SYS_pwrite64, i1, s1, sizeof(s1), i2);
>                 sleep(1);
>         }
>
>         return 0;
> }
> ```
>
> epoll_wait
> ```
>  #include <unistd.h>
>  #include <sys/epoll.h>
>  #include <stdlib.h>
>  #include <string.h>
>
> #define MAXEVENTS 2
>
> int main()
> {
>         int i1 =3D 1, i2 =3D 2, i3 =3D 3, i4 =3D 4;
>         char s1[] =3D "DINGZHEN", s2[] =3D "XUEBAO";
>
>         struct epoll_event ee =3D {
>                 .events =3D 114,
>                 .data.ptr =3D NULL,
>         };
>
>         struct epoll_event *events =3D calloc(MAXEVENTS, sizeof(struct ep=
oll_event));
>         memcpy(events, &ee, sizeof(ee));
>
>         while (1) {
>                 epoll_wait(i1, events, i2, i3);
>                 sleep(1);
>         }
>
>         return 0;
> }
> ```
>
> clone3
> ```
>  #include <unistd.h>
>  #include <sys/syscall.h>
>  #include <linux/sched.h>
>  #include <string.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>
> int main()
> {
>         int i1 =3D 1, i2 =3D 2, i3 =3D 3, i4 =3D 4;
>         char s1[] =3D "DINGZHEN", s2[] =3D "XUEBAO";
>
>         struct clone_args cla =3D {
>                 .flags =3D 1,
>                 .pidfd =3D 1,
>                 .child_tid =3D 4,
>                 .parent_tid =3D 5,
>                 .exit_signal =3D 1,
>                 .stack =3D 4,
>                 .stack_size =3D 1,
>                 .tls =3D 9,
>                 .set_tid =3D 1,
>                 .set_tid_size =3D 9,
>                 .cgroup =3D 8,
>         };
>
>         while (1) {
>                 syscall(SYS_clone3, &cla, i1);
>                 sleep(1);
>         }
>
>         return 0;
> }
> ```
>
> Please save them, compile and run them, in a separate window, 'ps aux |
> grep a.out' to get the pid of them (I'm sorry, but the workload is
> broken after the pid fix), and trace them with -p, or, if you want, with
> extra -e <syscall-name>. Reminder: for the third script, you can't trace
> it with -e clone, you can only trace it with -e clone3.
>
> Although the read-like syscalls augmentation is not fully supported, I
> am making significant progress. After lots of debugging, I'm sure I can
> implement it in v2.
>
> Howard Chu (3):
>   perf trace: Set up beauty_map, load it to BPF
>   perf trace: Collect augmented data using BPF
>   perf trace: Fix perf trace -p <PID>

Series:
Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-trace.c                    | 253 +++++++++++++++++-
>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 121 ++++++++-
>  tools/perf/util/evlist.c                      |  14 +-
>  tools/perf/util/evlist.h                      |   1 +
>  tools/perf/util/evsel.c                       |   3 +
>  5 files changed, 386 insertions(+), 6 deletions(-)
>
> --
> 2.45.2
>
