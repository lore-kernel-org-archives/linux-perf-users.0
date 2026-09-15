Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB83468C13
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508578; cv=pass; b=V+UiqXj8015Dq3EbkugQoQGq2yMxurh6m/zq/j7vcqS2ctymlq5ha4246ZeoUo659m3XGYG9ATM2jNpyNdLdWdCrzhizNHTvz52dcaFsBJIG5PaCcAs5hd63/PakYMk+hm+UpBi+hLfAbSpDpB1u8dpPZxY7n2pkNLbfY4ntLI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508578; c=relaxed/simple;
	bh=7FPuBKqfc5+V+XudiWfGUwcGgOF3XEWZ0MgBewJ876s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsFToTKc6XURWIQIgYLk+3W4of6I/pG5N4vYqJ8RGhHmkLaWIvTo2deInCeXj73Bk/QWnFgyAFo9cFJndJMmxSACY8GrvIlfj7llSOubnO8G/iTtvEF0h5xi1DyIM50jhuB7YLm+gP9aMCgBGmcNO4ZVnQM+hFXwbscdQKa2Aow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nvjLsVGg; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nvjLsVGg"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso32631cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 14:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508576; cv=none;
        d=google.com; s=arc-20260327;
        b=ZbTpgsULuN8vWJjQsP5ysw64TFG5Y+gNZBEHiheLlpgBZruovTVhQdDKCYF0bkpReK
         DZD4t9sIYBFKE/P4F+u86d6goTUubBzlJcrZNWwKjsX7M2DEdBSKu+tqmxZj7yOEGtqg
         7z4JG3BjkOUZIcLRyan7f5gLvJ6pbhFWZykAg2qpNxj+vFIsYzOXjbnHUXYymIsiX5S0
         53PauwEKe8Ffr9CFga1vFTZRG+xsq/A8+Zimr8B96e1SmQ/XxI+umNsiOl1ggjMgqcwa
         n1FaE4AxqVGyWnsJZCQAYhmIak14w5QiWIui/jrzPPbfhDgu3LCl8j9w/zGdQ+vESKog
         On5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aD5DtmrQU1XAAN2n47o7245dkYOoODedHBlENsGW6Jo=;
        fh=QSUTEVSYuc6aitWMuRX2ZmRRY+r5hIqrHomew1Ln+Ac=;
        b=GkS0hC0F5LJcyA0zIt5/2RXZGcCx7m4Rrhbg+NKZaMwe57rO8pS9+hSAZPem9UtRwm
         bjm/R1La4/AOHkguFrP03YaS1Z82m8+Os8VOxTIZH07zI5B2lLlnxq3hNPS44VNYLLYu
         9v66aUJ15u/chJn9FQ5ALoQfgbWfaUjuE20OXpNeHEMNwOvbHHuIBwsro6zMGLyuvEoZ
         JOPWnf7MHh68RrHFP1uRSxM8NeQtqMjsiucOvK7JNjRKpCRWPw0lFmOT3YaZxnN/SjU+
         X6qND3IvPeOrTI0DZ6he+pHAaGuREK7ls5fbGc0fPbEaLJCUrcc966qzx7bCL+59ehLs
         s4ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789508576; x=1790113376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aD5DtmrQU1XAAN2n47o7245dkYOoODedHBlENsGW6Jo=;
        b=nvjLsVGgRj0yMKuH2ZW853ibeWabA+JxD/OqUDRpdbXU8+rvn6D4qQPVdjhzkouMbY
         wsEIS306ZkSuh6KXf0XQHKsKByyJJfwQJvd8tshcsB9C+3E6+2y07HQvDfwAeu8liueV
         pm251xUmcAfqM9DldAzZXxASE3N7GSOex7/cE4kXfqSr99Rm7ozyqzsqKFZsLPBNCziZ
         x49WGmFvduSUAF0fHjYOZI6/RaxcbTJqfhcqtmH+Pjia03Xsr2Yo3IdpnywuyepAVlV8
         myfW/wFz8QX+I61Q0D2fvcJcxCT3b5DO05GZWvAAbpFlIKesKvO+GBaRkJG+BDKKc51T
         RBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508576; x=1790113376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aD5DtmrQU1XAAN2n47o7245dkYOoODedHBlENsGW6Jo=;
        b=uR3LwxbFIPuwV4QgAsg2UJaDVujq+e0PoqGUaFWUSxrwwRSZE3DzqX4A4r/8f/i3Bb
         YqefkfHSn6KWbo1CaRkcKEW9mGLcTvNS2f4wsmug1Rj6htL4fQPyxku5TzGjvkeMFeOq
         F/ZfyKDhKMR7rqqtzem7x5RWL9WfcZ6MCPL89bQSy/N4n8yE28g+PyHHo629imkvt7qe
         qFJxKJ2eYInyoOM//INsuj784nQ2vdw1hEEerZc8q0g8YAdFPolEgV6YPuBEJCECymSw
         n3aLEaqovTG7kvxC0SQt7PdseSiwIo7qIrracPHKuH2qhLvoYpNmQ5TdeoF/bk/ndRlU
         xRlQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6UhfDSbheRRtj8/aeK4z7MkN9PQ9QUM5+MUfBQT2/k2G0p469g3skPqZhBGpLE45NHlLEstrqMtNH/U/Tt5SY@vger.kernel.org
X-Gm-Message-State: AFuF++ndZbFsEVrZ8pgqAKUAZy64cAvOVvE0xxOlhgxjmoJ6qcVS1Y6w
	YuJgMspZEPi0uvB3QqH89EPM7S0xk9ntnlK5/RvFe0pPlIVuNCp5T4WIjLNQjzBpxgLh5Fvm6Kx
	JZqBrDriB1yI+Z21MBOTM4bvo226QdTV+4nZ0FKs2
X-Gm-Gg: AYBFou14IDnVq9qDI67RxQ4yH2tAz6s/R6zwDZJqQGXPB/y0C01ciFcIQTWKp+/ryqy
	ODeOAGAXCXnrTTHFdcOFov9qbuRfIExCsTU7Y9FBhBjeNouyPZLnj3x2ih7xzgk+/Tw43UdbmGG
	NG0v6bDC0efLdjDokEjsMfke29epVPAFwih6OOb6/D5RtYX6Jqm5MJ31G8sOXsQeuBxFDC7zco7
	bpuPBW5r58nfh49V0H42C/xSquYW+Kj9ARc13sbEJJ+uoSoTEeTd6XPe7uBbc4jcPN0+Khavj5J
	YR4tf3hhQp9lsSY7ysDaNvG/UeSKKn/of0oGqs4LH9oLGZKs1ibqFS3HjoJeV0Xxs4dbRDMr7W3
	unc5ajlVhf1/AuVVnI/XU0w==
X-Received: by 2002:a05:622a:4d8c:b0:531:34b9:2532 with SMTP id
 d75a77b69052e-5327ed8004emr1067291cf.4.1789508575206; Tue, 15 Sep 2026
 14:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224062531.96304-1-yunbolyu@smu.edu.sg>
In-Reply-To: <20260224062531.96304-1-yunbolyu@smu.edu.sg>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 14:42:43 -0700
X-Gm-Features: AcwNN1UXqi6h2JzlCIpIEM2PA8kElM-vlezQ38Lvvbn2yCoDh4fdAvu3ovmKIo8
Message-ID: <CAP-5=fWHGZteCwCga6x09hzAECmc8wMWxHbD27pq+vefVCeNgA@mail.gmail.com>
Subject: Re: [PATCH] alpha/perf: Clean up stale comments referencing old
 hw_perf_* APIs
To: Yunbo Lyu <yunbolv@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, richard.henderson@linaro.org, mattst88@gmail.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	julia.lawall@inria.fr, ratnadiraw@smu.edu.sg, xutong.ma@inria.fr, 
	kexinsun@smail.nju.edu.cn, Yunbo Lyu <yunbolyu@smu.edu.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 10:25=E2=80=AFPM Yunbo Lyu <yunbolv@gmail.com> wrot=
e:
>
> Two outdated comments in arch/alpha/kernel/perf_event.c referred to
> functions from the deprecated hw_perf_* APIs that were removed more
> than a decade ago:
>
> 1. hw_perf_disable():
>    This was superseded by per-PMU disable APIs such as
>    alpha_pmu_disable(), after commit 33696fc0d141 ("perf: Per PMU
>    disable"). The comment has been updated to reflect the correct
>    function name.
>
> 2. hw_perf_group_sched_in():
>    This function was removed in commit a13c3afd9b62 ("perf, sparc:
>    Implement group scheduling transactional APIs"). The corresponding
>    comment mentioning it has been removed. The if (n_ev =3D=3D 0) check i=
n
>    alpha_check_constraints() has also been removed, as this condition is
>    never true. The alpha_check_constraints() function is only called
>    from two places:
>
>    - alpha_pmu_add(), which calls alpha_check_constraints() with
>      n0 + 1, where n0 is the number of existing events (>=3D 0).
>    - __hw_perf_event_init(), which calls it with n + 1, where n is the
>      number of events in the group (>=3D 0).
>
>    In both cases, the n_ev argument is guaranteed to be at least 1.
>    Therefore, the check is redundant.
>
> No functional changes; comments and dead code cleanup.
>
> Fixes: 33696fc0d141 ("perf: Per PMU disable")
> Fixes: a13c3afd9b62 ("perf, sparc: Implement group scheduling transaction=
al APIs")
>
> Signed-off-by: Yunbo Lyu <yunbolyu@smu.edu.sg>

Thanks for the cleanup! A nit: the commit message mentions comments
but there is also the dead code clean up. Someone bisecting may
struggle to attribute this change if the commit message suggests it
only impacts comments. Could we either do 2 patches (comments + dead
code) or change the commit title to mention dead code?

Thanks,
Ian

> ---
>  arch/alpha/kernel/perf_event.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index a3eaab094ece..2f57626ffcfb 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -35,7 +35,7 @@ struct cpu_hw_events {
>         int                     enabled;
>         /* Number of events scheduled; also number entries valid in array=
s below. */
>         int                     n_events;
> -       /* Number events added since last hw_perf_disable(). */
> +       /* Number of events added since last alpha_pmu_disable(). */
>         int                     n_added;
>         /* Events currently scheduled. */
>         struct perf_event       *event[MAX_HWEVENTS];
> @@ -372,10 +372,6 @@ static int alpha_check_constraints(struct perf_event=
 **events,
>                                    unsigned long *evtypes, int n_ev)
>  {
>
> -       /* No HW events is possible from hw_perf_group_sched_in(). */
> -       if (n_ev =3D=3D 0)
> -               return 0;
> -
>         if (n_ev > alpha_pmu->num_pmcs)
>                 return -1;
>
> --
> 2.25.1
>
