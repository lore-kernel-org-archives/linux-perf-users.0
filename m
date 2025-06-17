Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E42285073
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178779; cv=none; b=oXWhSByx3120PV+qGepMUrVaIq3GtAdbodb8eb/gtym0GpYpyz2fVKAAGUYYa3/27CKhC9CNhLasEVvRsLVGgaxzhK3anxfMlhQc2aXXqDRHVUMcjS7Vk7HB65V8IU8RPGcMEOgSfN6e/HQvKAjbYFZUqpTW5/hIwOTRfXHKTRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178779; c=relaxed/simple;
	bh=hsslY0ddCeorP8XOH2q+7icw4VNv5z3sM6Zff31wPoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7uRESdgZEKKJ1zTLiw7wskJ/EYxOaAexhiXF0wHY0N0h56w1EkSvmzI8wqHDvWr19G/oCSudrWvifnW9BTnNjNvRsR6g6M1Rsp+rNM9xIwmswthZSQCGSimPHB2H2nMmBKd9Wcx1QMm7q5HBMQQ8U4fVv+5R8f7OPZTR/hvmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w41w8RjD; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w41w8RjD"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so2855ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750178777; x=1750783577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDNSt2befDvbYugQYjsStVnv0wd1OzH06bvPk1PSZmU=;
        b=w41w8RjDqkUZaAlz2k8IDXFs0BQCbgTqktKIr+JqJh5ZY8Hc1poQi6mPUED9bOvR5T
         JouUp8TDOOr7iw27NxJXRj3jPC1BmTmhcSnfEpVAcsRb3+GyXAeP+JcgYstqQ7RsXpVR
         6LSDfjvs+w6eSN1HlcjBrKvi0ESmqJCoJmGtsnvJjDAzlkwXQP6UbGb8KhB7za4f0A4x
         s0l+ecvS/KK2YpTs0Cks59NH+WE5+C1zXjUaxTPe1KuPu3XHYI2VlMKO3mp/AAy89W/2
         uiSHGsL27lu0OVPNHmXgRI46zuSR0oHBixOFFBZQakpd8fbKd6H04vCu3T6zxvZ26InL
         YOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178777; x=1750783577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDNSt2befDvbYugQYjsStVnv0wd1OzH06bvPk1PSZmU=;
        b=qk/PmJBbt6ctxzxnsFnGMeRhCnMm6s5F38cyhCx22UeCTJGAHUeEq/Qj9GuOjRQpxU
         e7KKXO1BhDWxWfzVL9+OqFCWyNfMnGVsbSmT+pNx+kQxcyT1m5nHE0b6PwR2+OX+68Gv
         gERh3hdYf49MPgBLIdW+SUntrIve8+aJ5cT69bYgWlzg51wMaeAEMqO6pcpFCqj+w3j1
         KiH8mXjQzRYkJ7Iw8lMi67u6NB2qh6kMTfIGy9MwRq8z6JU679/38cG03Vglx0OTHeSs
         E5ljSWcwHYql3Qxj4Dao8Fk44Xq0mxgloSmAIP53gCIwFA9MDG7eFSXUmlpz4UpQva0W
         K65g==
X-Forwarded-Encrypted: i=1; AJvYcCWvbGAleR7Bk3Dq+fbjaNrvW4XBruusCsipv96zFulf+4zZguQ5Ii/wzh4nbrQQuOQ/EypvNq5bt19n0sdhGyG/@vger.kernel.org
X-Gm-Message-State: AOJu0YxzZsdSrIbQS2uuSqGkMPwaVvuBkyJuiFWFqGAOzBGhHeE6n4+/
	QxpeY8P5P1Zm0rU1R1v0TkUE4q9/x85pFFO0NbkqdRQZvxKNyw+ZYaac5HYICAtb+xFm+ofMymI
	0gOA8iLdldmBp0+u36+h4ZrPOp38apMy7nZrqoWG7
X-Gm-Gg: ASbGncv5XJl0kPWTmND8YY9MAyBiVa+WEYlygwnQe2fqWXTpzQ0Ubb6i49PZ3MD27PT
	yjfeD6u+IeND5N3DrD/bkwUhIF74l7JClJaAH4Nnw8xtTTCq4b3bmDU+DEO5tgIUgCFLJERwaHI
	2UFVGc9u4zNv62UpQIxGHdkeutwjrHDyjiL5SIHS5NJtupFEjrntZSnoVjxoYMl4/eaBWOJQsC
X-Google-Smtp-Source: AGHT+IETyK/JU/9XHOBhnbjJte/+mbJo3qOX/UjV2k5RAB+4RTUdJJISK2iht8zdBjFFSZCJG0u6/vSDR6SzJZgE3LM=
X-Received: by 2002:a05:6e02:1aa5:b0:3da:7c33:5099 with SMTP id
 e9e14a558f8ab-3de09fa7317mr9034985ab.13.1750178777072; Tue, 17 Jun 2025
 09:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617150847.4029177-2-ashelat@redhat.com>
In-Reply-To: <20250617150847.4029177-2-ashelat@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 09:46:04 -0700
X-Gm-Features: AX0GCFsaRgUgTfGo3xUwE7T0uM19kqCpEJgSn7YytdFafHdFDCvBCqB91c_whOM
Message-ID: <CAP-5=fUh6-gbbcX4znPHdocwjaGqHJRUqKcK-S93jMbNpZ8hSA@mail.gmail.com>
Subject: Re: [PATCH] perf header: exempt x86_64 from core id test
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 8:11=E2=80=AFAM Anubhav Shelat <ashelat@redhat.com>=
 wrote:
>
> On a VM running on an x86_64 architecture, it is possible for the socket
> id to be greater than the processor number. So exclude x86_64 arch from
> the core id test.
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  tools/perf/util/header.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index e3cdc3b7b4ab..c1b4651d0c6a 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2618,9 +2618,12 @@ static int process_cpu_topology(struct feat_fd *ff=
, void *data __maybe_unused)
>          * The socket_id number might be higher than the numbers of cpus.
>          * This depends on the configuration.
>          * AArch64 is the same.
> +        * It is also possible for a VM running x86_64 to have a larger
> +        * socket_id number than the number of cpus.
>          */
>         if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
> -                         || !strncmp(ph->env.arch, "aarch64", 7)))
> +                         || !strncmp(ph->env.arch, "aarch64", 7)
> +                         || !strncmp(ph->env.arch, "x86_64", 6)))
>                 do_core_id_test =3D false;

Why do we have a boolean called do_core_id_test that is checking a
value assigned to the socket_id? :-)
I think at this point the test:
```
                if (do_core_id_test && nr !=3D (u32)-1 && nr > (u32)cpu_nr)=
 {
                       pr_debug("socket_id number is too big."
                                "You may need to upgrade the perf tool.\n")=
;
                       goto free_cpu;
               }
```
has no purpose and we can just delete it.

Thanks,
Ian

>
>         for (i =3D 0; i < (u32)cpu_nr; i++) {
> --
> 2.49.0
>
