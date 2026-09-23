Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B0560AB3
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190700; cv=pass; b=aJUA/wMm1IcczoewiycoHWWlbz44G5BVu2DaLyHYzJ891MjUzKq/SRky/+pkxapOHQvkJ9ktzpBwwwZWZ65ME/DRAlBioBiIneBYXjP15eXWIglKGIa3yL6kg5cb1uuKiUVHxaAXYpZqH2pevDcyKvwYApJe+nrY/jf/dq39XXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190700; c=relaxed/simple;
	bh=WyM9Ze+Bhx7ApLDVxVGXqmReVBsZfd8IwGWW1NUKLuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2Zi//e/yX4LFwo/zz5Er84JAfZHCoPDNq46CO3je0qdjreJRmAh1tkkLMh8LZP+2x5Q6ZMRfrmhmPNtPEL4CAzlH/O7mGI+nSdQJaaux+gXG0FsJxBKqS5CquIdIW8TYaFLAmmaCwybmMx3OjXZVWjHY2FEH8ZzU2qe8iF0ZSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3vdn73R; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3vdn73R"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-530e8c6fb80so40081cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 12:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790190697; cv=none;
        d=google.com; s=arc-20260327;
        b=VYX40+pHCPiLd2rGSjcF7+cAoCb0YC5IqnBW2ryOjZIaQEtuYZm+CeunwPjC4fBFmw
         cUSA9oeGIFRgG+p0RzlcLSzO2Is1BhFzG7gY7/4lBVJkMW5Bf3HmaqCPV/xJLrcKp14Y
         NazGpZumcvh44eMbK+K2FNrq1CVqK5Gse6eyqbDLeTB77pOAxBjJYaFYCcLujzq2H53/
         nptog+vDv2xm9LUWImSRTGrfvp84E8wpXxdlmKqJIhBqUmhpccrW6dGBEr6z3K6RaUUb
         wZCcbrpA6YSRKN7SVdlPAoSZnkH7ADJXIclPMS8FGp8X+5SnoAzZJk+42Ep9blQnczgj
         NgQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NQxLZICGnHK2h/s6KW/Zky2T9XW9w9CFC0y7KybVt0=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=H7fpnT9wXmBFM3Cr+Sg9ATkTNwdXdaQnDlvC9l+C+tKSrkhYDa6diSRICHTr6fRPJT
         fCypDi6+yljTx5fKeFRpSYehiq6MADrf1uZClQaLeA9yU5GZY+DpamfEWMzdID46oTK4
         7vIF06+/kyLj8U5qlmgjZ9hKJ21uAU1nGQg9tq2/mQeBFshfU5NpRK0chRExPa5SM8Sd
         y2aDWugmoImDjvsnED7a9DBVWLQaiqyBlXVFyjPFXZykdK+Nh9tT+m4wf2bHJNSFsIa7
         GhdsHDrjflGiNg9MmmCI5gzw/6bm//BKzpUk9LV0z5gtfDGtGQ1t5rLewN4/y/9Tdqfy
         Va0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790190697; x=1790795497; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NQxLZICGnHK2h/s6KW/Zky2T9XW9w9CFC0y7KybVt0=;
        b=I3vdn73RYDmRHJOxe8k0K29MxogtHP+IBA+g3KK4LE1Ak5aN8EqtGma1tMknaqZXuU
         mSlnzfLw/1tATHaEbmlSvLn3vQ/bvbCuiMpDWdh57hXVwSgUSEkku/LR5uLYVEPfR86R
         57/w9GujJODvR9ps3tectNnGu/yC/zcZcv06ApoSMlpdT/qfvGuG80RAlEOXwNYfn9V5
         rk4YV3kmwMCo5u3MJVzjUMcZn46ZEYqF4CNBWCrwTiFhM0eiUv2nJ/HDoU8EbJ6iDEgS
         +B/R7rrr5CPL9LT6qYPrXqNzke+I2AHPxzXwRHMcQ+mj+NbqhjtPgkhl1KKvBLcqhM+A
         g6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190697; x=1790795497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NQxLZICGnHK2h/s6KW/Zky2T9XW9w9CFC0y7KybVt0=;
        b=1YS2bkKQQZiOrCDwg0UOeAJBxP88dR/aNI+pxy/UZCC1Bbu0Hf3cs045m3lkX+TBi9
         mQOvSWZsOPbVbCeNR+YQtxxiIWKJ1pdXxd/jyxc07WKSu0NeHZK3yFdtDl46puwJ2k1n
         Tly42fqS95baBnz7g2xUtSj9gYFkOqLuLvdxTlD0PdR1HtwvR0wYrd9a1v0ZkcnP3ndA
         XOhyzryoyhgVoXJIuniiXAhE7+V2TmRtnYBcgUPeorzLBIcTjcsLMbC8uuR7TJhUSnPD
         GisFefEE9IaoohEBl4VCqONiJgjYuK1HXwxZUNt4Ya7AGGwl7HZB2o4U54wM3BuH0XLq
         LbeA==
X-Gm-Message-State: AFuF++lGIDveyw/8Y3EwM6YOjHU3HICdobUR1EYWrvwPtxrkNJnttCsL
	6XiQF8KIw7dD0xzwbCJ0Agx9Kko7+0eP5Ob96ST6yP0QimupOj78RQZtuFpq5HZ6fwut6+x/4pW
	1IIc+ZJ/rwWJCl/ojCdwa/MAutQKWF9QpE9gEOqQzMNdBMon6AZVapDrfgKs=
X-Gm-Gg: AYBFou2qsNpIe+Kwhha9gpHtrrSfeH5gvNuQpyoebOu7W1rKlx93EczfPC+76S+Qx0g
	lWwT6AVq/cIN1JM/Rq7MxTluoX24qWxi15EvgUg37Z7Rr0EiCZiUH/5oYbn9PA1a4wORRR9GI+Q
	LWlcZVMfi5e+JA8iET5K9EYjCDGEdXd+iY7lVs3b6jsK2UnnN/K2p3UJ/HKFsnYAgnH2QFyEU5N
	qJ+C9nzsXv7axMTxoJzqaJkoDrUvvW/cQLq0uLleirbY0lnRzKftbv9Pgp/Uc0BggBIPCBSPh9W
	Tj5uRMvL0b+GXkR5XP5rDwkhId+/sxccFI566ba33mEIIY1A3yIZtkAUgYEDVjsM+Fu2Zm/FtS4
	IN/J2vQ8W2ZJsYFG3Y1ax
X-Received: by 2002:a05:622a:4d0a:b0:530:e335:4ef with SMTP id
 d75a77b69052e-532f8cb1cb6mr4180531cf.2.1790190696663; Wed, 23 Sep 2026
 12:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-49-irogers@google.com> <20260923184942.B756E1F000FF@smtp.kernel.org>
In-Reply-To: <20260923184942.B756E1F000FF@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 12:11:24 -0700
X-Gm-Features: AclHuK9RhfE2VRdiaxPx6w1lQZEg5scq8EUYUuFYW_ImBNRcBFC_bSKcTzZfwJA
Message-ID: <CAP-5=fVakad4+OJSMa2G0ArVXShJ9oi2jKsoNNsL6UvG5NfTxQ@mail.gmail.com>
Subject: Re: [PATCH v3 48/49] perf script: Support standalone scripts and
 remove embedded scripting
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:49=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] perf script: TOCTOU race condition in signal handler allows se=
nding signals to recycled PIDs
> --
>
> commit 1ed2e4983f9ede9efdfc6d59669cdd2e466dc05b
> Author: Ian Rogers <irogers@google.com>
> Subject: perf script: Support standalone scripts and remove embedded scri=
pting
>
> This commit refactors perf script to launch standalone scripts directly v=
ia
> fork and execvp, while removing the legacy embedded Perl and Python scrip=
ting
> engines. It updates script discovery to prioritize the system python dire=
ctory
> and updates shell tests to use the new invocation style.
>
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
>
> [ ... ]
>
> > +static volatile sig_atomic_t script_child_pid;
> > +
> > +static void forward_script_sig(int sig, siginfo_t *info, void *ucontex=
t __maybe_unused)
> > +{
> > +     /*
> > +      * Terminal-generated signals (Ctrl-C / Ctrl-\) have si_code > 0
> > +      * (SI_KERNEL) and are already delivered by the TTY driver to the
> > +      * entire foreground process group, including the child script.
> > +      * Signals sent directly to the perf process via kill(2) / sigque=
ue(3)
> > +      * have si_code <=3D 0 (SI_USER, SI_QUEUE, etc.) and must be forw=
arded
> > +      * to the child script so it can catch KeyboardInterrupt / SIGTER=
M
> > +      * and flush its output before exiting.
> > +      */
> > +     if (script_child_pid > 0 && (sig =3D=3D SIGTERM || !info || info-=
>si_code <=3D 0))
> > +             kill(script_child_pid, sig);
>
> [Severity: Medium]
> Does this signal handler risk targeting a reused PID?
>
> The script_child_pid variable is not updated atomically with the waitpid(=
)
> call reaping the process, which creates a race window.
>
> If the parent is preempted right after waitpid() returns but before
> script_child_pid is cleared, the system could recycle the PID. This handl=
er
> might then trigger a kill() on an unrelated, newly created process.

In practice this window is small (O(a single instruction)) right
before perf script exits, and it would require both PID
wrap-around/reuse and an external kill() directed at perf's PID during
that boundary.

However, we can eliminate the window completely by waiting with
waitid(P_PID, pid, &info, WEXITED | WNOWAIT) so the child PID remains
unreaped while we clear script_child_pid =3D 0 and restore sigaction,
and then calling waitpid(pid, &status, 0) to reap the zombie. I'm
happy to include that if there is a v4 or as a follow-up cleanup.

Thanks,
Ian

> > +}
>
> [ ... ]
>
> > +             } else { /* parent */
> > +                     int status =3D 0;
> > +
> > +                     script_child_pid =3D pid;
> > +                     sigprocmask(SIG_SETMASK, &old_mask, NULL);
> > +                     while (waitpid(pid, &status, 0) !=3D pid) {
> > +                             if (errno =3D=3D EINTR)
> > +                                     continue;
> > +                             pr_err("failed to wait for script '%s': %=
s\n",
> > +                                    script_name, strerror(errno));
> > +                             err =3D -errno;
> > +                             script_child_pid =3D 0;
> > +                             sigaction(SIGINT, &old_int, NULL);
> > +                             sigaction(SIGQUIT, &old_quit, NULL);
> > +                             sigaction(SIGTERM, &old_term, NULL);
> > +                             goto out;
> > +                     }
> > +                     script_child_pid =3D 0;
>
> [Severity: Medium]
> Is there a way to safely synchronize the clearing of script_child_pid wit=
h the
> reaping of the child process?
>
> The child process is fully reaped as soon as waitpid() successfully retur=
ns
> here in cmd_script().
>
> If the thread is suspended or preempted exactly at this point, script_chi=
ld_pid
> remains set to the old PID while the system is free to reassign that PID.
>
> If a signal like SIGTERM arrives during this window, forward_script_sig()=
 will
> read the stale script_child_pid and send it to the new process holding th=
at PID.
>
> > +                     sigaction(SIGINT, &old_int, NULL);
> > +                     sigaction(SIGQUIT, &old_quit, NULL);
> > +                     sigaction(SIGTERM, &old_term, NULL);
> > +                     if (WIFEXITED(status))
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.30=
32038-1-irogers@google.com?part=3D48
