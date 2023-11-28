Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3Q0/9Gb"
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A519B5
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:47:40 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bbf7a6029so549e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Nov 2023 11:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701200858; x=1701805658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWZzgqk1GpEhjiNVn/Cj9VpwbrgeTzX4mCQ5GC4cr1M=;
        b=Y3Q0/9GbKJAR2sKPCPs4hcUKCRre0+CPukLq2yzasGFy1D5qGVSqLkMMayAJIYx7Ds
         d+iP5rqijGcTA0FNE2hHQf66lcv/8igsso3KHaQzVbS4+EX6OvS5Shf1fhs14TQbyPHx
         B4KLmEukYbpqQ6XCnjhyFQz14AJZ54zYZfkP32uz35jvcBEK6Cycq5rLfqqxs+2u0yTy
         p11FuiW4G9u2p9x9mbzl05o7PJ22oMpYITuv+4KwxbNjgPMoqG+ynOsrGD/e1L/2ntnI
         GOC/3qEuAz2EdisPmM4rN0wiVYlQoUoWgAZsYKLhDoNH/nBJPrVEnJZUJnDA5G71faN3
         df3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701200858; x=1701805658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWZzgqk1GpEhjiNVn/Cj9VpwbrgeTzX4mCQ5GC4cr1M=;
        b=FY/D+zyniVtAZcWM7GNjjlmYTggAew5zIlEauXjM2qzeb7NqcY8CR/pLvDPhdO0/PT
         wd/57V+CsJ5KnYm9+IOG8ZykM7gFjOK+yC5GHU7BQ0Fg/P8plpJYm757RcpY0XErdSoh
         UkJllcYF9eY0uYiXK6GfA2MJzFBLy9p1/z61Xrc4ju/RAKhqcMhWVlI1cL6wMz/rdY94
         DCbNYdtnq4rp8AZ8TUBOl+mrYYc68L/1UKvFVcCECXb0v4qxDqh53NUSl7oVw56hTO09
         pKiF0reWW3/Js6ytcN9Yg4avzNNruQWgwfhIew3TnsD7xOJmxaEyq5VifWs3MhTojZH4
         LWvQ==
X-Gm-Message-State: AOJu0YxBnfHfQXswfL4PUXhSJuZNgFzT2mZIQdj4/2vrt0ZPdl7c9tX+
	3Spinnt50KRLoY+KfCfCHWi7oyc6b+iC1xs8M9Y1Vg==
X-Google-Smtp-Source: AGHT+IEWNTfoKdDHE4Wzmk0DfPiA3Enq/fuaBctGXNLS9IquYLLYngmnLPqn5DJCij/tYZc8F8k74StaRV9UeKVsLow=
X-Received: by 2002:a05:6512:130b:b0:50a:a7e5:eb93 with SMTP id
 x11-20020a056512130b00b0050aa7e5eb93mr500594lfu.2.1701200858370; Tue, 28 Nov
 2023 11:47:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126070914.175332-1-likhitha@linux.ibm.com> <3cb4af55-dd0d-4491-9a29-8440aa2c191e@linux.ibm.com>
In-Reply-To: <3cb4af55-dd0d-4491-9a29-8440aa2c191e@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 28 Nov 2023 11:47:26 -0800
Message-ID: <CAP-5=fXiuCYaGhpGvC1PsUzu8OyUGvoUmOs3hHy3OQhzR3fXSA@mail.gmail.com>
Subject: Re: [PATCH] perf test record+probe_libc_inet_pton: Fix call chain
 match on powerpc
To: Disha Goel <disgoel@linux.ibm.com>
Cc: Likhitha Korrapati <likhitha@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@arm.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 1:57=E2=80=AFAM Disha Goel <disgoel@linux.ibm.com> =
wrote:
>
> On 26/11/23 12:39 pm, Likhitha Korrapati wrote:
>
> > The perf test "probe libc's inet_pton & backtrace it with ping" fails o=
n
> > powerpc as below:
> >
> > root@xxx perf]# perf test -v "probe libc's inet_pton & backtrace it wit=
h
> > ping"
> >   85: probe libc's inet_pton & backtrace it with ping                 :
> > --- start ---
> > test child forked, pid 96028
> > ping 96056 [002] 127271.101961: probe_libc:inet_pton: (7fffa1779a60)
> > 7fffa1779a60 __GI___inet_pton+0x0
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> > 7fffa172a73c getaddrinfo+0x121c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> > FAIL: expected backtrace entry
> > "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/glibc-hwcaps/power=
10/libc.so.6\)$"
> > got "7fffa172a73c getaddrinfo+0x121c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)"
> > test child finished with -1
> > ---- end ----
> > probe libc's inet_pton & backtrace it with ping: FAILED!
> >
> > This test installs a probe on libc's inet_pton function, which will use
> > uprobes and then uses perf trace on a ping to localhost. It gets 3
> > levels deep backtrace and checks whether it is what we expected or not.
> >
> > The test started failing from RHEL 9.4 where as it works in previous
> > distro version (RHEL 9.2). Test expects gaih_inet function to be part o=
f
> > backtrace. But in the glibc version (2.34-86) which is part of distro
> > where it fails, this function is missing and hence the test is failing.
> >
> >  From nm and ping command output we can confirm that gaih_inet function
> > is not present in the expected backtrace for glibc version glibc-2.34-8=
6
> >
> > [root@xxx perf]# nm /usr/lib64/glibc-hwcaps/power10/libc.so.6 | grep ga=
ih_inet
> > 00000000001273e0 t gaih_inet_serv
> > 00000000001cd8d8 r gaih_inet_typeproto
> >
> > [root@xxx perf]# perf script -i /tmp/perf.data.6E8
> > ping  104048 [000] 128582.508976: probe_libc:inet_pton: (7fff83779a60)
> >              7fff83779a60 __GI___inet_pton+0x0
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >              7fff8372a73c getaddrinfo+0x121c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >                 11dc73534 [unknown] (/usr/bin/ping)
> >              7fff8362a8c4 __libc_start_call_main+0x84
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >
> > FAIL: expected backtrace entry
> > "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/glibc-hwcaps/power=
10/libc.so.6\)$"
> > got "7fff9d52a73c getaddrinfo+0x121c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)"
> >
> > With version glibc-2.34-60 gaih_inet function is present as part of the
> > expected backtrace. So we cannot just remove the gaih_inet function fro=
m
> > the backtrace.
> >
> > [root@xxx perf]# nm /usr/lib64/glibc-hwcaps/power10/libc.so.6 | grep ga=
ih_inet
> > 0000000000130490 t gaih_inet.constprop.0
> > 000000000012e830 t gaih_inet_serv
> > 00000000001d45e4 r gaih_inet_typeproto
> >
> > [root@xxx perf]# ./perf script -i /tmp/perf.data.b6S
> > ping   67906 [000] 22699.591699: probe_libc:inet_pton_3: (7fffbdd80820)
> >              7fffbdd80820 __GI___inet_pton+0x0
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >              7fffbdd31160 gaih_inet.constprop.0+0xcd0
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >              7fffbdd31c7c getaddrinfo+0x14c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> >                 1140d3558 [unknown] (/usr/bin/ping)
> >
> > This patch solves this issue by doing a conditional skip. If there is a
> > gaih_inet function present in the libc then it will be added to the
> > expected backtrace else the function will be skipped from being added
> > to the expected backtrace.
> >
> > Output with the patch
> >
> > [root@xxx perf]# ./perf test -v "probe libc's inet_pton & backtrace it
> > with ping"
> >   83: probe libc's inet_pton & backtrace it with ping                 :
> > --- start ---
> > test child forked, pid 102662
> > ping 102692 [000] 127935.549973: probe_libc:inet_pton: (7fff93379a60)
> > 7fff93379a60 __GI___inet_pton+0x0
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> > 7fff9332a73c getaddrinfo+0x121c
> > (/usr/lib64/glibc-hwcaps/power10/libc.so.6)
> > 11ef03534 [unknown] (/usr/bin/ping)
> > test child finished with 0
> > ---- end ----
> > probe libc's inet_pton & backtrace it with ping: Ok
> >
> > Signed-off-by: Likhitha Korrapati <likhitha@linux.ibm.com>
> > Reported-by: Disha Goel <disgoel@linux.ibm.com>
>
> Thanks for the fix patch.
> I have tested on a Power10 machine, "probe libc's inet_pton & backtrace i=
t with ping"
> perf test passes with the patch applied.
>
> Output where gaih_inet function is not present
>
>         # perf test -v "probe libc's inet_pton & backtrace it with ping"
>          85: probe libc's inet_pton & backtrace it with ping             =
    :
>         --- start ---
>         test child forked, pid 4622
>         ping 4652 [011] 58.987631: probe_libc:inet_pton: (7fff91b79a60)
>         7fff91b79a60 __GI___inet_pton+0x0 (/usr/lib64/glibc-hwcaps/power1=
0/libc.so.6)
>         7fff91b2a73c getaddrinfo+0x121c (/usr/lib64/glibc-hwcaps/power10/=
libc.so.6)
>         119e53534 [unknown] (/usr/bin/ping)
>         test child finished with 0
>         ---- end ----
>         probe libc's inet_pton & backtrace it with ping: Ok
>
> Output where gaih_inet function is present
>
>         # ./perf test -v "probe libc's inet_pton & backtrace it with ping=
"
>          83: probe libc's inet_pton & backtrace it with ping             =
    :
>         --- start ---
>         test child forked, pid 84831
>         ping 84861 [000] 79056.019971: probe_libc:inet_pton: (7fff957631e=
8)
>         7fff957631e8 __GI___inet_pton+0x8 (/usr/lib64/glibc-hwcaps/power9=
/libc-2.28.so)
>         7fff95718760 gaih_inet.constprop.6+0xa90 (/usr/lib64/glibc-hwcaps=
/power9/libc-2.28.so)
>         7fff95719974 getaddrinfo+0x164 (/usr/lib64/glibc-hwcaps/power9/li=
bc-2.28.so)
>         122e732a4 [unknown] (/usr/bin/ping)
>         test child finished with 0
>         ---- end ----
>         probe libc's inet_pton & backtrace it with ping: Ok
>
> Tested-by: Disha Goel <disgoel@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>
> > ---
> >   tools/perf/tests/shell/record+probe_libc_inet_pton.sh | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/to=
ols/perf/tests/shell/record+probe_libc_inet_pton.sh
> > index eebeea6bdc76..72c65570db37 100755
> > --- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > +++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
> > @@ -45,7 +45,10 @@ trace_libc_inet_pton_backtrace() {
> >               ;;
> >       ppc64|ppc64le)
> >               eventattr=3D'max-stack=3D4'
> > -             echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" =
>> $expected
> > +             # Add gaih_inet to expected backtrace only if it is part =
of libc.
> > +             if nm $libc | grep -F -q gaih_inet.; then
> > +                     echo "gaih_inet.*\+0x[[:xdigit:]]+[[:space:]]\($l=
ibc\)$" >> $expected
> > +             fi
> >               echo "getaddrinfo\+0x[[:xdigit:]]+[[:space:]]\($libc\)$" =
>> $expected
> >               echo ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bi=
n/ping.*\)$" >> $expected
> >               ;;
