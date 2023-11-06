Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06F9461
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Nov 2023 04:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iix45Tj8"
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879149B
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Nov 2023 20:32:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2469828a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Nov 2023 20:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699245168; x=1699849968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xh4SnsgjogFb0EHENd8kBh5bdVO85QGU1hVaaPbn9j4=;
        b=iix45Tj8JWS2vSAkWTvb7U5AMOVbhEBo0y5fMOOXu7hBb2seEYFPFzqBt77hgg+YNX
         pOP358JESQskaKxc3ABTnI55+gKbtobuKpH24thNrJx+BSAXbsztURekBbFqPSJRux7o
         KzsVM+2eolbKcigAI4B44hJij/OxIW+Npry729dWR4nVP1AQMB9q6JTSWDZ20s9+HU2J
         hNNnrn1YZxBYXNopiC9PCPE248b3wcnJxBpxBIwfUQzb3z6COiLxK2jd95HYei5OxUWE
         RIi3ZAXiA0IrzvOiO4jFJofj3q5VjxV8njszFPiHAdQLb121VTswHlLoIy+I+jjZXes4
         uOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699245168; x=1699849968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xh4SnsgjogFb0EHENd8kBh5bdVO85QGU1hVaaPbn9j4=;
        b=hg0Jsk1loGek7H2SsUmoojFDA6Q0VDqhuKqwUefcRKPIK5qDiJdp4TRgPHBy0yQL1j
         v5Oq1jSyMymo+Vu5nmaDQWTrKcRUnwTCKOeKmiXNh7BUoFFI0KrbOE7YwU/CzV9tDylS
         iZ0mk6H6thPRcdMpa2LN6E1I8S+WY+HcuUYhenqdqnigyOajS6pPAEqFY3ztLzaeduHo
         LlihX5hkCKu8W6UcjwXLEt3YT8uQARpklSN/2BQJC6f/274fo7Bxj3dm6BL5jCwbgNoE
         8cj7qoNQ1Y6NCXD1CB/nu5eTqrOfU92M0DF5cNvetDOZlPDfYCK87YAqh50oZFwzANko
         WEOg==
X-Gm-Message-State: AOJu0YzKk+Bnj3wUm5I3qwHngqkeshpj7erbmMRxXMGuaVSUwqQXIor/
	BSEWXbVhxZZygOhb3A1C+aip2iF05Q05wt+oMvA1R6yy
X-Google-Smtp-Source: AGHT+IHEdeEfAGpcocOIsilvwyIdnzF1giSb2/VuJzHo3ZpRV0mxZA/kvYOWkB1e8eVdQvkWBdrKuZx4+f7YpeS9FnY=
X-Received: by 2002:a05:6a20:9599:b0:131:b3fa:eaaa with SMTP id
 iu25-20020a056a20959900b00131b3faeaaamr27228353pzb.61.1699245167931; Sun, 05
 Nov 2023 20:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3ea2cefb-7417-4cac-98fd-46325c5108e0@isc.org>
In-Reply-To: <3ea2cefb-7417-4cac-98fd-46325c5108e0@isc.org>
From: Namhyung Kim <namhyung@gmail.com>
Date: Sun, 5 Nov 2023 20:32:36 -0800
Message-ID: <CAM9d7cj8E7NMnpZ3r-eeYVonQ0UJXAgp6Hpw2fTCbtF7NU=xHQ@mail.gmail.com>
Subject: Re: [bug] nsinfo__mountns_enter failure can cause perf to operate on
 wrong file
To: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for the late reply.

On Fri, Oct 27, 2023 at 8:58=E2=80=AFAM Petr =C5=A0pa=C4=8Dek <pspacek@isc.=
org> wrote:
>
> Hello,
>
> I've noticed that sometimes "perf record" confuses paths between two
> different namespaces and inadvertently operates on a wrong file (on the
> same path - but wrong mount namespace).
>
> Version: 6.5, commit 750b95887e567848ac2c851dae47922cac6db946 from
> Linus's tree
>
> Reproducer using Podman container:
> All commands executed as non-privileged user, except the sysctl tweak.
>
> $ sudo sysctl -w 'kernel.perf_event_paranoid =3D -1'
>
> # binary in the container needs to have the same path as on host
> # but different content
> $ podman run -ti docker.io/library/ubuntu:23.10 /usr/bin/yes > /dev/null
>
> # leave this running and get PID of the process inside the container
> $ docker inspect $(docker ps --latest -q) | jq '.[0].State.Pid'
>
> # ! record as an unprivileged user !
> # record and use debuginfod from official Ubuntu servers
> $ perf record --debuginfod=3D'https://debuginfod.ubuntu.com/' --all-user
> -F 99 --pid 637217
>
> # check if we got symbols ... we should have because debuginfod has been
> configured
> $ perf script  # notice "unknown" all over the place
>
> # check build-ids in the recording
> $ perf buildid-list
> f53cbc885777b8cfc9e54a8015318a71e6845bc3 /usr/bin/yes
>
> # check build-id in the container
> $ docker exec -ti $(docker ps --latest -q) bash -c 'apt update; apt
> install -yyy file; file `which yes`'
> ... BuildID[sha1]=3D7c895824831420bd30a372431d2b241bb6ff5554 ...
>
>
> Values in perf output and in the containerized binary do not match. Huh?
> Where the "perf" value came from, anyway?
>
> Turns out the buildid-list shows value from the _host_:
> $ file /usr/bin/yes
> ... BuildID[sha1]=3Df53cbc885777b8cfc9e54a8015318a71e6845bc3 ...
>
>
> My guess is that this can happen when the user executing "perf record"
> does not have privileges to nsenter() the target namespace, but this
> failure is not checked.
>
> I could not follow "perf record" code, but "perf buildid-cache --add"
> calls nsinfo__mountns_enter() which has void return type, and hilarity
> ensues if that call fails.

Right, but I guess there's not much it can do in that case.
Maybe it can warn the user it could result in unknown symbols.

Thanks,
Namhyung


>
> It works as expected if I add "sudo" in front of each "perf" command.
>
> I'm happy to assist with debugging and testing.
