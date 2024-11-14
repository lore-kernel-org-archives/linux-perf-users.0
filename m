Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747F1AA7B4;
	Thu, 14 Nov 2024 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615421; cv=none; b=rQuidoM2RbAWztmVTNwqCshbG8mrJ4Kyfe7ulPAjkbjRTLvPks8jwMsVEGmgCRPbfLBeeCqBCaYp1HI3S0ktPQGw8doYrJexC/cqAhNotb+Uvop71xBs3lZYj+CIp9s2/PGbM5MRzcTulHyMQb11TV0KxX/xJM+2eoDIJ3gksNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615421; c=relaxed/simple;
	bh=m/RBqIj+4nCPjcKplLus7PXg59Oic1Jtd9R9rlN3rRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEqunwYaxUlA7k6SVot46wlyTu0QV3Rdp8QtrpK2rnPULpKkfRxBEpIAA8dMfb89KTbzk60pj4lZEtqE+w2DHvxlcjlbGuakK3ydRfkWxKBSdXNwngQPuHKTzUrQxOh1QUsfeKMsHYCJaN21cv5DDiLFC7pCk99F5r8/6E5eoTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6etKnJ8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6etKnJ8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ee4beee4d1so7713497b3.2;
        Thu, 14 Nov 2024 12:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615419; x=1732220219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSIgain3dy+QHcg+dbjr1CfDn9sK0gKN6LW/FDcze7o=;
        b=U6etKnJ8YW3CpY0Wn/oWqyRjmJ2r5eO32NiLaI7u3NOaNTGBZW8Vw9UttLZtkSvqCW
         mpfDp/CM2/uJ/VIgHf1ks2A313wUWuslfjgYBAnWVcaDKcZ3W0EZuczsADAvC7qGsbyT
         kr1HjJ54533S5dkWbkf3hdMt8Do8Ui1OlOnhuAhQT+ztV9dPcRhVwdlDxm2CR8W3+Pw1
         ZkDXQjK6Nog04B+R9kr5G44sfqho9Z+757EU9cJ+wrEMtWydZNEwzS9HT7Wcap94yevV
         xFilf3yU0AqxPKbNRECYHNx5gusnWb2J4+P3npR8wrwZ9hX15J21PBQK0HzgV7+72Svt
         QKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615419; x=1732220219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSIgain3dy+QHcg+dbjr1CfDn9sK0gKN6LW/FDcze7o=;
        b=wGA/D7k1AoT9qLpzPrrJfxpBbfH0R6WJgCcIn9T89DTYUQDktQyuaWH+bSxl5WpEKY
         QmDYigoLREx/J6JAcUge29occNSTFDzChrlHmEc1DhJoQMJ/D/MR0b5SshJselpOqGEy
         tLoT4x3C6//epQ68z/kKhqc73+eZIYQgotBBlu/AKAxR4krIx8cfdgYnc3+5xK1yWaSb
         GXZS3SxqXw3M0ZxAxoFczErI2lU7YyFhBR5OJP6Uqhp+usdyNEd0RP0xmT2vu27uN8ce
         MB+eb+z4jmRH6uIsEqwWrQb+M4O/th6IbcKCT6peGOvNXsioPM2gal4AuLsZqlNqX2LS
         11Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUZwiWjRwVIKailXIyIMwA7kfr9qs1ErsoHraOggQGcDM2V5Rbkw4SANFYKXqQReY9PsNkBE1Holybuxls=@vger.kernel.org, AJvYcCWtiHH/akxNLsi82S88TqNFKwDyqzX5PqZU9x0rD6DCFXoUnruitjqZG1oe7Y6Lqoj/m6gwXuy8QYcqVCc/szJScA==@vger.kernel.org
X-Gm-Message-State: AOJu0YykvrONxiDLxZfoao9el5uMoeVs31UkoK8opv37XJO0nRZoowjn
	mvnFC7Je54oc9KsdRg8/IsLld3IAlg3cuISs7yuSL9odavOpftZp2E573IZRIeSXwliRfsTDqzE
	Km3pEmR7OOZKA2A5SkbeIcnI964k=
X-Google-Smtp-Source: AGHT+IEelXxhJhr5P3Nxmm/DhkplTdE9CkTwp1xoRFlAsaDRDBaEJA+XrVSBQYL/YiXTA7gNxNObyvM3KuqFxelAyCs=
X-Received: by 2002:a05:690c:46c4:b0:6e2:ad08:4905 with SMTP id
 00721157ae682-6ee55a2b090mr3650347b3.1.1731615417649; Thu, 14 Nov 2024
 12:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106234518.115234-1-benjamin@engflow.com> <20241106234518.115234-2-benjamin@engflow.com>
 <ZzY1bPtoyRH-nRIV@x1> <ZzY20vZluj44w1Gt@x1> <CAEmfU+v8KR3Bd8w7kOX6ScGig106zh5gW9P5fwAw-BF3tmAp7A@mail.gmail.com>
 <ZzZY7U0AFk3245vy@x1>
In-Reply-To: <ZzZY7U0AFk3245vy@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 14 Nov 2024 12:16:46 -0800
Message-ID: <CAH0uvojcZMVzDyNkWCSHMdwn59T2fgn6iGoqrh9NhaaQ5H2DOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tests: add test for trace output loss
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Peterson <benjamin@engflow.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 14, 2024 at 12:09=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Nov 14, 2024 at 09:44:56AM -0800, Benjamin Peterson wrote:
> > > On Thu, Nov 14, 2024 at 02:37:52PM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > diff --git a/tools/perf/tests/shell/trace_exit_race.sh b/tools/perf/t=
ests/shell/trace_exit_race.sh
> > > index 8b70324bc5b4fb4c..c37ed6bb9f7e8fab 100755
> > > --- a/tools/perf/tests/shell/trace_exit_race.sh
> > > +++ b/tools/perf/tests/shell/trace_exit_race.sh
> > > @@ -12,10 +12,10 @@
> > >  skip_if_no_perf_trace || exit 2
>
> > >  trace_shutdown_race() {
> > > -       for i in $(seq 100); do
> > > +       for _ in $(seq 100); do
> > >                 perf trace -e syscalls:sys_enter_exit_group true 2>>$=
file
> > >         done
> > > -       [ $(grep -c -E " +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_en=
ter_exit_group\(\)$" $file) =3D "100" ]
> > > +       [ "$(grep -c -E ' +[0-9]+\.[0-9]+ +true/[0-9]+ syscalls:sys_e=
nter_exit_group\(\)$' $file)" =3D "100" ]
> > >  }
>
> > This all looks okay.
>
> The test is failing for me as there is garbage in the output of perf
> trace even with Namhyung having already applied your previous patch:
>
> =E2=AC=A2 [acme@toolbox perf-tools-next]$ git log --oneline --author benj=
amin@engflow.com
> 12bd434f68ea45c7 (HEAD -> perf-tools-next) perf tests: Add test for 'perf=
 trace' output loss
> efbcd2cd7eac10a9 perf trace: Do not lose last events in a race
> 5fb8e56542a3cf46 (perf-tools-next/tmp.perf-tools-next) perf trace: avoid =
garbage when not printing a trace event's arguments
> =E2=AC=A2 [acme@toolbox perf-tools-next]$
>
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982428 syscalls:sys_enter_exit_group( k?m)
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982430 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982432 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982434 syscalls:sys_enter_exit_group()
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982437 syscalls:sys_enter_exit_group( k=EF=BF=BD)
> root@number:~# perf trace -e syscalls:sys_enter_exit_group true
>      0.000 true/1982439 syscalls:sys_enter_exit_group(, loads 8=EF=BF=BD=
=EF=BF=BD1)
> root@number:~#
>
> So we don't _miss_ the events, which I was noticing and brought me to
> test your latest 2 patches, which I applied and added a Tested-by, now
> tryint to figure out this garbage...

Benjamin has already sent v2 to fix this:
https://lore.kernel.org/linux-perf-users/20241107232128.108981-2-benjamin@e=
ngflow.com/

Thanks,
Howard

>
> - Arnaldo
>
